# Environment Setup Guide

## JSON.parse Error Fix

The "JSON.parse: unexpected character at line 1 column 1 of the JSON data" error you're experiencing is caused by missing Supabase environment variables.

## Quick Fix

1. **Create a `.env.local` file** in your project root with the following content:

```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url_here
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key_here
```

2. **Get your Supabase credentials:**
   - Go to your [Supabase Dashboard](https://supabase.com/dashboard)
   - Select your project
   - Navigate to **Settings** → **API**
   - Copy the **Project URL** and **anon/public** key
   - Replace the placeholder values in your `.env.local` file

3. **Restart your development server:**
   ```bash
   npm run dev
   # or
   pnpm dev
   ```

## What Was Fixed

- Added proper error handling for missing environment variables
- The app now shows helpful error messages instead of crashing
- Added configuration checks in all API routes
- Created fallback Supabase client to prevent crashes

## Verification

After setting up the environment variables, you should see:
- No more JSON parsing errors
- Proper error messages if Supabase is not configured
- Successful API calls when properly configured

## Troubleshooting

If you're still seeing errors:
1. Make sure `.env.local` is in the project root (same level as `package.json`)
2. Verify the environment variable names are exactly as shown above
3. Restart your development server after making changes
4. Check the browser console for any remaining error messages


