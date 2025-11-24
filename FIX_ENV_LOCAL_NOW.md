# 🔴 FIX .env.local - Values Are Swapped!

## Current Problem in .env.local:

Your `.env.local` has **WRONG values** (they're swapped):

```env
SMTP_HOST=noreply.buildmate@gmail.com    ❌ WRONG (this is an email, not a host)
SMTP_USER=smtp.gmail.com                 ❌ WRONG (this is a host, not a user)
SMTP_PASSWORD=Buildmate123               ❌ WRONG (needs Gmail App Password)
```

---

## ✅ CORRECT Configuration:

Open `.env.local` and **replace** those lines with:

```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=noreply.buildmate@gmail.com
SMTP_PASSWORD=your_gmail_app_password_here
SMTP_FROM_EMAIL=BUILDMATE <noreply.buildmate@gmail.com>
SMTP_FROM_NAME=BUILDMATE
```

**Important:**
- `SMTP_HOST` = `smtp.gmail.com` (the server)
- `SMTP_USER` = `noreply.buildmate@gmail.com` (your email address)
- `SMTP_PASSWORD` = Gmail App Password (get from https://myaccount.google.com/apppasswords)
- `SMTP_PORT` = `587` (for TLS) or `465` (for SSL)

---

## 🔑 Get Gmail App Password:

1. Go to: https://myaccount.google.com/apppasswords
2. Create App Password for "Mail" → "Other" → Name: "BUILDMATE"
3. Copy the 16-character password (remove spaces)
4. Use it as `SMTP_PASSWORD`

---

## After Fixing:

1. **Save** `.env.local` (Ctrl+S)
2. **Restart server** (Ctrl+C, then `pnpm dev`)
3. **Test registration** - emails will be sent to real Gmail/Yahoo inboxes!

