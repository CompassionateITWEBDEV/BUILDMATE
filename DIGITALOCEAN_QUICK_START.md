# DigitalOcean Quick Start Guide

Quick deployment guide for Buildmate on DigitalOcean.

## Prerequisites Checklist

- [ ] DigitalOcean account created
- [ ] Droplet created (Ubuntu 22.04, 2 vCPU, 4GB RAM minimum)
- [ ] SSH access to droplet configured
- [ ] Domain name (optional, for custom domain)

## 5-Minute Deployment

### Step 1: Connect to Droplet
```bash
ssh root@YOUR_DROPLET_IP
```

### Step 2: Install Docker
```bash
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
apt install docker-compose-plugin -y
```

### Step 3: Clone Repository
```bash
cd /opt
git clone YOUR_REPO_URL buildmate
cd buildmate
```

### Step 4: Configure Environment
```bash
cp .env.production.example .env.production
nano .env.production  # Edit with your actual values
```

**Required values to update:**
- `POSTGRES_PASSWORD` - Strong password for database
- `NEXT_PUBLIC_SUPABASE_URL` - Your Supabase project URL
- `NEXT_PUBLIC_SUPABASE_ANON_KEY` - Supabase anon key
- `SUPABASE_SERVICE_ROLE_KEY` - Supabase service role key
- `SMTP_*` - Email configuration

### Step 5: Deploy
```bash
bash deploy.sh
```

Or manually:
```bash
docker compose build
docker compose up -d
```

### Step 6: Verify
```bash
docker compose ps
docker compose logs -f
```

## Access Your Application

- **Next.js App**: `http://YOUR_DROPLET_IP:3000`
- **Python API**: `http://YOUR_DROPLET_IP:5000`

## Set Up Domain (Optional)

1. Point your domain A record to droplet IP
2. Install Nginx:
   ```bash
   apt install nginx -y
   ```
3. Configure Nginx (see DIGITALOCEAN_DEPLOYMENT.md)
4. Install SSL:
   ```bash
   apt install certbot python3-certbot-nginx -y
   certbot --nginx -d your-domain.com
   ```

## Common Commands

```bash
# View logs
docker compose logs -f

# Restart services
docker compose restart

# Stop services
docker compose down

# Update application
git pull
docker compose build
docker compose up -d

# Backup database
docker compose exec postgres pg_dump -U buildmate buildmate > backup.sql

# Check service status
docker compose ps
```

## Troubleshooting

**Services won't start?**
```bash
docker compose logs
docker compose ps
```

**Port already in use?**
```bash
netstat -tulpn | grep :3000
# Change port in docker-compose.yml if needed
```

**Database connection issues?**
```bash
docker compose logs postgres
docker compose exec postgres psql -U buildmate -d buildmate
```

## Next Steps

- Read [DIGITALOCEAN_DEPLOYMENT.md](./DIGITALOCEAN_DEPLOYMENT.md) for detailed setup
- Configure firewall: `ufw allow 80,443,22/tcp && ufw enable`
- Set up monitoring and backups
- Configure SSL certificate

---

**Need help?** Check the full deployment guide: [DIGITALOCEAN_DEPLOYMENT.md](./DIGITALOCEAN_DEPLOYMENT.md)

