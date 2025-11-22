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
}

interface AuthContextType {
  user: CustomUser | null;
  login: (email: string, password: string) => Promise<{ success: boolean; error?: string }>;
  register: (username: string, email: string, password: string) => Promise<{ success: boolean; error?: string }>;
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
  // REGISTER USER
  // --------------------------
  const register = async (username: string, email: string, password: string) => {
    try {
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
        message: "A verification email has been sent. Please verify your email before logging in."
      };

    } catch (err: any) {
      return { success: false, error: err.message };
    }
  };


  // --------------------------
  // LOGIN USER
  // --------------------------
  const login = async (email: string, password: string) => {
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
    setIsLoading(false);
  };

  return (
    <AuthContext.Provider value={{ user, login, register, logout, isLoading }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) throw new Error("useAuth must be used within SupabaseAuthProvider");
  return context;
}
