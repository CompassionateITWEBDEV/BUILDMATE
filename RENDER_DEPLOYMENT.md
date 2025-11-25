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

3. **Set Environment Variables**
   - In the Render dashboard, go to your service
   - Navigate to "Environment" tab
   - Add the following environment variables:
     ```
     NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
     NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
     SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
     SMTP_HOST=smtp.gmail.com
     SMTP_PORT=587
     SMTP_USER=your_email@gmail.com
     SMTP_PASSWORD=your_app_password
     SMTP_FROM_EMAIL=BUILDMATE <your_email@gmail.com>
     PYTHON_API_URL=your_python_api_url (if separate)
     ```

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

## Notes

- Render provides a free tier with limitations
- For production, consider upgrading to a paid plan
- The Python API backend needs to be deployed separately if not using Docker Compose
- Database should be hosted separately (Supabase or Render PostgreSQL)

## Support

If you encounter issues:
1. Check Render documentation: https://render.com/docs
2. Review build logs in Render dashboard
3. Check Next.js deployment guide: https://nextjs.org/docs/deployment

