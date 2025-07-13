# backend/app/models/simulated_place.py
from sqlalchemy import Column, Integer, String, Float, ForeignKey
from sqlalchemy.orm import relationship
from app.extensions import db  # ✅ Use the correct base

class SimulatedPlace(db.Model):  # ✅ Must match others
    __tablename__ = "simulated_places"

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    latitude = Column(Float, nullable=False)
    longitude = Column(Float, nullable=False)
    category = Column(String)
    estimated_cost = Column(Float)

    trip_id = Column(Integer, ForeignKey("trips.id"))
    trip = relationship("Trip", back_populates="simulated_places")
