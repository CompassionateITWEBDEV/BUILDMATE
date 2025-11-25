#!/bin/bash

# Advanced DigitalOcean Deployment Script
# Includes database migration and health checks

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$PROJECT_ROOT"

echo "🚀 Buildmate DigitalOcean Deployment"
echo "===================================="

# Load environment variables
if [ -f .env.production ]; then
    export $(cat .env.production | grep -v '^#' | xargs)
else
    echo "❌ Error: .env.production not found"
    exit 1
fi

# Function to check service health
check_service() {
    local service=$1
    local max_attempts=30
    local attempt=1
    
    echo "⏳ Waiting for $service to be healthy..."
    
    while [ $attempt -le $max_attempts ]; do
        if docker compose ps | grep -q "$service.*healthy\|Up"; then
            echo "✅ $service is healthy"
            return 0
        fi
        echo "   Attempt $attempt/$max_attempts..."
        sleep 2
        attempt=$((attempt + 1))
    done
    
    echo "❌ $service failed to become healthy"
    docker compose logs "$service"
    return 1
}

# Build and start services
echo ""
echo "📦 Building Docker images..."
docker compose build

echo ""
echo "🚀 Starting services..."
docker compose up -d

# Wait for PostgreSQL
check_service "postgres"

# Wait for Python API
check_service "python-api"

# Wait for Next.js
check_service "nextjs"

# Run database migrations (if migration script exists)
if [ -f "scripts/migrate-db.sh" ]; then
    echo ""
    echo "🗄️  Running database migrations..."
    docker compose exec -T nextjs sh -c "npm run migrate || echo 'No migrate script found'"
fi

# Seed database (optional)
read -p "Do you want to seed the database? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🌱 Seeding database..."
    docker compose exec -T nextjs npm run seed || echo "No seed script found"
fi

# Display service URLs
echo ""
echo "✅ Deployment complete!"
echo ""
echo "📊 Service Status:"
docker compose ps
echo ""
echo "🌐 Services are available at:"
echo "   - Next.js App: http://localhost:3000"
echo "   - Python API: http://localhost:5000"
echo "   - PostgreSQL: localhost:5432"
echo ""
echo "📝 Useful commands:"
echo "   - View logs: docker compose logs -f"
echo "   - Stop services: docker compose down"
echo "   - Restart services: docker compose restart"
echo "   - View logs for specific service: docker compose logs -f nextjs"

