# 🚨 URGENT: Update .env.local with Real SMTP Values

## Current Problem:
Your `.env.local` file has **PLACEHOLDERS** instead of real values:
- ❌ `SMTP_HOST=your_smtp_host`
- ❌ `SMTP_USER=your_smtp_user`

This is why emails are not being sent!

---

## ✅ FIX NOW:

### Step 1: Open `.env.local`

Open the file in your code editor (VS Code).

### Step 2: Find and Replace These Lines

**Find:**
```env
SMTP_HOST=your_smtp_host
SMTP_PORT=587
SMTP_USER=your_smtp_user
SMTP_PASSWORD=your_smtp_password
SMTP_FROM_EMAIL=BUILDMATE <noreply@buildmate.com>
```

**Replace with (for Gmail):**
```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your_gmail_app_password_here
SMTP_FROM_EMAIL=BUILDMATE <your-email@gmail.com>
SMTP_FROM_NAME=BUILDMATE
```

**Important:**
- Replace `your-email@gmail.com` with your **actual Gmail address**
- Replace `your_gmail_app_password_here` with your **Gmail App Password**
  - Get it from: https://myaccount.google.com/apppasswords
  - It's a 16-character password (no spaces)

### Step 3: Save the File

Press **Ctrl+S** to save.

### Step 4: Restart Server

1. **Stop server**: Press `Ctrl+C` in terminal
2. **Start server**: Run `pnpm dev`

---

## ✅ After Fixing:

When you try to register, you should see:
```
📧 SMTP Host: smtp.gmail.com
📧 SMTP User: your-email@gmail.com
✅ SMTP connection verified successfully
✅ Email sent successfully via Supabase SMTP
```

And you'll receive the email in Gmail!

---

## 🔑 Get Gmail App Password:

1. Go to: https://myaccount.google.com/apppasswords
2. Sign in with your Gmail account
3. Select "Mail" and "Other (Custom name)"
4. Enter name: "BUILDMATE"
5. Click "Generate"
6. **Copy the 16-character password** (it looks like: `abcd efgh ijkl mnop`)
7. Remove spaces and use it as `SMTP_PASSWORD`

**Note:** You need 2-Factor Authentication enabled on Gmail to create App Passwords.

---

## 📋 Complete Example:

Here's what your `.env.local` should look like (with your actual values):

```env
# Supabase SMTP Configuration
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=dummy.dumm.acc001@gmail.com
SMTP_PASSWORD=abcdefghijklmnop
SMTP_FROM_EMAIL=BUILDMATE <dummy.dumm.acc001@gmail.com>
SMTP_FROM_NAME=BUILDMATE
```

---

## ❌ Common Mistakes:

1. **Using placeholders**: `your_smtp_host` ❌
2. **Wrong host**: `gmail.com` ❌ (should be `smtp.gmail.com`)
3. **Regular password**: Using Gmail password instead of App Password ❌
4. **Not restarting**: Must restart server after changes ❌

---

## 🎯 Quick Checklist:

- [ ] Opened `.env.local`
- [ ] Replaced `your_smtp_host` with `smtp.gmail.com`
- [ ] Replaced `your_smtp_user` with your Gmail address
- [ ] Replaced `your_smtp_password` with Gmail App Password
- [ ] Updated `SMTP_FROM_EMAIL` with your Gmail
- [ ] Saved file (Ctrl+S)
- [ ] **Restarted server** (Ctrl+C then `pnpm dev`)
- [ ] Tested registration

---

## 💡 Remember:

- ❌ Placeholders = No emails sent
- ✅ Real values = Emails sent to Gmail

**You MUST replace ALL placeholders with real values!**

