from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from app.extensions import db  # ✅ Use db from Flask-SQLAlchemy

class User(db.Model):  # ✅ Inherit from db.Model
    __tablename__ = "users"

    id = Column(Integer, primary_key=True)
    username = Column(String, unique=True, nullable=False)
    email = Column(String, unique=True, nullable=False)
    password_hash = Column(String, nullable=False)

    trips = relationship("Trip", back_populates="user", cascade="all, delete-orphan")
    tokens = relationship("OAuthToken", back_populates="user", cascade="all, delete-orphan")
    micro_trips = relationship("MicroTrip", back_populates="user", cascade="all, delete-orphan")

    def to_dict(self):
        return {
            "id": self.id,
            "username": self.username,
            "email": self.email
        }

# ✅ These imports ensure models are registered for Alembic migrations
from .trip import Trip
from .microtrip import MicroTrip
