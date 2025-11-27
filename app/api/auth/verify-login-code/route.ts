import { NextRequest, NextResponse } from 'next/server'
import { loginVerificationCodes } from '../send-login-verification-code/route'

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
    const storedData = loginVerificationCodes.get(emailKey)

    if (!storedData) {
      console.error(`❌ Login verification code not found for ${emailKey}`)
      return NextResponse.json(
        { error: 'Verification code not found. Please request a new code.' },
        { status: 400 }
      )
    }

    const now = Date.now()
    const timeRemaining = Math.ceil((storedData.expiresAt - now) / 1000)
    
    if (storedData.expiresAt < now) {
      loginVerificationCodes.delete(emailKey)
      console.error(`❌ Login verification code expired for ${emailKey}. Expired at ${new Date(storedData.expiresAt).toISOString()}`)
      return NextResponse.json(
        { error: 'Verification code has expired. Please request a new code.' },
        { status: 400 }
      )
    }
    
    console.log(`✅ Verifying login code for ${emailKey}, ${timeRemaining} seconds remaining`)

    if (storedData.code !== code.trim()) {
      return NextResponse.json(
        { error: 'Invalid verification code. Please try again.' },
        { status: 400 }
      )
    }

    // Code is valid - mark as verified
    storedData.verified = true
    loginVerificationCodes.set(emailKey, storedData)

    console.log('✅ Login verification code verified for email:', emailKey)

    return NextResponse.json({
      success: true,
      message: 'Email verified successfully'
    })

  } catch (error: any) {
    console.error('Verify login code error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

// Check if login is verified
export async function checkLoginVerified(email: string): Promise<boolean> {
  const emailKey = email.trim().toLowerCase()
  const storedData = loginVerificationCodes.get(emailKey)
  
  if (!storedData) return false
  if (storedData.expiresAt < Date.now()) {
    loginVerificationCodes.delete(emailKey)
    return false
  }
  
  return storedData.verified === true
}

