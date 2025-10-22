"use client"

import { createContext, useContext, useState, useEffect, type ReactNode } from "react"
import { supabase } from "@/lib/supabase"
import type { User } from "@supabase/supabase-js"

interface AuthContextType {
  user: User | null
  login: (email: string, password: string) => Promise<boolean>
  register: (username: string, email: string, password: string) => Promise<boolean>
  logout: () => Promise<void>
  isLoading: boolean
}

const AuthContext = createContext<AuthContextType | undefined>(undefined)

export function SupabaseAuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null)
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    // Get initial session
    const getInitialSession = async () => {
      const { data: { session } } = await supabase.auth.getSession()
      setUser(session?.user ?? null)
      setIsLoading(false)
    }

    getInitialSession()

    // Listen for auth changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      async (event, session) => {
        setUser(session?.user ?? null)
        setIsLoading(false)
      }
    )

    return () => subscription.unsubscribe()
  }, [])

  const login = async (email: string, password: string): Promise<boolean> => {
    setIsLoading(true)
    
    try {
      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password,
      })

      if (error) {
        console.error('Login error:', error.message)
        setIsLoading(false)
        return false
      }

      // Update user profile if needed
      if (data.user) {
        const { data: profile } = await supabase
          .from('users')
          .select('*')
          .eq('email', email)
          .single()

        if (!profile) {
          // Create user profile if it doesn't exist
          await supabase
            .from('users')
            .insert({
              user_name: data.user.user_metadata?.full_name || email.split('@')[0],
              email: email,
              password: '', // Password is handled by Supabase Auth
              user_type: 'user'
            })
        }
      }

      setIsLoading(false)
      return true
    } catch (error) {
      console.error('Login error:', error)
      setIsLoading(false)
      return false
    }
  }

  const register = async (username: string, email: string, password: string): Promise<boolean> => {
    setIsLoading(true)
    
    try {
      const { data, error } = await supabase.auth.signUp({
        email,
        password,
        options: {
          data: {
            full_name: username,
          }
        }
      })

      if (error) {
        console.error('Registration error:', error.message)
        setIsLoading(false)
        return false
      }

      // Create user profile
      if (data.user) {
        await supabase
          .from('users')
          .insert({
            user_name: username,
            email: email,
            password: '', // Password is handled by Supabase Auth
            user_type: 'user'
          })
      }

      setIsLoading(false)
      return true
    } catch (error) {
      console.error('Registration error:', error)
      setIsLoading(false)
      return false
    }
  }

  const logout = async (): Promise<void> => {
    setIsLoading(true)
    
    try {
      await supabase.auth.signOut()
    } catch (error) {
      console.error('Logout error:', error)
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <AuthContext.Provider value={{ user, login, register, logout, isLoading }}>
      {children}
    </AuthContext.Provider>
  )
}

export function useSupabaseAuth() {
  const context = useContext(AuthContext)
  if (context === undefined) {
    throw new Error("useSupabaseAuth must be used within a SupabaseAuthProvider")
  }
  return context
}

