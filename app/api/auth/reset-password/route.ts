import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'
import { createClient } from '@supabase/supabase-js'
import bcrypt from 'bcryptjs'
import { checkResetVerified } from '../verify-reset-code/route'

// Use service role key for admin operations
const supabaseAdmin = process.env.SUPABASE_SERVICE_ROLE_KEY
  ? createClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    )
  : null

export async function POST(request: NextRequest) {
  try {
    // Parse request body with error handling
    let body
    try {
      const text = await request.text()
      if (!text || text.trim() === '') {
        return NextResponse.json(
          { error: 'Request body is empty. Email, token, and password are required.' },
          { status: 400 }
        )
      }
      body = JSON.parse(text)
    } catch (parseError: any) {
      console.error('❌ JSON parse error:', parseError.message)
      return NextResponse.json(
        { error: 'Invalid JSON in request body. Please provide email, token, and password as JSON.' },
        { status: 400 }
      )
    }

    const { email, token, password } = body

    if (!email || !token || !password) {
      return NextResponse.json(
        { error: 'Email, token, and password are required' },
        { status: 400 }
      )
    }

    if (password.length < 6) {
      return NextResponse.json(
        { error: 'Password must be at least 6 characters long' },
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

    // Verify the reset token using our code verification system
    const emailKey = email.trim().toLowerCase()
    console.log('🔍 Validating reset token for email:', emailKey)
    console.log('🔍 Token (first 10 chars):', token?.substring(0, 10))
    
    const isVerified = await checkResetVerified(emailKey, token)

    if (!isVerified) {
      console.error('❌ Reset token validation failed for email:', emailKey)
      console.error('  Token provided:', token?.substring(0, 10))
      
      // Import resetCodes to check what's stored
      const { resetCodes } = await import('../send-reset-code/route')
      const storedData = resetCodes.get(emailKey)
      
      if (!storedData) {
        console.error('  No stored data found for email')
        return NextResponse.json(
          { 
            error: 'Invalid or expired reset token. Please request a new password reset.',
            details: 'The reset token was not found. This may happen if the server restarted or the token expired. Please go back and verify your code again.'
          },
          { status: 400 }
        )
      }
      
      if (!storedData.verified) {
        console.error('  Email not verified yet')
        return NextResponse.json(
          { 
            error: 'Email not verified. Please verify your email with the 6-digit code first.',
            details: 'You must verify the reset code before resetting your password.'
          },
          { status: 400 }
        )
      }
      
      if (storedData.token !== token) {
        console.error('  Token mismatch')
        console.error('  Expected:', storedData.token?.substring(0, 10))
        console.error('  Received:', token?.substring(0, 10))
        return NextResponse.json(
          { 
            error: 'Invalid reset token. Please verify your code again.',
            details: 'The reset token does not match. Please go back to the verification step and verify your code again.'
          },
          { status: 400 }
        )
      }
      
      if ((storedData as any).tokenExpiresAt && Date.now() > (storedData as any).tokenExpiresAt) {
        console.error('  Token expired')
        console.error('  Expired at:', new Date((storedData as any).tokenExpiresAt).toISOString())
        return NextResponse.json(
          { 
            error: 'Reset token has expired. Please request a new password reset.',
            details: 'The reset token is only valid for 15 minutes. Please go back and verify your code again.'
          },
          { status: 400 }
        )
      }
      
      return NextResponse.json(
        { 
          error: 'Invalid or expired reset token. Please request a new password reset.',
          details: 'The reset token could not be validated. Please go back and verify your code again.'
        },
        { status: 400 }
      )
    }
    
    console.log('✅ Reset token validated successfully for email:', emailKey)

    // Get user from database
    const { data: user, error: userError } = await supabase
      .from('users')
      .select('supabase_id, email')
      .eq('email', email.trim().toLowerCase())
      .single()

    if (userError || !user) {
      return NextResponse.json(
        { error: 'User not found' },
        { status: 404 }
      )
    }

    // Hash the new password
    const hashedPassword = await bcrypt.hash(password, 12)

    // Update password in custom users table
    const { error: updateError } = await supabase
      .from('users')
      .update({ password: hashedPassword })
      .eq('email', email.trim().toLowerCase())

    if (updateError) {
      console.error('Error updating password in users table:', updateError)
      return NextResponse.json(
        { error: 'Failed to update password' },
        { status: 500 }
      )
    }

    // Also update password in Supabase Auth if supabase_id exists
    if (supabaseAdmin && user.supabase_id) {
      try {
        const { error: authUpdateError } = await supabaseAdmin.auth.admin.updateUserById(
          user.supabase_id,
          { password }
        )

        if (authUpdateError) {
          console.error('Error updating password in Supabase Auth:', authUpdateError)
          // Don't fail the request if Auth update fails, since we already updated the custom table
        }
      } catch (err) {
        console.error('Error updating Supabase Auth password:', err)
        // Continue even if Auth update fails
      }
    }

    return NextResponse.json({
      success: true,
      message: 'Password reset successfully'
    })

  } catch (error: any) {
    console.error('Reset password error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

