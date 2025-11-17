# How to Disable Email Confirmation in Supabase

## Problem
If you're seeing the error "Email not confirmed" when trying to log in, it means Supabase Auth is requiring email confirmation before allowing users to sign in.

## Solution 1: Disable Email Confirmation in Supabase Dashboard (Recommended)

1. **Go to your Supabase Dashboard**
   - Navigate to: https://supabase.com/dashboard
   - Select your project

2. **Navigate to Authentication Settings**
   - Click on "Authentication" in the left sidebar
   - Click on "Settings" (gear icon)

3. **Disable Email Confirmation**
   - Scroll down to "Email Auth" section
   - Find "Enable email confirmations" toggle
   - **Turn it OFF**
   - Click "Save" at the bottom

4. **Test**
   - Try logging in again
   - The error should be gone

## Solution 2: Use Custom Authentication (Current Implementation)

This codebase uses a **custom users table** for authentication, which doesn't require email confirmation:

- **Location**: `contexts/supabase-auth-context.tsx`
- **How it works**: 
  - Users are stored in a custom `users` table
  - Passwords are hashed with bcrypt
  - No email confirmation required
  - Login/register directly query the database

**This is already implemented and working!** The error you're seeing might be from:
- A different part of the codebase using Supabase Auth
- An old authentication flow that hasn't been updated
- A different project entirely

## Solution 3: Auto-Confirm Users Programmatically

If you must use Supabase Auth and can't disable email confirmation in the dashboard, you can auto-confirm users when they register:

### Server-Side API Route Example

```typescript
// app/api/auth/register-with-confirmation/route.ts
import { createClient } from '@supabase/supabase-js'
import { NextRequest, NextResponse } from 'next/server'

const supabaseAdmin = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY! // Service role key, not anon key
)

export async function POST(request: NextRequest) {
  const { email, password } = await request.json()

  // Create user
  const { data: authData, error: authError } = await supabaseAdmin.auth.admin.createUser({
    email,
    password,
    email_confirm: true // Auto-confirm email
  })

  if (authError) {
    return NextResponse.json({ error: authError.message }, { status: 400 })
  }

  return NextResponse.json({ success: true, user: authData.user })
}
```

**Important**: 
- This requires the `SUPABASE_SERVICE_ROLE_KEY` environment variable
- Never expose the service role key to the client
- Only use this in server-side API routes

## Current Implementation Status

✅ **Custom Authentication**: Already implemented and working
- Uses custom `users` table
- No email confirmation required
- See: `contexts/supabase-auth-context.tsx`

❌ **Supabase Auth**: Not used for login/register
- Only used for token verification in some API routes
- Should not trigger email confirmation errors

## Troubleshooting

If you're still seeing the error:

1. **Check which authentication method is being used**
   - Look for `supabase.auth.signInWithPassword` in your code
   - Replace it with the custom auth system

2. **Check Supabase Dashboard settings**
   - Verify email confirmation is disabled
   - Check if there are any other auth settings causing issues

3. **Clear browser cache and localStorage**
   - Old auth tokens might be cached
   - Clear `localStorage` and try again

4. **Check for multiple Supabase clients**
   - Make sure you're using the same Supabase instance
   - Check `lib/supabase.ts` for the client configuration


