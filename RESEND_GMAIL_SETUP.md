# Quick Setup: Resend Email Verification for Gmail

## Problem
Verification codes are not being sent to Gmail because Resend requires a verified sender domain/email.

## Solution: Set Up Resend (5 minutes)

### Step 1: Create Resend Account
1. Go to https://resend.com
2. Sign up with your email (can use Gmail)
3. Verify your email address

### Step 2: Get Your API Key
1. After logging in, go to **API Keys** in the sidebar
2. Click **Create API Key**
3. Name it "BUILDMATE Development" or "BUILDMATE Production"
4. **Copy the API key immediately** (starts with `re_`)

### Step 3: Create `.env.local` File
Create a file named `.env.local` in the root of your project (same folder as `package.json`):

```env
# Resend Email Service Configuration
RESEND_API_KEY=re_your_actual_api_key_here

# For testing, use Resend's default test domain (no verification needed)
RESEND_FROM_EMAIL=BUILDMATE <onboarding@resend.dev>

# For production, use your verified domain (after domain verification)
# RESEND_FROM_EMAIL=BUILDMATE <noreply@yourdomain.com>
```

**Important:**
- Replace `re_your_actual_api_key_here` with your actual Resend API key
- For **testing/development**, use `onboarding@resend.dev` (already verified by Resend)
- For **production**, you'll need to verify your own domain

### Step 4: Restart Your Development Server
After creating `.env.local`:
1. Stop your Next.js server (Ctrl+C)
2. Start it again: `npm run dev` or `pnpm dev`

### Step 5: Test Email Sending
1. Go to the registration page
2. Enter your Gmail address
3. Click "Send Verification Code"
4. Check your Gmail inbox (and spam folder)

## For Production: Verify Your Domain

If you want to use your own domain (e.g., `noreply@yourdomain.com`):

1. In Resend dashboard, go to **Domains**
2. Click **Add Domain**
3. Enter your domain (e.g., `yourdomain.com`)
4. Add the DNS records provided by Resend to your domain's DNS settings
5. Wait for verification (usually 5-10 minutes)
6. Update `.env.local`:
   ```env
   RESEND_FROM_EMAIL=BUILDMATE <noreply@yourdomain.com>
   ```

## Troubleshooting

### Email Still Not Sending?

1. **Check `.env.local` exists**: Make sure the file is in the root directory
2. **Check API Key**: Verify it starts with `re_` and is correct
3. **Check Server Logs**: Look at your terminal/console for error messages
4. **Check Resend Dashboard**: Go to Resend dashboard → Emails to see delivery status
5. **Restart Server**: After changing `.env.local`, always restart your dev server

### Common Errors

**Error: "Domain not verified"**
- Solution: Use `onboarding@resend.dev` for testing, or verify your domain

**Error: "Invalid API key"**
- Solution: Double-check your API key in `.env.local`

**Error: "Rate limit exceeded"**
- Solution: Resend free tier allows 100 emails/day. Wait or upgrade plan

### Check Console Logs

The updated code now logs detailed information:
- `📧 Sending verification email to: [email]` - Email is being sent
- `✅ Email sent successfully` - Email was sent successfully
- `❌ Resend email error:` - Error occurred (check details)

## Quick Test

After setup, you should see in your terminal:
```
📧 Sending verification email to: your-email@gmail.com
📧 From email: BUILDMATE <onboarding@resend.dev>
✅ Email sent successfully: { id: '...' }
```

If you see errors, check the error message for details.

