# Setup Resend API Key - Step by Step

## Current Issue
Your `.env.local` file has a placeholder API key. You need to replace it with a real one from Resend.

## Quick Setup (5 minutes)

### Step 1: Get Your Resend API Key

1. **Open Resend Dashboard**
   - Go to: https://resend.com
   - Sign in (or create free account)

2. **Create API Key**
   - Click on **"API Keys"** in the left sidebar
   - Click **"Create API Key"** button
   - Give it a name: `BUILDMATE Development`
   - Click **"Add"**
   - **IMPORTANT:** Copy the key immediately (you'll only see it once!)
   - It should look like: `re_abc123xyz456def789ghi012jkl345mno678pqr901stu234vwx567`

### Step 2: Update `.env.local`

1. **Open `.env.local`** in your code editor (VS Code/Cursor)

2. **Find this line:**
   ```env
   RESEND_API_KEY=re_your_api_key_here
   ```

3. **Replace with your actual key:**
   ```env
   RESEND_API_KEY=re_your_actual_long_key_here
   ```
   
   **Example:**
   ```env
   RESEND_API_KEY=re_abc123xyz456def789ghi012jkl345mno678pqr901stu234vwx567
   ```

4. **Make sure:**
   - ✅ No spaces around the `=`
   - ✅ No quotes around the key
   - ✅ The entire key is on one line
   - ✅ Key starts with `re_`
   - ✅ Key is 40+ characters long

5. **Save the file** (Ctrl+S)

### Step 3: Restart Your Server

**CRITICAL:** You MUST restart your server for changes to take effect!

1. In your terminal, press **Ctrl+C** to stop the server
2. Start it again: `pnpm dev` or `npm run dev`

### Step 4: Test

1. Try registering with your Gmail
2. Check your terminal - you should see:
   ```
   📧 Sending verification email to: your-email@gmail.com
   📧 API Key configured: Yes
   ✅ Email sent successfully: { id: '...' }
   ```
3. Check your Gmail inbox (and spam folder)

## Troubleshooting

### Still getting "API key is invalid"?

1. **Check the key format:**
   - Should start with `re_`
   - Should be 40+ characters
   - No spaces or quotes

2. **Verify in Resend Dashboard:**
   - Go to https://resend.com/api-keys
   - Make sure the key is "Active"
   - If not, create a new one

3. **Restart server:**
   - Environment variables only load on startup
   - Stop (Ctrl+C) and start again

4. **Check for typos:**
   - Make sure you copied the entire key
   - No extra characters or spaces

### Need a new API key?

If you lost your key or it's not working:
1. Go to https://resend.com/api-keys
2. Delete the old key (if needed)
3. Create a new one
4. Update `.env.local`
5. Restart server

## Free Tier Limits

Resend free tier includes:
- ✅ 3,000 emails per month
- ✅ 100 emails per day
- ✅ Perfect for development and testing

## Still Having Issues?

Check your terminal for detailed error messages. The code now logs:
- `📧 API Key configured: Yes/No` - Shows if key is detected
- `❌ Resend email error:` - Shows the actual error from Resend
- `✅ Email sent successfully` - Confirms email was sent

