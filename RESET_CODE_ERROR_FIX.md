# 🔍 Reset Code Error - "Invalid reset code"

## Error:
```
Error: Invalid reset code. Please check and try again.
```

This error means the reset code you entered doesn't match the code that was sent.

---

## 🔍 Possible Causes:

### 1. Code Not Received
**Problem**: Email wasn't sent because SMTP is not configured.

**Solution**: 
- Check terminal for error messages
- Fix SMTP configuration in `.env.local`
- Get Gmail App Password
- Restart server

### 2. Wrong Code Entered
**Problem**: Typo or extra spaces in the code.

**Solution**: 
- Enter the exact 6-digit code from email
- No spaces or dashes
- Check for typos

### 3. Code Expired
**Problem**: More than 10 minutes passed since code was sent.

**Solution**: 
- Request a new reset code
- Enter it quickly (within 10 minutes)

### 4. Server Restarted
**Problem**: Verification data was cleared from memory.

**Solution**: 
- Request a new reset code
- Enter it immediately

---

## ✅ How to Fix:

### Step 1: Check if Email Was Sent
Look in terminal for:
```
✅ Password reset code email sent successfully
```

If you see errors instead, SMTP is not configured.

### Step 2: Check Your Email
- ✅ Check Gmail inbox
- ✅ Check spam/junk folder
- ✅ Check "All Mail"
- ✅ Look for email from "BUILDMATE"

### Step 3: Enter Code Correctly
- Enter the **exact 6-digit code** from email
- No spaces: `123456` (not `123 456`)
- No dashes: `123456` (not `123-456`)
- All digits: Make sure all 6 numbers are entered

### Step 4: Enter Quickly
- Codes expire in **10 minutes**
- Enter code as soon as you receive it
- Don't wait too long

---

## 🔍 Check Terminal Logs:

When you request reset code, you should see:
```
✅ Reset code generated for email: your-email@gmail.com
✅ Code stored. Expires at: ...
```

When you verify code, you should see:
```
✅ Reset code verified successfully for email: your-email@gmail.com
```

If you see errors instead, check what they say.

---

## 🛠️ Quick Fix:

1. **Request new code**: Click "Resend Code"
2. **Check email**: Look in Gmail inbox/spam
3. **Enter code immediately**: Don't wait
4. **Enter exactly**: No spaces, all 6 digits

---

## 💡 Remember:

- ✅ Codes are 6 digits (e.g., `123456`)
- ✅ No spaces or dashes
- ✅ Expires in 10 minutes
- ✅ Must match exactly

The error means the code doesn't match - check terminal logs for details!

