# app/routes/google_calendar.py
from flask import Blueprint, redirect, request, session, url_for, jsonify
import os
import google_auth_oauthlib.flow
import googleapiclient.discovery
import googleapiclient.errors

calendar_bp = Blueprint('calendar', __name__)

# Load credentials from file
CLIENT_SECRETS_FILE = "client_secret.json"
SCOPES = ['https://www.googleapis.com/auth/calendar.events']

@calendar_bp.route("/authorize")
def authorize():
    flow = google_auth_oauthlib.flow.Flow.from_client_secrets_file(
        CLIENT_SECRETS_FILE,
        scopes=SCOPES)
    flow.redirect_uri = url_for('calendar.oauth2callback', _external=True)

    authorization_url, state = flow.authorization_url(
        access_type='offline',
        include_granted_scopes='true')

    session['state'] = state
    return redirect(authorization_url)

@calendar_bp.route("/oauth2callback")
def oauth2callback():
    state = session['state']

    flow = google_auth_oauthlib.flow.Flow.from_client_secrets_file(
        CLIENT_SECRETS_FILE,
        scopes=SCOPES,
        state=state)
    flow.redirect_uri = url_for('calendar.oauth2callback', _external=True)

    flow.fetch_token(authorization_response=request.url)

    credentials = flow.credentials
    session['credentials'] = {
        'token': credentials.token,
        'refresh_token': credentials.refresh_token,
        'token_uri': credentials.token_uri,
        'client_id': credentials.client_id,
        'client_secret': credentials.client_secret,
        'scopes': credentials.scopes
    }

    return redirect(url_for('calendar.create_event'))

@calendar_bp.route("/create_event")
def create_event():
    credentials_data = session.get('credentials')
    if not credentials_data:
        return redirect(url_for('calendar.authorize'))

    from google.oauth2.credentials import Credentials
    credentials = Credentials(**credentials_data)

    service = googleapiclient.discovery.build('calendar', 'v3', credentials=credentials)

    event = {
        'summary': 'Your FlexTrip Event',
        'location': 'Bavaria',
        'description': 'This is a generated event from FlexTrip',
        'start': {
            'dateTime': '2025-07-05T09:00:00',
            'timeZone': 'Europe/Berlin',
        },
        'end': {
            'dateTime': '2025-07-05T17:00:00',
            'timeZone': 'Europe/Berlin',
        }
    }

    event = service.events().insert(calendarId='primary', body=event).execute()
    return jsonify({'status': 'success', 'event_link': event.get('htmlLink')})
