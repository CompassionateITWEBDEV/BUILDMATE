# 🚨 FIX THIS NOW - Step by Step

## Current Error:
```
❌ Resend email error: {
  "statusCode": 401,
  "name": "validation_error",
  "message": "API key is invalid"
}
```

## Root Cause:
Your `.env.local` file contains: `RESEND_API_KEY=re_your_api_key_here`

This is a **PLACEHOLDER**, not a real API key!

---

## ✅ FIX IN 5 MINUTES:

### STEP 1: Get Real API Key (2 minutes)

1. **Open your web browser**
2. **Go to**: https://resend.com/api-keys
3. **Sign in** (or create free account if needed)
4. **Click "Create API Key"** button
5. **Name it**: `BUILDMATE`
6. **COPY THE KEY IMMEDIATELY**
   - It looks like: `re_abc123xyz456def789ghi012jkl345mno678pqr901stu234vwx567`
   - Starts with `re_`
   - Is 40+ characters long
   - ⚠️ **You can only see it once!**

### STEP 2: Update .env.local (1 minute)

**Option A: Using VS Code (Easiest)**
1. Open VS Code
2. Open `.env.local` file (in project root)
3. Find this line:
   ```
   RESEND_API_KEY=re_your_api_key_here
   ```
4. **Delete** `re_your_api_key_here`
5. **Paste** your actual key from Step 1
6. Should look like:
   ```
   RESEND_API_KEY=re_abc123xyz456def789ghi012jkl345mno678pqr901stu234vwx567
   ```
   (Use YOUR actual key, not this example!)
7. **Save** (Ctrl+S)

**Option B: Using PowerShell**
```powershell
# Replace YOUR_ACTUAL_KEY with the key you copied
(Get-Content .env.local) -replace 'RESEND_API_KEY=re_your_api_key_here', 'RESEND_API_KEY=YOUR_ACTUAL_KEY' | Set-Content .env.local
```

### STEP 3: Verify the Change (30 seconds)

Run this to check:
```powershell
Get-Content .env.local | Select-String "RESEND_API_KEY"
```

You should see your **actual key** (40+ characters), NOT `re_your_api_key_here`

### STEP 4: Restart Server (1 minute)

⚠️ **CRITICAL**: Environment variables only load when server starts!

1. **Stop server**: Press `Ctrl+C` in terminal
2. **Start server**: Run `pnpm dev`
3. **Wait** for server to start

### STEP 5: Test (30 seconds)

1. Go to registration page
2. Enter your email
3. Click "Send Verification Code"
4. Check terminal - should see:
   ```
   ✅ Email sent successfully
   ```
5. Check your email inbox!

---

## ✅ Success Indicators:

**In Terminal:**
```
📧 Sending verification email to: your-email@gmail.com
📧 From email: BUILDMATE <onboarding@resend.dev>
📧 API Key configured: Yes
✅ Email sent successfully: { id: 'email_...', ... }
```

**In Email:**
- You'll receive the verification code in your Gmail inbox!

---

## ❌ Common Mistakes:

1. **Using placeholder**: `re_your_api_key_here` ❌
2. **Not restarting server**: Must restart after changing `.env.local` ❌
3. **Extra spaces**: `RESEND_API_KEY = re_...` ❌ (no spaces)
4. **Quotes**: `RESEND_API_KEY="re_..."` ❌ (no quotes)
5. **Wrong key**: Using an old/revoked key ❌

---

## 🆘 Still Not Working?

### Check 1: Is the key correct?
- ✅ Starts with `re_`
- ✅ Is 40+ characters
- ✅ No spaces or quotes
- ✅ Matches exactly what you copied

### Check 2: Did you restart?
- ✅ Stopped server (Ctrl+C)?
- ✅ Started server (`pnpm dev`)?
- ✅ Environment variables only load on startup!

### Check 3: Is key active?
- ✅ Check Resend dashboard
- ✅ Make sure key is not revoked
- ✅ Create a new key if needed

---

## 📝 Quick Checklist:

- [ ] Got API key from https://resend.com/api-keys
- [ ] Copied FULL key (40+ characters)
- [ ] Opened `.env.local` file
- [ ] Replaced `re_your_api_key_here` with actual key
- [ ] Saved file (Ctrl+S)
- [ ] **Restarted server** (Ctrl+C then `pnpm dev`)
- [ ] Tested registration
- [ ] Checked email inbox

---

## 💡 Why This Happens:

The error `"API key is invalid"` means Resend is rejecting your key because:
- It's a placeholder, not a real key
- The key is revoked/expired
- The key has typos

**Solution**: Get a real, active API key from Resend and replace the placeholder.

---

## 🎯 Bottom Line:

**You MUST replace `re_your_api_key_here` with a REAL API key from Resend.**

Until you do this, emails will NOT work. There's no workaround - you need a valid Resend API key.

