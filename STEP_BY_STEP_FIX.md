# 🔧 Step-by-Step: Fix Email Verification

## Current Problem:
```
Failed to send verification email. Please check your Resend configuration and verify your domain
```

**Root Cause**: Your `.env.local` still has the placeholder API key: `re_your_api_key_here`

---

## ✅ Complete Fix (Follow Each Step):

### STEP 1: Open Resend Website
1. Open your web browser
2. Go to: **https://resend.com/api-keys**
3. **Sign in** (or create a free account if you don't have one)

### STEP 2: Create API Key
1. Click the **"Create API Key"** button (usually blue/green)
2. Enter a name: `BUILDMATE Development`
3. Click **"Add"** or **"Create"**
4. **IMMEDIATELY COPY** the key that appears
   - It will look like: `re_abc123xyz456def789ghi012jkl345mno678pqr901stu234vwx567`
   - Starts with `re_`
   - Is 40+ characters long
   - ⚠️ **You can only see it once!**

### STEP 3: Update .env.local File

**Option A: Using Code Editor (Recommended)**
1. Open `.env.local` in VS Code (or your editor)
2. Find this line:
   ```env
   RESEND_API_KEY=re_your_api_key_here
   ```
3. Replace `re_your_api_key_here` with your **actual key** from Step 2
4. It should look like:
   ```env
   RESEND_API_KEY=re_abc123xyz456def789ghi012jkl345mno678pqr901stu234vwx567
   ```
   (Use YOUR actual key, not this example!)
5. **Save the file** (Ctrl+S)

**Option B: Using PowerShell**
```powershell
# Replace YOUR_ACTUAL_KEY with the key from Resend
(Get-Content .env.local) -replace 'RESEND_API_KEY=re_your_api_key_here', 'RESEND_API_KEY=YOUR_ACTUAL_KEY' | Set-Content .env.local
```

### STEP 4: Verify the Change
Run this command to check:
```powershell
Get-Content .env.local | Select-String "RESEND_API_KEY"
```

You should see your **actual key** (40+ characters), NOT `re_your_api_key_here`

### STEP 5: Restart Your Server
⚠️ **CRITICAL**: Environment variables only load when the server starts!

1. **Stop the server**: Press `Ctrl+C` in your terminal
2. **Start it again**: Run `pnpm dev` (or `npm run dev`)

### STEP 6: Test
1. Go to your registration page
2. Enter your email (Gmail, Yahoo, etc.)
3. Click "Send Verification Code"
4. Check your email inbox (and spam folder)

---

## ✅ Success Indicators:

After fixing, in your terminal you should see:
```
📧 Sending verification email to: your-email@gmail.com
📧 From email: BUILDMATE <onboarding@resend.dev>
📧 API Key configured: Yes
✅ Email sent successfully: { id: 'email_...', ... }
```

And you'll receive the email!

---

## ❌ If Still Not Working:

### Check 1: API Key Format
- ✅ Should start with `re_`
- ✅ Should be 40+ characters
- ✅ No spaces or quotes around it
- ✅ Should be on one line

### Check 2: Server Restart
- ✅ Did you stop the server (Ctrl+C)?
- ✅ Did you start it again (`pnpm dev`)?
- ✅ Environment variables only load on startup!

### Check 3: Resend Account
- ✅ Is your Resend account active?
- ✅ Is the API key still active in Resend dashboard?
- ✅ Check Resend dashboard for any errors

### Check 4: Domain Verification
- The error mentions "verify your domain"
- For testing, `onboarding@resend.dev` should work without domain verification
- If you're using a custom domain, you need to verify it in Resend

---

## 🆘 Still Stuck?

1. **Check terminal output** - Look for specific error messages
2. **Verify in Resend dashboard** - Make sure the API key is active
3. **Try creating a NEW API key** - Sometimes keys can be invalid
4. **Check email format** - Make sure you're using a valid email address

---

## 📝 Quick Checklist:

- [ ] Got API key from https://resend.com/api-keys
- [ ] Copied the FULL key (40+ characters)
- [ ] Updated `.env.local` file
- [ ] Saved the file
- [ ] **Restarted the server** (Ctrl+C then `pnpm dev`)
- [ ] Tested registration/forgot password
- [ ] Checked email inbox and spam folder

---

## 💡 Pro Tip:

If you're still having issues, check the terminal output when you try to send an email. The error message will tell you exactly what's wrong:
- `API key is invalid` = Wrong key or placeholder
- `Domain not verified` = Need to verify domain in Resend
- `Rate limit exceeded` = Too many requests, wait a bit

