# Quick Fix: Send Verification Codes to Gmail

## The Problem
Verification codes are being logged to console instead of sent to Gmail because Resend API key is not configured.

## Solution (2 minutes)

### Step 1: Get Resend API Key
1. Go to https://resend.com
2. Sign up or log in
3. Go to **API Keys** → **Create API Key**
4. Copy the key (starts with `re_`)

### Step 2: Create `.env.local` File
In your project root (same folder as `package.json`), create a file named `.env.local`:

```env
RESEND_API_KEY=re_your_actual_api_key_here
RESEND_FROM_EMAIL=BUILDMATE <onboarding@resend.dev>
```

**Replace `re_your_actual_api_key_here` with your actual Resend API key!**

### Step 3: Restart Your Server
1. Stop your Next.js server (Ctrl+C in terminal)
2. Start it again: `pnpm dev` or `npm run dev`

### Step 4: Test
1. Try registering again with your Gmail
2. Check your Gmail inbox (and spam folder)
3. You should receive the verification code email!

## What Changed
- ✅ Fixed Resend import to use ES6 syntax
- ✅ Better error messages showing what's missing
- ✅ Will actually send emails when API key is configured
- ✅ Uses `onboarding@resend.dev` (pre-verified domain) for testing

## Verify It's Working
After setup, when you try to register, you should see in your terminal:
```
📧 Sending verification email to: your-email@gmail.com
📧 From email: BUILDMATE <onboarding@resend.dev>
📧 API Key configured: Yes
✅ Email sent successfully: { id: '...' }
```

If you see errors, check the error message for details.

