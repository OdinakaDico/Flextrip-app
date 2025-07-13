from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app.extensions import db
from app.models.user import User  # ✅ Import here to ensure both classes are defined

class OAuthToken(db.Model):  # ✅ Inherit from db.Model (not Base)
    __tablename__ = "oauth_tokens"

    id = Column(Integer, primary_key=True)
    provider = Column(String, nullable=False)
    access_token = Column(String, nullable=False)
    refresh_token = Column(String)
    expires_in = Column(Integer)
    token_type = Column(String)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"))

    user = relationship("User", back_populates="tokens")

# ✅ Define reverse relationship AFTER both classes are imported
User.tokens = relationship("OAuthToken", back_populates="user", cascade="all, delete-orphan")
