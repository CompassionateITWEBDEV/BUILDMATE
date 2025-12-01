import { supabase } from './supabase'
import type { Database } from './supabase'

// Type aliases for easier use
type User = Database['public']['Tables']['users']['Row']
type Build = Database['public']['Tables']['builds']['Row']
type Component = Database['public']['Tables']['components']['Row']
type ComponentCategory = Database['public']['Tables']['component_categories']['Row']
type BuildType = Database['public']['Tables']['build_types']['Row']
type Retailer = Database['public']['Tables']['retailers']['Row']
type BuildComponent = Database['public']['Tables']['build_components']['Row']

// User operations
export const userService = {
  async create(user: Database['public']['Tables']['users']['Insert']) {
    const { data, error } = await supabase
      .from('users')
      .insert(user)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async getByEmail(email: string) {
    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('email', email)
      .single()
    
    if (error) {
      // If no user found, return null instead of throwing error
      if (error.code === 'PGRST116') {
        return null
      }
      throw error
    }
    return data
  },

  async getById(userId: number) {
    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('user_id', userId)
      .single()
    
    if (error) {
      // If no user found, return null instead of throwing error
      if (error.code === 'PGRST116') {
        return null
      }
      throw error
    }
    return data
  },

  async update(userId: number, updates: Database['public']['Tables']['users']['Update']) {
    const { data, error } = await supabase
      .from('users')
      .update(updates)
      .eq('user_id', userId)
      .select()
      .single()
    
    if (error) throw error
    return data
  }
}

// Component operations
export const componentService = {
  async getAll() {
    const { data, error } = await supabase
      .from('components')
      .select(`
        *,
        component_categories(*),
        retailers(*)
      `)
      .limit(2000)  // Increase limit to fetch all components
    
    if (error) throw error
    return data
  },

  async getByCategory(categoryId: number) {
    const { data, error } = await supabase
      .from('components')
      .select(`
        *,
        component_categories(*),
        retailers(*)
      `)
      .eq('category_id', categoryId)
    
    if (error) throw error
    return data
  },

  async getById(componentId: number) {
    const { data, error } = await supabase
      .from('components')
      .select(`
        *,
        component_categories(*),
        retailers(*)
      `)
      .eq('component_id', componentId)
      .single()
    
    if (error) throw error
    return data
  },

  async create(component: Database['public']['Tables']['components']['Insert']) {
    const { data, error } = await supabase
      .from('components')
      .insert(component)
      .select(`
        *,
        component_categories(*),
        retailers(*)
      `)
      .single()
    
    if (error) throw error
    return data
  },

  async update(componentId: number, updates: Database['public']['Tables']['components']['Update']) {
    const { data, error } = await supabase
      .from('components')
      .update(updates)
      .eq('component_id', componentId)
      .select(`
        *,
        component_categories(*),
        retailers(*)
      `)
      .single()
    
    if (error) throw error
    return data
  },

  async delete(componentId: number) {
    const { error } = await supabase
      .from('components')
      .delete()
      .eq('component_id', componentId)
    
    if (error) throw error
  }
}

// Build operations
export const buildService = {
  async create(build: Database['public']['Tables']['builds']['Insert']) {
    const { data, error } = await supabase
      .from('builds')
      .insert(build)
      .select(`
        *,
        build_types(*),
        users(*)
      `)
      .single()
    
    if (error) throw error
    return data
  },

  async createWithDuplicateCheck(
    build: Database['public']['Tables']['builds']['Insert'],
    components: Record<string, any>
  ) {
    // First check for duplicates
    const existingBuilds = await this.getByUserId(build.user_id)
    
    // Convert existing builds to fingerprints for comparison
    const existingFingerprints = existingBuilds.map(existingBuild => ({
      build_id: existingBuild.build_id,
      build_name: existingBuild.build_name,
      components: components, // This would need to be fetched from build_components
      totalPrice: 0, // This would need to be calculated
      componentCount: 0, // This would need to be calculated
      priceRange: 'budget' as const,
      performanceCategory: 'budget'
    }))

    // For now, we'll implement basic duplicate checking
    const duplicateCheck = await this.checkForDuplicateBuild(build, existingFingerprints)
    
    if (duplicateCheck.isDuplicate) {
      throw new Error(`Duplicate build detected: ${duplicateCheck.reason}`)
    }

    // Create the build if no duplicates found
    return this.create(build)
  },

  async checkForDuplicateBuild(
    newBuild: Database['public']['Tables']['builds']['Insert'],
    existingBuilds: any[]
  ) {
    // Check for exact name duplicates
    const nameDuplicate = existingBuilds.find(
      build => build.build_name.toLowerCase() === newBuild.build_name.toLowerCase()
    )

    if (nameDuplicate) {
      return {
        isDuplicate: true,
        reason: `Build name "${newBuild.build_name}" already exists`,
        duplicateBuildId: nameDuplicate.build_id
      }
    }

    // Additional duplicate checks can be added here
    // For example, checking component combinations, price ranges, etc.

    return {
      isDuplicate: false,
      reason: null,
      duplicateBuildId: null
    }
  },

  async getAll() {
    const { data, error } = await supabase
      .from('builds')
      .select(`
        *,
        build_types(*),
        users(*)
      `)
      .order('date_created', { ascending: false })
    
    if (error) throw error
    return data
  },

  async getByUserId(userId: number) {
    const { data, error } = await supabase
      .from('builds')
      .select(`
        *,
        build_types(*),
        users(*)
      `)
      .eq('user_id', userId)
      .order('date_created', { ascending: false })
    
    if (error) throw error
    return data
  },

  async getById(buildId: number) {
    const { data, error } = await supabase
      .from('builds')
      .select(`
        *,
        build_types(*),
        users(*)
      `)
      .eq('build_id', buildId)
      .single()
    
    if (error) throw error
    return data
  },

  async update(buildId: number, updates: Database['public']['Tables']['builds']['Update']) {
    const { data, error } = await supabase
      .from('builds')
      .update(updates)
      .eq('build_id', buildId)
      .select(`
        *,
        build_types(*),
        users(*)
      `)
      .single()
    
    if (error) throw error
    return data
  },

  async delete(buildId: number) {
    const { error } = await supabase
      .from('builds')
      .delete()
      .eq('build_id', buildId)
    
    if (error) throw error
  },

  async getStatistics() {
    // Get total builders count
    const { count: buildersCount, error: buildersError } = await supabase
      .from('users')
      .select('*', { count: 'exact', head: true })
    
    if (buildersError) throw buildersError

    // Get total builds count
    const { count: buildsCount, error: buildsError } = await supabase
      .from('builds')
      .select('*', { count: 'exact', head: true })
    
    if (buildsError) throw buildsError

    const { count: commentsCount, error: commentsError } = await supabase
      .from('build_comments')
      .select('*', { count: 'exact', head: true })
    
    if (commentsError) throw commentsError

    const { count: likesCount, error: likesError } = await supabase
      .from('build_likes')
      .select('*', { count: 'exact', head: true })
    
    if (likesError) throw commentsError


    return {
      totalBuilders: buildersCount || 0,
      totalBuilds: buildsCount || 0,
      totalLikes: likesCount || 0, // Using comments as proxy for now
      totalComments: commentsCount || 0
    }
  }
}

// Build Component operations
export const buildComponentService = {
  async addComponent(buildId: number, componentId: number) {
    const { data, error } = await supabase
      .from('build_components')
      .insert({
        build_id: buildId,
        component_id: componentId
      })
      .select(`
        *,
        components(
          *,
          component_categories(*),
          retailers(*)
        )
      `)
      .single()
    
    if (error) throw error
    return data
  },

  async removeComponent(buildId: number, componentId: number) {
    const { error } = await supabase
      .from('build_components')
      .delete()
      .eq('build_id', buildId)
      .eq('component_id', componentId)
    
    if (error) throw error
  },

  async getBuildComponents(buildId: number) {
    const { data, error } = await supabase
      .from('build_components')
      .select(`
        *,
        components(
          *,
          component_categories(*),
          retailers(*)
        )
      `)
      .eq('build_id', buildId)
    
    if (error) throw error
    return data
  },


  async updateBuildComponents(buildId: number, componentIds: number[]) {
    // First, remove all existing components
    await supabase
      .from('build_components')
      .delete()
      .eq('build_id', buildId)
    
    // Then add the new components
    if (componentIds.length > 0) {
      const buildComponents = componentIds.map(componentId => ({
        build_id: buildId,
        component_id: componentId
      }))
      
      const { data, error } = await supabase
        .from('build_components')
        .insert(buildComponents)
        .select(`
          *,
          components(
            *,
            component_categories(*),
            retailers(*)
          )
        `)
      
      if (error) throw error
      return data
    }
    
    return []
  }
}

// Category operations
export const categoryService = {
  async getAll() {
    const { data, error } = await supabase
      .from('component_categories')
      .select('*')
      .order('category_name')
    
    if (error) throw error
    return data
  },

  async getById(categoryId: number) {
    const { data, error } = await supabase
      .from('component_categories')
      .select('*')
      .eq('category_id', categoryId)
      .single()
    
    if (error) throw error
    return data
  }
}

// Build Type operations
export const buildTypeService = {
  async getAll() {
    const { data, error } = await supabase
      .from('build_types')
      .select('*')
      .order('type_name')
    
    if (error) throw error
    return data
  },

  async getById(buildTypeId: number) {
    const { data, error } = await supabase
      .from('build_types')
      .select('*')
      .eq('build_type_id', buildTypeId)
      .single()
    
    if (error) throw error
    return data
  }
}

// Retailer operations
export const retailerService = {
  async getAll() {
    const { data, error } = await supabase
      .from('retailers')
      .select('*')
      .order('retailer_name')
    
    if (error) throw error
    return data
  },

  async getById(retailerId: number) {
    const { data, error } = await supabase
      .from('retailers')
      .select('*')
      .eq('retailer_id', retailerId)
      .single()
    
    if (error) throw error
    return data
  },

  async create(retailer: Database['public']['Tables']['retailers']['Insert']) {
    const { data, error } = await supabase
      .from('retailers')
      .insert(retailer)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async update(retailerId: number, updates: Database['public']['Tables']['retailers']['Update']) {
    const { data, error } = await supabase
      .from('retailers')
      .update(updates)
      .eq('retailer_id', retailerId)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async delete(retailerId: number) {
    const { error } = await supabase
      .from('retailers')
      .delete()
      .eq('retailer_id', retailerId)
    
    if (error) throw error
  }
}

// Build Guide operations
export const buildGuideService = {
  async getAll() {
    const { data, error } = await supabase
      .from('build_guides')
      .select(`
        *,
        builds(*)
      `)
      .order('created_at', { ascending: false })
    
    if (error) throw error
    return data
  },

  async getByBuildId(buildId: number) {
    const { data, error } = await supabase
      .from('build_guides')
      .select(`
        *,
        builds(*)
      `)
      .eq('build_id', buildId)
      .order('created_at', { ascending: false })
    
    if (error) throw error
    return data
  },

  async getById(buildGuideId: number) {
    const { data, error } = await supabase
      .from('build_guides')
      .select(`
        *,
        builds(*)
      `)
      .eq('build_guide_id', buildGuideId)
      .single()
    
    if (error) throw error
    return data
  },

  async create(buildGuide: Database['public']['Tables']['build_guides']['Insert']) {
    const { data, error } = await supabase
      .from('build_guides')
      .insert(buildGuide)
      .select(`
        *,
        builds(*)
      `)
      .single()
    
    if (error) throw error
    return data
  },

  async update(buildGuideId: number, updates: Database['public']['Tables']['build_guides']['Update']) {
    const { data, error } = await supabase
      .from('build_guides')
      .update({
        ...updates,
        updated_at: new Date().toISOString()
      })
      .eq('build_guide_id', buildGuideId)
      .select(`
        *,
        builds(*)
      `)
      .single()
    
    if (error) throw error
    return data
  },

  async delete(buildGuideId: number) {
    const { error } = await supabase
      .from('build_guides')
      .delete()
      .eq('build_guide_id', buildGuideId)
    
    if (error) throw error
  }
}

// Price History operations
export const priceHistoryService = {
  async getByComponentId(componentId: number) {
    const { data, error } = await supabase
      .from('price_history')
      .select('*')
      .eq('component_id', componentId)
      .order('changed_at', { ascending: false })
      .limit(50)
    
    if (error) throw error
    return data
  },

  async getAll() {
    const { data, error } = await supabase
      .from('price_history')
      .select(`
        *,
        components(*)
      `)
      .order('changed_at', { ascending: false })
      .limit(100)
    
    if (error) throw error
    return data
  }
}

// User History operations
export const userHistoryService = {
  async getBuildHistory(buildId: number) {
    const { data, error } = await supabase
      .from('build_history')
      .select(`
        *,
        builds(*)
      `)
      .eq('build_id', buildId)
      .order('changed_at', { ascending: false })
    
    if (error) throw error
    return data
  },

  async createHistoryEntry(history: Database['public']['Tables']['build_history']['Insert']) {
    const { data, error } = await supabase
      .from('build_history')
      .insert(history)
      .select(`
        *,
        builds(*)
      `)
      .single()
    
    if (error) throw error
    return data
  },

  async getUserBuildHistory(userId: number) {
    const { data, error } = await supabase
      .from('build_history')
      .select(`
        *,
        builds!inner(*)
      `)
      .eq('builds.user_id', userId)
      .order('changed_at', { ascending: false })
    
    if (error) throw error
    return data
  }
}

// Admin operations
export const adminService = {
  async getAllUsers() {
    const { data, error } = await supabase
      .from('users')
      .select('*')
      .order('created_at', { ascending: false })
    
    if (error) throw error
    return data
  },

  async getAllBuilds() {
    const { data, error } = await supabase
      .from('builds')
      .select(`
        *,
        build_types(*),
        users(*)
      `)
      .order('date_created', { ascending: false })
    
    if (error) throw error
    return data
  },

  async getAllComponents() {
    const { data, error } = await supabase
      .from('components')
      .select(`
        *,
        component_categories(*),
        retailers(*)
      `)
      .order('component_name')
    
    if (error) throw error
    return data
  },

  async getAllPurchases() {
    // Get all builds with user info - these represent purchases
    const { data, error } = await supabase
      .from('builds')
      .select(`
        *,
        build_types(type_name),
        users(user_name, email, user_id)
      `)
      .order('date_created', { ascending: false })
    
    if (error) throw error
    return data
  },

  async deleteUser(userId: number) {
    const { error } = await supabase
      .from('users')
      .delete()
      .eq('user_id', userId)
    
    if (error) throw error
  },

  async deleteBuild(buildId: number) {
    const { error } = await supabase
      .from('builds')
      .delete()
      .eq('build_id', buildId)
    
    if (error) throw error
  },

  async deleteComponent(componentId: number) {
    const { error } = await supabase
      .from('components')
      .delete()
      .eq('component_id', componentId)
    
    if (error) throw error
  },

  async updateUserRole(userId: number, userType: 'admin' | 'user' | 'moderator') {
    const { data, error } = await supabase
      .from('users')
      .update({ user_type: userType })
      .eq('user_id', userId)
      .select()
      .single()
    
    if (error) throw error
    return data
  }
}



export type { 
  User, 
  Build, 
  Component, 
  ComponentCategory, 
  BuildType, 
  Retailer, 
  BuildComponent 
}
