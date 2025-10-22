// Client-side authentication service using API routes

export interface AuthUser {
  id: string
  email: string
  username: string
  user_type: 'admin' | 'user' | 'moderator'
  created_at: string
  last_sign_in?: string
  email_confirmed?: boolean
}

export interface AuthResponse {
  success: boolean
  message: string
  user?: AuthUser
  session?: {
    access_token: string
    refresh_token: string
    expires_at: number
  }
}

export interface ProfileUpdateData {
  username: string
  user_type?: 'admin' | 'user' | 'moderator'
}

class AuthAPI {
  private baseUrl = '/api/auth'

  // Helper method to get auth headers
  private getAuthHeaders(token?: string | null) {
    const headers: HeadersInit = {
      'Content-Type': 'application/json',
    }

    if (token) {
      headers.Authorization = `Bearer ${token}`
    }

    return headers
  }

  // Register a new user
  async register(username: string, email: string, password: string): Promise<AuthResponse> {
    try {
      const response = await fetch(`${this.baseUrl}/register`, {
        method: 'POST',
        headers: this.getAuthHeaders(),
        body: JSON.stringify({ username, email, password }),
      })

      const data = await response.json()

      if (!response.ok) {
        throw new Error(data.error || 'Registration failed')
      }

      return data
    } catch (error) {
      console.error('Registration error:', error)
      throw error
    }
  }

  // Login user
  async login(email: string, password: string): Promise<AuthResponse> {
    try {
      const response = await fetch(`${this.baseUrl}/login`, {
        method: 'POST',
        headers: this.getAuthHeaders(),
        body: JSON.stringify({ email, password }),
      })

      const data = await response.json()

      if (!response.ok) {
        throw new Error(data.error || 'Login failed')
      }

      // Store session data in localStorage
      if (data.session) {
        localStorage.setItem('auth_token', data.session.access_token)
        localStorage.setItem('refresh_token', data.session.refresh_token)
        localStorage.setItem('token_expires_at', data.session.expires_at.toString())
      }

      return data
    } catch (error) {
      console.error('Login error:', error)
      throw error
    }
  }

  // Logout user
  async logout(): Promise<AuthResponse> {
    try {
      const token = this.getStoredToken()
      
      const response = await fetch(`${this.baseUrl}/logout`, {
        method: 'POST',
        headers: this.getAuthHeaders(token),
      })

      const data = await response.json()

      // Clear stored session data
      this.clearStoredSession()

      return data
    } catch (error) {
      console.error('Logout error:', error)
      // Clear session data even if API call fails
      this.clearStoredSession()
      throw error
    }
  }

  // Get current user profile
  async getCurrentUser(): Promise<AuthUser | null> {
    try {
      const token = this.getStoredToken()
      if (!token) {
        return null
      }

      const response = await fetch(`${this.baseUrl}/me`, {
        method: 'GET',
        headers: this.getAuthHeaders(token),
      })

      if (!response.ok) {
        if (response.status === 401) {
          // Token is invalid, clear stored session
          this.clearStoredSession()
        }
        return null
      }

      const data = await response.json()
      return data.user || null
    } catch (error) {
      console.error('Get current user error:', error)
      return null
    }
  }

  // Update user profile
  async updateProfile(profileData: ProfileUpdateData): Promise<AuthResponse> {
    try {
      const token = this.getStoredToken()
      if (!token) {
        throw new Error('No authentication token found')
      }

      const response = await fetch(`${this.baseUrl}/profile`, {
        method: 'PUT',
        headers: this.getAuthHeaders(token),
        body: JSON.stringify(profileData),
      })

      const data = await response.json()

      if (!response.ok) {
        throw new Error(data.error || 'Profile update failed')
      }

      return data
    } catch (error) {
      console.error('Update profile error:', error)
      throw error
    }
  }

  // Get stored token
  private getStoredToken(): string | null {
    if (typeof window === 'undefined') return null
    
    const token = localStorage.getItem('auth_token')
    const expiresAt = localStorage.getItem('token_expires_at')
    
    if (!token || !expiresAt) return null
    
    // Check if token is expired
    if (Date.now() >= parseInt(expiresAt)) {
      this.clearStoredSession()
      return null
    }
    
    return token
  }

  // Clear stored session data
  private clearStoredSession(): void {
    if (typeof window === 'undefined') return
    
    localStorage.removeItem('auth_token')
    localStorage.removeItem('refresh_token')
    localStorage.removeItem('token_expires_at')
  }

  // Check if user is authenticated
  isAuthenticated(): boolean {
    return this.getStoredToken() !== null
  }

  // Get stored user data (for initial load)
  getStoredUser(): AuthUser | null {
    if (typeof window === 'undefined') return null
    
    try {
      const storedUser = localStorage.getItem('buildmate-user')
      return storedUser ? JSON.parse(storedUser) : null
    } catch {
      return null
    }
  }

  // Store user data
  storeUser(user: AuthUser): void {
    if (typeof window === 'undefined') return
    
    localStorage.setItem('buildmate-user', JSON.stringify(user))
  }

  // Clear user data
  clearUser(): void {
    if (typeof window === 'undefined') return
    
    localStorage.removeItem('buildmate-user')
  }
}

// Export singleton instance
export const authAPI = new AuthAPI()
