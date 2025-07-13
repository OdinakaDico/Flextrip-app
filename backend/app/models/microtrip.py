from datetime import datetime
from app.extensions import db

class MicroTrip(db.Model):
    __tablename__ = "micro_trips"

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("users.id", ondelete="CASCADE"), nullable=True)
    name = db.Column(db.String(120), default="Untitled Trip")
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    # Relationships
    pois = db.relationship("MicroTripPOI", back_populates="trip", cascade="all, delete-orphan")
    user = db.relationship("User", back_populates="micro_trips", lazy=True)

class MicroTripPOI(db.Model):
    __tablename__ = "micro_trip_pois"

    id = db.Column(db.Integer, primary_key=True)
    trip_id = db.Column(db.Integer, db.ForeignKey("micro_trips.id", ondelete="CASCADE"))
    name = db.Column(db.String(200), nullable=False)
    interests = db.Column(db.String(200))
    duration_minutes = db.Column(db.Integer)

    trip = db.relationship("MicroTrip", back_populates="pois")
