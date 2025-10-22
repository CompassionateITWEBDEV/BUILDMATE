import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'
import { userService } from '@/lib/database'
import bcrypt from 'bcryptjs'

export async function POST(request: NextRequest) {
  try {
    // Check if Supabase is properly configured
    if (!process.env.NEXT_PUBLIC_SUPABASE_URL || !process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY) {
      return NextResponse.json(
        { error: 'Supabase configuration missing. Please check your environment variables.' },
        { status: 500 }
      )
    }

    const body = await request.json()
    const { email, password } = body

    // Validate input
    if (!email || !password) {
      return NextResponse.json(
        { error: 'Email and password are required' },
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

    // Get user from database
    const userProfile = await userService.getByEmail(email)
    
    console.log('User profile found:', userProfile ? 'Yes' : 'No')
    if (userProfile) {
      console.log('User email:', userProfile.email)
      console.log('Stored password hash:', userProfile.password)
      console.log('Password length:', userProfile.password?.length)
    }
    
    if (!userProfile) {
      return NextResponse.json(
        { error: 'Invalid email or password' },
        { status: 401 }
      )
    }

    // Verify password
    console.log('Attempting password verification...')
    const isPasswordValid = await bcrypt.compare(password, userProfile.password)
    console.log('Password verification result:', isPasswordValid)
    
    if (!isPasswordValid) {
      return NextResponse.json(
        { error: 'Invalid email or password' },
        { status: 401 }
      )
    }

    // Generate a simple session token (in production, use JWT)
    const sessionToken = Buffer.from(`${userProfile.user_id}:${Date.now()}`).toString('base64')
    const expiresAt = Date.now() + (24 * 60 * 60 * 1000) // 24 hours

    // Return success response with user data
    return NextResponse.json({
      success: true,
      message: 'Login successful',
      user: {
        id: userProfile.user_id.toString(),
        email: userProfile.email,
        username: userProfile.user_name,
        user_type: userProfile.user_type,
        created_at: userProfile.created_at,
        last_sign_in: new Date().toISOString()
      },
      session: {
        access_token: sessionToken,
        refresh_token: sessionToken, // Simple implementation
        expires_at: expiresAt
      }
    }, { status: 200 })

  } catch (error) {
    console.error('Login error:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}


