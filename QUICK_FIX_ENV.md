# 🚨 QUICK FIX - .env.local Configuration

## Current Problem:

Your `.env.local` has **SWAPPED values**:

```env
SMTP_HOST=noreply.buildmate@gmail.com    ❌ WRONG (this is an email)
SMTP_USER=smtp.gmail.com                 ❌ WRONG (this is a host)
SMTP_PASSWORD=Buildmate123               ❌ WRONG (needs App Password)
```

---

## ✅ CORRECT Configuration:

Open `.env.local` and **replace** with:

```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=noreply.buildmate@gmail.com
SMTP_PASSWORD=your_16_character_gmail_app_password
SMTP_FROM_EMAIL=BUILDMATE <noreply.buildmate@gmail.com>
SMTP_FROM_NAME=BUILDMATE
```

**Key Points:**
- `SMTP_HOST` = `smtp.gmail.com` (the server address)
- `SMTP_USER` = `noreply.buildmate@gmail.com` (your email address)
- `SMTP_PASSWORD` = Gmail App Password (16 characters, no spaces)
- Get App Password: https://myaccount.google.com/apppasswords

---

## 🔑 Get Gmail App Password:

1. Go to: https://myaccount.google.com/apppasswords
2. Create App Password: Mail → Other → Name: "BUILDMATE"
3. Copy 16-character password (remove spaces)
4. Paste as `SMTP_PASSWORD` in `.env.local`

---

## After Fixing:

1. **Save** `.env.local` (Ctrl+S)
2. **Restart server** (Ctrl+C, then `pnpm dev`)
3. **Test registration** - emails will be sent to Gmail/Yahoo inboxes!

---

## ✅ What's Fixed:

- ✅ Error handling improved (no more crashes)
- ✅ Real email validation (Gmail, Yahoo, etc.)
- ✅ Better error messages
- ✅ Codes sent to verified email addresses

**Now fix your `.env.local` and restart the server!**

