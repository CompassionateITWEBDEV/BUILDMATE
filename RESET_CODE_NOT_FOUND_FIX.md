# 🔍 Reset Code "Not Found" Error - Complete Fix

## Error:
```
Error: Invalid or expired reset code. Please request a new password reset.
```

This error means the reset code is not found in the server's memory.

---

## 🔍 Root Causes:

### 1. **Server Restarted** ⚠️ MOST COMMON
**Problem**: Reset codes are stored in memory. If the server restarts, all codes are lost.

**Solution**: 
- Request a new reset code after server restart
- Complete the reset process in one session

### 2. **Code Expired**
**Problem**: Reset codes expire after 10 minutes.

**Solution**: 
- Request a new code
- Enter it quickly (within 10 minutes)

### 3. **Email Mismatch**
**Problem**: The email used to verify doesn't match the email used to request.

**Solution**: 
- Use the **exact same email address** (case-insensitive, but must match)
- Check for typos or extra spaces

### 4. **Email Not Sent**
**Problem**: SMTP failed, so you never received the code.

**Solution**: 
- Check terminal for the code (in development mode)
- Fix SMTP configuration
- Request a new code

---

## ✅ How to Fix:

### Step 1: Check Terminal Logs

When you request a reset code, you should see:
```
✅ Reset code generated for email: your-email@gmail.com
✅ Code stored: 123456
✅ Code expires at: 2024-01-01T12:10:00.000Z
✅ Total codes in memory: 1
```

When you verify, you should see:
```
🔍 Looking up reset code for email: your-email@gmail.com
🔍 Total codes in memory: 1
🔍 Available email keys: ['your-email@gmail.com']
✅ Found stored code for email: your-email@gmail.com
```

If you see "❌ Reset code not found", check:
- Is the email key exactly the same?
- Are there any codes in memory? (Total codes: 0 = server restarted)

### Step 2: Request New Code

If the code is not found:
1. **Go back** to the email input step
2. **Enter your email** again
3. **Click "Send Verification Code"**
4. **Enter the code immediately** (within 10 minutes)

### Step 3: Use Exact Same Email

Make sure:
- ✅ Same email address (case doesn't matter, but must match)
- ✅ No extra spaces
- ✅ Same format (e.g., `user@gmail.com` not `user@Gmail.com`)

### Step 4: Complete Quickly

- ✅ Enter code within 10 minutes
- ✅ Complete in one session
- ✅ Don't restart server between steps

---

## 🛠️ Development Mode:

If SMTP is not configured, the code will be logged to terminal:
```
🔐 Password reset code for your-email@gmail.com : 123456
```

You can use this code even if email failed (until server restarts).

---

## 💡 Important Notes:

1. **Memory Storage**: Codes are stored in memory, not in database
   - ✅ Fast and simple
   - ❌ Lost on server restart
   - ❌ Lost after expiration

2. **10 Minute Expiry**: Codes expire after 10 minutes
   - Request new code if expired

3. **Email Key Matching**: Must use exact same email
   - Email is normalized (lowercase, trimmed)
   - But must be the same address

4. **Server Restart**: All codes are cleared
   - Request new code after restart

---

## 🔍 Debugging:

Check terminal for:
- `✅ Reset code generated` - Code was created
- `✅ Code stored` - Code is in memory
- `🔍 Looking up reset code` - Verification attempt
- `❌ Reset code not found` - Code missing

If you see "Total codes in memory: 0", the server restarted.

---

## ✅ Quick Fix Checklist:

- [ ] Request a new reset code
- [ ] Use the exact same email address
- [ ] Enter code within 10 minutes
- [ ] Check terminal for code (if SMTP not working)
- [ ] Complete in one session
- [ ] Don't restart server

The improved error messages will now show more details about what went wrong!

