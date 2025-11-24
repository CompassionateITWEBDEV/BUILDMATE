# Supabase Email Configuration Guide

## Overview

The application now uses **Supabase SMTP** for sending verification codes instead of Resend. You need to configure SMTP in your Supabase Dashboard.

---

## Step 1: Configure SMTP in Supabase Dashboard

1. **Go to Supabase Dashboard**:
   - Navigate to: [Authentication → SMTP Settings](https://supabase.com/dashboard/project/sldiqjjgddegffbzjqma/auth/smtp)

2. **Enable Custom SMTP**:
   - Toggle "Enable Custom SMTP"
   - Enter your SMTP provider details

3. **Common SMTP Providers**:

   **Gmail:**
   - Host: `smtp.gmail.com`
   - Port: `587` (TLS) or `465` (SSL)
   - User: Your Gmail address
   - Password: Gmail App Password (not your regular password)
   - [How to create Gmail App Password](https://support.google.com/accounts/answer/185833)

   **SendGrid:**
   - Host: `smtp.sendgrid.net`
   - Port: `587`
   - User: `apikey`
   - Password: Your SendGrid API key

   **Mailgun:**
   - Host: `smtp.mailgun.org`
   - Port: `587`
   - User: Your Mailgun SMTP username
   - Password: Your Mailgun SMTP password

   **AWS SES:**
   - Host: `email-smtp.region.amazonaws.com` (e.g., `email-smtp.us-east-1.amazonaws.com`)
   - Port: `587`
   - User: Your AWS SES SMTP username
   - Password: Your AWS SES SMTP password

4. **Test Connection**: Click "Test" to verify SMTP works

---

## Step 2: Configure Environment Variables

After configuring SMTP in Supabase Dashboard, add these to your `.env.local` file:

```env
# Supabase SMTP Configuration
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your_app_password_or_api_key
SMTP_FROM_EMAIL=BUILDMATE <noreply@yourdomain.com>
SMTP_FROM_NAME=BUILDMATE
```

**Important Notes:**
- `SMTP_HOST`: Your SMTP server hostname
- `SMTP_PORT`: Usually `587` (TLS) or `465` (SSL)
- `SMTP_USER`: Your SMTP username
- `SMTP_PASSWORD`: Your SMTP password or API key
- `SMTP_FROM_EMAIL`: Email address to send from (can include name: `Name <email@domain.com>`)
- `SMTP_FROM_NAME`: Display name for emails

---

## Step 3: Restart Your Server

After updating `.env.local`:
1. Stop your server (Ctrl+C)
2. Start it again: `pnpm dev`

---

## Testing

1. Go to registration page
2. Enter your email
3. Click "Send Verification Code"
4. Check your email inbox

You should see in terminal:
```
📧 Sending verification email via Supabase SMTP to: your-email@gmail.com
📧 From email: BUILDMATE <noreply@yourdomain.com>
📧 SMTP Host: smtp.gmail.com
✅ Email sent successfully via Supabase SMTP: <message-id>
```

---

## Troubleshooting

### "SMTP not configured" Error:
- ✅ Check `.env.local` has all SMTP variables
- ✅ Verify SMTP credentials are correct
- ✅ Make sure server was restarted after updating `.env.local`

### "Authentication failed" Error:
- ✅ Check SMTP username and password
- ✅ For Gmail, use App Password (not regular password)
- ✅ Verify SMTP host and port are correct

### "Connection timeout" Error:
- ✅ Check SMTP host is correct
- ✅ Verify port number (587 for TLS, 465 for SSL)
- ✅ Check firewall/network settings

### Emails Not Received:
- ✅ Check spam/junk folder
- ✅ Verify sender email is correct
- ✅ Check SMTP provider logs/dashboard

---

## Security Best Practices

1. **Never commit `.env.local`** to version control
2. **Use App Passwords** for Gmail (not your main password)
3. **Rotate credentials** regularly
4. **Use environment-specific** SMTP settings (dev vs production)

---

## Next Steps

After configuring SMTP:
- ✅ Verification codes will be sent via Supabase SMTP
- ✅ Password reset codes will be sent via Supabase SMTP
- ✅ All emails use your configured SMTP provider

---

## Support

For issues:
- **SMTP Configuration**: Check Supabase Dashboard → Authentication → SMTP Settings
- **Email Delivery**: Check your SMTP provider's dashboard/logs
- **Code Issues**: Check terminal output for error messages

