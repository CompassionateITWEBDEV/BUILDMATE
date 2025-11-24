# Supabase Email Service Setup

## Overview

To use Supabase for sending verification codes, you need to:

1. **Configure SMTP in Supabase Dashboard**
2. **Update code to use Supabase's email service**

---

## Step 1: Configure Supabase SMTP

### In Supabase Dashboard:

1. Go to: [Supabase Dashboard → Authentication → SMTP Settings](https://supabase.com/dashboard/project/sldiqjjgddegffbzjqma/auth/smtp)

2. **Enable Custom SMTP**:
   - Toggle "Enable Custom SMTP"
   - Enter your SMTP provider details:
     - **SMTP Host**: (e.g., `smtp.gmail.com`, `smtp.sendgrid.net`)
     - **SMTP Port**: (e.g., `587` for TLS, `465` for SSL)
     - **SMTP User**: Your SMTP username
     - **SMTP Password**: Your SMTP password
     - **Sender Email**: Email address to send from
     - **Sender Name**: Display name (e.g., "BUILDMATE")

3. **Common SMTP Providers**:
   - **Gmail**: `smtp.gmail.com:587` (requires App Password)
   - **SendGrid**: `smtp.sendgrid.net:587`
   - **Mailgun**: `smtp.mailgun.org:587`
   - **AWS SES**: `email-smtp.region.amazonaws.com:587`

4. **Test Connection**: Click "Test" to verify SMTP works

---

## Step 2: Update Code

The code will be updated to use Supabase's email service instead of Resend.

---

## Step 3: Enable Email Confirmations (Optional)

If you want Supabase to handle email confirmations automatically:

1. Go to: [Authentication → Configuration](https://supabase.com/dashboard/project/sldiqjjgddegffbzjqma/auth/providers)
2. Enable "Enable email confirmations"
3. Customize email templates if needed

---

## Important Notes

- **SMTP Configuration**: You must configure SMTP in Supabase dashboard
- **Email Templates**: Supabase uses its own email templates
- **Custom Codes**: We'll still use our 6-digit code system, but send via Supabase

---

## Next Steps

After configuring SMTP in Supabase, the code will be updated to use Supabase's email service.

