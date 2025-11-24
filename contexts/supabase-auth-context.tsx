"use client";

import { createContext, useContext, useState, useEffect, ReactNode } from "react";
import { supabase } from "@/lib/supabase";
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
  login: (email: string, password: string, rememberMe?: boolean) => Promise<{ success: boolean; error?: string }>;
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
      const { data: { session } } = await supabase.auth.getSession();

      if (session) {
        const supabaseUser = session.user;
        const { data: profile } = await supabase
          .from("users")
          .select("*")
          .eq("supabase_id", supabaseUser.id)
          .single();

        if (profile) setUser(profile as CustomUser);
      }

      setIsLoading(false);
    };

    init();

    const { data: listener } = supabase.auth.onAuthStateChange((_event, session) => {
      if (session?.user) {
        supabase
          .from("users")
          .select("*")
          .eq("supabase_id", session.user.id)
          .single()
          .then(({ data }) => setUser(data as CustomUser));
      } else {
        setUser(null);
      }
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
  // LOGIN USER
  // --------------------------
  const login = async (email: string, password: string, rememberMe: boolean = false) => {
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

      setUser(profile as CustomUser);

      // Store remember me preference in localStorage
      if (rememberMe) {
        localStorage.setItem('buildmate-remember-me', 'true')
        // Store session expiration preference (30 days for remember me)
        const expirationDate = new Date()
        expirationDate.setDate(expirationDate.getDate() + 30)
        localStorage.setItem('buildmate-session-expires', expirationDate.toISOString())
        console.log('✅ Remember me enabled - session will persist for 30 days')
      } else {
        localStorage.setItem('buildmate-remember-me', 'false')
        // For non-remember me, we'll check session on next page load
        // Supabase handles session storage automatically
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
    await supabase.auth.signOut();
    setUser(null);
    // Clear remember me preferences
    localStorage.removeItem('buildmate-remember-me')
    localStorage.removeItem('buildmate-session-expires')
    setIsLoading(false);
  };

  return (
    <AuthContext.Provider value={{ user, login, register, sendVerificationCode, verifyCode, logout, isLoading }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) throw new Error("useAuth must be used within SupabaseAuthProvider");
  return context;
}
