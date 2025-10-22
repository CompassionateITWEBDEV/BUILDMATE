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
    const { username, email, password } = body

    // Validate input
    if (!username || !email || !password) {
      return NextResponse.json(
        { error: 'Username, email, and password are required' },
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

    // Validate password strength
    if (password.length < 6) {
      return NextResponse.json(
        { error: 'Password must be at least 6 characters long' },
        { status: 400 }
      )
    }

    // Check if user already exists
    const existingUser = await userService.getByEmail(email)
    if (existingUser) {
      return NextResponse.json(
        { error: 'User with this email already exists' },
        { status: 409 }
      )
    }

    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10)

    // Create user profile in database
    try {
      const userProfile = await userService.create({
        user_name: username,
        email: email,
        password: hashedPassword,
        user_type: 'user'
      })

      // Generate a simple session token
      const sessionToken = Buffer.from(`${userProfile.user_id}:${Date.now()}`).toString('base64')
      const expiresAt = Date.now() + (24 * 60 * 60 * 1000) // 24 hours

      // Return success response with user data
      return NextResponse.json({
        success: true,
        message: 'Registration successful',
        user: {
          id: userProfile.user_id.toString(),
          email: userProfile.email,
          username: userProfile.user_name,
          user_type: userProfile.user_type,
          created_at: userProfile.created_at,
          email_confirmed: true
        },
        session: {
          access_token: sessionToken,
          refresh_token: sessionToken,
          expires_at: expiresAt
        }
      }, { status: 201 })

    } catch (dbError) {
      console.error('Database error:', dbError)
      return NextResponse.json(
        { error: 'Failed to create user profile' },
        { status: 500 }
      )
    }

  } catch (error) {
    console.error('Registration error:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}