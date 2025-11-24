import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'
import nodemailer from 'nodemailer'

// Initialize nodemailer transporter
const createTransporter = () => {
  const smtpHost = process.env.SMTP_HOST
  const smtpPort = process.env.SMTP_PORT ? parseInt(process.env.SMTP_PORT) : 587
  const smtpUser = process.env.SMTP_USER
  const smtpPassword = process.env.SMTP_PASSWORD

  if (!smtpHost || !smtpUser || !smtpPassword) {
    throw new Error('SMTP credentials are missing')
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

// POST - Send message from retailer to user or vice versa
export async function POST(request: NextRequest) {
  try {
    const { buildId, retailerEmail, userEmail, message, senderType, senderName } = await request.json()

    if (!buildId || !retailerEmail || !userEmail || !message || !senderType) {
      return NextResponse.json(
        { error: 'Missing required fields: buildId, retailerEmail, userEmail, message, senderType' },
        { status: 400 }
      )
    }

    // Fetch build data
    const { data: buildData, error: buildError } = await supabase
      .from('builds')
      .select(`
        build_id,
        build_name,
        users(email, user_name),
        build_components(
          components(
            retailers(retailer_name, email)
          )
        )
      `)
      .eq('build_id', buildId)
      .single()

    if (buildError || !buildData) {
      return NextResponse.json(
        { error: 'Build not found' },
        { status: 404 }
      )
    }

    const buildName = buildData.build_name
    const userName = (buildData.users as any)?.user_name || 'Customer'
    const userEmailFromDb = (buildData.users as any)?.email

    // Find retailer name
    const components = (buildData.build_components as any[]).map((bc: any) => bc.components)
    const retailer = components.find((c: any) => c.retailers?.email === retailerEmail)?.retailers
    const retailerName = retailer?.retailer_name || 'Retailer'

    // Store conversation in localStorage (in production, use database)
    const conversationKey = `buildmate-conversation-${buildId}-${retailerEmail}`
    
    // Create conversation entry
    const conversationEntry = {
      id: Date.now().toString(),
      buildId,
      retailerEmail,
      userEmail,
      message,
      senderType, // 'retailer' or 'user'
      senderName: senderName || (senderType === 'retailer' ? retailerName : userName),
      createdAt: new Date().toISOString(),
    }

    // Parse from email
    const fromEmailRaw = process.env.SMTP_FROM_EMAIL || 'noreply@buildmate.com'
    const fromName = process.env.SMTP_FROM_NAME || 'BUILDMATE'
    const fromEmail = fromEmailRaw.includes('<') 
      ? fromEmailRaw.match(/<(.+)>/)?.[1] || fromEmailRaw 
      : fromEmailRaw

    let transporter
    try {
      transporter = createTransporter()
    } catch (error: any) {
      return NextResponse.json(
        { error: 'Email service not configured' },
        { status: 500 }
      )
    }

    // Send email to the recipient
    const recipientEmail = senderType === 'retailer' ? userEmail : retailerEmail
    const recipientName = senderType === 'retailer' ? userName : retailerName
    const senderNameForEmail = senderName || (senderType === 'retailer' ? retailerName : userName)

    const emailHtml = `
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>New Message - ${buildName}</title>
        </head>
        <body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
          <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
            <h1 style="color: white; margin: 0;">BUILDMATE</h1>
            <p style="color: rgba(255,255,255,0.9); margin: 10px 0 0 0;">New Message</p>
          </div>
          
          <div style="background: #f9fafb; padding: 30px; border-radius: 0 0 10px 10px;">
            <h2 style="color: #1f2937; margin-top: 0;">Hello ${recipientName},</h2>
            <p style="color: #4b5563;">You have received a new message regarding your purchase order:</p>
            
            <div style="background: white; padding: 20px; border-radius: 8px; margin: 20px 0; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
              <h3 style="color: #1f2937; margin-top: 0; border-bottom: 2px solid #e5e7eb; padding-bottom: 10px;">Build Information</h3>
              <p style="margin: 5px 0;"><strong>Build Name:</strong> ${buildName}</p>
              <p style="margin: 5px 0;"><strong>Build ID:</strong> #${buildId}</p>
            </div>

            <div style="background: white; padding: 20px; border-radius: 8px; margin: 20px 0; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
              <h3 style="color: #1f2937; margin-top: 0; border-bottom: 2px solid #e5e7eb; padding-bottom: 10px;">Message from ${senderNameForEmail}</h3>
              <div style="background: #f3f4f6; padding: 15px; border-radius: 6px; margin: 15px 0;">
                <p style="margin: 0; color: #1f2937; white-space: pre-wrap;">${message}</p>
              </div>
            </div>

            <div style="background: #dbeafe; border-left: 4px solid #3b82f6; padding: 15px; margin: 20px 0; border-radius: 4px;">
              <p style="margin: 0; color: #1e40af; font-size: 14px;">
                <strong>Reply:</strong> You can reply to this message by responding directly to this email, or visit your purchase details page to continue the conversation.
              </p>
            </div>

            <div style="text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #e5e7eb;">
              <p style="color: #6b7280; font-size: 12px; margin: 5px 0;">
                This is an automated email from BUILDMATE. Please reply to continue the conversation.
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
      await transporter.sendMail({
        from: `${fromName} <${fromEmail}>`,
        to: recipientEmail,
        replyTo: senderType === 'retailer' ? retailerEmail : userEmail,
        subject: `New Message - ${buildName} (Build #${buildId})`,
        html: emailHtml,
      })

      return NextResponse.json({
        success: true,
        message: 'Message sent successfully',
        conversationEntry,
      })
    } catch (emailError: any) {
      console.error('Error sending email:', emailError)
      return NextResponse.json(
        { error: 'Failed to send email', details: emailError.message },
        { status: 500 }
      )
    }

  } catch (error: any) {
    console.error('Conversation error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

// GET - Retrieve conversation history
export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const buildId = searchParams.get('buildId')
    const retailerEmail = searchParams.get('retailerEmail')

    if (!buildId || !retailerEmail) {
      return NextResponse.json(
        { error: 'buildId and retailerEmail are required' },
        { status: 400 }
      )
    }

    // In production, fetch from database
    // For now, return empty array (conversations stored in localStorage on client)
    return NextResponse.json({
      success: true,
      conversations: [],
      message: 'Conversations are stored client-side. Use POST to send messages.',
    })

  } catch (error: any) {
    console.error('Get conversation error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

