import { NextRequest, NextResponse } from 'next/server'
import { verificationCodes } from '../send-verification-code/route'

export async function POST(request: NextRequest) {
  try {
    const { email, token } = await request.json()

    if (!email || !token) {
      return NextResponse.json(
        { error: 'Email and verification token are required' },
        { status: 400 }
      )
    }

    const emailKey = email.trim().toLowerCase()
    const storedData = verificationCodes.get(emailKey)

    if (!storedData) {
      console.error('❌ Verification not found for email:', emailKey)
      return NextResponse.json(
        { 
          error: 'Verification not found or expired. Please restart the registration process and verify your email again.',
          details: 'The verification code may have expired or you need to verify your email first.'
        },
        { status: 400 }
      )
    }

    const verifiedData = storedData as any

    // Check if email was verified first
    if (!verifiedData.verified) {
      console.error('❌ Email not verified yet. Email:', emailKey)
      return NextResponse.json(
        { 
          error: 'Email not verified. Please verify your email with the 6-digit code first.',
          details: 'You must enter the verification code before completing registration.'
        },
        { status: 400 }
      )
    }

    // Check if token matches
    if (!verifiedData.token || verifiedData.token !== token) {
      console.error('❌ Token mismatch. Expected:', verifiedData.token?.substring(0, 10), 'Got:', token?.substring(0, 10))
      return NextResponse.json(
        { 
          error: 'Invalid verification token. Please restart the registration process.',
          details: 'The verification token does not match. Please verify your email again.'
        },
        { status: 400 }
      )
    }

    // Check if token expired
    if (verifiedData.tokenExpiresAt && verifiedData.tokenExpiresAt < Date.now()) {
      verificationCodes.delete(emailKey)
      console.error('❌ Token expired for email:', emailKey)
      return NextResponse.json(
        { 
          error: 'Verification token has expired. Please restart the registration process.',
          details: 'The verification token is only valid for 15 minutes. Please verify your email again.'
        },
        { status: 400 }
      )
    }

    console.log('✅ Token verified successfully for email:', emailKey)
    return NextResponse.json({
      success: true,
      message: 'Verification token is valid'
    })

  } catch (error: any) {
    console.error('Verify token error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

