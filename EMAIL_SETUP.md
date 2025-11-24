# Email Service Setup Guide

This application uses **Resend** for sending purchase details and password reset emails to verified email addresses.

## Setup Instructions

### 1. Create a Resend Account

1. Go to [resend.com](https://resend.com)
2. Sign up for a free account
3. Verify your email address

### 2. Get Your API Key

1. After logging in, go to the **API Keys** section
2. Click **Create API Key**
3. Give it a name (e.g., "BUILDMATE Production")
4. Copy the API key (you'll only see it once!)

### 3. Configure Environment Variables

Add the following to your `.env.local` file:

```env
# Resend Email Service
RESEND_API_KEY=re_your_api_key_here
RESEND_FROM_EMAIL=BUILDMATE <noreply@yourdomain.com>
```

**Important Notes:**
- Replace `re_your_api_key_here` with your actual Resend API key
- Replace `noreply@yourdomain.com` with your verified domain email
- For testing, you can use Resend's test domain: `onboarding@resend.dev`

### 4. Verify Your Domain (Production)

For production use, you need to verify your domain:

1. Go to **Domains** in Resend dashboard
2. Click **Add Domain**
3. Add your domain (e.g., `yourdomain.com`)
4. Add the DNS records provided by Resend to your domain's DNS settings
5. Wait for verification (usually takes a few minutes)

### 5. Test Email Sending

1. Build a PC in the builder
2. Save the build
3. Click "View Purchase Details"
4. Click "Send Purchase Details to Email"
5. Check your inbox (and spam folder) for the email

## Security Features

### Email Verification

- Purchase details are **only** sent to the verified email address associated with the build owner
- The system verifies that the email matches the build owner's email before sending
- Password reset emails are sent to the verified email address on file

### Email Content

The purchase details email includes:
- Build name and type
- Complete component list with prices
- Retailer information (name, address, phone, email)
- Total price
- Security notice

## Troubleshooting

### Email Not Sending

1. **Check API Key**: Make sure `RESEND_API_KEY` is set correctly in `.env.local`
2. **Check From Email**: Ensure `RESEND_FROM_EMAIL` uses a verified domain
3. **Check Console**: Look for error messages in the browser console and server logs
4. **Resend Dashboard**: Check the Resend dashboard for delivery status and errors

### Development Mode

In development, if `RESEND_API_KEY` is not set, the API will return a warning but won't fail. This allows development without email setup, but emails won't actually be sent.

### Production Mode

In production, if `RESEND_API_KEY` is not set, the API will return an error. Make sure to configure Resend before deploying to production.

## Alternative Email Services

If you prefer to use a different email service, you can modify `app/api/purchase/send-email/route.ts` to use:

- **SendGrid**: `@sendgrid/mail`
- **AWS SES**: `@aws-sdk/client-ses`
- **Nodemailer**: `nodemailer` (works with SMTP)
- **Supabase Email**: Built-in Supabase email service

## Free Tier Limits

Resend's free tier includes:
- 3,000 emails per month
- 100 emails per day
- Unlimited domains (after verification)

For higher limits, upgrade to a paid plan.

## Support

For issues with:
- **Resend Service**: Contact Resend support at support@resend.com
- **BUILDMATE Integration**: Check the application logs or contact the development team

