import { supabase } from './supabase'
import type { Database } from './supabase'

/**
 * User History Service
 * Manages build history tracking and user activity logs
 */
export const userHistoryService = {
  /**
   * Get all history entries for a specific build
   */
  async getBuildHistory(buildId: number) {
    const { data, error } = await supabase
      .from('build_history')
      .select(`
        *,
        builds(
          build_id,
          build_name,
          user_id,
          users(user_name, email)
        )
      `)
      .eq('build_id', buildId)
      .order('changed_at', { ascending: false })
    
    if (error) throw error
    return data
  },

  /**
   * Create a new history entry when a build is modified
   */
  async createHistoryEntry(
    buildId: number,
    changeDescription: string
  ) {
    const { data, error } = await supabase
      .from('build_history')
      .insert({
        build_id: buildId,
        change_description: changeDescription,
        changed_at: new Date().toISOString()
      })
      .select(`
        *,
        builds(*)
      `)
      .single()
    
    if (error) throw error
    return data
  },

  /**
   * Get all build history for a specific user
   */
  async getUserBuildHistory(userId: number) {
    const { data, error } = await supabase
      .from('build_history')
      .select(`
        *,
        builds!inner(
          build_id,
          build_name,
          user_id,
          date_created
        )
      `)
      .eq('builds.user_id', userId)
      .order('changed_at', { ascending: false })
    
    if (error) throw error
    return data
  },

  /**
   * Get recent activity across all builds (for admin dashboard)
   */
  async getRecentActivity(limit: number = 50) {
    const { data, error } = await supabase
      .from('build_history')
      .select(`
        *,
        builds(
          build_id,
          build_name,
          user_id,
          users(user_name, email)
        )
      `)
      .order('changed_at', { ascending: false })
      .limit(limit)
    
    if (error) throw error
    return data
  },

  /**
   * Get history statistics for a user
   */
  async getUserHistoryStats(userId: number) {
    const history = await this.getUserBuildHistory(userId)
    
    return {
      totalChanges: history.length,
      buildsModified: new Set(history.map(h => h.build_id)).size,
      recentActivity: history.slice(0, 10)
    }
  }
}

