import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'
import nodemailer from 'nodemailer'

// Store login verification codes temporarily (in-memory)
// In production, use Redis or a database
const loginVerificationCodes = new Map<string, { code: string; expiresAt: number; email: string }>()

// Clean up expired codes every 10 minutes
setInterval(() => {
  const now = Date.now()
  for (const [email, data] of loginVerificationCodes.entries()) {
    if (data.expiresAt < now) {
      loginVerificationCodes.delete(email)
    }
  }
}, 10 * 60 * 1000)

// Initialize nodemailer transporter
const createTransporter = () => {
  const smtpHost = process.env.SMTP_HOST
  const smtpPort = process.env.SMTP_PORT ? parseInt(process.env.SMTP_PORT) : 587
  const smtpUser = process.env.SMTP_USER
  const smtpPassword = process.env.SMTP_PASSWORD
  const smtpFromEmail = process.env.SMTP_FROM_EMAIL || 'BUILDMATE <noreply@buildmate.com>'
  const smtpFromName = process.env.SMTP_FROM_NAME || 'BUILDMATE'

  // Check for placeholders
  if (smtpHost === 'your_smtp_host' || smtpUser === 'your_smtp_user' || smtpPassword === 'your_smtp_password') {
    throw new Error('SMTP credentials in environment variables are still placeholders. Please configure them in Render/Vercel dashboard.')
  }

  if (!smtpHost || !smtpUser || !smtpPassword) {
    console.error('❌ SMTP Configuration Missing:')
    console.error('   SMTP_HOST:', smtpHost ? '✅ Set' : '❌ Missing')
    console.error('   SMTP_USER:', smtpUser ? '✅ Set' : '❌ Missing')
    console.error('   SMTP_PASSWORD:', smtpPassword ? '✅ Set' : '❌ Missing')
    throw new Error('SMTP credentials are missing in environment variables. Please configure SMTP_HOST, SMTP_USER, and SMTP_PASSWORD in Render/Vercel dashboard.')
  }

  console.log('📧 SMTP Configuration:')
  console.log('   Host:', smtpHost)
  console.log('   Port:', smtpPort)
  console.log('   User:', smtpUser)
  console.log('   From:', smtpFromEmail)

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

export async function POST(request: NextRequest) {
  try {
    const { email, userId } = await request.json()

    if (!email || !userId) {
      return NextResponse.json(
        { error: 'Email and user ID are required' },
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

    // Check if user exists (verify by user_id and email match)
    const { data: user, error: userError } = await supabase
      .from('users')
      .select('email, user_name, user_id')
      .eq('user_id', userId)
      .eq('email', email.trim().toLowerCase())
      .single()

    if (userError || !user) {
      return NextResponse.json(
        { error: 'User not found or email mismatch' },
        { status: 404 }
      )
    }

    // Generate 6-digit verification code
    const code = Math.floor(100000 + Math.random() * 900000).toString()
    const expiresAt = Date.now() + 10 * 60 * 1000 // 10 minutes

    // Store code with email as key
    loginVerificationCodes.set(email.trim().toLowerCase(), {
      code,
      expiresAt,
      email: email.trim().toLowerCase()
    })

    // Send email with verification code
    let transporter
    try {
      transporter = createTransporter()
    } catch (transporterError: any) {
      console.error('❌ SMTP configuration error:', transporterError.message)
      return NextResponse.json(
        { error: 'Email service not configured' },
        { status: 500 }
      )
    }

    const fromEmailRaw = process.env.SMTP_FROM_EMAIL || 'noreply@buildmate.com'
    const fromName = process.env.SMTP_FROM_NAME || 'BUILDMATE'
    const fromEmail = fromEmailRaw.includes('<') 
      ? fromEmailRaw.match(/<(.+)>/)?.[1] || fromEmailRaw 
      : fromEmailRaw

    const emailHtml = `
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Login Verification Code</title>
        </head>
        <body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
          <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
            <h1 style="color: white; margin: 0;">BUILDMATE</h1>
            <p style="color: rgba(255,255,255,0.9); margin: 10px 0 0 0;">Login Verification Code</p>
          </div>
          
          <div style="background: #f9fafb; padding: 30px; border-radius: 0 0 10px 10px;">
            <h2 style="color: #1f2937; margin-top: 0;">Hello ${user.user_name},</h2>
            <p style="color: #4b5563;">You've requested to login to your BUILDMATE account. Please use the verification code below:</p>
            
            <div style="background: white; padding: 30px; border-radius: 8px; margin: 20px 0; box-shadow: 0 1px 3px rgba(0,0,0,0.1); text-align: center;">
              <h1 style="color: #667eea; font-size: 48px; margin: 0; letter-spacing: 8px; font-weight: bold;">${code}</h1>
              <p style="color: #6b7280; margin-top: 10px; font-size: 14px;">This code will expire in 10 minutes</p>
            </div>

            <div style="background: #fef3c7; border-left: 4px solid #f59e0b; padding: 15px; margin: 20px 0; border-radius: 4px;">
              <p style="margin: 0; color: #92400e; font-size: 14px;">
                <strong>Security Notice:</strong> If you didn't request this code, please ignore this email or contact support if you're concerned about your account security.
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
    `

    try {
      // Verify SMTP connection first
      await transporter.verify()
      console.log('✅ SMTP connection verified')

      const emailInfo = await transporter.sendMail({
        from: `${fromName} <${fromEmail}>`,
        to: email.trim().toLowerCase(),
        subject: `BUILDMATE Login Verification Code: ${code}`,
        html: emailHtml,
      })

      console.log('✅ Login verification code sent to:', email.trim().toLowerCase())
      console.log('   Message ID:', emailInfo.messageId)

      return NextResponse.json({
        success: true,
        message: 'Verification code sent to your email'
      })
    } catch (emailError: any) {
      console.error('❌ Error sending login verification email:', emailError)
      console.error('   Error details:', {
        code: emailError.code,
        command: emailError.command,
        response: emailError.response,
        responseCode: emailError.responseCode
      })
      
      // Provide more helpful error messages
      let errorMessage = 'Failed to send verification code email'
      if (emailError.code === 'EAUTH') {
        errorMessage = 'SMTP authentication failed. Please check SMTP_USER and SMTP_PASSWORD in environment variables.'
      } else if (emailError.code === 'ECONNECTION') {
        errorMessage = 'Cannot connect to SMTP server. Please check SMTP_HOST and SMTP_PORT in environment variables.'
      } else if (emailError.message) {
        errorMessage = `Email sending failed: ${emailError.message}`
      }
      
      return NextResponse.json(
        { error: errorMessage },
        { status: 500 }
      )
    }

  } catch (error: any) {
    console.error('Send login verification code error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

// Export the map for use in verify route
export { loginVerificationCodes }

