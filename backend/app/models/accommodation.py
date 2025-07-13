from sqlalchemy import Column, Integer, String, Float, ForeignKey
from sqlalchemy.orm import relationship
from app.extensions import db

class Accommodation(db.Model):
    __tablename__ = "accommodations"

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    address = Column(String)
    city = Column(String)
    country = Column(String)
    price_per_night = Column(Float)
    rating = Column(Float)
    trip_id = Column(Integer, ForeignKey("trips.id"))

    trip = relationship("Trip", back_populates="accommodations")
