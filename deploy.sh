#!/bin/bash

# Buildmate DigitalOcean Deployment Script
# This script automates the deployment process on a DigitalOcean droplet

set -e

echo "🚀 Starting Buildmate Deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Please run as root or with sudo${NC}"
    exit 1
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}Docker not found. Installing Docker...${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm get-docker.sh
fi

# Check if Docker Compose is installed
if ! command -v docker compose &> /dev/null; then
    echo -e "${YELLOW}Docker Compose not found. Installing...${NC}"
    apt-get update
    apt-get install -y docker-compose-plugin
fi

# Check if .env.production exists
if [ ! -f .env.production ]; then
    echo -e "${YELLOW}.env.production not found. Creating from template...${NC}"
    cat > .env.production << EOF
# Database Configuration
POSTGRES_PASSWORD=change_me_strong_password

# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key

# SMTP Configuration
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your_gmail_app_password
SMTP_FROM_EMAIL=BUILDMATE <your-email@gmail.com>
SMTP_FROM_NAME=BUILDMATE

# Application URLs
PYTHON_API_URL=http://localhost:5000
EOF
    echo -e "${RED}⚠️  Please edit .env.production with your actual values before continuing!${NC}"
    exit 1
fi

# Stop existing containers
echo -e "${YELLOW}Stopping existing containers...${NC}"
docker compose down || true

# Build images
echo -e "${YELLOW}Building Docker images...${NC}"
docker compose build --no-cache

# Start services
echo -e "${YELLOW}Starting services...${NC}"
docker compose up -d

# Wait for services to be healthy
echo -e "${YELLOW}Waiting for services to be ready...${NC}"
sleep 10

# Check service status
echo -e "${YELLOW}Checking service status...${NC}"
docker compose ps

# Show logs
echo -e "${GREEN}✅ Deployment complete!${NC}"
echo -e "${YELLOW}View logs with: docker compose logs -f${NC}"
echo -e "${YELLOW}Check status with: docker compose ps${NC}"

