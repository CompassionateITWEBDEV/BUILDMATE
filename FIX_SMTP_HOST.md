# 🔴 FIX: SMTP_HOST Error

## Current Error:
```
getaddrinfo ENOTFOUND your_smtp_host
```

## Problem:
Your `.env.local` file has:
```
SMTP_HOST=your_smtp_host
```

This is a **PLACEHOLDER**, not a real SMTP host!

---

## ✅ FIX (2 Steps):

### Step 1: Update `.env.local`

Open `.env.local` and find:
```
SMTP_HOST=your_smtp_host
```

**Replace it with:**
```
SMTP_HOST=smtp.gmail.com
```

**For other providers:**
- Gmail: `SMTP_HOST=smtp.gmail.com`
- SendGrid: `SMTP_HOST=smtp.sendgrid.net`
- Mailgun: `SMTP_HOST=smtp.mailgun.org`

### Step 2: Make Sure All SMTP Variables Are Set

Your `.env.local` should have:
```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your_gmail_app_password
SMTP_FROM_EMAIL=BUILDMATE <your-email@gmail.com>
SMTP_FROM_NAME=BUILDMATE
```

**Important:**
- Replace `your-email@gmail.com` with your actual Gmail
- Replace `your_gmail_app_password` with your Gmail App Password
- Get App Password: https://myaccount.google.com/apppasswords

### Step 3: Restart Server

1. Press **Ctrl+C** to stop
2. Run `pnpm dev` to start again

---

## ✅ After Fixing:

You should see in terminal:
```
📧 SMTP Host: smtp.gmail.com
✅ SMTP connection verified successfully
✅ Email sent successfully via Supabase SMTP
```

And you'll receive the email in Gmail!

---

## ❌ Common Mistakes:

1. **Using placeholder**: `SMTP_HOST=your_smtp_host` ❌
2. **Wrong host**: `SMTP_HOST=gmail.com` ❌ (should be `smtp.gmail.com`)
3. **Not restarting**: Must restart after changing `.env.local` ❌
4. **Wrong password**: Using regular Gmail password instead of App Password ❌

---

## 🎯 Quick Fix:

1. Open `.env.local`
2. Find `SMTP_HOST=your_smtp_host`
3. Change to `SMTP_HOST=smtp.gmail.com`
4. Save file
5. Restart server (Ctrl+C, then `pnpm dev`)

That's it! The error will be fixed.

