# 🔑 How to Get SMTP Password (Gmail App Password)

## For Gmail Users:

Gmail requires an **App Password** (not your regular Gmail password) for SMTP authentication.

---

## ✅ Step-by-Step Guide:

### Step 1: Enable 2-Factor Authentication

**You MUST have 2FA enabled first!**

1. Go to: https://myaccount.google.com/security
2. Find "2-Step Verification"
3. If not enabled, click "Get started" and follow the steps
4. You'll need your phone to verify

### Step 2: Create App Password

1. **Go to App Passwords page:**
   - Direct link: https://myaccount.google.com/apppasswords
   - Or: Google Account → Security → 2-Step Verification → App passwords

2. **Sign in** with your Gmail account

3. **Select app and device:**
   - **Select app**: Choose "Mail"
   - **Select device**: Choose "Other (Custom name)"
   - **Enter name**: Type "BUILDMATE" (or any name you want)
   - Click **"Generate"**

4. **Copy the password:**
   - Google will show a **16-character password**
   - It looks like: `abcd efgh ijkl mnop` (with spaces)
   - **Copy it immediately** - you can only see it once!

5. **Remove spaces:**
   - The password has spaces: `abcd efgh ijkl mnop`
   - Remove them: `abcdefghijklmnop`
   - Use this in `.env.local` as `SMTP_PASSWORD`

---

## 📝 Add to .env.local:

```env
SMTP_PASSWORD=abcdefghijklmnop
```

(Use your actual 16-character App Password, no spaces)

---

## 🔍 Where to Find It Later:

If you lose your App Password:

1. Go to: https://myaccount.google.com/apppasswords
2. You'll see a list of App Passwords you've created
3. You can **delete** old ones and create new ones
4. **Note:** You can't see the password again after creation, only delete it

---

## ⚠️ Important Notes:

- **App Password is different** from your regular Gmail password
- **16 characters** (usually shown with spaces, remove them)
- **One-time view** - copy it immediately
- **2FA required** - must have 2-Factor Authentication enabled
- **Per-app** - you can create multiple App Passwords for different apps

---

## 🆘 Troubleshooting:

### "App passwords aren't available for your account"
- **Solution:** Enable 2-Factor Authentication first
- Go to: https://myaccount.google.com/security
- Enable "2-Step Verification"

### "Can't find App passwords option"
- Make sure 2FA is enabled
- Try direct link: https://myaccount.google.com/apppasswords
- Or: Security → 2-Step Verification → App passwords (at bottom)

### "Password not working"
- Make sure you **removed spaces** from the password
- Check you copied the **full 16 characters**
- Verify 2FA is still enabled
- Try creating a new App Password

---

## 📋 Quick Checklist:

- [ ] 2-Factor Authentication enabled on Gmail
- [ ] Went to https://myaccount.google.com/apppasswords
- [ ] Selected "Mail" and "Other (Custom name)"
- [ ] Named it "BUILDMATE"
- [ ] Copied the 16-character password
- [ ] Removed spaces from password
- [ ] Added to `.env.local` as `SMTP_PASSWORD`
- [ ] Saved file and restarted server

---

## 🎯 Example:

**What you'll see:**
```
Your app password for BUILDMATE:
abcd efgh ijkl mnop
```

**What to use in .env.local:**
```env
SMTP_PASSWORD=abcdefghijklmnop
```

(No spaces!)

---

## 💡 Alternative: Other Email Providers

### SendGrid:
- Get API key from SendGrid dashboard
- Use as `SMTP_PASSWORD`

### Mailgun:
- Get SMTP password from Mailgun dashboard
- Use as `SMTP_PASSWORD`

### AWS SES:
- Get SMTP credentials from AWS SES
- Use as `SMTP_PASSWORD`

---

## 🔗 Direct Links:

- **App Passwords**: https://myaccount.google.com/apppasswords
- **Security Settings**: https://myaccount.google.com/security
- **2-Step Verification**: https://myaccount.google.com/signinoptions/two-step-verification

