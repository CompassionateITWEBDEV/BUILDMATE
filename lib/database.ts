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
  }
}
