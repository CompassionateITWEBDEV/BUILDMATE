# Render.com Environment Variables Setup

## ⚠️ IMPORTANT: Configure SMTP for Email Verification

Para makareceive ang verification codes sa Render/Vercel deployment, kailangan i-configure ang SMTP environment variables.

## Step 1: Go to Render Dashboard

1. Login sa Render.com
2. Piliin ang **BUILDMATE** service
3. Click **Environment** tab sa left sidebar

## Step 2: Add Environment Variables

I-add ang mga sumusunod na environment variables:

### Required SMTP Variables:

```
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=dummy.dumm.acc001@gmail.com
SMTP_PASSWORD=your_gmail_app_password_here
SMTP_FROM_EMAIL=BUILDMATE <dummy.dumm.acc001@gmail.com>
SMTP_FROM_NAME=BUILDMATE
```

### Supabase Variables (if not yet added):

```
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key
```

### Other Variables:

```
NODE_ENV=production
PORT=3000
PYTHON_API_URL=http://python-api:5000
```

## Step 3: Get Gmail App Password

1. Go to: https://myaccount.google.com/apppasswords
2. Sign in with `dummy.dumm.acc001@gmail.com`
3. Select:
   - App: **Mail**
   - Device: **Other (Custom name)**
   - Name: **BUILDMATE Render**
4. Click **Generate**
5. Copy the 16-character password (remove spaces)
6. Paste it as `SMTP_PASSWORD` value sa Render

## Step 4: Save and Redeploy

1. Click **Save Changes** sa Render
2. Render will automatically redeploy
3. Wait for deployment to complete

## Step 5: Test Email Verification

1. Try to login sa deployed app
2. Check email inbox para sa verification code
3. Check Render logs kung may errors:
   - Go to **Logs** tab
   - Look for SMTP errors

## Troubleshooting

### Code not received?

1. **Check Render Logs:**
   - Go to service → **Logs** tab
   - Look for errors like "SMTP configuration error" or "Failed to send email"

2. **Verify Environment Variables:**
   - Go to **Environment** tab
   - Make sure all SMTP variables are set correctly
   - No typos or extra spaces

3. **Check Gmail App Password:**
   - Make sure you're using App Password, not regular password
   - App Password should be 16 characters (no spaces)

4. **Check Email Provider:**
   - Make sure email is from Gmail, Yahoo, or other supported provider
   - Check spam folder

5. **Test SMTP Connection:**
   - You can test locally first with `.env.local`
   - If works locally, should work in Render too

## Common Errors

### "Email service not configured"
- **Fix:** Add all SMTP environment variables in Render

### "SMTP connection error"
- **Fix:** Check SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASSWORD values

### "Authentication failed"
- **Fix:** Use Gmail App Password, not regular password

### "Code not received"
- **Fix:** Check spam folder, verify email address is correct

## Quick Checklist

- [ ] All SMTP variables added in Render Environment tab
- [ ] Gmail App Password generated and set as SMTP_PASSWORD
- [ ] SMTP_HOST set to `smtp.gmail.com`
- [ ] SMTP_PORT set to `587`
- [ ] SMTP_USER set to `dummy.dumm.acc001@gmail.com`
- [ ] SMTP_FROM_EMAIL includes email address
- [ ] Service redeployed after adding variables
- [ ] Tested login and checked email inbox

## Notes

- Environment variables are case-sensitive
- No spaces before/after `=` sign
- Redeploy is required after adding/changing environment variables
- Check logs if emails are not being sent

