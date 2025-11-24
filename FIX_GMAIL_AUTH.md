# 🔴 FIX: Gmail Authentication Failed

## Current Error:
```
Invalid login: 535-5.7.8 Username and Password not accepted
```

## Problem:
Gmail is **rejecting your credentials**. This means:
- ❌ You're using your **regular Gmail password** (won't work)
- ✅ You need a **Gmail App Password** (required for SMTP)

---

## ✅ FIX (3 Steps):

### Step 1: Get Gmail App Password

1. **Go to**: https://myaccount.google.com/apppasswords
2. **Sign in** with your Gmail account (`noreply.buildmate@gmail.com`)
3. **If you see "App passwords aren't available"**:
   - You need to enable **2-Factor Authentication** first
   - Go to: https://myaccount.google.com/security
   - Enable "2-Step Verification"
   - Then come back to App Passwords

4. **Create App Password**:
   - **Select app**: Choose "Mail"
   - **Select device**: Choose "Other (Custom name)"
   - **Enter name**: "BUILDMATE"
   - Click **"Generate"**

5. **Copy the password**:
   - You'll see: `abcd efgh ijkl mnop` (16 characters with spaces)
   - **Remove spaces**: `abcdefghijklmnop`
   - **Copy it immediately** - you can only see it once!

### Step 2: Update .env.local

Open `.env.local` and make sure it has:

```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=noreply.buildmate@gmail.com
SMTP_PASSWORD=abcdefghijklmnop
SMTP_FROM_EMAIL=BUILDMATE <noreply.buildmate@gmail.com>
SMTP_FROM_NAME=BUILDMATE
```

**Important:**
- Replace `abcdefghijklmnop` with your **actual 16-character App Password** (no spaces)
- Make sure `SMTP_USER` is your **full Gmail address**
- Make sure `SMTP_HOST` is `smtp.gmail.com` (not the email address)

### Step 3: Restart Server

1. **Stop**: Press `Ctrl+C` in terminal
2. **Start**: Run `pnpm dev`

---

## ✅ After Fixing:

You should see:
```
✅ SMTP connection verified successfully
✅ Email sent successfully via Supabase SMTP
```

And verification codes will be sent to Gmail inboxes!

---

## ❌ Common Mistakes:

1. **Using regular password**: `SMTP_PASSWORD=your_regular_password` ❌
   - **Fix**: Use Gmail App Password

2. **Wrong username**: `SMTP_USER=gmail.com` ❌
   - **Fix**: Use full email: `noreply.buildmate@gmail.com`

3. **Spaces in password**: `SMTP_PASSWORD=abcd efgh ijkl mnop` ❌
   - **Fix**: Remove spaces: `abcdefghijklmnop`

4. **2FA not enabled**: Can't create App Password ❌
   - **Fix**: Enable 2-Factor Authentication first

---

## 🔑 Quick Checklist:

- [ ] 2-Factor Authentication enabled on Gmail
- [ ] Went to https://myaccount.google.com/apppasswords
- [ ] Created App Password for "Mail" → "Other" → "BUILDMATE"
- [ ] Copied 16-character password (removed spaces)
- [ ] Updated `.env.local` with App Password
- [ ] Saved file (Ctrl+S)
- [ ] **Restarted server** (Ctrl+C, then `pnpm dev`)
- [ ] Tested registration

---

## 🆘 Still Not Working?

### Check 1: Is 2FA Enabled?
- Go to: https://myaccount.google.com/security
- Make sure "2-Step Verification" is ON
- If not, enable it first

### Check 2: Is App Password Correct?
- Make sure you copied the **full 16 characters**
- Make sure you **removed all spaces**
- Try creating a **new App Password** if unsure

### Check 3: Is Username Correct?
- Should be: `noreply.buildmate@gmail.com`
- Not: `smtp.gmail.com` or just `gmail.com`

### Check 4: Did You Restart?
- **Must restart server** after changing `.env.local`
- Environment variables only load on startup

---

## 💡 Remember:

- ❌ Regular Gmail password = Authentication failed
- ✅ Gmail App Password = Authentication successful

**You MUST use App Password for Gmail SMTP!**

