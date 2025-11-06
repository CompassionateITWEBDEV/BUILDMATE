// Utility script to add verified users to the custom users table
// This can be run in the browser console or as a separate script

import { supabase } from '@/lib/supabase'
import bcrypt from 'bcryptjs'

export async function addVerifiedUser(username: string, email: string, password: string) {
  try {
    console.log('Adding verified user:', { username, email })
    
    // Check if user already exists
    const { data: existingUser, error: checkError } = await supabase
      .from('users')
      .select('email')
      .eq('email', email)
      .single()

    if (existingUser) {
      console.error('User already exists in database')
      return { success: false, error: 'User already exists' }
    }

    // Hash password using bcrypt
    const hashedPassword = await bcrypt.hash(password, 12)
    
    // Add to custom users table
    const { data: userData, error: userError } = await supabase
      .from('users')
      .insert({
        user_name: username,
        email: email,
        password: hashedPassword,
        user_type: 'user'
      })
      .select()

    if (userError) {
      console.error('Custom users table error:', userError.message)
      return { success: false, error: userError.message }
    }

    console.log('User added to custom users table:', userData)
    return { success: true, data: userData }
  } catch (error) {
    console.error('Error adding verified user:', error)
    return { success: false, error: error instanceof Error ? error.message : 'Unknown error' }
  }
}

// Example usage:
// addVerifiedUser('testuser', 'test@example.com', 'password123')
