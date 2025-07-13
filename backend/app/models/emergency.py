from sqlalchemy import Column, Integer, String
from app.extensions import db

class Emergency(db.Model):
    __tablename__ = "emergencies"

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    phone_number = Column(String, nullable=False)
    city = Column(String, nullable=False)
