import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'
import nodemailer from 'nodemailer'

// Initialize nodemailer transporter with Supabase SMTP configuration
const createTransporter = () => {
  const smtpHost = process.env.SMTP_HOST
  const smtpPort = process.env.SMTP_PORT ? parseInt(process.env.SMTP_PORT) : 587
  const smtpUser = process.env.SMTP_USER
  const smtpPassword = process.env.SMTP_PASSWORD

  if (!smtpHost || !smtpUser || !smtpPassword) {
    return null
  }

  return nodemailer.createTransport({
    host: smtpHost,
    port: smtpPort,
    secure: smtpPort === 465,
    auth: {
      user: smtpUser,
      pass: smtpPassword,
    },
  })
}

// Store reset codes temporarily (in production, use Redis or database)
const resetCodes = new Map<string, { code: string; expiresAt: number; email: string }>()

// Clean up expired codes every 10 minutes
setInterval(() => {
  const now = Date.now()
  for (const [key, value] of resetCodes.entries()) {
    if (value.expiresAt < now) {
      resetCodes.delete(key)
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

    // Check if user exists in database
    const { data: user, error: userError } = await supabase
      .from('users')
      .select('email, user_name')
      .eq('email', email.trim().toLowerCase())
      .single()

    // For security, don't reveal if email exists
    // But we'll still send a code if email format is valid
    if (userError || !user) {
      // Return success message even if user doesn't exist (security best practice)
      return NextResponse.json({
        success: true,
        message: 'If an account exists with this email, a password reset code has been sent.'
      })
    }

    // Generate 6-digit reset code
    const code = Math.floor(100000 + Math.random() * 900000).toString()
    const expiresAt = Date.now() + 10 * 60 * 1000 // 10 minutes

    // Store code with email as key (ensure code is stored as string, trimmed)
    const emailKey = email.trim().toLowerCase()
    resetCodes.set(emailKey, {
      code: code.trim(), // Ensure code is trimmed when stored
      expiresAt,
      email: emailKey
    })

    console.log('✅ Reset code generated for email:', emailKey)
    console.log('✅ Code stored:', code)
    console.log('✅ Code expires at:', new Date(expiresAt).toISOString())
    console.log('✅ Total codes in memory:', resetCodes.size)

    // Send reset code via email using Supabase SMTP
    const transporter = createTransporter()
    
    if (!transporter) {
      console.error('❌ SMTP not configured. SMTP credentials are missing in environment variables.')
      console.log('💡 To fix: Configure SMTP in Supabase Dashboard → Authentication → SMTP Settings')
      
      if (process.env.NODE_ENV === 'development') {
        console.log('🔐 Password reset code for', email, ':', code)
        return NextResponse.json({
          success: true,
          message: 'Password reset code generated (check console). Configure SMTP to send emails.',
          code: code
        })
      }
      
      return NextResponse.json(
        { error: 'Email service not configured. Please configure SMTP in Supabase Dashboard.' },
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
      
      console.log('📧 Sending password reset code via Supabase SMTP to:', email.trim().toLowerCase())
      console.log('📧 From email:', `${fromName} <${fromEmail}>`)
      console.log('📧 SMTP Host:', process.env.SMTP_HOST)
      
      const mailOptions = {
        from: `${fromName} <${fromEmail}>`,
        to: email.trim().toLowerCase(),
        subject: 'BUILDMATE - Password Reset Code',
        html: `
          <!DOCTYPE html>
          <html>
            <head>
              <meta charset="utf-8">
              <meta name="viewport" content="width=device-width, initial-scale=1.0">
              <title>Password Reset</title>
            </head>
            <body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
              <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
                <h1 style="color: white; margin: 0;">BUILDMATE</h1>
                <p style="color: rgba(255,255,255,0.9); margin: 10px 0 0 0;">Password Reset</p>
              </div>
              
              <div style="background: #f9fafb; padding: 30px; border-radius: 0 0 10px 10px;">
                <h2 style="color: #1f2937; margin-top: 0;">Hello ${user.user_name || 'User'},</h2>
                <p style="color: #4b5563;">You requested to reset your password. Please use the verification code below to proceed:</p>
                
                <div style="background: white; padding: 30px; border-radius: 8px; margin: 20px 0; text-align: center; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                  <p style="color: #6b7280; font-size: 14px; margin: 0 0 10px 0;">Your password reset code is:</p>
                  <div style="font-size: 32px; font-weight: bold; color: #667eea; letter-spacing: 8px; font-family: 'Courier New', monospace;">
                    ${code}
                  </div>
                </div>

                <p style="color: #6b7280; font-size: 14px; margin: 20px 0;">
                  This code will expire in <strong>10 minutes</strong>. If you didn't request this reset, please ignore this email and your password will remain unchanged.
                </p>

                <div style="background: #fef3c7; border-left: 4px solid #f59e0b; padding: 15px; margin: 20px 0; border-radius: 4px;">
                  <p style="margin: 0; color: #92400e; font-size: 14px;">
                    <strong>Security Notice:</strong> Never share this code with anyone. BUILDMATE will never ask for your reset code.
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
      
      console.log('✅ Password reset code email sent successfully via Supabase SMTP:', info.messageId)
      return NextResponse.json({
        success: true,
        message: 'Password reset code sent to your verified email address'
      })
    } catch (emailError: any) {
      console.error('❌ Error sending email via Supabase SMTP:', emailError)
      console.error('Error details:', JSON.stringify(emailError, null, 2))
      
      // Even if email fails, the code is still stored in memory
      // In development, return the code so user can test
      if (process.env.NODE_ENV === 'development') {
        console.log('⚠️ Email sending failed, but code is stored in memory')
        console.log('🔐 Password reset code for', emailKey, ':', code)
        console.log('💡 You can still verify this code (until server restarts or code expires)')
        return NextResponse.json({
          success: true,
          message: 'Email sending failed, but code generated (check console). Fix SMTP configuration to send emails.',
          code: code,
          error: emailError.message || 'Email sending failed',
          note: 'Code is stored in memory. You can verify it even if email failed (until server restarts).'
        })
      }
      
      // In production, don't expose the code but still store it
      // User might have received email before the error
      console.log('⚠️ Email sending failed, but code is stored in memory for:', emailKey)
      return NextResponse.json(
        { 
          success: true,
          message: 'Password reset code may have been sent. If you did not receive it, please check your spam folder or try again.',
          details: 'The code is stored and valid for 10 minutes. If email failed, please check SMTP configuration.'
        },
        { status: 200 }
      )
    }

  } catch (error: any) {
    console.error('Send reset code error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

// Export resetCodes for use in verify route
export { resetCodes }

