import os
from flask import Flask
from datetime import timedelta
from .config import Config
from .extensions import db, migrate, cors
from .routes import register_routes
#from .user import User
#from .trip import Trip
#from .oauth_token import OAuthToken
#from .microtrip import MicroTrip, MicroTripPOI

def create_app():
    app = Flask(
        __name__,
        static_folder=os.path.abspath('../frontend'),
        template_folder=os.path.abspath('../frontend')
    )

    # ✅ Set Content Security Policy headers
    @app.after_request
    def apply_csp(response):
        response.headers["Content-Security-Policy"] = (
            "default-src 'self'; "
            "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://apis.google.com https://www.gstatic.com https://cdn.jsdelivr.net; "
            "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com https://cdn.jsdelivr.net https://cdnjs.cloudflare.com; "
            "connect-src 'self' http://localhost:5000 https://accounts.google.com https://www.googleapis.com https://content.googleapis.com https://router.project-osrm.org; "
            "img-src 'self' data: https://*.tile.openstreetmap.org https://cdn.jsdelivr.net;"
        )
        return response

    # ✅ Load configuration
    app.config.from_object(Config)

    # ✅ Session settings
    app.secret_key = app.config['SECRET_KEY']
    app.permanent_session_lifetime = timedelta(days=7)

    # ✅ Initialize extensions
    db.init_app(app)
    migrate.init_app(app, db)

    # ✅ Enable CORS for frontend communication
    cors.init_app(app, resources={r"/api/*": {"origins": "http://localhost:3000"}}, supports_credentials=True)

    # ✅ Register all API routes
    register_routes(app)

    # ✅ Ensure models are registered for Alembic
    from app import models

    # ✅ Register calendar blueprint
    from app.routes.google_calendar import calendar_bp
    app.register_blueprint(calendar_bp)

    return app
