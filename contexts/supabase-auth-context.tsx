"use client"

import { createContext, useContext, useState, useEffect, type ReactNode } from "react"
import { supabase } from "@/lib/supabase"
import bcrypt from 'bcryptjs'

// Custom user interface based on your users table
interface CustomUser {
  user_id: number
  user_name: string
  email: string
  user_type: 'admin' | 'user' | 'moderator'
  created_at: string
}

interface AuthContextType {
  user: CustomUser | null
  login: (email: string, password: string) => Promise<{ success: boolean; error?: string }>
  register: (username: string, email: string, password: string) => Promise<boolean>
  logout: () => Promise<void>
  isLoading: boolean
}

const AuthContext = createContext<AuthContextType | undefined>(undefined)

export function SupabaseAuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<CustomUser | null>(null)
  const [isLoading, setIsLoading] = useState(true)

  // Safe state setter to prevent React error boundary from catching errors
  const safeSetIsLoading = (value: boolean) => {
    try {
      console.log('Setting isLoading to:', value)
      setIsLoading(value)
    } catch (error) {
      console.error('Error setting loading state:', error)
    }
  }

  const safeSetUser = (value: CustomUser | null) => {
    try {
      console.log('Setting user to:', value ? 'present' : 'null')
      setUser(value)
    } catch (error) {
      console.error('Error setting user state:', error)
    }
  }

  useEffect(() => {
    // Check for stored user session in localStorage
    const getInitialSession = async () => {
      try {
        console.log('Getting initial session from localStorage...')
        const storedUser = localStorage.getItem('buildmate-user')
        
        if (storedUser) {
          console.log('Found stored user, verifying...')
          const userData = JSON.parse(storedUser)
          
          // Verify user still exists in database
          const { data: userProfile, error: profileError } = await supabase
            .from('users')
            .select('*')
            .eq('email', userData.email)
            .single()

          if (profileError || !userProfile) {
            console.log('Stored user no longer exists in database, clearing...')
            localStorage.removeItem('buildmate-user')
            safeSetUser(null)
          } else {
            console.log('Stored user verified, setting user...')
            safeSetUser(userProfile)
          }
        } else {
          console.log('No stored user found')
          safeSetUser(null)
        }
        
        safeSetIsLoading(false)
      } catch (error) {
        console.error('Error getting initial session:', error)
        localStorage.removeItem('buildmate-user')
        safeSetUser(null)
        safeSetIsLoading(false)
      }
    }

    getInitialSession()
  }, [])

  const login = async (email: string, password: string): Promise<{ success: boolean; error?: string }> => {
    try {
      console.log('Starting login process for:', email)
      safeSetIsLoading(true)
      
      // Validate input
      if (!email || !password) {
        return { success: false, error: 'Email and password are required' }
      }

      // Validate email format
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
      if (!emailRegex.test(email)) {
        return { success: false, error: 'Please enter a valid email address' }
      }

      // Get user from custom users table
      console.log('Fetching user from custom users table...')
      const { data: userProfile, error: userError } = await supabase
        .from('users')
        .select('*')
        .eq('email', email.trim().toLowerCase())
        .single()

      if (userError) {
        // Check if it's a "not found" error
        if (userError.code === 'PGRST116') {
          console.error('User not found in database')
          return { success: false, error: 'Invalid email or password. Please check your credentials and try again.' }
        }
        console.error('Database error:', userError.message)
        return { success: false, error: 'Unable to connect to server. Please try again later.' }
      }

      if (!userProfile) {
        console.error('User not found in database')
        return { success: false, error: 'Invalid email or password. Please check your credentials and try again.' }
      }

      console.log('User found in database, verifying password...')
      
      // Verify password using bcrypt
      const isPasswordValid = await bcrypt.compare(password, userProfile.password)
      
      if (!isPasswordValid) {
        console.error('Invalid password')
        return { success: false, error: 'Invalid email or password. Please check your credentials and try again.' }
      }

      console.log('Password verified, logging in user...')
      
      // Store user in localStorage and set state
      localStorage.setItem('buildmate-user', JSON.stringify(userProfile))
      safeSetUser(userProfile)
      
      console.log('Login successful')
      return { success: true }
    } catch (error: any) {
      console.error('Login error:', error)
      
      // Handle specific error types
      if (error.message?.includes('network') || error.message?.includes('fetch')) {
        return { success: false, error: 'Network error. Please check your internet connection and try again.' }
      }
      
      return { success: false, error: 'An unexpected error occurred. Please try again later.' }
    } finally {
      console.log('Setting loading to false')
      safeSetIsLoading(false)
    }
  }

  const register = async (username: string, email: string, password: string): Promise<boolean> => {
    try {
      console.log('Starting registration process for:', email)
      safeSetIsLoading(true)
      
      // Check if user already exists
      console.log('Checking if user already exists...')
      const { data: existingUser, error: checkError } = await supabase
        .from('users')
        .select('email')
        .eq('email', email)
        .single()

      if (existingUser) {
        console.error('User already exists in database')
        return false
      }

      console.log('User does not exist, hashing password...')
      
      // Hash password using bcrypt
      const hashedPassword = await bcrypt.hash(password, 12)
      
      console.log('Creating user in custom users table...')
      
      // Create user in custom users table
      const { data: userData, error: insertError } = await supabase
        .from('users')
        .insert({
          user_name: username,
          email: email,
          password: hashedPassword,
          user_type: 'user'
        })
        .select()

      if (insertError) {
        console.error('Error creating user:', insertError.message)
        return false
      }

      console.log('User created successfully:', userData)
      
      // Store user in localStorage and set state
      if (userData && userData[0]) {
        localStorage.setItem('buildmate-user', JSON.stringify(userData[0]))
        safeSetUser(userData[0])
      }
      
      console.log('Registration successful')
      return true
    } catch (error) {
      console.error('Registration error:', error)
      return false
    } finally {
      safeSetIsLoading(false)
    }
  }

  const logout = async (): Promise<void> => {
    try {
      console.log('Logging out user...')
      safeSetIsLoading(true)
      
      // Clear localStorage and user state
      localStorage.removeItem('buildmate-user')
      safeSetUser(null)
      
      console.log('Logout successful')
    } catch (error) {
      console.error('Logout error:', error)
    } finally {
      safeSetIsLoading(false)
    }
  }

  return (
    <AuthContext.Provider value={{ user, login, register, logout, isLoading }}>
      {children}
    </AuthContext.Provider>
  )
}

export function useAuth() {
  const context = useContext(AuthContext)
  if (context === undefined) {
    throw new Error("useAuth must be used within a SupabaseAuthProvider")
  }
  return context
}

export function useSupabaseAuth() {
  const context = useContext(AuthContext)
  if (context === undefined) {
    throw new Error("useSupabaseAuth must be used within a SupabaseAuthProvider")
  }
  return context
}

