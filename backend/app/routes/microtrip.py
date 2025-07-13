# backend/app/routes/microtrip.py
from __future__ import annotations

import random
import traceback
from datetime import datetime, time, timedelta

from flask import Blueprint, jsonify, request
from sqlalchemy import func
from sqlalchemy.exc import SQLAlchemyError

from app.extensions import db
from app.models.poi import PointOfInterest as POI
from app.models import MicroTrip, MicroTripPOI
from calendar_utils import add_trip_events  # 📅 Google‑calendar helper

microtrip_bp = Blueprint("microtrip", __name__, url_prefix="/api/microtrip")


# ----------------------------------------------------------------------------- #
# Helpers
# ----------------------------------------------------------------------------- #
def simulate_travel(poi_from: dict, poi_to: dict) -> dict:
    """Return a fake travel segment between two POIs."""
    mode = random.choice(["walk", "car"])
    if mode == "walk":
        duration = random.randint(5, 20)
        distance = round(random.uniform(0.5, 2.5), 1)
    else:
        duration = random.randint(3, 10)
        distance = round(random.uniform(1, 5), 1)

    return {
        "from": poi_from["name"],
        "to": poi_to["name"],
        "mode": mode,
        "duration_minutes": duration,
        "distance_km": distance,
    }


# ----------------------------------------------------------------------------- #
# /api/microtrip/generate
# ----------------------------------------------------------------------------- #
@microtrip_bp.route("/generate", methods=["POST"])
def generate_microtrip():
    try:
        data = request.get_json(force=True) or {}
        location = data.get("current_location")
        interests = data.get("interests", [])
        budget = data.get("budget")
        add_to_calendar = data.get("add_to_calendar", False)

        if not location or not interests:
            return (
                jsonify(
                    {"error": "Both 'current_location' and at least one 'interest' are required."}
                ),
                400,
            )

        print(
            f"✅ Request: location={location}, interests={interests}, "
            f"budget={budget}, calendar={add_to_calendar}"
        )

        # --- query POIs ---------------------------------------------------- #
        try:
            print("🔍 Executing POI query with ARRAY operator")
            print("➡️ location.lower():", location.lower())
            print("➡️ interests:", interests)

            pois = (
                db.session.query(POI)
                .filter(
                    func.lower(POI.location) == location.lower(),
                    POI.interests.op("&&")(interests),
                )
                .order_by(POI.id)
                .all()
            )
            print(f"✅ Found {len(pois)} matching POIs")
        except SQLAlchemyError as err:
            print("❌ SQLAlchemyError while querying POIs")
            traceback.print_exc()
            return jsonify({"error": f"Database error: {err}"}), 500

        # --- build itinerary ---------------------------------------------- #
        available_start = time(9, 0)
        max_trip_minutes = 5 * 60
        max_stops = 5

        selected, travel_segments = [], []
        total_minutes = 0
        current_time = datetime.combine(datetime.today(), available_start)

        for idx, poi in enumerate(pois):
            stay = poi.duration_minutes or 60
            if total_minutes + stay > max_trip_minutes:
                break

            # travel from previous POI
            if idx > 0:
                travel = simulate_travel(selected[-1], {"name": poi.name})
                if total_minutes + travel["duration_minutes"] + stay > max_trip_minutes:
                    break
                current_time += timedelta(minutes=travel["duration_minutes"])
                total_minutes += travel["duration_minutes"]
                travel_segments.append(travel)

            start_time = current_time
            end_time = current_time + timedelta(minutes=stay)

            selected.append(
                {
                    "name": poi.name,
                    "description": poi.description or "",
                    "location": poi.location,
                    "interests": poi.interests,
                    "duration_minutes": stay,
                    "estimated_cost": poi.estimated_cost or 10.0,
                    "price_range": poi.price_range or "€",
                    "opening_time": str(poi.opening_time or "09:00"),
                    "closing_time": str(poi.closing_time or "18:00"),
                    "start_time": start_time.isoformat(),
                    "end_time": end_time.isoformat(),
                }
            )

            total_minutes += stay
            current_time = end_time
            if len(selected) >= max_stops:
                break

        # --- optional calendar sync -------------------------------------- #
        response = {"recommended": selected, "travel_segments": travel_segments}
        if add_to_calendar and selected:
            response["calendar_urls"] = add_trip_events(selected)

        return jsonify(response), 200

    except Exception as err:
        print("❌ Unexpected error in /api/microtrip/generate")
        traceback.print_exc()
        return jsonify({"error": f"Server error: {err}"}), 500


# ----------------------------------------------------------------------------- #
# /api/microtrip/save
# ----------------------------------------------------------------------------- #
@microtrip_bp.route("/save", methods=["POST"])
def save_microtrip():
    data = request.get_json(force=True) or {}

    try:
        trip = MicroTrip(name=data.get("name", "Untitled Trip"), user_id=data.get("user_id"))

        for poi in data.get("pois", []):
            trip.pois.append(
                MicroTripPOI(
                    name=poi["name"],
                    interests=",".join(poi.get("interests", [])),
                    duration_minutes=poi.get("duration_minutes", 60),
                )
            )

        db.session.add(trip)
        db.session.commit()
        return jsonify({"message": "Trip saved!", "trip_id": trip.id}), 201

    except Exception as err:
        db.session.rollback()
        print("❌ Unexpected error in /api/microtrip/save")
        traceback.print_exc()
        return jsonify({"error": f"Server error: {err}"}), 500
