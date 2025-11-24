# Check Why Emails Are Not Being Received

## SMTP is Configured ✅
Your `.env.local` has SMTP credentials, but emails still aren't arriving.

---

## 🔍 Diagnostic Steps:

### 1. Check Terminal Output
When you try to register, look in your terminal for:

**Good Signs:**
```
📧 Sending verification email via Supabase SMTP to: your-email@gmail.com
📧 SMTP Host: smtp.gmail.com
✅ SMTP connection verified successfully
✅ Email sent successfully via Supabase SMTP: <message-id>
```

**Bad Signs:**
```
❌ SMTP connection failed: ...
❌ Error sending email via Supabase SMTP: ...
```

**What to do:**
- Copy the error message from terminal
- Share it so we can fix the issue

---

### 2. Check Gmail Settings

**Check These Places:**
1. ✅ **Inbox** - Check if email arrived
2. ✅ **Spam/Junk** - Often emails go here first
3. ✅ **All Mail** - Search for "BUILDMATE" or "verification"
4. ✅ **Promotions Tab** - Sometimes Gmail filters here

**Gmail Search:**
- Search for: `from:BUILDMATE` or `verification code`
- Check "All Mail" not just "Inbox"

---

### 3. Verify SMTP Credentials

**For Gmail, you need:**
- ✅ **App Password** (not regular password)
- ✅ **2-Factor Authentication** enabled
- ✅ Correct Gmail address

**Get Gmail App Password:**
1. Go to: https://myaccount.google.com/apppasswords
2. Create new App Password
3. Use the 16-character password (no spaces)

---

### 4. Test SMTP Connection

**In Supabase Dashboard:**
1. Go to: Authentication → SMTP Settings
2. Click **"Test"** button
3. Check if test email is received

**If test fails:**
- Check SMTP credentials are correct
- Verify App Password is correct
- Make sure 2FA is enabled

---

### 5. Check Server Restart

**Important:** Did you restart the server after adding SMTP?
- ✅ Stop server (Ctrl+C)
- ✅ Start again (`pnpm dev`)
- Environment variables only load on startup!

---

## 🚨 Common Issues:

### Issue: "SMTP connection failed"
**Possible causes:**
- Wrong SMTP_HOST (should be `smtp.gmail.com`)
- Wrong SMTP_PORT (should be `587`)
- Wrong SMTP_USER (should be full Gmail address)
- Wrong SMTP_PASSWORD (should be App Password, not regular password)

### Issue: "Authentication failed"
**Solution:**
- Use Gmail App Password (not regular password)
- Make sure 2FA is enabled on Gmail
- Verify SMTP_USER is your full Gmail address

### Issue: Email sent but not received
**Solution:**
- Check spam folder
- Check "All Mail" in Gmail
- Wait 1-2 minutes (sometimes delayed)
- Check Gmail filters/blocked senders

---

## 📋 Action Items:

1. **Check terminal** - What error do you see?
2. **Check Gmail** - Inbox, Spam, All Mail
3. **Verify SMTP** - Test in Supabase Dashboard
4. **Check credentials** - App Password correct?
5. **Restart server** - Did you restart after adding SMTP?

---

## 💡 Quick Test:

1. Try registering again
2. **Watch terminal** for error messages
3. **Check Gmail** (Inbox + Spam)
4. **Share terminal output** if there are errors

The terminal output will tell us exactly what's wrong!

