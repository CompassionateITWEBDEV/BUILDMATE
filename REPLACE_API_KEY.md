# 🔴 REPLACE API KEY NOW

## Current Problem:
Your `.env.local` file contains:
```
RESEND_API_KEY=re_your_api_key_here
```

This is a **PLACEHOLDER** - it's not a real API key. That's why you're getting:
```
"API key is invalid"
```

---

## ✅ FIX IT (5 Steps):

### 1️⃣ Open Resend Website
- Go to: **https://resend.com/api-keys**
- Sign in (or create free account)

### 2️⃣ Create API Key
- Click **"Create API Key"**
- Name: `BUILDMATE`
- **COPY THE KEY** (starts with `re_`, 40+ characters)
- ⚠️ You'll only see it once!

### 3️⃣ Open `.env.local` File
- In VS Code, open `.env.local` (in project root folder)
- Find this line:
  ```
  RESEND_API_KEY=re_your_api_key_here
  ```

### 4️⃣ Replace the Placeholder
- **Delete** `re_your_api_key_here`
- **Paste** your actual key from Step 2
- Should look like:
  ```
  RESEND_API_KEY=re_abc123xyz456def789ghi012jkl345mno678pqr901stu234vwx567
  ```
- **Save** (Ctrl+S)

### 5️⃣ Restart Server
- Press **Ctrl+C** in terminal
- Run: `pnpm dev`

---

## ✅ Verify It Worked:

After restarting, try registering again. You should see:
```
✅ Email sent successfully
```

And you'll receive the email!

---

## ❌ If Still Not Working:

1. **Check the key** - Make sure it's 40+ characters
2. **Check for typos** - Copy/paste exactly
3. **Check Resend dashboard** - Make sure key is active
4. **Restart server** - Must restart after changing `.env.local`

---

## 🎯 Remember:

- ❌ `re_your_api_key_here` = PLACEHOLDER (doesn't work)
- ✅ `re_abc123xyz456...` = REAL KEY (works)

You MUST replace the placeholder with a real key!

