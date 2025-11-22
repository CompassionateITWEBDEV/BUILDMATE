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
export const supabase = createClient(
  supabaseUrl || 'https://placeholder.supabase.co',
  supabaseAnonKey || 'placeholder-key'
)

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
          component_price: number | null
          compatibility_information: string | null
          category_id: number
          retailer_id: number | null
        }
        Insert: {
          component_id?: number
          component_name: string
          component_price?: number | null
          compatibility_information?: string | null
          category_id: number
          retailer_id?: number | null
        }
        Update: {
          component_id?: number
          component_name?: string
          component_price?: number | null
          compatibility_information?: string | null
          category_id?: number
          retailer_id?: number | null
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
    }
  }
}

