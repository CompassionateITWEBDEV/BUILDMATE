import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'
import nodemailer from 'nodemailer'

// Initialize nodemailer transporter with Supabase SMTP configuration
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
    const { buildId, userEmail } = await request.json()

    if (!buildId || !userEmail) {
      return NextResponse.json(
        { error: 'Build ID and user email are required' },
        { status: 400 }
      )
    }

    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if (!emailRegex.test(userEmail)) {
      return NextResponse.json(
        { error: 'Invalid email format' },
        { status: 400 }
      )
    }

    // Fetch build data with components
    const { data: buildData, error: buildError } = await supabase
      .from('builds')
      .select(`
        build_id,
        build_name,
        total_price,
        date_created,
        build_types(type_name),
        users(email, user_name),
        build_components(
          components(
            component_id,
            component_name,
            component_price,
            component_categories(category_name),
            retailers(
              retailer_name,
              retailer_address,
              retailer_phone,
              email
            )
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

    // Verify that the email matches the build owner's email
    const buildOwnerEmail = (buildData.users as any)?.email
    if (buildOwnerEmail !== userEmail) {
      return NextResponse.json(
        { error: 'Email does not match the build owner. For security, purchase details can only be sent to the verified email address.' },
        { status: 403 }
      )
    }

    // Prepare email content
    const components = (buildData.build_components as any[]).map((bc: any) => bc.components)
    const buildName = buildData.build_name
    const totalPrice = buildData.total_price
    const buildType = (buildData.build_types as any)?.type_name || 'Custom'
    const userName = (buildData.users as any)?.user_name || 'User'

    // Collect unique retailers with their components
    const retailerMap = new Map<string, { retailer: any; components: any[] }>()
    components.forEach((component: any) => {
      const retailer = component.retailers
      if (retailer && retailer.email) {
        const retailerEmail = retailer.email.trim().toLowerCase()
        if (!retailerMap.has(retailerEmail)) {
          retailerMap.set(retailerEmail, { retailer, components: [] })
        }
        retailerMap.get(retailerEmail)!.components.push(component)
      } else if (retailer && !retailer.email) {
        console.warn(`⚠️ Retailer "${retailer.retailer_name}" has no email address. Skipping email notification.`)
      }
    })

    console.log(`📧 Found ${retailerMap.size} retailer(s) with email addresses to notify`)
    if (retailerMap.size > 0) {
      retailerMap.forEach(({ retailer }, email) => {
        console.log(`  - ${retailer.retailer_name}: ${email} (${retailerMap.get(email)!.components.length} component(s))`)
      })
    }

    // Create HTML email content
    const emailHtml = `
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Purchase Details - ${buildName}</title>
        </head>
        <body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
          <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
            <h1 style="color: white; margin: 0;">BUILDMATE</h1>
            <p style="color: rgba(255,255,255,0.9); margin: 10px 0 0 0;">Purchase Details</p>
          </div>
          
          <div style="background: #f9fafb; padding: 30px; border-radius: 0 0 10px 10px;">
            <h2 style="color: #1f2937; margin-top: 0;">Hello ${userName},</h2>
            <p style="color: #4b5563;">Thank you for using BUILDMATE! Here are the purchase details for your build: <strong>${buildName}</strong></p>
            
            <div style="background: white; padding: 20px; border-radius: 8px; margin: 20px 0; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
              <h3 style="color: #1f2937; margin-top: 0; border-bottom: 2px solid #e5e7eb; padding-bottom: 10px;">Build Information</h3>
              <p style="margin: 5px 0;"><strong>Build Name:</strong> ${buildName}</p>
              <p style="margin: 5px 0;"><strong>Build Type:</strong> ${buildType}</p>
              <p style="margin: 5px 0;"><strong>Total Price:</strong> ₱${totalPrice.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</p>
              <p style="margin: 5px 0;"><strong>Date Created:</strong> ${new Date(buildData.date_created).toLocaleDateString()}</p>
            </div>

            <div style="background: white; padding: 20px; border-radius: 8px; margin: 20px 0; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
              <h3 style="color: #1f2937; margin-top: 0; border-bottom: 2px solid #e5e7eb; padding-bottom: 10px;">Components (${components.length})</h3>
              ${components.map((component: any, index: number) => {
                const category = component.component_categories?.category_name || 'Unknown'
                const retailer = component.retailers
                return `
                  <div style="border-bottom: 1px solid #e5e7eb; padding: 15px 0; ${index === components.length - 1 ? 'border-bottom: none;' : ''}">
                    <p style="margin: 5px 0; font-weight: bold; color: #1f2937;">${component.component_name}</p>
                    <p style="margin: 5px 0; color: #6b7280; font-size: 14px;">Category: ${category}</p>
                    <p style="margin: 5px 0; color: #059669; font-weight: bold;">Price: ₱${component.component_price.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</p>
                    ${retailer ? `
                      <div style="margin-top: 10px; padding-top: 10px; border-top: 1px solid #f3f4f6;">
                        <p style="margin: 3px 0; font-size: 13px; color: #4b5563;"><strong>Retailer:</strong> ${retailer.retailer_name}</p>
                        ${retailer.retailer_address ? `<p style="margin: 3px 0; font-size: 13px; color: #4b5563;"><strong>Address:</strong> ${retailer.retailer_address}</p>` : ''}
                        ${retailer.retailer_phone ? `<p style="margin: 3px 0; font-size: 13px; color: #4b5563;"><strong>Phone:</strong> ${retailer.retailer_phone}</p>` : ''}
                        ${retailer.email ? `<p style="margin: 3px 0; font-size: 13px; color: #4b5563;"><strong>Email:</strong> ${retailer.email}</p>` : ''}
                      </div>
                    ` : ''}
                  </div>
                `
              }).join('')}
            </div>

            <div style="background: #fef3c7; border-left: 4px solid #f59e0b; padding: 15px; margin: 20px 0; border-radius: 4px;">
              <p style="margin: 0; color: #92400e; font-size: 14px;">
                <strong>Security Notice:</strong> This email was sent to your verified email address (${userEmail}) for security purposes. 
                Please keep this information confidential.
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

    // Send email to user using Nodemailer with Supabase SMTP
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

    const emailResults = {
      userEmailSent: false,
      retailerEmailsSent: 0,
      retailerEmailsFailed: 0,
      errors: [] as string[]
    }

    // Send email to user
    try {
      await transporter.verify()
      console.log('✅ SMTP connection verified')

      const userMailOptions = {
        from: `${fromName} <${fromEmail}>`,
        to: userEmail,
        subject: `Purchase Details - ${buildName}`,
        html: emailHtml,
      }

      const userEmailInfo = await transporter.sendMail(userMailOptions)
      console.log('✅ Purchase details email sent to user:', userEmailInfo.messageId)
      emailResults.userEmailSent = true
    } catch (userEmailError: any) {
      console.error('❌ Error sending email to user:', userEmailError)
      emailResults.errors.push(`Failed to send email to user: ${userEmailError.message}`)
    }

    // Send emails to retailers
    console.log(`📧 Starting to send emails to ${retailerMap.size} retailer(s)...`)
    const retailerEmailPromises = Array.from(retailerMap.entries()).map(async ([retailerEmail, { retailer, components: retailerComponents }]) => {
      try {
        // Create retailer-specific email content
        const retailerEmailHtml = `
          <!DOCTYPE html>
          <html>
            <head>
              <meta charset="utf-8">
              <meta name="viewport" content="width=device-width, initial-scale=1.0">
              <title>New Purchase Order - ${buildName}</title>
            </head>
            <body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
              <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
                <h1 style="color: white; margin: 0;">BUILDMATE</h1>
                <p style="color: rgba(255,255,255,0.9); margin: 10px 0 0 0;">New Purchase Order</p>
              </div>
              
              <div style="background: #f9fafb; padding: 30px; border-radius: 0 0 10px 10px;">
                <h2 style="color: #1f2937; margin-top: 0;">Hello ${retailer.retailer_name},</h2>
                <p style="color: #4b5563;">A customer has created a build that includes components from your store. Here are the details:</p>
                
                <div style="background: white; padding: 20px; border-radius: 8px; margin: 20px 0; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                  <h3 style="color: #1f2937; margin-top: 0; border-bottom: 2px solid #e5e7eb; padding-bottom: 10px;">Customer Information</h3>
                  <p style="margin: 5px 0;"><strong>Customer Name:</strong> ${userName}</p>
                  <p style="margin: 5px 0;"><strong>Build Name:</strong> ${buildName}</p>
                  <p style="margin: 5px 0;"><strong>Build Type:</strong> ${buildType}</p>
                  <p style="margin: 5px 0;"><strong>Date Created:</strong> ${new Date(buildData.date_created).toLocaleDateString()}</p>
                </div>

                <div style="background: white; padding: 20px; border-radius: 8px; margin: 20px 0; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                  <h3 style="color: #1f2937; margin-top: 0; border-bottom: 2px solid #e5e7eb; padding-bottom: 10px;">Components from Your Store (${retailerComponents.length})</h3>
                  ${retailerComponents.map((component: any, index: number) => {
                    const category = component.component_categories?.category_name || 'Unknown'
                    const componentTotal = retailerComponents.reduce((sum: number, c: any) => sum + (parseFloat(c.component_price) || 0), 0)
                    return `
                      <div style="border-bottom: 1px solid #e5e7eb; padding: 15px 0; ${index === retailerComponents.length - 1 ? 'border-bottom: none;' : ''}">
                        <p style="margin: 5px 0; font-weight: bold; color: #1f2937;">${component.component_name}</p>
                        <p style="margin: 5px 0; color: #6b7280; font-size: 14px;">Category: ${category}</p>
                        <p style="margin: 5px 0; color: #059669; font-weight: bold;">Price: ₱${component.component_price.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</p>
                      </div>
                    `
                  }).join('')}
                  <div style="margin-top: 15px; padding-top: 15px; border-top: 2px solid #e5e7eb;">
                    <p style="margin: 5px 0; font-size: 16px; font-weight: bold; color: #1f2937;">
                      Subtotal: ₱${retailerComponents.reduce((sum: number, c: any) => sum + (parseFloat(c.component_price) || 0), 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                    </p>
                  </div>
                </div>

                <div style="background: #dbeafe; border-left: 4px solid #3b82f6; padding: 15px; margin: 20px 0; border-radius: 4px;">
                  <p style="margin: 0; color: #1e40af; font-size: 14px;">
                    <strong>Next Steps:</strong> Please prepare the components listed above. The customer will be notified once the order is ready for pickup or delivery.
                  </p>
                </div>

                <div style="background: white; padding: 20px; border-radius: 8px; margin: 20px 0; box-shadow: 0 1px 3px rgba(0,0,0,0.1); border: 2px solid #3b82f6;">
                  <h3 style="color: #1f2937; margin-top: 0; border-bottom: 2px solid #e5e7eb; padding-bottom: 10px;">Contact Customer</h3>
                  <p style="color: #4b5563; margin-bottom: 15px;">You can send a message to the customer by replying to this email. Your reply will be forwarded to the customer.</p>
                  
                  <div style="background: #f3f4f6; padding: 15px; border-radius: 6px; margin: 15px 0;">
                    <p style="margin: 0; color: #1f2937; font-size: 14px;">
                      <strong>To send a message:</strong>
                    </p>
                    <ul style="margin: 10px 0 0 20px; padding: 0; color: #4b5563; font-size: 14px;">
                      <li style="margin-bottom: 5px;">Simply reply to this email</li>
                      <li style="margin-bottom: 5px;">Your message will be sent to: <strong>${userEmail}</strong></li>
                      <li>The customer can reply directly to continue the conversation</li>
                    </ul>
                  </div>
                  
                  <div style="text-align: center; margin-top: 15px;">
                    <a 
                      href="mailto:${userEmail}?subject=Re: Purchase Order - ${buildName} (Build #${buildData.build_id})&body=Hello ${userName},%0D%0A%0D%0A[Type your message here]%0D%0A%0D%0ABest regards,%0D%0A${retailer.retailer_name}"
                      style="background: #3b82f6; color: white; padding: 12px 24px; border: none; border-radius: 6px; font-weight: bold; text-decoration: none; display: inline-block; font-size: 14px;">
                      Reply via Email
                    </a>
                  </div>
                  
                  <p style="color: #6b7280; font-size: 12px; margin-top: 15px; margin-bottom: 0; text-align: center;">
                    Or simply reply to this email to send a message to the customer.
                  </p>
                </div>

                <div style="text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #e5e7eb;">
                  <p style="color: #6b7280; font-size: 12px; margin: 5px 0;">
                    This is an automated email from BUILDMATE. You can contact the customer using the form above.
                  </p>
                  <p style="color: #9ca3af; font-size: 11px; margin: 5px 0;">
                    © ${new Date().getFullYear()} BUILDMATE. All rights reserved.
                  </p>
                </div>
              </div>
            </body>
          </html>
        `

        const retailerMailOptions = {
          from: `${fromName} <${fromEmail}>`,
          to: retailerEmail,
          subject: `New Purchase Order - ${buildName} (${retailerComponents.length} items)`,
          html: retailerEmailHtml,
        }

        const retailerEmailInfo = await transporter.sendMail(retailerMailOptions)
        console.log(`✅ Purchase order email sent to retailer ${retailer.retailer_name}:`, retailerEmailInfo.messageId)
        emailResults.retailerEmailsSent++
        return { success: true, retailer: retailer.retailer_name }
      } catch (retailerEmailError: any) {
        console.error(`❌ Error sending email to retailer ${retailer.retailer_name}:`, retailerEmailError)
        emailResults.retailerEmailsFailed++
        emailResults.errors.push(`Failed to send email to ${retailer.retailer_name}: ${retailerEmailError.message}`)
        return { success: false, retailer: retailer.retailer_name, error: retailerEmailError.message }
      }
    })

    // Wait for all retailer emails to be sent
    await Promise.all(retailerEmailPromises)

    // Return response
    if (emailResults.userEmailSent && emailResults.retailerEmailsSent > 0) {
      return NextResponse.json({
        success: true,
        message: `Purchase details sent to your email and ${emailResults.retailerEmailsSent} retailer(s)`,
        userEmailSent: emailResults.userEmailSent,
        retailerEmailsSent: emailResults.retailerEmailsSent,
        retailerEmailsFailed: emailResults.retailerEmailsFailed,
        errors: emailResults.errors.length > 0 ? emailResults.errors : undefined
      })
    } else if (emailResults.userEmailSent) {
      return NextResponse.json({
        success: true,
        message: 'Purchase details sent to your email. No retailer emails were sent (retailers may not have email addresses).',
        userEmailSent: emailResults.userEmailSent,
        retailerEmailsSent: emailResults.retailerEmailsSent,
        warnings: emailResults.errors
      })
    } else {
      return NextResponse.json(
        { 
          success: false,
          error: 'Failed to send purchase details email',
          details: emailResults.errors
        },
        { status: 500 }
      )
    }

  } catch (error: any) {
    console.error('Send purchase email error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

