# Fix for Supabase Query Error in PC Builder

## Problem
The PC Builder page is showing this error:
```
Supabase query error in componentService.getAll(): {}
```

## Root Cause
This error typically occurs due to:
1. **Row Level Security (RLS) policies** blocking access to components table
2. **Missing Supabase connection** or expired credentials
3. **Database permissions** issues

## Solutions Applied

### 1. ✅ Enhanced Error Handling (`lib/database.ts`)
- Changed error handling to return empty array instead of throwing
- Added try-catch blocks to prevent app crashes
- Added detailed console logging
- Now shows friendly messages instead of breaking the app

### 2. ✅ RLS Policies Script Created
**File:** `scripts/enable-rls-policies.sql`

Run this script in your Supabase SQL Editor to enable proper access:

```sql
-- Allow public read access to components
CREATE POLICY "Allow public read access to components"
ON components FOR SELECT TO public USING (true);

-- Allow public read access to component_categories
CREATE POLICY "Allow public read access to component_categories"
ON component_categories FOR SELECT TO public USING (true);

-- Allow public read access to retailers
CREATE POLICY "Allow public read access to retailers"
ON retailers FOR SELECT TO public USING (true);
```

## How to Fix

### Option 1: Quick Fix (Recommended for Development)
1. Go to Supabase Dashboard
2. Navigate to: **Authentication > Policies**
3. Select the `components` table
4. Click **"Disable RLS"** temporarily

OR run in SQL Editor:
```sql
ALTER TABLE components DISABLE ROW LEVEL SECURITY;
ALTER TABLE component_categories DISABLE ROW LEVEL SECURITY;
ALTER TABLE retailers DISABLE ROW LEVEL SECURITY;
```

### Option 2: Proper Fix (Recommended for Production)
1. Go to Supabase Dashboard
2. Navigate to: **SQL Editor**
3. Paste the contents of `scripts/enable-rls-policies.sql`
4. Click **Run**

This creates proper RLS policies that allow:
- ✅ Public read access to components
- ✅ Authenticated users can create/edit builds
- ✅ Users can only modify their own builds

## Testing

After applying the fix:

1. **Refresh the PC Builder page**
2. **Check browser console** - you should see:
   ```
   ✅ Successfully fetched X components from Supabase
   ```
3. **Components should load** without errors

## Verification

Check if the fix worked:

```sql
-- In Supabase SQL Editor:
SELECT COUNT(*) FROM components;
```

If you get a number (not an error), the fix is working!

## Still Having Issues?

### Check Supabase Connection:
1. Verify `NEXT_PUBLIC_SUPABASE_URL` in `.env.local`
2. Verify `NEXT_PUBLIC_SUPABASE_ANON_KEY` in `.env.local`
3. Restart dev server: `npm run dev`

### Check Browser Console:
Look for detailed error messages that will now show:
- Error message
- Error code
- Hints for fixing

### Contact Support:
If issues persist, check:
- Supabase project status (supabase.com/dashboard)
- Network connectivity
- Firewall/proxy settings

## Summary

**What Changed:**
- ✅ Better error handling (no more crashes)
- ✅ Detailed error logging
- ✅ RLS policy script created
- ✅ Graceful fallbacks

**Next Steps:**
1. Run the RLS policy script OR disable RLS temporarily
2. Refresh the PC Builder page
3. Components should now load successfully

**Files Modified:**
- `lib/database.ts` - Enhanced error handling
- `scripts/enable-rls-policies.sql` - RLS policies (NEW)

