import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'
import crypto from 'crypto'
import nodemailer from 'nodemailer'

// Initialize nodemailer transporter with Supabase SMTP configuration
const createTransporter = () => {
  // Get SMTP credentials from environment variables
  // These should match what you configure in Supabase Dashboard → Authentication → SMTP Settings
  const smtpHost = process.env.SMTP_HOST
  const smtpPort = process.env.SMTP_PORT ? parseInt(process.env.SMTP_PORT) : 587
  const smtpUser = process.env.SMTP_USER
  const smtpPassword = process.env.SMTP_PASSWORD
  const smtpFromEmail = process.env.SMTP_FROM_EMAIL || 'BUILDMATE <noreply@buildmate.com>'
  const smtpFromName = process.env.SMTP_FROM_NAME || 'BUILDMATE'

  // Check if SMTP credentials are missing
  if (!smtpHost || !smtpUser || !smtpPassword) {
    return null
  }

  // Check if placeholders are still being used
  const placeholderPatterns = {
    host: /your_smtp_host|smtp\.example\.com|example\.com/i,
    user: /your_smtp_user|your-email|example@/i,
    password: /your_smtp_password|your_password|password/i
  }

  if (placeholderPatterns.host.test(smtpHost)) {
    throw new Error(`SMTP_HOST is still a placeholder: "${smtpHost}". Please replace with actual SMTP host (e.g., smtp.gmail.com) in .env.local`)
  }

  if (placeholderPatterns.user.test(smtpUser)) {
    throw new Error(`SMTP_USER is still a placeholder: "${smtpUser}". Please replace with your actual email address in .env.local`)
  }

  if (placeholderPatterns.password.test(smtpPassword)) {
    throw new Error(`SMTP_PASSWORD is still a placeholder. Please replace with your actual SMTP password (Gmail App Password) in .env.local`)
  }

  return nodemailer.createTransport({
    host: smtpHost,
    port: smtpPort,
    secure: smtpPort === 465, // true for 465, false for other ports
    auth: {
      user: smtpUser,
      pass: smtpPassword,
    },
  })
}

// Store verification codes temporarily (in production, use Redis or database)
const verificationCodes = new Map<string, { code: string; expiresAt: number; email: string }>()

// Clean up expired codes every 10 minutes (codes expire after 5 minutes)
setInterval(() => {
  const now = Date.now()
  for (const [key, value] of verificationCodes.entries()) {
    if (value.expiresAt < now) {
      verificationCodes.delete(key)
    }
  }
}, 10 * 60 * 1000)

export async function POST(request: NextRequest) {
  try {
    const { email } = await request.json()

    if (!email) {
      return NextResponse.json(
        { error: 'Email is required' },
        { status: 400 }
      )
    }

    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if (!emailRegex.test(email)) {
      return NextResponse.json(
        { error: 'Invalid email format' },
        { status: 400 }
      )
    }

    // Validate that email is from a real email provider (Gmail, Yahoo, Outlook, etc.)
    const emailDomain = email.trim().toLowerCase().split('@')[1]
    const realEmailProviders = [
      'gmail.com', 'googlemail.com',
      'yahoo.com', 'yahoo.co.uk', 'yahoo.co.jp', 'ymail.com', 'rocketmail.com',
      'outlook.com', 'hotmail.com', 'live.com', 'msn.com',
      'icloud.com', 'me.com', 'mac.com',
      'protonmail.com', 'proton.me',
      'aol.com',
      'mail.com', 'email.com'
    ]
    
    const isValidProvider = realEmailProviders.some(provider => 
      emailDomain === provider || emailDomain.endsWith('.' + provider)
    )

    if (!isValidProvider) {
      return NextResponse.json(
        { 
          error: 'Please use a verified email address from a real email provider (Gmail, Yahoo, Outlook, etc.)',
          details: 'We only send verification codes to verified email addresses for security'
        },
        { status: 400 }
      )
    }

    // Check if email already exists
    const { data: existingUser } = await supabase
      .from('users')
      .select('email')
      .eq('email', email.trim().toLowerCase())
      .single()

    if (existingUser) {
      return NextResponse.json(
        { error: 'Email already registered. Please use a different email or login.' },
        { status: 400 }
      )
    }

    // Check if there's an existing code that hasn't expired yet
    const existingCode = verificationCodes.get(email.trim().toLowerCase())
    if (existingCode && existingCode.expiresAt > Date.now()) {
      const timeRemaining = Math.ceil((existingCode.expiresAt - Date.now()) / 1000 / 60)
      console.log(`⚠️ Code already exists for ${email}, expires in ${timeRemaining} minutes`)
      // Don't overwrite - return the existing code info (but don't send email again)
      return NextResponse.json({
        success: true,
        message: `A verification code was already sent. Please check your email. The code expires in ${timeRemaining} minute(s).`,
        codeAlreadySent: true
      })
    }

    // Generate 6-digit verification code
    const code = Math.floor(100000 + Math.random() * 900000).toString()
    const expiresAt = Date.now() + 5 * 60 * 1000 // 5 minutes

    // Store code with email as key
    verificationCodes.set(email.trim().toLowerCase(), {
      code,
      expiresAt,
      email: email.trim().toLowerCase(),
      createdAt: Date.now() // Track when code was created
    })
    
    console.log(`✅ New verification code generated for ${email}, expires at ${new Date(expiresAt).toISOString()}`)

    // Send verification code via email using Supabase SMTP
    let transporter
    try {
      transporter = createTransporter()
    } catch (placeholderError: any) {
      // Handle placeholder detection error
      console.error('❌', placeholderError.message)
      if (process.env.NODE_ENV === 'development') {
        console.log('🔐 Verification code for', email, ':', code)
        return NextResponse.json({
          success: false,
          error: placeholderError.message,
          code: code, // Only in development
          message: 'Please update .env.local with real SMTP credentials. Check console for verification code.'
        })
      }
      return NextResponse.json(
        { 
          error: placeholderError.message,
          details: 'Please update .env.local file with actual SMTP credentials (not placeholders)'
        },
        { status: 400 }
      )
    }
    
    if (!transporter) {
      console.error('❌ SMTP not configured. SMTP credentials are missing in environment variables.')
      console.log('💡 To fix: Add to .env.local:')
      console.log('   SMTP_HOST=smtp.gmail.com')
      console.log('   SMTP_PORT=587')
      console.log('   SMTP_USER=your-email@gmail.com')
      console.log('   SMTP_PASSWORD=your_gmail_app_password')
      console.log('   SMTP_FROM_EMAIL=BUILDMATE <your-email@gmail.com>')
      
      // In development, still log the code but warn user
      if (process.env.NODE_ENV === 'development') {
        console.log('🔐 Verification code for', email, ':', code)
        return NextResponse.json({
          success: true,
          message: 'Verification code generated (check console). Configure SMTP to send emails.',
          code: code // Only in development
        })
      }
      
      return NextResponse.json(
        { 
          error: 'Email service not configured. Please add SMTP credentials to .env.local file.',
          details: 'Required: SMTP_HOST, SMTP_USER, SMTP_PASSWORD'
        },
        { status: 500 }
      )
    }

    try {
      // Parse from email (supports both "Name <email>" and "email" formats)
      const fromEmailRaw = process.env.SMTP_FROM_EMAIL || 'noreply@buildmate.com'
      const fromName = process.env.SMTP_FROM_NAME || 'BUILDMATE'
      const fromEmail = fromEmailRaw.includes('<') 
        ? fromEmailRaw.match(/<(.+)>/)?.[1] || fromEmailRaw 
        : fromEmailRaw
      
      console.log('📧 Sending verification email via Supabase SMTP to:', email.trim().toLowerCase())
      console.log('📧 From email:', `${fromName} <${fromEmail}>`)
      console.log('📧 SMTP Host:', process.env.SMTP_HOST)
      console.log('📧 SMTP Port:', process.env.SMTP_PORT || '587')
      console.log('📧 SMTP User:', process.env.SMTP_USER)
      
      // Test SMTP connection first
      try {
        await transporter.verify()
        console.log('✅ SMTP connection verified successfully')
      } catch (verifyError: any) {
        console.error('❌ SMTP connection failed:', verifyError.message)
        console.error('❌ Error code:', verifyError.code)
        
        // Provide helpful error messages based on error type
        let errorMessage = 'SMTP connection failed'
        if (verifyError.code === 'ENOTFOUND' || verifyError.message.includes('ENOTFOUND')) {
          errorMessage = `SMTP host "${process.env.SMTP_HOST}" not found. Please check SMTP_HOST in .env.local is correct (e.g., smtp.gmail.com)`
        } else if (verifyError.code === 'EAUTH' || verifyError.message.includes('Invalid login') || verifyError.message.includes('authentication')) {
          errorMessage = 'SMTP authentication failed. Please check SMTP_USER and SMTP_PASSWORD in .env.local are correct. For Gmail, use App Password (not regular password).'
        } else if (verifyError.code === 'ETIMEDOUT' || verifyError.message.includes('timeout')) {
          errorMessage = 'SMTP connection timeout. Please check SMTP_HOST and SMTP_PORT in .env.local'
        } else {
          errorMessage = `SMTP connection failed: ${verifyError.message}`
        }
        
        // Return error response instead of throwing
        if (process.env.NODE_ENV === 'development') {
          console.log('🔐 Verification code for', email, ':', code)
          return NextResponse.json({
            success: false,
            error: errorMessage,
            code: code, // Only in development
            message: 'SMTP connection failed. Check console for verification code and fix SMTP configuration.'
          })
        }
        
        return NextResponse.json(
          { 
            error: errorMessage,
            details: 'Please check your SMTP configuration in .env.local file'
          },
          { status: 500 }
        )
      }
      
      const mailOptions = {
        from: `${fromName} <${fromEmail}>`,
        to: email.trim().toLowerCase(),
        subject: 'BUILDMATE - Email Verification Code',
        html: `
            <!DOCTYPE html>
            <html>
              <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Email Verification</title>
              </head>
              <body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
                <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
                  <h1 style="color: white; margin: 0;">BUILDMATE</h1>
                  <p style="color: rgba(255,255,255,0.9); margin: 10px 0 0 0;">Email Verification</p>
                </div>
                
                <div style="background: #f9fafb; padding: 30px; border-radius: 0 0 10px 10px;">
                  <h2 style="color: #1f2937; margin-top: 0;">Hello,</h2>
                  <p style="color: #4b5563;">Thank you for signing up for BUILDMATE! Please use the verification code below to complete your registration:</p>
                  
                  <div style="background: white; padding: 30px; border-radius: 8px; margin: 20px 0; text-align: center; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                    <p style="color: #6b7280; font-size: 14px; margin: 0 0 10px 0;">Your verification code is:</p>
                    <div style="font-size: 32px; font-weight: bold; color: #667eea; letter-spacing: 8px; font-family: 'Courier New', monospace;">
                      ${code}
                    </div>
                  </div>

                  <p style="color: #6b7280; font-size: 14px; margin: 20px 0;">
                    This code will expire in <strong>5 minutes</strong>. If you didn't request this code, please ignore this email.
                  </p>

                  <div style="background: #fef3c7; border-left: 4px solid #f59e0b; padding: 15px; margin: 20px 0; border-radius: 4px;">
                    <p style="margin: 0; color: #92400e; font-size: 14px;">
                      <strong>Security Notice:</strong> Never share this code with anyone. BUILDMATE will never ask for your verification code.
                    </p>
                  </div>

                  <div style="text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #e5e7eb;">
                    <p style="color: #6b7280; font-size: 12px; margin: 5px 0;">
                      This is an automated email from BUILDMATE. Please do not reply to this email.
                    </p>
                    <p style="color: #9ca3af; font-size: 11px; margin: 5px 0;">
                      © ${new Date().getFullYear()} BUILDMATE. All rights reserved.
                    </p>
                  </div>
                </div>
              </body>
            </html>
          `,
      }

      const info = await transporter.sendMail(mailOptions)
      
      console.log('✅ Email sent successfully via Supabase SMTP:', info.messageId)
      return NextResponse.json({
        success: true,
        message: 'Verification code sent to your email'
      })
    } catch (emailError: any) {
      console.error('❌ Error sending email via Supabase SMTP:', emailError)
      console.error('Error details:', JSON.stringify(emailError, null, 2))
      
      // In development, still return the code for testing
      if (process.env.NODE_ENV === 'development') {
        console.log('🔐 Verification code for', email, ':', code)
        return NextResponse.json({
          success: true,
          message: 'Email sending failed, but code generated (check console). Fix SMTP configuration to send emails.',
          code: code,
          error: emailError.message || 'Email sending failed'
        })
      }
      
      return NextResponse.json(
        { 
          error: 'Failed to send verification email. Please check your SMTP configuration in Supabase Dashboard.',
          details: emailError.message || 'Unknown error'
        },
        { status: 500 }
      )
    }

  } catch (error: any) {
    console.error('Send verification code error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

// Export verificationCodes for use in verify route
export { verificationCodes }

