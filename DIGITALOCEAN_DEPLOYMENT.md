# DigitalOcean Deployment Guide

This guide will help you deploy Buildmate to a DigitalOcean droplet, running both the Next.js application and PostgreSQL database on a single droplet.

## Prerequisites

1. A DigitalOcean account ([Sign up here](https://www.digitalocean.com/))
2. Basic knowledge of Linux command line
3. Domain name (optional, for custom domain)

## Step 1: Create a DigitalOcean Droplet

1. **Log in to DigitalOcean Dashboard**
   - Go to [https://cloud.digitalocean.com](https://cloud.digitalocean.com)

2. **Create a New Droplet**
   - Click "Create" → "Droplets"
   - Choose configuration:
     - **Image**: Ubuntu 22.04 (LTS)
     - **Plan**: Basic
     - **CPU**: Regular (2 vCPU minimum recommended)
     - **Memory**: 4GB RAM minimum, 8GB recommended
     - **Storage**: 25GB SSD minimum (50GB recommended)
     - **Datacenter**: Choose closest to your users
     - **Authentication**: SSH keys (recommended) or root password

3. **Finalize and Create**
   - Give your droplet a hostname: `buildmate-production`
   - Click "Create Droplet"
   - Wait for droplet to be created (1-2 minutes)

## Step 2: Connect to Your Droplet

1. **Get your droplet IP address** from the DigitalOcean dashboard

2. **SSH into your droplet**:
   ```bash
   ssh root@YOUR_DROPLET_IP
   ```

   Or if using SSH keys:
   ```bash
   ssh -i ~/.ssh/your_key root@YOUR_DROPLET_IP
   ```

## Step 3: Initial Server Setup

### Update System Packages
```bash
apt update && apt upgrade -y
```

### Install Docker and Docker Compose
```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Install Docker Compose
apt install docker-compose-plugin -y

# Verify installation
docker --version
docker compose version
```

### Install Git
```bash
apt install git -y
```

### Create Non-Root User (Optional but Recommended)
```bash
adduser buildmate
usermod -aG docker buildmate
usermod -aG sudo buildmate
```

## Step 4: Clone and Configure Application

### Clone Repository
```bash
cd /opt
git clone YOUR_REPOSITORY_URL buildmate
cd buildmate
```

Or if you need to upload files manually:
```bash
# Create directory
mkdir -p /opt/buildmate
cd /opt/buildmate
# Upload files using scp or SFTP
```

### Create Environment File
```bash
nano .env.production
```

Add the following configuration:
```env
# Database Configuration
POSTGRES_PASSWORD=your_strong_database_password_here

# Supabase Configuration (if using Supabase)
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
```

**Important**: Replace all placeholder values with your actual credentials.

### Update Next.js Configuration

Ensure `next.config.mjs` has standalone output enabled:
```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  // ... rest of your config
}
```

## Step 5: Build and Start Services

### Build Docker Images
```bash
docker compose build
```

### Start Services
```bash
docker compose up -d
```

### Check Service Status
```bash
docker compose ps
```

### View Logs
```bash
# All services
docker compose logs -f

# Specific service
docker compose logs -f nextjs
docker compose logs -f postgres
docker compose logs -f python-api
```

## Step 6: Initialize Database

### Run Database Migrations
```bash
# Connect to PostgreSQL container
docker compose exec postgres psql -U buildmate -d buildmate

# Or run migration script if you have one
docker compose exec nextjs npm run migrate
```

### Seed Database (Optional)
```bash
docker compose exec nextjs npm run seed
```

## Step 7: Configure Firewall

```bash
# Allow SSH
ufw allow 22/tcp

# Allow HTTP
ufw allow 80/tcp

# Allow HTTPS
ufw allow 443/tcp

# Enable firewall
ufw enable
```

## Step 8: Set Up Reverse Proxy (Nginx)

### Install Nginx
```bash
apt install nginx -y
```

### Create Nginx Configuration
```bash
nano /etc/nginx/sites-available/buildmate
```

Add the following configuration:
```nginx
server {
    listen 80;
    server_name your-domain.com www.your-domain.com;

    # Next.js Application
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }

    # Python API
    location /api/python {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### Enable Site
```bash
ln -s /etc/nginx/sites-available/buildmate /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
nginx -t
systemctl restart nginx
```

## Step 9: Set Up SSL with Let's Encrypt (Optional but Recommended)

```bash
# Install Certbot
apt install certbot python3-certbot-nginx -y

# Obtain SSL certificate
certbot --nginx -d your-domain.com -d www.your-domain.com

# Auto-renewal is set up automatically
```

## Step 10: Set Up Auto-Start on Reboot

### Create Systemd Service
```bash
nano /etc/systemd/system/buildmate.service
```

Add:
```ini
[Unit]
Description=Buildmate Docker Compose
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/opt/buildmate
ExecStart=/usr/bin/docker compose up -d
ExecStop=/usr/bin/docker compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
```

### Enable Service
```bash
systemctl enable buildmate.service
systemctl start buildmate.service
```

## Step 11: Monitoring and Maintenance

### Check Service Health
```bash
# Docker services
docker compose ps

# System resources
htop

# Disk usage
df -h

# Docker logs
docker compose logs --tail=100
```

### Update Application
```bash
cd /opt/buildmate
git pull
docker compose build
docker compose up -d
docker compose exec nextjs npm run migrate  # If needed
```

### Backup Database
```bash
# Create backup
docker compose exec postgres pg_dump -U buildmate buildmate > backup_$(date +%Y%m%d).sql

# Restore backup
docker compose exec -T postgres psql -U buildmate buildmate < backup_YYYYMMDD.sql
```

## Troubleshooting

### Services Not Starting
```bash
# Check logs
docker compose logs

# Check Docker status
systemctl status docker

# Restart Docker
systemctl restart docker
```

### Port Already in Use
```bash
# Check what's using the port
netstat -tulpn | grep :3000

# Kill process or change port in docker-compose.yml
```

### Database Connection Issues
```bash
# Check PostgreSQL logs
docker compose logs postgres

# Test connection
docker compose exec postgres psql -U buildmate -d buildmate -c "SELECT 1;"
```

### Out of Memory
```bash
# Check memory usage
free -h

# Consider upgrading droplet or optimizing application
```

## Security Best Practices

1. **Change default passwords** immediately
2. **Use SSH keys** instead of passwords
3. **Keep system updated**: `apt update && apt upgrade`
4. **Regular backups** of database
5. **Monitor logs** for suspicious activity
6. **Use firewall** (UFW) to restrict access
7. **Enable SSL/HTTPS** for production
8. **Rotate credentials** regularly

## Cost Optimization

- Start with a smaller droplet and scale up as needed
- Use DigitalOcean's monitoring to track resource usage
- Set up alerts for high resource usage
- Consider using DigitalOcean's managed PostgreSQL for better performance (separate service)

## Support

For issues or questions:
- Check application logs: `docker compose logs`
- Review DigitalOcean documentation
- Check Next.js deployment documentation

---

**Deployment Complete!** Your Buildmate application should now be running on your DigitalOcean droplet.

