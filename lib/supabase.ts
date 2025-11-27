import { createClient } from '@supabase/supabase-js'
import { UUID } from 'crypto'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://sldiqjjgddegffbzjqma.supabase.co'
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNsZGlxampnZGRlZ2ZmYnpqcW1hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc1MjA1MDMsImV4cCI6MjA3MzA5NjUwM30.wir0lfBKEo0NimhsPjLmJvXexFjyQTmyHzGsE40xDmA'

// Check if environment variables are configured
if (!supabaseUrl || !supabaseAnonKey) {
  console.error('Missing Supabase environment variables!')
  console.error('Please create a .env.local file with:')
  console.error('NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url')
  console.error('NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key')
  console.error('Current values:', { supabaseUrl, supabaseAnonKey: supabaseAnonKey ? 'present' : 'missing' })
} else {
  const usingEnvVars = process.env.NEXT_PUBLIC_SUPABASE_URL && process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  console.log('✅ Supabase configuration loaded successfully!')
  console.log('Using environment variables:', usingEnvVars ? 'Yes' : 'No (using fallback values)')
  console.log('URL:', supabaseUrl)
  console.log('Anon Key:', supabaseAnonKey ? 'present' : 'missing')
}

// Create Supabase client with fallback for missing environment variables
// Configure for better session persistence
export const supabase = createClient(
  supabaseUrl || 'https://placeholder.supabase.co',
  supabaseAnonKey || 'placeholder-key',
  {
    auth: {
      persistSession: true,
      autoRefreshToken: true,
      detectSessionInUrl: true,
      storage: typeof window !== 'undefined' ? window.localStorage : undefined,
      storageKey: 'buildmate-supabase-auth-token',
      // Refresh token before it expires (refresh 5 minutes before expiration)
      refreshTokenRotationEnabled: true,
    },
    global: {
      headers: {
        'x-client-info': 'buildmate-web',
      },
    },
  }
)

// Helper function to handle JWT expiration errors and ensure valid session
export async function ensureValidSession() {
  try {
    // First, try to get current session
    const { data: { session }, error } = await supabase.auth.getSession();
    
    if (error) {
      console.warn('⚠️ Error getting session:', error.message);
      // Try to refresh if it's an expiration error
      if (error.message?.includes('JWT') || error.message?.includes('expired')) {
        console.log('🔄 Attempting to refresh expired session...');
        const { data: { session: refreshedSession }, error: refreshError } = await supabase.auth.refreshSession();
        if (!refreshError && refreshedSession) {
          console.log('✅ Session refreshed successfully');
          return refreshedSession;
        }
        console.error('❌ Failed to refresh session:', refreshError);
      }
      return null;
    }
    
    if (!session) {
      console.warn('⚠️ No active session found');
      return null;
    }
    
    // Check if session is expired
    const expiresAt = session.expires_at;
    if (expiresAt && expiresAt * 1000 < Date.now()) {
      console.log('⚠️ Session expired, refreshing...');
      const { data: { session: newSession }, error: refreshError } = await supabase.auth.refreshSession();
      if (refreshError || !newSession) {
        console.error('❌ Failed to refresh expired session:', refreshError);
        return null;
      }
      console.log('✅ Session refreshed successfully');
      return newSession;
    }
    
    // Session is valid
    return session;
  } catch (error) {
    console.error('❌ Error ensuring valid session:', error);
    return null;
  }
}

// Legacy function name for backward compatibility
export async function handleExpiredToken() {
  return ensureValidSession();
}

// Database Types based on your schema
export interface Database {
  public: {
    Tables: {
      users: {
        Row: {
          user_id: number
          user_name: string
          email: string
          password: string
          user_type: 'admin' | 'user' | 'moderator'
          created_at: string
          avatar_url: string
          supabase_id: UUID
          bio: string | null
          location: string | null
          website: string | null
        }
        Insert: {
          user_id?: number
          user_name: string
          email: string
          password: string
          user_type?: 'admin' | 'user' | 'moderator'
          created_at?: string
          avatar_url?: string
          supabase_i?: UUID
          bio?: string | null
          location?: string | null
          website?: string | null
        }
        Update: {
          user_id?: number
          user_name?: string
          email?: string
          password?: string
          user_type?: 'admin' | 'user' | 'moderator'
          created_at?: string
          avatar_url?: string
          supabase_id?: UUID
          bio?: string | null
          location?: string | null
          website?: string | null          
        }
      }
      build_types: {
        Row: {
          build_type_id: number
          type_name: string
          description: string | null
        }
        Insert: {
          build_type_id?: number
          type_name: string
          description?: string | null
        }
        Update: {
          build_type_id?: number
          type_name?: string
          description?: string | null
        }
      }
      builds: {
        Row: {
          build_id: number
          user_id: number
          build_type_id: number
          build_name: string
          date_created: string
          total_price: number
          likes: number
          comments: number
          views: number
          description: string
        }
        Insert: {
          build_id?: number
          user_id: number
          build_type_id: number
          build_name: string
          date_created?: string
          total_price: number
          likes: number
          comments: number
          views: number
          description?: string
        }
        Update: {
          build_id?: number
          user_id?: number
          build_type_id?: number
          build_name?: string
          date_created?: string
          total_price: number
          likes?: number
          comments?: number
          views?: number
          description?: string
        }
      }
      component_categories: {
        Row: {
          category_id: number
          category_name: string
          description: string | null
        }
        Insert: {
          category_id?: number
          category_name: string
          description?: string | null
        }
        Update: {
          category_id?: number
          category_name?: string
          description?: string | null
        }
      }
      components: {
        Row: {
          component_id: number
          component_name: string
          component_brand: string | null
          component_price: number | null
          component_description: string | null
          component_image: string | null
          compatibility_information: string | null
          category_id: number
          retailer_id: number | null
          availability_status: 'in_stock' | 'out_of_stock' | 'low_stock' | 'discontinued' | null
        }
        Insert: {
          component_id?: number
          component_name: string
          component_brand?: string | null
          component_price?: number | null
          component_description?: string | null
          component_image?: string | null
          compatibility_information?: string | null
          category_id: number
          retailer_id?: number | null
          availability_status?: 'in_stock' | 'out_of_stock' | 'low_stock' | 'discontinued' | null
        }
        Update: {
          component_id?: number
          component_name?: string
          component_brand?: string | null
          component_price?: number | null
          component_description?: string | null
          component_image?: string | null
          compatibility_information?: string | null
          category_id?: number
          retailer_id?: number | null
          availability_status?: 'in_stock' | 'out_of_stock' | 'low_stock' | 'discontinued' | null
        }
      }
      price_history: {
        Row: {
          price_history_id: number
          component_id: number
          old_price: number | null
          new_price: number
          changed_at: string
          changed_by: string | null
        }
        Insert: {
          price_history_id?: number
          component_id: number
          old_price?: number | null
          new_price: number
          changed_at?: string
          changed_by?: string | null
        }
        Update: {
          price_history_id?: number
          component_id?: number
          old_price?: number | null
          new_price?: number
          changed_at?: string
          changed_by?: string | null
        }
      }
      retailers: {
        Row: {
          retailer_id: number
          retailer_name: string
          email: string | null
          website: string | null
          retailer_address: string | null
          retailer_phone: string | null
          retailer_contact_person: string | null
        }
        Insert: {
          retailer_id?: number
          retailer_name: string
          email?: string | null
          website?: string | null
          retailer_address?: string | null
          retailer_phone?: string | null
          retailer_contact_person?: string | null
        }
        Update: {
          retailer_id?: number
          retailer_name?: string
          email?: string | null
          website?: string | null
          retailer_address?: string | null
          retailer_phone?: string | null
          retailer_contact_person?: string | null
        }
      }
      build_components: {
        Row: {
          build_component_id: number
          build_id: number
          component_id: number
        }
        Insert: {
          build_component_id?: number
          build_id: number
          component_id: number
        }
        Update: {
          build_component_id?: number
          build_id?: number
          component_id?: number
        }
      }
      user_activity: {
        Row: {
          activity_id: number
          user_id: number
          activity_type: 'login' | 'logout' | 'build_created' | 'build_updated' | 'build_deleted' | 'component_viewed' | 'guide_viewed' | 'profile_updated'
          activity_description: string
          ip_address: string | null
          user_agent: string | null
          created_at: string
        }
        Insert: {
          activity_id?: number
          user_id: number
          activity_type: 'login' | 'logout' | 'build_created' | 'build_updated' | 'build_deleted' | 'component_viewed' | 'guide_viewed' | 'profile_updated'
          activity_description: string
          ip_address?: string | null
          user_agent?: string | null
          created_at?: string
        }
        Update: {
          activity_id?: number
          user_id?: number
          activity_type?: 'login' | 'logout' | 'build_created' | 'build_updated' | 'build_deleted' | 'component_viewed' | 'guide_viewed' | 'profile_updated'
          activity_description?: string
          ip_address?: string | null
          user_agent?: string | null
          created_at?: string
        }
      }
      build_history: {
        Row: {
          bhistory_id: number
          build_id: number
          change_description: string | null
          changed_at: string
        }
        Insert: {
          bhistory_id?: number
          build_id: number
          change_description?: string | null
          changed_at?: string
        }
        Update: {
          bhistory_id?: number
          build_id?: number
          change_description?: string | null
          changed_at?: string
        }
      }
      build_guides: {
        Row: {
          build_guide_id: number
          build_id: number
          build_guide_name: string
          guide_steps: string
          build_guide_thumbnail: string | null
          description: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          build_guide_id?: number
          build_id: number
          build_guide_name: string
          guide_steps: string
          build_guide_thumbnail?: string | null
          description?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          build_guide_id?: number
          build_id?: number
          build_guide_name?: string
          guide_steps?: string
          build_guide_thumbnail?: string | null
          description?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      build_comments: {
        Row: {
          comment_id: number
          build_id: number
          user_id: number
          content: string
          likes: number
          created_at: string
          updated_at: string
        }
        Insert: {
          comment_id?: number
          build_id: number
          user_id: number
          content: string
          likes?: number
          created_at?: string
          updated_at?: string
        }
        Update: {
          comment_id?: number
          build_id?: number
          user_id?: number
          content?: string
          likes?: number
          created_at?: string
          updated_at?: string
        }
      }
      build_views: {
        Row: {
          view_id: number
          build_id: number
          user_id: number
          created_at: string
        }
        Insert: {
          view_id?: number
          build_id: number
          user_id: number
          created_at?: string
        }
        Update: {
          view_id?: number
          build_id?: number
          user_id?: number
          created_at?: string
        }
      }
      build_likes: {
        Row: {
          build_likes_id: number
          user_id: number
          build_id: number
          created_at: string
        }
        Insert: {
          build_likes_id?: number
          user_id: number
          build_id: number
          created_at?: string
        }
        Update: {
          build_likes_id?: number
          user_id?: number
          build_id?: number
          created_at?: string
        }
      }
    }
  }
}

