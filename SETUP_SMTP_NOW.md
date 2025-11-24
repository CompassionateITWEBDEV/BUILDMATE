# 🚨 URGENT: Setup SMTP to Send Verification Codes

## Problem:
Verification codes are **NOT being sent to Gmail** because SMTP is not configured.

## Current Status:
❌ SMTP_HOST: NOT FOUND
❌ SMTP_PORT: NOT FOUND  
❌ SMTP_USER: NOT FOUND
❌ SMTP_PASSWORD: NOT FOUND
❌ SMTP_FROM_EMAIL: NOT FOUND

---

## ✅ FIX IN 3 STEPS:

### Step 1: Configure SMTP in Supabase Dashboard

1. **Go to Supabase Dashboard**:
   - Open: https://supabase.com/dashboard/project/sldiqjjgddegffbzjqma/auth/smtp

2. **Enable Custom SMTP**:
   - Toggle "Enable Custom SMTP" to ON
   - Fill in your SMTP details

3. **For Gmail (Recommended)**:
   - **SMTP Host**: `smtp.gmail.com`
   - **SMTP Port**: `587`
   - **SMTP User**: Your Gmail address (e.g., `your-email@gmail.com`)
   - **SMTP Password**: Gmail App Password (NOT your regular password!)
     - [How to create Gmail App Password](https://support.google.com/accounts/answer/185833)
   - **Sender Email**: Your Gmail address
   - **Sender Name**: `BUILDMATE`

4. **Test Connection**: Click "Test" to verify it works

---

### Step 2: Add SMTP Credentials to `.env.local`

Open `.env.local` in your code editor and add:

```env
# Supabase SMTP Configuration (for sending verification codes)
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
- For Gmail, you MUST use an App Password, not your regular password

---

### Step 3: Restart Your Server

1. **Stop server**: Press `Ctrl+C` in terminal
2. **Start server**: Run `pnpm dev`

---

## ✅ After Setup:

When you try to register, you should see in terminal:
```
📧 Sending verification email via Supabase SMTP to: your-email@gmail.com
📧 From email: BUILDMATE <your-email@gmail.com>
📧 SMTP Host: smtp.gmail.com
✅ Email sent successfully via Supabase SMTP: <message-id>
```

And you'll receive the email in your Gmail inbox!

---

## 🔑 Gmail App Password Setup:

1. Go to: https://myaccount.google.com/apppasswords
2. Sign in with your Gmail account
3. Select "Mail" and "Other (Custom name)"
4. Enter name: "BUILDMATE"
5. Click "Generate"
6. **Copy the 16-character password** (no spaces)
7. Use this as your `SMTP_PASSWORD` in `.env.local`

---

## ❌ Common Issues:

### "SMTP not configured" Error:
- ✅ Check `.env.local` has all SMTP variables
- ✅ Verify no typos in variable names
- ✅ Restart server after updating `.env.local`

### "Authentication failed" Error:
- ✅ For Gmail, use App Password (not regular password)
- ✅ Check SMTP username is your full Gmail address
- ✅ Verify SMTP host and port are correct

### Emails Not Received:
- ✅ Check spam/junk folder
- ✅ Verify sender email matches your Gmail
- ✅ Check terminal for error messages
- ✅ Wait a few minutes (sometimes delayed)

---

## 📋 Quick Checklist:

- [ ] Configured SMTP in Supabase Dashboard
- [ ] Created Gmail App Password
- [ ] Added SMTP credentials to `.env.local`
- [ ] Saved `.env.local` file
- [ ] **Restarted server** (Ctrl+C then `pnpm dev`)
- [ ] Tested registration
- [ ] Checked Gmail inbox (and spam folder)

---

## 🎯 Remember:

- ❌ Without SMTP configuration = No emails sent
- ✅ With SMTP configured = Emails sent to Gmail

**You MUST configure SMTP before verification codes will be sent!**

