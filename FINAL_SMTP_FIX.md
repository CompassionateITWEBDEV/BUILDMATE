# ✅ FINAL FIX - Update .env.local Now

## Current Error:
```
SMTP_HOST is still a placeholder: "your_smtp_host"
```

## ✅ FIX (2 Steps):

### Step 1: Update `.env.local`

Open `.env.local` in VS Code and find these lines:

**Find:**
```env
SMTP_HOST=your_smtp_host
SMTP_USER=your_smtp_user
SMTP_PASSWORD=your_smtp_password
```

**Replace with:**
```env
SMTP_HOST=smtp.gmail.com
SMTP_USER=dummy.dumm.acc001@gmail.com
SMTP_PASSWORD=your_16_character_gmail_app_password
SMTP_FROM_EMAIL=BUILDMATE <dummy.dumm.acc001@gmail.com>
SMTP_FROM_NAME=BUILDMATE
```

**Important:**
- Replace `your_16_character_gmail_app_password` with your **actual Gmail App Password**
- Get it from: https://myaccount.google.com/apppasswords
- It's a 16-character password (remove spaces)

### Step 2: Restart Server

1. **Stop**: Press `Ctrl+C` in terminal
2. **Start**: Run `pnpm dev`

---

## 🔑 Get Gmail App Password:

1. Go to: https://myaccount.google.com/apppasswords
2. Sign in with your Gmail account
3. Select:
   - App: **Mail**
   - Device: **Other (Custom name)**
   - Name: **BUILDMATE**
4. Click **Generate**
5. **Copy the 16-character password** (looks like: `abcd efgh ijkl mnop`)
6. **Remove spaces** and paste it as `SMTP_PASSWORD` in `.env.local`

**Note:** You need 2-Factor Authentication enabled on Gmail to create App Passwords.

---

## ✅ After Fixing:

When you try to register, you should see:
```
📧 SMTP Host: smtp.gmail.com
📧 SMTP User: dummy.dumm.acc001@gmail.com
✅ SMTP connection verified successfully
✅ Email sent successfully via Supabase SMTP
```

And you'll receive the verification email in Gmail!

---

## 📋 Complete Example:

Your `.env.local` should look like this:

```env
# Supabase SMTP Configuration
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=dummy.dumm.acc001@gmail.com
SMTP_PASSWORD=abcdefghijklmnop
SMTP_FROM_EMAIL=BUILDMATE <dummy.dumm.acc001@gmail.com>
SMTP_FROM_NAME=BUILDMATE
```

(Replace `abcdefghijklmnop` with your actual App Password)

---

## ❌ Common Mistakes:

1. **Using placeholder**: `SMTP_HOST=your_smtp_host` ❌
2. **Wrong host**: `SMTP_HOST=gmail.com` ❌ (should be `smtp.gmail.com`)
3. **Regular password**: Using Gmail password instead of App Password ❌
4. **Not restarting**: Must restart server after changes ❌

---

## 🎯 Quick Checklist:

- [ ] Opened `.env.local`
- [ ] Changed `your_smtp_host` → `smtp.gmail.com`
- [ ] Changed `your_smtp_user` → `dummy.dumm.acc001@gmail.com`
- [ ] Got Gmail App Password from https://myaccount.google.com/apppasswords
- [ ] Changed `your_smtp_password` → Gmail App Password (16 characters, no spaces)
- [ ] Saved file (Ctrl+S)
- [ ] **Restarted server** (Ctrl+C, then `pnpm dev`)
- [ ] Tested registration

---

## 💡 Remember:

- ❌ Placeholders = Error message (which you're seeing now)
- ✅ Real values = Emails sent successfully

**Replace the placeholders and restart the server!**

