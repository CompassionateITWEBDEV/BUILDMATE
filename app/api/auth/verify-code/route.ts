import { NextRequest, NextResponse } from 'next/server'
import { verificationCodes } from '../send-verification-code/route'
import crypto from 'crypto'

export async function POST(request: NextRequest) {
  try {
    const { email, code } = await request.json()

    if (!email || !code) {
      return NextResponse.json(
        { error: 'Email and verification code are required' },
        { status: 400 }
      )
    }

    const emailKey = email.trim().toLowerCase()
    const storedData = verificationCodes.get(emailKey)

    if (!storedData) {
      console.error(`❌ Verification code not found for ${emailKey}`)
      return NextResponse.json(
        { error: 'Verification code not found. Please request a new code.' },
        { status: 400 }
      )
    }

    const now = Date.now()
    const timeRemaining = Math.ceil((storedData.expiresAt - now) / 1000)
    
    if (storedData.expiresAt < now) {
      verificationCodes.delete(emailKey)
      console.error(`❌ Verification code expired for ${emailKey}. Expired at ${new Date(storedData.expiresAt).toISOString()}`)
      return NextResponse.json(
        { error: 'Verification code has expired. Please request a new code.' },
        { status: 400 }
      )
    }
    
    console.log(`✅ Verifying code for ${emailKey}, ${timeRemaining} seconds remaining`)

    if (storedData.code !== code.trim()) {
      return NextResponse.json(
        { error: 'Invalid verification code. Please try again.' },
        { status: 400 }
      )
    }

    // Code is valid - mark email as verified
    // Store verification token (valid for 15 minutes)
    const verificationToken = crypto.randomBytes(32).toString('hex')
    const tokenExpiresAt = Date.now() + 15 * 60 * 1000 // 15 minutes

    // Update stored data with token
    const updatedData = {
      ...storedData,
      verified: true,
      token: verificationToken,
      tokenExpiresAt
    }
    verificationCodes.set(email.trim().toLowerCase(), updatedData)

    console.log('✅ Verification code verified for email:', email.trim().toLowerCase())
    console.log('✅ Token generated and stored. Expires at:', new Date(tokenExpiresAt).toISOString())

    return NextResponse.json({
      success: true,
      message: 'Email verified successfully',
      token: verificationToken
    })

  } catch (error: any) {
    console.error('Verify code error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

// Helper function to check if email is verified
export async function checkEmailVerified(email: string, token: string): Promise<boolean> {
  const storedData = verificationCodes.get(email.trim().toLowerCase())
  
  if (!storedData || !(storedData as any).verified) {
    return false
  }

  if ((storedData as any).token !== token) {
    return false
  }

  if ((storedData as any).tokenExpiresAt && (storedData as any).tokenExpiresAt < Date.now()) {
    verificationCodes.delete(email.trim().toLowerCase())
    return false
  }

  return true
}

