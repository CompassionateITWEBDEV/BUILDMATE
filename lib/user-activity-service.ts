import { supabase } from './supabase'

export interface UserActivity {
  activity_id: number
  user_id: number
  activity_type: 'login' | 'logout' | 'build_created' | 'build_updated' | 'build_deleted' | 'component_viewed' | 'guide_viewed' | 'profile_updated'
  activity_description: string
  ip_address?: string
  user_agent?: string
  created_at: string
  users?: {
    user_name: string
    email: string
  }
}

export const userActivityService = {
  async logActivity(
    userId: number,
    activityType: UserActivity['activity_type'],
    description: string,
    metadata?: { ipAddress?: string; userAgent?: string }
  ) {
    const { data, error } = await supabase
      .from('user_activity')
      .insert({
        user_id: userId,
        activity_type: activityType,
        activity_description: description,
        ip_address: metadata?.ipAddress,
        user_agent: metadata?.userAgent,
      })
      .select()
      .single()

    if (error) {
      console.error('Error logging activity:', error)
      throw error
    }
    return data
  },

  async getUserActivity(userId: number, limit = 50) {
    const { data, error } = await supabase
      .from('user_activity')
      .select(`
        *,
        users(user_name, email)
      `)
      .eq('user_id', userId)
      .order('created_at', { ascending: false })
      .limit(limit)

    if (error) throw error
    return data as UserActivity[]
  },

  async getAllActivity(limit = 100) {
    const { data, error } = await supabase
      .from('user_activity')
      .select(`
        *,
        users(user_name, email, user_type)
      `)
      .order('created_at', { ascending: false })
      .limit(limit)

    if (error) throw error
    return data as UserActivity[]
  },

  async getActivityByType(activityType: UserActivity['activity_type'], limit = 50) {
    const { data, error } = await supabase
      .from('user_activity')
      .select(`
        *,
        users(user_name, email)
      `)
      .eq('activity_type', activityType)
      .order('created_at', { ascending: false })
      .limit(limit)

    if (error) throw error
    return data as UserActivity[]
  },

  async getRecentActivity(hours = 24, limit = 50) {
    const hoursAgo = new Date()
    hoursAgo.setHours(hoursAgo.getHours() - hours)

    const { data, error } = await supabase
      .from('user_activity')
      .select(`
        *,
        users(user_name, email, user_type)
      `)
      .gte('created_at', hoursAgo.toISOString())
      .order('created_at', { ascending: false })
      .limit(limit)

    if (error) throw error
    return data as UserActivity[]
  }
}

