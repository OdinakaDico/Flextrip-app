FROM python:3.11-slim

# Create non-root user and set permissions
RUN adduser --disabled-password --gecos '' codespace \
    && mkdir -p /home/codespace \
    && chown -R codespace:codespace /home/codespace

# Switch to codespace user
USER codespace

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

COPY . .

CMD ["python", "run.py"]
