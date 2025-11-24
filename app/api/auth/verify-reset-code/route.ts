import { NextRequest, NextResponse } from 'next/server'
import { resetCodes } from '../send-reset-code/route'
import crypto from 'crypto'

export async function POST(request: NextRequest) {
  try {
    // Parse request body with error handling
    let body
    try {
      const text = await request.text()
      if (!text || text.trim() === '') {
        return NextResponse.json(
          { error: 'Request body is empty. Email and reset code are required.' },
          { status: 400 }
        )
      }
      body = JSON.parse(text)
    } catch (parseError: any) {
      console.error('❌ JSON parse error:', parseError.message)
      return NextResponse.json(
        { error: 'Invalid JSON in request body. Please provide email and code as JSON.' },
        { status: 400 }
      )
    }

    const { email, code } = body

    if (!email || !code) {
      return NextResponse.json(
        { error: 'Email and reset code are required' },
        { status: 400 }
      )
    }

    // Look up the stored code
    const emailKey = email.trim().toLowerCase()
    console.log('🔍 Looking up reset code for email:', emailKey)
    console.log('🔍 Total codes in memory:', resetCodes.size)
    console.log('🔍 Available email keys:', Array.from(resetCodes.keys()))
    
    const storedData = resetCodes.get(emailKey)

    if (!storedData) {
      console.error('❌ Reset code not found for email:', emailKey)
      console.error('  Available codes:', Array.from(resetCodes.keys()))
      console.error('  Requested email key:', emailKey)
      console.error('  Email keys match?', Array.from(resetCodes.keys()).includes(emailKey))
      
      // Check if there's a similar email (case/whitespace issue)
      const similarKeys = Array.from(resetCodes.keys()).filter(key => 
        key.toLowerCase() === emailKey || key.replace(/\s/g, '') === emailKey.replace(/\s/g, '')
      )
      if (similarKeys.length > 0) {
        console.error('  ⚠️ Found similar keys:', similarKeys)
      }
      
      return NextResponse.json(
        { 
          error: 'Invalid or expired reset code. Please request a new password reset.',
          details: 'The reset code may have expired, the server may have restarted, or you need to request a new one. If you just requested a code, make sure you use the exact email address you entered.'
        },
        { status: 400 }
      )
    }
    
    console.log('✅ Found stored code for email:', emailKey)
    console.log('✅ Code expires at:', new Date(storedData.expiresAt).toISOString())

    // Check if code has expired
    if (Date.now() > storedData.expiresAt) {
      resetCodes.delete(emailKey)
      console.error('❌ Reset code expired for email:', emailKey)
      console.error('  Expired at:', new Date(storedData.expiresAt).toISOString())
      return NextResponse.json(
        { 
          error: 'Reset code has expired. Please request a new password reset.',
          details: 'Reset codes expire after 10 minutes. Please request a new code.'
        },
        { status: 400 }
      )
    }

    // Verify the code (trim whitespace and compare)
    const trimmedCode = code.trim()
    const storedCode = storedData.code.trim()
    
    if (storedCode !== trimmedCode) {
      console.error('❌ Reset code mismatch for email:', email.trim().toLowerCase())
      console.error('  Expected:', storedCode)
      console.error('  Received:', trimmedCode)
      return NextResponse.json(
        { 
          error: 'Invalid reset code. Please check and try again.',
          details: 'Make sure you enter the exact 6-digit code from your email. Check for typos or extra spaces.'
        },
        { status: 400 }
      )
    }

    // Generate a reset token (valid for 15 minutes)
    const resetToken = crypto.randomBytes(32).toString('hex')
    const tokenExpiresAt = Date.now() + 15 * 60 * 1000 // 15 minutes

    // Update stored data with token
    const updatedData = {
      ...storedData,
      verified: true,
      token: resetToken,
      tokenExpiresAt
    }
    resetCodes.set(emailKey, updatedData)

    console.log('✅ Reset code verified successfully for email:', emailKey)
    console.log('✅ Reset token generated. Expires at:', new Date(tokenExpiresAt).toISOString())

    return NextResponse.json({
      success: true,
      message: 'Reset code verified successfully',
      token: resetToken
    })

  } catch (error: any) {
    console.error('Verify reset code error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

// Helper function to check if reset is verified
export async function checkResetVerified(email: string, token: string): Promise<boolean> {
  const storedData = resetCodes.get(email.trim().toLowerCase())
  
  if (!storedData) {
    return false
  }

  if (!storedData.verified || storedData.token !== token) {
    return false
  }

  if (Date.now() > (storedData as any).tokenExpiresAt) {
    return false
  }

  return true
}

