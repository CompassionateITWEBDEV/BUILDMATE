import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'

export async function POST(request: NextRequest) {
  try {
    // Get the authorization header
    const authHeader = request.headers.get('authorization')
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return NextResponse.json(
        { error: 'Authorization header required' },
        { status: 401 }
      )
    }

    const token = authHeader.substring(7) // Remove 'Bearer ' prefix

    // Set the session for the request
    const { error: setSessionError } = await supabase.auth.setSession({
      access_token: token,
      refresh_token: '' // We don't have refresh token in this context
    })

    if (setSessionError) {
      console.error('Session error:', setSessionError)
      return NextResponse.json(
        { error: 'Invalid session' },
        { status: 401 }
      )
    }

    // Sign out the user
    const { error: signOutError } = await supabase.auth.signOut()

    if (signOutError) {
      console.error('Sign out error:', signOutError)
      return NextResponse.json(
        { error: 'Failed to sign out' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      message: 'Logout successful'
    }, { status: 200 })

  } catch (error) {
    console.error('Logout error:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}

// Alternative logout method that doesn't require token
export async function GET() {
  try {
    // This method can be used for client-side logout
    const { error } = await supabase.auth.signOut()

    if (error) {
      console.error('Sign out error:', error)
      return NextResponse.json(
        { error: 'Failed to sign out' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      message: 'Logout successful'
    }, { status: 200 })

  } catch (error) {
    console.error('Logout error:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}




