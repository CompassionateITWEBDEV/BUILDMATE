# Troubleshooting: Verification Code Not Received in Gmail

## Quick Checks:

### 1. Is SMTP Configured?
Check if you have these in `.env.local`:
```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your_app_password
SMTP_FROM_EMAIL=BUILDMATE <your-email@gmail.com>
```

### 2. Did You Restart Server?
- ✅ Stop server (Ctrl+C)
- ✅ Start again (`pnpm dev`)
- Environment variables only load on startup!

### 3. Check Terminal Output
When you try to register, look for:
- ✅ `📧 Sending verification email via Supabase SMTP` = Good
- ✅ `✅ Email sent successfully` = Email was sent
- ❌ `❌ SMTP not configured` = Missing credentials
- ❌ `❌ Error sending email` = SMTP connection failed

### 4. Check Gmail
- ✅ Check **Inbox**
- ✅ Check **Spam/Junk** folder
- ✅ Check **All Mail**
- ✅ Wait 1-2 minutes (sometimes delayed)

---

## Common Issues:

### Issue 1: "SMTP not configured"
**Solution:**
1. Add SMTP credentials to `.env.local`
2. Restart server

### Issue 2: "Authentication failed"
**Solution:**
- For Gmail, use **App Password** (not regular password)
- Get App Password: https://myaccount.google.com/apppasswords

### Issue 3: "Connection timeout"
**Solution:**
- Check SMTP_HOST is correct: `smtp.gmail.com`
- Check SMTP_PORT is correct: `587`
- Check firewall/network settings

### Issue 4: Email sent but not received
**Solution:**
- Check spam folder
- Check "All Mail" in Gmail
- Verify sender email matches your Gmail
- Wait a few minutes

---

## Step-by-Step Fix:

### Step 1: Verify SMTP Configuration
Run this command to check:
```powershell
Get-Content .env.local | Select-String "SMTP"
```

You should see all 5 SMTP variables.

### Step 2: Test SMTP Connection
1. Go to Supabase Dashboard → Authentication → SMTP Settings
2. Click "Test" button
3. If test fails, check your credentials

### Step 3: Check Terminal Logs
When registering, watch terminal for:
- Error messages
- SMTP connection status
- Email sending status

### Step 4: Check Gmail Settings
1. Make sure Gmail account is active
2. Check if 2-factor authentication is enabled (required for App Password)
3. Verify App Password is correct

---

## Still Not Working?

1. **Check terminal output** - Look for specific error messages
2. **Verify SMTP in Supabase Dashboard** - Make sure it's enabled and tested
3. **Double-check .env.local** - No typos, correct values
4. **Try different email** - Test with another Gmail address
5. **Check Gmail security** - Make sure "Less secure app access" or App Passwords are enabled

---

## Quick Test:

1. Try registering with your email
2. Check terminal for errors
3. Check Gmail inbox and spam
4. Share the terminal error message if any

