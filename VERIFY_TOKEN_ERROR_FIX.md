# 🔍 Verify Token 400 Error - Troubleshooting

## Error:
```
POST /api/auth/verify-token 400 in 1303ms
```

This 400 error means the verification token validation failed.

---

## 🔍 Possible Causes:

### 1. Email Not Verified First
**Problem**: You're trying to register without verifying the email code first.

**Solution**: 
- Make sure you enter the 6-digit verification code
- Click "Verify & Create Account"
- The code verification must complete before registration

### 2. Token Expired
**Problem**: More than 15 minutes passed between code verification and registration.

**Solution**: 
- Complete registration immediately after verifying code
- If too much time passed, verify code again

### 3. Verification Data Cleared
**Problem**: Server restarted or verification data was cleared from memory.

**Solution**: 
- Verify code again
- Complete registration right after

### 4. Token Mismatch
**Problem**: The token passed to verify-token doesn't match the stored token.

**Solution**: 
- Make sure you're using the token returned from verify-code
- Don't modify or store the token incorrectly

---

## ✅ How the Flow Should Work:

1. **Step 1**: Enter email → Click "Send Verification Code"
2. **Step 2**: Enter 6-digit code → Click "Verify & Create Account"
   - This calls `/api/auth/verify-code` → Returns token
3. **Step 3**: Registration uses that token
   - Calls `/api/auth/verify-token` with email + token
   - If valid, creates account

---

## 🔍 Check Terminal Logs:

When you verify the code, you should see:
```
✅ Verification code verified for email: your-email@gmail.com
✅ Token generated and stored. Expires at: ...
```

When registering, you should see:
```
✅ Token verified successfully for email: your-email@gmail.com
```

If you see errors instead, check what they say.

---

## 🛠️ Quick Fix:

If you're getting 400 error:

1. **Start over**: Go back to registration
2. **Enter email**: Click "Send Verification Code"
3. **Enter code quickly**: Don't wait too long
4. **Click "Verify & Create Account"**: Complete registration immediately

---

## 💡 Remember:

- ✅ Verify code first (returns token)
- ✅ Use that token immediately for registration
- ✅ Don't wait more than 15 minutes
- ✅ Complete the flow in one session

The 400 error means the token validation failed - check the error message for details!

