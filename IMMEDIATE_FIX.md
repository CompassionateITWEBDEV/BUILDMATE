# 🚨 IMMEDIATE FIX - Replace Placeholders

## The Error:
```
getaddrinfo ENOTFOUND your_smtp_host
```

This means `.env.local` still has **PLACEHOLDERS** instead of real values.

---

## ✅ DO THIS NOW (3 Steps):

### Step 1: Open `.env.local`

In VS Code, open the `.env.local` file in your project root.

### Step 2: Find and Replace

**Find this:**
```env
SMTP_HOST=your_smtp_host
SMTP_USER=your_smtp_user
SMTP_PASSWORD=your_smtp_password
```

**Replace with this (use YOUR actual Gmail):**
```env
SMTP_HOST=smtp.gmail.com
SMTP_USER=dummy.dumm.acc001@gmail.com
SMTP_PASSWORD=abcdefghijklmnop
SMTP_FROM_EMAIL=BUILDMATE <dummy.dumm.acc001@gmail.com>
SMTP_FROM_NAME=BUILDMATE
```

**Important:**
- Use your **actual Gmail address** for `SMTP_USER`
- Get **Gmail App Password** from: https://myaccount.google.com/apppasswords
- Replace `abcdefghijklmnop` with your **actual 16-character App Password**

### Step 3: Save and Restart

1. **Save**: Press `Ctrl+S`
2. **Stop server**: Press `Ctrl+C` in terminal
3. **Start server**: Run `pnpm dev`

---

## ✅ After Fixing:

Try registering again. You should see:
```
📧 SMTP Host: smtp.gmail.com
✅ SMTP connection verified successfully
✅ Email sent successfully
```

---

## 🔑 Get Gmail App Password:

1. Go to: https://myaccount.google.com/apppasswords
2. Sign in
3. Select "Mail" → "Other" → Name: "BUILDMATE"
4. Click "Generate"
5. Copy the 16-character password (remove spaces)
6. Paste it as `SMTP_PASSWORD` in `.env.local`

---

## ⚠️ CRITICAL:

- ❌ `SMTP_HOST=your_smtp_host` = PLACEHOLDER (doesn't work)
- ✅ `SMTP_HOST=smtp.gmail.com` = REAL VALUE (works)

**You MUST replace the placeholders!**

---

## 📋 Quick Checklist:

- [ ] Opened `.env.local`
- [ ] Changed `your_smtp_host` → `smtp.gmail.com`
- [ ] Changed `your_smtp_user` → your Gmail address
- [ ] Changed `your_smtp_password` → Gmail App Password
- [ ] Saved file (Ctrl+S)
- [ ] **Restarted server** (Ctrl+C, pnpm dev)
- [ ] Tested registration

---

## 🎯 Remember:

**The server MUST be restarted after changing `.env.local`!**

Environment variables only load when the server starts.

