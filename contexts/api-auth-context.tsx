"use client"

import { createContext, useContext, useState, useEffect, type ReactNode } from "react"
import { authAPI, type AuthUser } from "@/lib/auth-api"

interface AuthContextType {
  user: AuthUser | null
  login: (email: string, password: string) => Promise<boolean>
  register: (username: string, email: string, password: string) => Promise<boolean>
  logout: () => Promise<void>
  updateProfile: (profileData: { username: string; user_type?: 'admin' | 'user' | 'moderator' }) => Promise<boolean>
  isLoading: boolean
  error: string | null
  clearError: () => void
}

const AuthContext = createContext<AuthContextType | undefined>(undefined)

export function APIAuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<AuthUser | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    // Check for stored user session on mount
    const initializeAuth = async () => {
      try {
        // First check if we have a stored user
        const storedUser = authAPI.getStoredUser()
        if (storedUser) {
          setUser(storedUser)
        }

        // Then verify with the server
        const currentUser = await authAPI.getCurrentUser()
        if (currentUser) {
          setUser(currentUser)
          authAPI.storeUser(currentUser)
        } else {
          // Clear stored data if server verification fails
          authAPI.clearUser()
          setUser(null)
        }
      } catch (error) {
        console.error('Auth initialization error:', error)
        authAPI.clearUser()
        setUser(null)
      } finally {
        setIsLoading(false)
      }
    }

    initializeAuth()
  }, [])

  const login = async (email: string, password: string): Promise<boolean> => {
    setIsLoading(true)
    setError(null)

    try {
      const response = await authAPI.login(email, password)
      
      if (response.success && response.user) {
        setUser(response.user)
        authAPI.storeUser(response.user)
        return true
      }
      
      return false
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'Login failed'
      setError(errorMessage)
      console.error('Login error:', error)
      return false
    } finally {
      setIsLoading(false)
    }
  }

  const register = async (username: string, email: string, password: string): Promise<boolean> => {
    setIsLoading(true)
    setError(null)

    try {
      const response = await authAPI.register(username, email, password)
      
      if (response.success && response.user) {
        setUser(response.user)
        authAPI.storeUser(response.user)
        return true
      }
      
      return false
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'Registration failed'
      setError(errorMessage)
      console.error('Registration error:', error)
      return false
    } finally {
      setIsLoading(false)
    }
  }

  const logout = async (): Promise<void> => {
    setIsLoading(true)
    setError(null)

    try {
      await authAPI.logout()
    } catch (error) {
      console.error('Logout error:', error)
    } finally {
      setUser(null)
      authAPI.clearUser()
      setIsLoading(false)
    }
  }

  const updateProfile = async (profileData: { username: string; user_type?: 'admin' | 'user' | 'moderator' }): Promise<boolean> => {
    setIsLoading(true)
    setError(null)

    try {
      const response = await authAPI.updateProfile(profileData)
      
      if (response.success && response.user) {
        setUser(response.user)
        authAPI.storeUser(response.user)
        return true
      }
      
      return false
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'Profile update failed'
      setError(errorMessage)
      console.error('Update profile error:', error)
      return false
    } finally {
      setIsLoading(false)
    }
  }

  const clearError = () => setError(null)

  return (
    <AuthContext.Provider 
      value={{ 
        user, 
        login, 
        register, 
        logout, 
        updateProfile, 
        isLoading, 
        error: error,
        clearError: clearError
      }}
    >
      {children}
    </AuthContext.Provider>
  )
}

export function useAPIAuth() {
  const context = useContext(AuthContext)
  if (context === undefined) {
    throw new Error("useAPIAuth must be used within an APIAuthProvider")
  }
  return context
}
