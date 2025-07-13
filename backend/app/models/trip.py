from sqlalchemy import Column, Integer, String, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from datetime import datetime
from app.extensions import db

class Trip(db.Model):
    __tablename__ = "trips"

    id           = Column(Integer, primary_key=True)
    name         = Column(String, nullable=False)
    destination  = Column(String, nullable=False)
    start_date   = Column(DateTime, nullable=False)
    end_date     = Column(DateTime, nullable=False)
    user_id      = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"))

    created_at   = Column(DateTime, default=datetime.utcnow)

    # Relationships
    user              = relationship("User", back_populates="trips")
    itinerary_items   = relationship("ItineraryItem", back_populates="trip", cascade="all, delete-orphan")
    simulated_places  = relationship("SimulatedPlace", back_populates="trip", cascade="all, delete-orphan")
    accommodations    = relationship("Accommodation", back_populates="trip", cascade="all, delete-orphan")
