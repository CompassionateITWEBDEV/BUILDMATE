# Troubleshooting: Python Backend Endpoint Not Found

## Error Message
```
Python backend endpoint not found. Please check PYTHON_API_URL. Current: https://buildmate-python-api.onrender.com
```

## Quick Diagnosis Steps

### Step 1: Check if Backend Service Exists on Render

1. Go to **Render Dashboard**: https://dashboard.render.com
2. Look for a service named `buildmate-python-api`
3. If it doesn't exist, you need to deploy it (see Step 2)
4. If it exists, check its status:
   - ✅ **Live** = Service is running
   - ⏳ **Building** = Service is deploying (wait a few minutes)
   - ❌ **Failed** = Deployment failed (check logs)

### Step 2: Deploy Python Backend (If Not Deployed)

1. **Go to Render Dashboard** → Click **"New +"** → **"Web Service"**

2. **Connect Repository:**
   - Connect your GitHub account if not already connected
   - Select repository: `CompassionateITWEBDEV/BUILDMATE`

3. **Configure Service:**
   - **Name**: `buildmate-python-api`
   - **Environment**: **Python 3**
   - **Region**: Choose closest to your users
   - **Branch**: `main`
   - **Root Directory**: Leave empty (or set to repository root)

4. **Build & Start Commands:**
   - **Build Command**: `pip install -r Algorithm/python-backend/requirements.txt`
   - **Start Command**: `cd Algorithm/python-backend && python api.py`

5. **Environment Variables:**
   ```
   SUPABASE_URL=your_supabase_url
   SUPABASE_KEY=your_supabase_anon_key
   PORT=5000
   ```
   (Get these from your Supabase project settings)

6. **Plan**: Choose **Starter** (free tier) or higher

7. **Click "Create Web Service"**

8. **Wait for Deployment** (usually 2-5 minutes)

### Step 3: Verify Backend is Running

After deployment, test these URLs in your browser:

#### Test 1: Root Endpoint
```
https://buildmate-python-api.onrender.com/
```

**Expected Response:**
```json
{
  "message": "Python Algorithm Backend",
  "endpoints": ["/api/csp", "/api/graph", "/api/components", "/health"]
}
```

#### Test 2: Health Check
```
https://buildmate-python-api.onrender.com/health
```

**Expected Response:**
```json
{
  "status": "ok",
  "message": "Python backend is running"
}
```

#### Test 3: CSP Endpoint (POST)
Use a tool like Postman or curl:
```bash
curl -X POST https://buildmate-python-api.onrender.com/api/csp \
  -H "Content-Type: application/json" \
  -d '{"budget": 100000, "user_inputs": {}}'
```

**Expected Response:**
```json
{
  "solutions": [...],
  "total_found": 10
}
```

### Step 4: Update PYTHON_API_URL in Frontend

Once backend is confirmed working:

1. **Get the Backend URL** from Render dashboard
   - It should be: `https://buildmate-python-api.onrender.com`
   - Or: `https://buildmate-python-api-xxxx.onrender.com` (if custom name)

2. **Update Environment Variable:**

   **For Vercel:**
   - Go to Vercel Dashboard → Your Project → Settings → Environment Variables
   - Add/Update: `PYTHON_API_URL`
   - Value: `https://buildmate-python-api.onrender.com`
   - Save and redeploy

   **For Render (Next.js Service):**
   - Go to Render Dashboard → Your Next.js Service → Environment
   - Add/Update: `PYTHON_API_URL`
   - Value: `https://buildmate-python-api.onrender.com`
   - Save Changes (will auto-redeploy)

### Step 5: Check Render Logs

If backend is deployed but not working:

1. Go to **Python Backend Service** → **Logs** tab
2. Look for errors:
   - ❌ **Import errors**: Missing dependencies
   - ❌ **Database errors**: Wrong Supabase credentials
   - ❌ **Port errors**: PORT environment variable not set
   - ❌ **Module not found**: Missing Python files

## Common Issues & Solutions

### Issue 1: Service Not Found (404)

**Cause**: Backend service not deployed or wrong URL

**Solution**:
- Deploy the backend service (Step 2)
- Verify the URL matches exactly in `PYTHON_API_URL`
- Check Render dashboard for the correct service URL

### Issue 2: Service Unavailable (502/503)

**Cause**: Service is starting up or crashed

**Solution**:
- Wait 2-5 minutes for service to start (free tier is slow)
- Check Render logs for startup errors
- Verify environment variables are set correctly
- Check if service is in "Building" state

### Issue 3: CORS Errors

**Cause**: Backend not allowing requests from frontend domain

**Solution**:
- The Python backend already has `CORS(app)` configured
- If still getting CORS errors, check Render logs

### Issue 4: Database Connection Errors

**Cause**: Wrong Supabase credentials

**Solution**:
- Verify `SUPABASE_URL` and `SUPABASE_KEY` in Render environment variables
- Get correct values from Supabase Dashboard → Settings → API
- Use `anon` key, not `service_role` key

### Issue 5: Module Import Errors

**Cause**: Missing Python files or wrong paths

**Solution**:
- Check Render logs for import errors
- Verify all files are in `Algorithm/python-backend/` directory
- Ensure `requirements.txt` has all dependencies

## Quick Checklist

- [ ] Python backend service exists on Render
- [ ] Service status is "Live" (not "Building" or "Failed")
- [ ] Root endpoint (`/`) returns JSON
- [ ] Health endpoint (`/health`) returns `{"status": "ok"}`
- [ ] `PYTHON_API_URL` is set in frontend environment variables
- [ ] `PYTHON_API_URL` matches the actual Render service URL
- [ ] Frontend service has been redeployed after setting `PYTHON_API_URL`
- [ ] Supabase credentials are correct in backend environment variables

## Testing After Fix

1. Go to Builder page
2. Set a budget (minimum ₱10,000)
3. Click "CSP Recommendation Checker"
4. Should work without errors

## Still Not Working?

1. **Check Browser Console** (F12):
   - Look for network errors
   - Check if request is being made to correct URL

2. **Check Render Logs**:
   - Python backend service → Logs
   - Look for incoming requests and errors

3. **Check Vercel/Render Logs**:
   - Next.js service → Logs
   - Look for API route errors

4. **Verify URLs Match**:
   - Backend URL in Render dashboard
   - `PYTHON_API_URL` in frontend environment variables
   - Must match exactly (including `https://`)

## Need Help?

If still having issues:
1. Share Render service logs
2. Share browser console errors
3. Verify all environment variables are set
4. Check if service is on free tier (may be slow to start)

