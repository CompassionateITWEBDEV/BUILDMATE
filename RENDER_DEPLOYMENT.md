# Render Deployment Guide

This guide will help you deploy BUILDMATE on Render.com.

## Prerequisites

1. A Render.com account
2. GitHub repository access (https://github.com/CompassionateITWEBDEV/BUILDMATE.git)
3. Environment variables ready (Supabase, SMTP, etc.)

## Deployment Steps

### Option 1: Using render.yaml (Recommended)

1. **Connect Repository to Render**
   - Go to Render Dashboard
   - Click "New +" → "Web Service"
   - Connect your GitHub account
   - Select the repository: `CompassionateITWEBDEV/BUILDMATE`

2. **Render will auto-detect render.yaml**
   - Render will automatically use the `render.yaml` configuration
   - Make sure the file is in the root of your repository

3. **Set Environment Variables** ⚠️ CRITICAL FOR EMAIL VERIFICATION
   - In the Render dashboard, go to your service
   - Navigate to "Environment" tab
   - Add the following environment variables:
     ```
     # Supabase Configuration
     NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
     NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
     SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
     
     # SMTP Configuration (REQUIRED for email verification codes)
     SMTP_HOST=smtp.gmail.com
     SMTP_PORT=587
     SMTP_USER=dummy.dumm.acc001@gmail.com
     SMTP_PASSWORD=your_16_character_gmail_app_password
     SMTP_FROM_EMAIL=BUILDMATE <dummy.dumm.acc001@gmail.com>
     SMTP_FROM_NAME=BUILDMATE
     
     # Other
     NODE_ENV=production
     PORT=3000
     PYTHON_API_URL=your_python_api_url (if separate)
     ```
   
   **⚠️ IMPORTANT:** 
   - Get Gmail App Password from: https://myaccount.google.com/apppasswords
   - Use the 16-character App Password (not your regular Gmail password)
   - Without SMTP configuration, verification codes will NOT be sent!
   - See `RENDER_ENV_SETUP.md` for detailed instructions

4. **Deploy**
   - Click "Manual Deploy" → "Deploy latest commit"
   - Or push to your main branch to trigger auto-deploy

### Option 2: Manual Configuration

If `render.yaml` doesn't work, configure manually:

1. **Service Settings**
   - **Name**: buildmate-nextjs
   - **Environment**: Node
   - **Region**: Choose closest to your users
   - **Branch**: main
   - **Root Directory**: Leave empty (or use `/` if needed)

2. **Build & Start Commands**
   - **Build Command**: `npm install -g pnpm@latest && pnpm install --frozen-lockfile && pnpm build`
   - **Start Command**: `pnpm start`

3. **Environment Variables**
   - Add all the variables listed in Option 1

## Important: Service Type

**Your Next.js app MUST be deployed as a Web Service, NOT a Static Site.**

- ✅ **Web Service**: Runs a Node.js server (required for API routes, Supabase, etc.)
- ❌ **Static Site**: Only serves static files (won't work with your app)

If you accidentally created a Static Site:
1. Delete the Static Site service
2. Create a new Web Service
3. Connect your repository
4. Render will auto-detect `render.yaml` and configure it correctly

**For Web Services, there is NO publish directory** - the server runs directly.

## Troubleshooting

### Error: "Service Root Directory missing"

If you see this error:
```
Service Root Directory "/opt/render/project/src/BUILDMATE" is missing.
```

**Solution 1**: In Render dashboard, set **Root Directory** to empty or `/`

**Solution 2**: If the repository is cloned into a subdirectory, set Root Directory to that subdirectory name (e.g., `BUILDMATE`)

**Solution 3**: Update `render.yaml` and ensure it's committed to your repository

### Build Fails

1. **Check Build Logs**
   - Go to your service → "Logs" tab
   - Look for specific error messages

2. **Common Issues**:
   - **pnpm not found**: The build command installs pnpm globally, but if it fails, try:
     ```
     npm install -g pnpm@latest && pnpm install && pnpm build
     ```
   - **Lock file issues**: If `pnpm-lock.yaml` is missing, remove `--frozen-lockfile` flag
   - **Memory issues**: Upgrade to a higher plan if build runs out of memory

### Environment Variables Not Working

1. Ensure all variables are set in Render dashboard
2. Variables starting with `NEXT_PUBLIC_` must be set for client-side access
3. Restart the service after adding new environment variables

## Post-Deployment

1. **Verify Deployment**
   - Check the service URL provided by Render
   - Test the application functionality

2. **Set Up Custom Domain** (Optional)
   - Go to your service → "Settings" → "Custom Domains"
   - Add your domain and follow DNS configuration instructions

3. **Enable Auto-Deploy**
   - Go to "Settings" → "Auto-Deploy"
   - Enable auto-deploy from main branch

## Python Backend Setup

**⚠️ IMPORTANT:** Para mag-work ang CSP Recommendation Checker, kailangan i-deploy ang Python backend.

### Quick Setup:

1. **Create Python Backend Service:**
   - Go to Render Dashboard → "New +" → "Web Service"
   - Name: `buildmate-python-api`
   - Environment: **Python 3**
   - Build Command: `pip install -r Algorithm/python-backend/requirements.txt`
   - Start Command: `cd Algorithm/python-backend && python api.py`
   - Environment Variables:
     ```
     SUPABASE_URL=your_supabase_url
     SUPABASE_KEY=your_supabase_anon_key
     PORT=5000
     ```

2. **Update Next.js Service:**
   - Add `PYTHON_API_URL` environment variable
   - Value: Your Python backend URL (e.g., `https://buildmate-python-api.onrender.com`)

3. **See `RENDER_PYTHON_BACKEND_SETUP.md` for detailed instructions**

## Notes

- Render provides a free tier with limitations
- For production, consider upgrading to a paid plan
- The Python API backend needs to be deployed separately as a Web Service
- Database should be hosted separately (Supabase or Render PostgreSQL)
- Free tier services may spin down after inactivity (takes time to wake up)

## Support

If you encounter issues:
1. Check Render documentation: https://render.com/docs
2. Review build logs in Render dashboard
3. Check Next.js deployment guide: https://nextjs.org/docs/deployment

