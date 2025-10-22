import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'
import { userService } from '@/lib/database'

export async function GET(request: NextRequest) {
  try {
    // Check if Supabase is properly configured
    if (!process.env.NEXT_PUBLIC_SUPABASE_URL || !process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY) {
      return NextResponse.json(
        { error: 'Supabase configuration missing. Please check your environment variables.' },
        { status: 500 }
      )
    }

    // Get the authorization header
    const authHeader = request.headers.get('authorization')
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return NextResponse.json(
        { error: 'Authorization header required' },
        { status: 401 }
      )
    }

    const token = authHeader.substring(7) // Remove 'Bearer ' prefix

    // Verify the token and get user
    const { data: { user }, error: authError } = await supabase.auth.getUser(token)

    if (authError || !user) {
      console.error('Auth error:', authError)
      return NextResponse.json(
        { error: 'Invalid or expired token' },
        { status: 401 }
      )
    }

    // Get user profile from database
    try {
      const userProfile = await userService.getByEmail(user.email!)

      return NextResponse.json({
        success: true,
        user: {
          id: user.id,
          email: user.email,
          username: userProfile.user_name,
          user_type: userProfile.user_type,
          created_at: user.created_at,
          last_sign_in: user.last_sign_in_at,
          email_confirmed: user.email_confirmed_at !== null
        }
      }, { status: 200 })

    } catch (dbError) {
      console.error('Database error:', dbError)
      return NextResponse.json(
        { error: 'Failed to retrieve user profile' },
        { status: 500 }
      )
    }

  } catch (error) {
    console.error('Get user error:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}


