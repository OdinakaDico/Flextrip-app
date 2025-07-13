from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from app.extensions import db  # ✅ Use db from Flask-SQLAlchemy

class ItineraryItem(db.Model):
    __tablename__ = "itinerary_items"

    id          = Column(Integer, primary_key=True)
    trip_id     = Column(Integer, ForeignKey("trips.id", ondelete="CASCADE"))
    title       = Column(String, nullable=False)
    description = Column(String)
    start_time  = Column(DateTime, default=datetime.utcnow)
    end_time    = Column(DateTime)

    # ✅ Don't import Trip here to avoid circular import
    trip = relationship("Trip", back_populates="itinerary_items")
