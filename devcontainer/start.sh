#!/bin/bash
echo "🔧 Starting Docker Compose stack..."
docker-compose up --build -d

echo "🌐 Backend: http://localhost:5000"
echo "🎨 Frontend: http://localhost:3000"
