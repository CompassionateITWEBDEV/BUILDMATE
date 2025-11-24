# 🔧 Fix: Replace Placeholder API Key

## Current Problem
Your `.env.local` file has: `RESEND_API_KEY=re_your_api_key_here`
This is a **placeholder**, not a real API key. You need to replace it with your actual Resend API key.

---

## ✅ Solution: Get Real API Key (5 minutes)

### Step 1: Open Resend Dashboard
👉 **Go to:** https://resend.com/api-keys

### Step 2: Sign In or Create Account
- If you don't have an account, click "Sign Up" (it's free)
- Verify your email if prompted

### Step 3: Create API Key
1. Click the **"Create API Key"** button (usually blue/green button)
2. Enter a name: `BUILDMATE Development`
3. Click **"Add"** or **"Create"**
4. **IMPORTANT:** Copy the key immediately - it looks like:
   ```
   re_abc123xyz456def789ghi012jkl345mno678pqr901stu234vwx567
   ```
   - Starts with `re_`
   - Is 40+ characters long
   - You'll only see it once!

### Step 4: Update `.env.local`

**Option A: Manual Edit**
1. Open `.env.local` in your code editor
2. Find: `RESEND_API_KEY=re_your_api_key_here`
3. Replace with: `RESEND_API_KEY=re_your_actual_key_from_step_3`
4. Save the file (Ctrl+S)

**Option B: Using PowerShell** (if you have the key ready)
```powershell
# Replace YOUR_ACTUAL_KEY with the key from Resend
(Get-Content .env.local) -replace 'RESEND_API_KEY=re_your_api_key_here', 'RESEND_API_KEY=YOUR_ACTUAL_KEY' | Set-Content .env.local
```

### Step 5: Restart Server ⚠️ CRITICAL
1. In terminal, press **Ctrl+C** to stop
2. Run: `pnpm dev` or `npm run dev`

### Step 6: Test
Try registering again. You should see:
```
✅ Email sent successfully
```

---

## 🎯 Quick Checklist

- [ ] Opened https://resend.com/api-keys
- [ ] Signed in to Resend
- [ ] Created a new API key
- [ ] Copied the key (40+ characters, starts with `re_`)
- [ ] Updated `.env.local` file
- [ ] Saved the file
- [ ] **Restarted the server** (Ctrl+C then `pnpm dev`)
- [ ] Tested registration

---

## ❓ Still Not Working?

### Check 1: Is the key correct?
- Should start with `re_`
- Should be 40+ characters
- No spaces or quotes around it

### Check 2: Did you restart?
- Environment variables only load on server startup
- Must restart after changing `.env.local`

### Check 3: Check terminal output
After restarting, when you try to register, you should see:
```
📧 API Key configured: Yes
✅ Email sent successfully
```

If you see `❌ Resend email error`, check the error message for details.

---

## 🆘 Need Help?

If you're stuck:
1. Make sure you have a Resend account (free signup)
2. Verify the API key is active in Resend dashboard
3. Check that `.env.local` is in the project root (same folder as `package.json`)
4. Ensure no extra spaces or quotes in the API key

