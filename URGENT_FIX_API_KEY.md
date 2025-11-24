# 🚨 URGENT: Fix Invalid API Key Error

## Current Error:
```
❌ Resend email error: {
  "statusCode": 401,
  "name": "validation_error",
  "message": "API key is invalid"
}
```

## Why This Happens:
Your `.env.local` file contains: `RESEND_API_KEY=re_your_api_key_here`

This is a **PLACEHOLDER**, not a real API key. Resend rejects it because it's not valid.

---

## ✅ Fix in 3 Steps (5 minutes):

### Step 1: Get Real API Key

1. **Open your browser** and go to:
   ```
   https://resend.com/api-keys
   ```

2. **Sign in** (or create free account if needed)

3. **Click "Create API Key"** button

4. **Name it**: `BUILDMATE Development`

5. **Copy the key** - it will look like:
   ```
   re_abc123xyz456def789ghi012jkl345mno678pqr901stu234vwx567
   ```
   - Starts with `re_`
   - Is 40+ characters long
   - ⚠️ **You'll only see it once!** Copy it immediately.

### Step 2: Update `.env.local`

1. **Open** `.env.local` in your code editor

2. **Find this line**:
   ```env
   RESEND_API_KEY=re_your_api_key_here
   ```

3. **Replace** `re_your_api_key_here` with your **actual key** from Step 1:
   ```env
   RESEND_API_KEY=re_abc123xyz456def789ghi012jkl345mno678pqr901stu234vwx567
   ```
   (Use YOUR actual key, not this example!)

4. **Save the file** (Ctrl+S)

### Step 3: Restart Server

1. **Stop server**: Press `Ctrl+C` in terminal

2. **Start server**: Run `pnpm dev`

3. **Test**: Try registering again

---

## ✅ Success Indicators:

After fixing, you should see in terminal:
```
📧 Sending verification email to: your-email@gmail.com
📧 From email: BUILDMATE <onboarding@resend.dev>
📧 API Key configured: Yes
✅ Email sent successfully: { id: 'email_...', ... }
```

And you'll receive the email in your Gmail inbox!

---

## ❌ Common Mistakes:

1. **Using placeholder**: `re_your_api_key_here` ❌
2. **Not restarting server**: Environment variables only load on startup ❌
3. **Extra spaces**: `RESEND_API_KEY = re_...` ❌ (no spaces around `=`)
4. **Quotes**: `RESEND_API_KEY="re_..."` ❌ (no quotes needed)

---

## 🆘 Still Not Working?

1. **Double-check** the key in `.env.local` matches exactly what you copied
2. **Verify** the key is active in Resend dashboard
3. **Check** you restarted the server after updating `.env.local`
4. **Look** at terminal output for specific error messages

---

## 📧 Need Help?

If you're stuck:
- Check `FIX_API_KEY.md` for detailed instructions
- Verify your Resend account is active
- Make sure the API key hasn't been revoked in Resend dashboard

