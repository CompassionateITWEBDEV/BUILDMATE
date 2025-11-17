/**
 * Helper functions for Supabase Auth
 * 
 * NOTE: This codebase uses a custom users table for authentication.
 * These helpers are only needed if you must use Supabase Auth for some reason.
 * 
 * To disable email confirmation in Supabase:
 * 1. Go to your Supabase Dashboard
 * 2. Navigate to Authentication > Settings
 * 3. Under "Email Auth", disable "Enable email confirmations"
 * 4. Save changes
 */

import { supabase } from './supabase'

/**
 * Auto-confirms a user's email in Supabase Auth
 * This bypasses the email confirmation requirement
 * 
 * WARNING: This requires admin privileges and should only be used
 * if you need to use Supabase Auth instead of the custom users table
 */
export async function autoConfirmUserEmail(email: string): Promise<{ success: boolean; error?: string }> {
  try {
    // This requires using the service role key, not the anon key
    // You would need to call this from a server-side API route
    // with the service role key
    
    // For now, this is a placeholder - actual implementation would require
    // server-side code with service role access
    
    return {
      success: false,
      error: 'Auto-confirmation requires server-side implementation with service role key'
    }
  } catch (error) {
    return {
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error'
    }
  }
}

/**
 * Creates a user in Supabase Auth without requiring email confirmation
 * This should be called from a server-side API route
 */
export async function createUserWithoutEmailConfirmation(
  email: string,
  password: string
): Promise<{ success: boolean; error?: string; userId?: string }> {
  try {
    // This requires admin/service role access
    // Should be implemented in a server-side API route
    
    return {
      success: false,
      error: 'This requires server-side implementation with service role key'
    }
  } catch (error) {
    return {
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error'
    }
  }
}

/**
 * IMPORTANT: The recommended approach is to use the custom users table
 * which doesn't require email confirmation. See contexts/supabase-auth-context.tsx
 * 
 * If you must use Supabase Auth, you have two options:
 * 
 * 1. Disable email confirmation in Supabase Dashboard:
 *    - Go to Authentication > Settings
 *    - Disable "Enable email confirmations"
 * 
 * 2. Auto-confirm users programmatically (requires service role key):
 *    - Create a server-side API route
 *    - Use the service role key (not anon key)
 *    - Call admin API to update user's email_confirmed_at
 */


