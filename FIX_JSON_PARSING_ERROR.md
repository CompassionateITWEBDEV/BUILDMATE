# ✅ Fixed: "Unexpected token '<', "<!doctype "... is not valid JSON"

## Problem

When the Python backend is not deployed or returns an HTML error page (404, 502, etc.), the code tried to parse HTML as JSON, causing this error:

```
Unexpected token '<', "<!doctype "... is not valid JSON
```

## ✅ What Was Fixed

### 1. Server-Side API Routes (`app/api/algorithms/csp/route.ts` & `app/api/algorithms/upgrade/route.ts`)

- ✅ **Content-Type Validation**: Checks if response is JSON before parsing
- ✅ **HTML Detection**: Detects HTML responses (starts with `<!`)
- ✅ **Better Error Messages**: Provides specific messages for different error scenarios:
  - 404: "Python backend endpoint not found. Please check PYTHON_API_URL"
  - 502/503: "Python backend service is unavailable. The service may be starting up"
  - HTML response: "Python backend returned HTML error page"
- ✅ **JSON Parsing Protection**: Catches JSON parsing errors and provides helpful messages

### 2. Client-Side Service (`lib/algorithm-service.ts`)

- ✅ **Content-Type Validation**: Validates response is JSON before parsing
- ✅ **HTML Detection**: Detects and handles HTML error pages
- ✅ **Better Error Handling**: Catches JSON parsing errors and provides user-friendly messages
- ✅ **Network Error Handling**: Improved messages for connection failures

## Common Causes

1. **Python Backend Not Deployed**: Backend service doesn't exist on Render
2. **Wrong PYTHON_API_URL**: URL points to wrong service or localhost
3. **Backend Service Down**: Service is starting up or crashed
4. **404 Error**: Endpoint doesn't exist (wrong URL path)
5. **CORS Issues**: Backend not allowing requests from frontend domain

## How to Fix

### Step 1: Deploy Python Backend on Render

1. Go to Render Dashboard
2. Create new **Web Service**:
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

### Step 2: Update PYTHON_API_URL in Vercel/Render

1. Go to your Next.js service (Vercel or Render)
2. **Environment Variables** tab
3. Add/Update `PYTHON_API_URL`:
   ```
   PYTHON_API_URL=https://buildmate-python-api.onrender.com
   ```
   (Replace with your actual Python backend URL)

### Step 3: Verify Backend is Running

1. Visit the Python backend URL directly:
   ```
   https://your-python-backend-url.onrender.com/
   ```
2. Should return JSON:
   ```json
   {
     "message": "Python Algorithm Backend",
     "endpoints": ["/api/csp", "/api/graph", "/api/components", "/health"]
   }
   ```

### Step 4: Test CSP Feature

1. Go to Builder page
2. Set a budget (minimum ₱10,000)
3. Click "CSP Recommendation Checker"
4. Should work without JSON parsing errors

## Error Messages You'll See Now

Instead of cryptic JSON parsing errors, you'll see helpful messages:

- ✅ "Python backend endpoint not found. Please check PYTHON_API_URL"
- ✅ "Python backend service is unavailable. The service may be starting up"
- ✅ "Cannot connect to Python backend at [URL]. Please make sure the backend service is deployed and running"
- ✅ "Backend returned invalid response. Please verify the Python backend service is deployed and running correctly"

## Troubleshooting

### Still Getting JSON Errors?

1. **Check PYTHON_API_URL**:
   - Should be: `https://your-backend-url.onrender.com`
   - NOT: `http://localhost:5000`

2. **Check Backend Health**:
   - Visit: `https://your-backend-url.onrender.com/health`
   - Should return: `{"status": "ok", "message": "Python backend is running"}`

3. **Check Render Logs**:
   - Go to Python backend service → **Logs** tab
   - Look for errors or startup issues

4. **Check Vercel/Render Logs**:
   - Go to Next.js service → **Logs** tab
   - Look for connection errors or API errors

## Notes

- The error handling now gracefully handles HTML responses
- You'll get clear error messages instead of JSON parsing errors
- The backend URL is shown in error messages for easier debugging
- All error cases are now handled properly

