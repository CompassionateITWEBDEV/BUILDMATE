# Python Backend Setup for Render.com

## ⚠️ IMPORTANT: CSP Algorithm Requires Python Backend

Para mag-work ang CSP Recommendation Checker, kailangan i-deploy ang Python backend sa Render.

## Option 1: Deploy Python Backend as Separate Service (Recommended)

### Step 1: Create Python Backend Service in Render

1. **Go to Render Dashboard**
   - Click **"New +"** → **"Web Service"**
   - Connect your GitHub repository: `CompassionateITWEBDEV/BUILDMATE`

2. **Configure Service:**
   - **Name**: `buildmate-python-api`
   - **Environment**: **Python 3**
   - **Region**: Same as your Next.js service
   - **Branch**: `main`
   - **Root Directory**: Leave empty

3. **Build & Start Commands:**
   - **Build Command**: `pip install -r Algorithm/python-backend/requirements.txt`
   - **Start Command**: `cd Algorithm/python-backend && python api.py`

4. **Environment Variables:**
   ```
   SUPABASE_URL=your_supabase_url
   SUPABASE_KEY=your_supabase_anon_key
   PORT=5000
   ```

5. **Deploy**
   - Click **"Create Web Service"**
   - Wait for deployment to complete
   - Copy the service URL (e.g., `https://buildmate-python-api.onrender.com`)

### Step 2: Update Next.js Service Environment Variable

1. **Go to your Next.js service** in Render
2. **Environment** tab
3. **Add/Update** `PYTHON_API_URL`:
   ```
   PYTHON_API_URL=https://buildmate-python-api.onrender.com
   ```
   (Replace with your actual Python backend URL)

4. **Save and Redeploy**

## Option 2: Using render.yaml (Auto-deploy)

If you use `render.yaml`, it will automatically create both services:

1. **Python Backend Service** - `buildmate-python-api`
2. **Next.js Service** - `buildmate-nextjs`

After deployment:
1. Get the Python backend URL from Render dashboard
2. Update `PYTHON_API_URL` in Next.js service environment variables
3. Redeploy Next.js service

## Option 3: Disable CSP Feature (Temporary)

If you don't want to deploy Python backend yet, you can disable the CSP button:

1. The CSP button will show an error when clicked
2. Users can still build PCs manually
3. Upgrade suggestions will also not work

## Testing

After deploying Python backend:

1. **Check Python Backend Health:**
   - Visit: `https://your-python-backend-url.onrender.com/`
   - Should return: `{"status": "ok", "message": "Python backend is running"}`

2. **Test CSP in Builder:**
   - Set a budget (minimum ₱10,000)
   - Click "CSP Recommendation Checker"
   - Should work without errors

## Troubleshooting

### Python Backend Not Starting

1. **Check Build Logs:**
   - Go to Python service → **Logs** tab
   - Look for import errors or missing dependencies

2. **Common Issues:**
   - **Missing dependencies**: Make sure `requirements.txt` has all packages
   - **Python version**: Render uses Python 3.11 by default
   - **Import errors**: Check if all algorithm files are in correct paths

### CSP Still Not Working

1. **Verify PYTHON_API_URL:**
   - Check Next.js service environment variables
   - Should be: `https://your-python-backend-url.onrender.com`
   - NOT: `http://localhost:5000`

2. **Check Service URLs:**
   - Python backend should be accessible publicly
   - No authentication required for health check

3. **Check Logs:**
   - Next.js service logs - look for connection errors
   - Python backend logs - look for request errors

## Quick Checklist

- [ ] Python backend service created in Render
- [ ] Build command: `pip install -r Algorithm/python-backend/requirements.txt`
- [ ] Start command: `cd Algorithm/python-backend && python api.py`
- [ ] Environment variables set (SUPABASE_URL, SUPABASE_KEY)
- [ ] Python backend deployed and accessible
- [ ] PYTHON_API_URL set in Next.js service
- [ ] Next.js service redeployed
- [ ] Tested CSP recommendation checker

## Notes

- Python backend needs to be running 24/7 for CSP to work
- Free tier on Render may spin down after inactivity (takes time to wake up)
- Consider upgrading to paid plan for always-on service
- Python backend URL will be different for each deployment

