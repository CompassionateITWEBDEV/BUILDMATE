# BuildMate PC builder

*Automatically synced with your [v0.app](https://v0.app) deployments*

[![Deployed on Vercel](https://img.shields.io/badge/Deployed%20on-Vercel-black?style=for-the-badge&logo=vercel)](https://vercel.com/brians-projects-58f72137/v0-build-mate-pc-builder)
[![Built with v0](https://img.shields.io/badge/Built%20with-v0.app-black?style=for-the-badge)](https://v0.app/chat/projects/LPM9vhywwaG)

## Overview

This repository will stay in sync with your deployed chats on [v0.app](https://v0.app).
Any changes you make to your deployed app will be automatically pushed to this repository from [v0.app](https://v0.app).

## Deployment

### Vercel Deployment

Your project is live at:

**[https://vercel.com/brians-projects-58f72137/v0-build-mate-pc-builder](https://vercel.com/brians-projects-58f72137/v0-build-mate-pc-builder)**

### DigitalOcean Deployment

Buildmate can be deployed to a DigitalOcean droplet running both the Next.js application and PostgreSQL database on a single droplet.

**Quick Start:**
1. See [DIGITALOCEAN_DEPLOYMENT.md](./DIGITALOCEAN_DEPLOYMENT.md) for detailed instructions
2. Run the deployment script: `bash deploy.sh`
3. Or use Docker Compose: `docker compose up -d`

**Requirements:**
- DigitalOcean droplet (2 vCPU, 4GB RAM minimum, 8GB recommended)
- Ubuntu 22.04 (LTS)
- Docker and Docker Compose installed

For complete setup instructions, see [DIGITALOCEAN_DEPLOYMENT.md](./DIGITALOCEAN_DEPLOYMENT.md).

## Build your app

Continue building your app on:

**[https://v0.app/chat/projects/LPM9vhywwaG](https://v0.app/chat/projects/LPM9vhywwaG)**

## How It Works

1. Create and modify your project using [v0.app](https://v0.app)
2. Deploy your chats from the v0 interface
3. Changes are automatically pushed to this repository
4. Vercel deploys the latest version from this repository