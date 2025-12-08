"use client";

import { createContext, useContext, useState, useEffect, ReactNode } from "react";
import { supabase, ensureValidSession } from "@/lib/supabase";
import bcrypt from "bcryptjs";

interface CustomUser {
  user_id: number;
  user_name: string;
  email: string;
  user_type: "admin" | "user" | "moderator";
  created_at: string;
  avatar_url: string;
  supabase_id: string;
  bio: string;
  website: string;
  location: string;
}

interface AuthContextType {
  user: CustomUser | null;
  login: (email: string, password: string, rememberMe?: boolean, skipVerification?: boolean) => Promise<{ success: boolean; error?: string; requiresVerification?: boolean; userId?: number }>;
  sendLoginVerificationCode: (email: string, userId: number) => Promise<{ success: boolean; error?: string }>;
  verifyLoginCode: (email: string, code: string) => Promise<{ success: boolean; error?: string }>;
  register: (username: string, email: string, password: string, verificationToken: string) => Promise<{ success: boolean; error?: string }>;
  sendVerificationCode: (email: string) => Promise<{ success: boolean; error?: string }>;
  verifyCode: (email: string, code: string) => Promise<{ success: boolean; token?: string; error?: string }>;
  logout: () => Promise<void>;
  isLoading: boolean;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function SupabaseAuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<CustomUser | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  // --------------------------
  // Load session on startup
  // --------------------------
  useEffect(() => {
    const init = async () => {
      try {
        const { data: { session }, error } = await supabase.auth.getSession();

        if (error) {
          console.error('Error getting session:', error);
          // If it's a JWT expiration error, try to refresh
          if (error.message?.includes('JWT') || error.message?.includes('expired')) {
            console.log('🔄 Attempting to refresh expired session...');
            const { data: { session: refreshedSession }, error: refreshError } = await supabase.auth.refreshSession();
            if (!refreshError && refreshedSession) {
              // Retry with refreshed session
              const { data: profile } = await supabase
                .from("users")
                .select("*")
                .eq("supabase_id", refreshedSession.user.id)
                .single();
              if (profile) {
                setUser(profile as CustomUser);
                console.log('✅ Session refreshed and profile loaded:', profile.user_name);
                setIsLoading(false);
                return;
              }
            }
          }
          setIsLoading(false);
          return;
        }

        if (session) {
          // Check if session is expired
          const expiresAt = session.expires_at;
          if (expiresAt && expiresAt * 1000 < Date.now()) {
            console.log('⚠️ Session expired, refreshing...');
            const { data: { session: refreshedSession }, error: refreshError } = await supabase.auth.refreshSession();
            if (refreshError || !refreshedSession) {
              console.error('❌ Failed to refresh expired session:', refreshError);
              setUser(null);
              setIsLoading(false);
              return;
            }
            // Use refreshed session
            const supabaseUser = refreshedSession.user;
            const { data: profile, error: profileError } = await supabase
              .from("users")
              .select("*")
              .eq("supabase_id", supabaseUser.id)
              .single();

            if (profileError) {
              // Check if it's a JWT expiration error
              if (profileError.message?.includes('JWT') || profileError.message?.includes('expired') || profileError.code === 'PGRST301') {
                console.warn('⚠️ JWT expired during profile fetch - attempting to refresh session');
                // Try to refresh the session
                const { data: { session: newSession }, error: refreshError } = await supabase.auth.refreshSession();
                if (refreshError || !newSession) {
                  console.error('❌ Failed to refresh session:', refreshError);
                  setUser(null);
                  setIsLoading(false);
                  return;
                }
                // Retry profile fetch with refreshed session
                const { data: retryProfile } = await supabase
                  .from("users")
                  .select("*")
                  .eq("supabase_id", newSession.user.id)
                  .single();
                if (retryProfile) {
                  setUser(retryProfile as CustomUser);
                  console.log('✅ Profile loaded after session refresh:', retryProfile.user_name);
                }
              } else {
                // Check if error has meaningful content
                const hasMessage = profileError?.message && typeof profileError.message === 'string' && profileError.message.trim().length > 0;
                const hasCode = profileError?.code && typeof profileError.code === 'string' && profileError.code.trim().length > 0;
                const hasDetails = profileError?.details && typeof profileError.details === 'string' && profileError.details.trim().length > 0;
                const hasHint = profileError?.hint && typeof profileError.hint === 'string' && profileError.hint.trim().length > 0;
                
                // Check if error object is truly empty
                const errorKeys = Object.keys(profileError).filter(key => profileError[key] !== undefined && profileError[key] !== null && profileError[key] !== '');
                const isEmpty = errorKeys.length === 0 || (!hasMessage && !hasCode && !hasDetails && !hasHint);
                
                const isNotFound = profileError.code === 'PGRST116';
                
                // Only log if error has meaningful content
                if (!isEmpty && !isNotFound) {
                  console.error('Error fetching profile (first check):', {
                    message: profileError.message || 'N/A',
                    code: profileError.code || 'N/A',
                    details: profileError.details || 'N/A'
                  });
                }
                // Clear session silently
                await supabase.auth.signOut();
              }
            } else if (profile) {
              setUser(profile as CustomUser);
              console.log('✅ Session refreshed and profile loaded:', profile.user_name);
            }
          } else {
            // Session is valid, proceed normally
            const supabaseUser = session.user;
            const { data: profile, error: profileError } = await supabase
              .from("users")
              .select("*")
              .eq("supabase_id", supabaseUser.id)
              .single();

            if (profileError) {
              // Check if error has meaningful content
              const hasMessage = profileError?.message && typeof profileError.message === 'string' && profileError.message.trim().length > 0;
              const hasCode = profileError?.code && typeof profileError.code === 'string' && profileError.code.trim().length > 0;
              const hasDetails = profileError?.details && typeof profileError.details === 'string' && profileError.details.trim().length > 0;
              const hasHint = profileError?.hint && typeof profileError.hint === 'string' && profileError.hint.trim().length > 0;
              
              // Check if error object is truly empty
              const errorKeys = Object.keys(profileError).filter(key => profileError[key] !== undefined && profileError[key] !== null && profileError[key] !== '');
              const isEmpty = errorKeys.length === 0 || (!hasMessage && !hasCode && !hasDetails && !hasHint);
              
              const isNotFound = profileError.code === 'PGRST116';
              
              // ONLY log if error has actual meaningful content
              if (!isEmpty && !isNotFound && (hasMessage || hasCode || hasDetails || hasHint)) {
                console.error('Error fetching profile (second check):', {
                  message: profileError.message || 'N/A',
                  code: profileError.code || 'N/A',
                  details: profileError.details || 'N/A'
                });
              }
              // Clear session silently
              await supabase.auth.signOut();
            } else if (profile) {
              setUser(profile as CustomUser);
              console.log('✅ Session restored - user logged in:', profile.user_name);
            }
          }
        } else {
          console.log('ℹ️ No active session found');
        }
      } catch (err) {
        console.error('Session initialization error:', err);
      } finally {
        setIsLoading(false);
      }
    };

    init();

    // Listen for auth state changes, but only clear user on explicit sign out
    const { data: listener } = supabase.auth.onAuthStateChange(async (event, session) => {
      console.log('Auth state changed:', event, session ? 'session exists' : 'no session');
      
      if (event === 'SIGNED_OUT') {
        // Only clear user on explicit sign out
        console.log('🔴 User signed out - clearing session');
        setUser(null);
        localStorage.removeItem('buildmate-remember-me');
        localStorage.removeItem('buildmate-session-expires');
      } else if (event === 'TOKEN_REFRESHED') {
        // Token refreshed - keep user logged in and reload profile if needed
        console.log('🔄 Session token refreshed - keeping user logged in');
        if (session?.user) {
          try {
            const { data: profile } = await supabase
              .from("users")
              .select("*")
              .eq("supabase_id", session.user.id)
              .single();
            
            if (profile) {
              setUser(profile as CustomUser);
              console.log('✅ Profile reloaded after token refresh:', profile.user_name);
            }
          } catch (error) {
            console.error('Error reloading profile after token refresh:', error);
          }
        }
      } else if (session?.user) {
        // User signed in or session exists - load profile
        try {
          const { data: profile, error: profileError } = await supabase
            .from("users")
            .select("*")
            .eq("supabase_id", session.user.id)
            .single();
          
          if (profileError) {
            // Check if it's a JWT expiration error
            if (profileError.message?.includes('JWT') || profileError.message?.includes('expired') || profileError.code === 'PGRST301') {
              console.warn('⚠️ JWT expired - attempting to refresh session');
              // Try to refresh the session
              const { data: { session: newSession }, error: refreshError } = await supabase.auth.refreshSession();
              if (refreshError || !newSession) {
                console.error('❌ Failed to refresh session:', refreshError);
                setUser(null);
                return;
              }
              // Retry profile fetch with refreshed session
              const { data: retryProfile } = await supabase
                .from("users")
                .select("*")
                .eq("supabase_id", newSession.user.id)
                .single();
              if (retryProfile) {
                setUser(retryProfile as CustomUser);
                console.log('✅ Profile loaded after session refresh:', retryProfile.user_name);
              }
            } else {
              // Check if error has meaningful content before logging
              const hasMessage = profileError?.message && typeof profileError.message === 'string' && profileError.message.trim().length > 0;
              const hasCode = profileError?.code && typeof profileError.code === 'string' && profileError.code.trim().length > 0;
              const hasDetails = profileError?.details && typeof profileError.details === 'string' && profileError.details.trim().length > 0;
              
              const errorKeys = Object.keys(profileError).filter(key => profileError[key] !== undefined && profileError[key] !== null && profileError[key] !== '');
              const isEmpty = errorKeys.length === 0 || (!hasMessage && !hasCode && !hasDetails);
              
              if (!isEmpty) {
                console.error('Error fetching profile (auth state change):', {
                  message: profileError.message || 'N/A',
                  code: profileError.code || 'N/A',
                  details: profileError.details || 'N/A'
                });
              }
            }
          } else if (profile) {
            setUser(profile as CustomUser);
            console.log('✅ User session active:', profile.user_name);
          }
        } catch (error) {
          console.error('Error in auth state change handler:', error);
        }
      }
      // Don't clear user on other events (like SIGNED_IN, USER_UPDATED, etc.)
    });

    return () => listener.subscription.unsubscribe();
  }, []);

  // --------------------------
  // SEND VERIFICATION CODE
  // --------------------------
  const sendVerificationCode = async (email: string) => {
    try {
      const response = await fetch('/api/auth/send-verification-code', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email }),
      })

      // Check if response is OK and has content
      if (!response.ok) {
        const errorText = await response.text()
        try {
          const errorData = JSON.parse(errorText)
          return { success: false, error: errorData.error || errorData.message || 'Failed to send verification code' }
        } catch {
          return { success: false, error: errorText || `Server error: ${response.status}` }
        }
      }

      // Check if response has content before parsing
      const contentType = response.headers.get('content-type')
      if (!contentType || !contentType.includes('application/json')) {
        const text = await response.text()
        return { success: false, error: text || 'Invalid response from server' }
      }

      const data = await response.json()
      return data
    } catch (err: any) {
      console.error('Send verification code error:', err)
      return { success: false, error: err.message || 'Failed to send verification code. Please try again.' }
    }
  }

  // --------------------------
  // VERIFY CODE
  // --------------------------
  const verifyCode = async (email: string, code: string) => {
    try {
      const response = await fetch('/api/auth/verify-code', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, code }),
      })

      // Check if response is OK and has content
      if (!response.ok) {
        const errorText = await response.text()
        try {
          const errorData = JSON.parse(errorText)
          return { success: false, error: errorData.error || errorData.message || 'Invalid verification code' }
        } catch {
          return { success: false, error: errorText || `Server error: ${response.status}` }
        }
      }

      // Check if response has content before parsing
      const contentType = response.headers.get('content-type')
      if (!contentType || !contentType.includes('application/json')) {
        const text = await response.text()
        return { success: false, error: text || 'Invalid response from server' }
      }

      const data = await response.json()
      return data
    } catch (err: any) {
      console.error('Verify code error:', err)
      return { success: false, error: err.message || 'Failed to verify code. Please try again.' }
    }
  }

  // --------------------------
  // REGISTER USER
  // --------------------------
  const register = async (username: string, email: string, password: string, verificationToken: string) => {
    try {
      // Verify token first by checking with the verification API
      const verifyResponse = await fetch('/api/auth/verify-token', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, token: verificationToken }),
      })

      // Check if response has valid JSON
      const contentType = verifyResponse.headers.get('content-type')
      let verifyData
      
      if (contentType && contentType.includes('application/json')) {
        verifyData = await verifyResponse.json()
      } else {
        const text = await verifyResponse.text()
        return { success: false, error: text || 'Failed to verify token' }
      }

      if (!verifyData.success) {
        return { success: false, error: verifyData.error || 'Email verification required. Please verify your email first.' }
      }

      const { data: authData, error: authError } = await supabase.auth.signUp({
        email: email.trim().toLowerCase(),
        password: password
      });

      if (authError) {
        console.error("SUPABASE SIGNUP ERROR:", authError);
        return { success: false, error: authError.message };
      }

      const supabaseId = authData.user?.id;
      if (!supabaseId) return { success: false, error: "Supabase user missing!" };

      // Hash password for your custom users table
      const hashedPassword = await bcrypt.hash(password, 12);

      // Insert into your database
      const { error: insertError } = await supabase
        .from("users")
        .insert({
          user_name: username,
          email: email.trim().toLowerCase(),
          password: hashedPassword,
          user_type: "user",
          avatar_url: "",
          supabase_id: supabaseId
        });

      if (insertError) {
        return { success: false, error: insertError.message };
      }
      // DO NOT auto-login
      return {
        success: true,
        message: "Account created successfully! You can now login."
      };

    } catch (err: any) {
      return { success: false, error: err.message };
    }
  };


  // --------------------------
  // SEND LOGIN VERIFICATION CODE
  // --------------------------
  const sendLoginVerificationCode = async (email: string, userId: number) => {
    try {
      const response = await fetch('/api/auth/send-login-verification-code', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, userId }),
      })

      if (!response.ok) {
        const errorText = await response.text()
        try {
          const errorData = JSON.parse(errorText)
          return { success: false, error: errorData.error || 'Failed to send verification code' }
        } catch {
          return { success: false, error: errorText || `Server error: ${response.status}` }
        }
      }

      const contentType = response.headers.get('content-type')
      if (!contentType || !contentType.includes('application/json')) {
        const text = await response.text()
        return { success: false, error: text || 'Invalid response from server' }
      }

      const data = await response.json()
      return data
    } catch (err: any) {
      console.error('Send login verification code error:', err)
      return { success: false, error: err.message || 'Failed to send verification code. Please try again.' }
    }
  }

  // --------------------------
  // VERIFY LOGIN CODE
  // --------------------------
  const verifyLoginCode = async (email: string, code: string) => {
    try {
      const response = await fetch('/api/auth/verify-login-code', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, code }),
      })

      if (!response.ok) {
        const errorText = await response.text()
        try {
          const errorData = JSON.parse(errorText)
          return { success: false, error: errorData.error || 'Invalid verification code' }
        } catch {
          return { success: false, error: errorText || `Server error: ${response.status}` }
        }
      }

      const contentType = response.headers.get('content-type')
      if (!contentType || !contentType.includes('application/json')) {
        const text = await response.text()
        return { success: false, error: text || 'Invalid response from server' }
      }

      const data = await response.json()
      return data
    } catch (err: any) {
      console.error('Verify login code error:', err)
      return { success: false, error: err.message || 'Failed to verify code. Please try again.' }
    }
  }

  // --------------------------
  // LOGIN USER
  // --------------------------
  const login = async (email: string, password: string, rememberMe: boolean = false, skipVerification: boolean = false) => {
    setIsLoading(true);

    try {
      const { data: authData, error } = await supabase.auth.signInWithPassword({
        email,
        password
      });

      if (error) return { success: false, error: error.message };

      const supabaseId = authData.user.id;

      const { data: profile } = await supabase
        .from("users")
        .select("*")
        .eq("supabase_id", supabaseId)
        .single();

      if (!profile) return { success: false, error: "Profile not found" };

      // If verification is required and not skipped, sign out and require verification
      if (!skipVerification) {
        // Sign out to prevent access until verification
        await supabase.auth.signOut()
        
        return { 
          success: true, 
          requiresVerification: true,
          userId: profile.user_id
        };
      }

      // Verification skipped or completed - set user and complete login
      setUser(profile as CustomUser);

      // Store remember me preference in localStorage
      if (rememberMe) {
        localStorage.setItem('buildmate-remember-me', 'true')
        const expirationDate = new Date()
        expirationDate.setDate(expirationDate.getDate() + 30)
        localStorage.setItem('buildmate-session-expires', expirationDate.toISOString())
        console.log('✅ Remember me enabled - session will persist for 30 days')
      } else {
        localStorage.setItem('buildmate-remember-me', 'false')
        localStorage.removeItem('buildmate-session-expires')
        console.log('✅ Remember me disabled - session will expire when browser closes')
      }

      return { success: true };

    } finally {
      setIsLoading(false);
    }
  };

  // --------------------------
  // LOGOUT
  // --------------------------
  const logout = async () => {
    setIsLoading(true);
    try {
      console.log('🔴 Logging out user...');
      await supabase.auth.signOut();
      setUser(null);
      // Clear remember me preferences
      localStorage.removeItem('buildmate-remember-me');
      localStorage.removeItem('buildmate-session-expires');
      console.log('✅ User logged out successfully');
    } catch (error) {
      console.error('Logout error:', error);
      // Still clear local state even if signOut fails
      setUser(null);
      localStorage.removeItem('buildmate-remember-me');
      localStorage.removeItem('buildmate-session-expires');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <AuthContext.Provider value={{ 
      user, 
      login, 
      sendLoginVerificationCode, 
      verifyLoginCode, 
      register, 
      sendVerificationCode, 
      verifyCode, 
      logout, 
      isLoading 
    }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) throw new Error("useAuth must be used within SupabaseAuthProvider");
  return context;
}