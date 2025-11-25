import { NextRequest, NextResponse } from 'next/server'
import nodemailer from 'nodemailer'

// Initialize nodemailer transporter with SMTP configuration
const createTransporter = () => {
  const smtpHost = process.env.SMTP_HOST
  const smtpPort = process.env.SMTP_PORT ? parseInt(process.env.SMTP_PORT) : 587
  const smtpUser = process.env.SMTP_USER
  const smtpPassword = process.env.SMTP_PASSWORD
  const smtpFromEmail = process.env.SMTP_FROM_EMAIL || 'BUILDMATE <noreply@buildmate.com>'
  const smtpFromName = process.env.SMTP_FROM_NAME || 'BUILDMATE'

  // Validate for placeholders
  if (smtpHost === 'your_smtp_host' || smtpUser === 'your_smtp_user' || smtpPassword === 'your_smtp_password') {
    throw new Error('SMTP credentials in .env.local are still placeholders. Please replace them with actual values.')
  }

  if (!smtpHost || !smtpUser || !smtpPassword) {
    throw new Error('SMTP credentials (host, user, password) are missing in environment variables.')
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

export async function POST(request: NextRequest) {
  try {
    const ticketData = await request.json()

    if (!ticketData) {
      return NextResponse.json(
        { error: 'Ticket data is required' },
        { status: 400 }
      )
    }

    const {
      id,
      title,
      type,
      priority,
      status,
      description,
      createdAt,
      userName,
      userEmail,
      buildId,
      assignedTo
    } = ticketData

    // Validate required fields
    if (!id || !title || !type || !description) {
      return NextResponse.json(
        { error: 'Missing required ticket fields' },
        { status: 400 }
      )
    }

    // Get support type label
    const supportTypeLabels: Record<string, string> = {
      troubleshooting: 'Troubleshooting',
      build_problem: 'Build Problem',
      delivery: 'Delivery/Repair',
      general: 'General Inquiry'
    }

    // Get priority label
    const priorityLabels: Record<string, string> = {
      low: 'Low',
      medium: 'Medium',
      high: 'High',
      urgent: 'Urgent'
    }

    const supportTypeLabel = supportTypeLabels[type] || type
    const priorityLabel = priorityLabels[priority] || priority

    // Create HTML email content
    const emailHtml = `
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>New Support Ticket - ${id}</title>
        </head>
        <body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
          <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
            <h1 style="color: white; margin: 0;">BUILDMATE</h1>
            <p style="color: rgba(255,255,255,0.9); margin: 10px 0 0 0;">New Support Ticket</p>
          </div>
          
          <div style="background: #f9fafb; padding: 30px; border-radius: 0 0 10px 10px;">
            <h2 style="color: #1f2937; margin-top: 0;">New Support Ticket Created</h2>
            <p style="color: #4b5563;">A customer has submitted a new support ticket. Please review and respond accordingly.</p>
            
            <div style="background: white; padding: 20px; border-radius: 8px; margin: 20px 0; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
              <h3 style="color: #1f2937; margin-top: 0; border-bottom: 2px solid #e5e7eb; padding-bottom: 10px;">Ticket Information</h3>
              <p style="margin: 5px 0;"><strong>Ticket ID:</strong> ${id}</p>
              <p style="margin: 5px 0;"><strong>Title:</strong> ${title}</p>
              <p style="margin: 5px 0;"><strong>Type:</strong> ${supportTypeLabel}</p>
              <p style="margin: 5px 0;"><strong>Priority:</strong> <span style="color: ${priority === 'urgent' ? '#dc2626' : priority === 'high' ? '#ea580c' : priority === 'medium' ? '#d97706' : '#16a34a'}; font-weight: bold;">${priorityLabel}</span></p>
              <p style="margin: 5px 0;"><strong>Status:</strong> ${status}</p>
              <p style="margin: 5px 0;"><strong>Date Created:</strong> ${new Date(createdAt || new Date().toISOString()).toLocaleString()}</p>
              ${assignedTo ? `<p style="margin: 5px 0;"><strong>Assigned To:</strong> ${assignedTo}</p>` : ''}
            </div>

            <div style="background: white; padding: 20px; border-radius: 8px; margin: 20px 0; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
              <h3 style="color: #1f2937; margin-top: 0; border-bottom: 2px solid #e5e7eb; padding-bottom: 10px;">Customer Information</h3>
              ${userName ? `<p style="margin: 5px 0;"><strong>Customer Name:</strong> ${userName}</p>` : ''}
              ${userEmail ? `<p style="margin: 5px 0;"><strong>Customer Email:</strong> <a href="mailto:${userEmail}" style="color: #3b82f6;">${userEmail}</a></p>` : ''}
              ${buildId ? `<p style="margin: 5px 0;"><strong>Related Build ID:</strong> ${buildId}</p>` : ''}
            </div>

            <div style="background: white; padding: 20px; border-radius: 8px; margin: 20px 0; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
              <h3 style="color: #1f2937; margin-top: 0; border-bottom: 2px solid #e5e7eb; padding-bottom: 10px;">Description</h3>
              <div style="background: #f3f4f6; padding: 15px; border-radius: 6px; margin: 15px 0;">
                <p style="margin: 0; color: #1f2937; white-space: pre-wrap;">${description}</p>
              </div>
            </div>

            <div style="background: #dbeafe; border-left: 4px solid #3b82f6; padding: 15px; margin: 20px 0; border-radius: 4px;">
              <p style="margin: 0; color: #1e40af; font-size: 14px;">
                <strong>Action Required:</strong> Please review this ticket and respond to the customer as soon as possible. 
                ${userEmail ? `You can reply directly to this email to contact the customer at ${userEmail}.` : ''}
              </p>
            </div>

            <div style="text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #e5e7eb;">
              <p style="color: #6b7280; font-size: 12px; margin: 5px 0;">
                This is an automated email from BUILDMATE Support System.
              </p>
              <p style="color: #9ca3af; font-size: 11px; margin: 5px 0;">
                © ${new Date().getFullYear()} BUILDMATE. All rights reserved.
              </p>
            </div>
          </div>
        </body>
      </html>
    `

    // Send email using Nodemailer
    let transporter
    try {
      transporter = createTransporter()
    } catch (transporterError: any) {
      console.error('❌ SMTP configuration error:', transporterError.message)
      if (process.env.NODE_ENV === 'development') {
        return NextResponse.json({
          success: false,
          error: transporterError.message,
          message: 'Please configure SMTP in .env.local'
        })
      }
      return NextResponse.json(
        { error: 'Email service not configured. Please configure SMTP settings.' },
        { status: 500 }
      )
    }

    if (!transporter) {
      return NextResponse.json(
        { error: 'Email service not configured. Please configure SMTP settings.' },
        { status: 500 }
      )
    }

    // Parse from email
    const fromEmailRaw = process.env.SMTP_FROM_EMAIL || 'noreply@buildmate.com'
    const fromName = process.env.SMTP_FROM_NAME || 'BUILDMATE'
    const fromEmail = fromEmailRaw.includes('<') 
      ? fromEmailRaw.match(/<(.+)>/)?.[1] || fromEmailRaw 
      : fromEmailRaw

    // Always send to Central Juan email
    const CENTRAL_JUAN_EMAIL = 'sales.centraljuan.net@gmail.com'

    try {
      await transporter.verify()
      console.log('✅ SMTP connection verified')

      const mailOptions = {
        from: `${fromName} <${fromEmail}>`,
        to: CENTRAL_JUAN_EMAIL,
        replyTo: userEmail || fromEmail,
        subject: `New Support Ticket - ${id}: ${title}`,
        html: emailHtml,
      }

      const emailInfo = await transporter.sendMail(mailOptions)
      console.log('✅ Support ticket email sent to Central Juan:', emailInfo.messageId)

      return NextResponse.json({
        success: true,
        message: 'Support ticket notification sent successfully',
        emailSent: true,
        messageId: emailInfo.messageId
      })
    } catch (emailError: any) {
      console.error('❌ Error sending support ticket email:', emailError)
      return NextResponse.json(
        { 
          success: false,
          error: 'Failed to send support ticket email',
          details: emailError.message 
        },
        { status: 500 }
      )
    }

  } catch (error: any) {
    console.error('Send support ticket email error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

