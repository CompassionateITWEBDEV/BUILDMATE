import { componentService, categoryService } from './database'
import type { Component, ComponentCategory, PerformanceCategory } from './mock-data'

// Convert database component to app component format
function convertDbComponentToAppComponent(dbComponent: any): Component {
  return {
    id: `component-${dbComponent.component_id}`,
    name: dbComponent.component_name,
    brand: dbComponent.retailers?.retailer_name || 'Unknown',
    price: dbComponent.component_price || 0,
    category: dbComponent.component_categories?.category_name?.toLowerCase() as ComponentCategory || 'cpu',
    image: `/placeholder.svg`, // You can add image URLs to your database
    rating: 4.5, // You can add ratings to your database
    reviews: Math.floor(Math.random() * 1000) + 100, // You can add review counts to your database
    specifications: {
      'Compatibility': dbComponent.compatibility_information || 'Standard compatibility',
      'Price': `$${dbComponent.component_price || 0}`,
      'Category': dbComponent.component_categories?.category_name || 'Unknown',
      'Retailer': dbComponent.retailers?.retailer_name || 'Unknown'
    },
    compatibility: {
      socket: 'Standard',
      formFactor: 'Standard',
      memoryType: 'DDR4',
      powerRequirement: 100,
      dimensions: {
        length: 100,
        width: 100,
        height: 50
      }
    },
    performanceTags: ['all'] as PerformanceCategory[]
  }
}

// Get all components from Supabase
export async function getSupabaseComponents(): Promise<Component[]> {
  try {
    const dbComponents = await componentService.getAll()
    return dbComponents.map(convertDbComponentToAppComponent)
  } catch (error) {
    console.error('Error fetching components from Supabase:', error)
    return []
  }
}

// Get components by category from Supabase
export async function getSupabaseComponentsByCategory(category: ComponentCategory): Promise<Component[]> {
  try {
    // First get the category ID
    const categories = await categoryService.getAll()
    const categoryId = categories.find(c => c.category_name.toLowerCase() === category)?.category_id
    
    if (!categoryId) {
      return []
    }

    const dbComponents = await componentService.getByCategory(categoryId)
    return dbComponents.map(convertDbComponentToAppComponent)
  } catch (error) {
    console.error('Error fetching components by category from Supabase:', error)
    return []
  }
}

// Get component by ID from Supabase
export async function getSupabaseComponentById(componentId: string): Promise<Component | null> {
  try {
    const id = parseInt(componentId.replace('component-', ''))
    const dbComponent = await componentService.getById(id)
    return convertDbComponentToAppComponent(dbComponent)
  } catch (error) {
    console.error('Error fetching component by ID from Supabase:', error)
    return null
  }
}

// Create a new component in Supabase
export async function createSupabaseComponent(component: Omit<Component, 'id'>): Promise<Component | null> {
  try {
    // Get category ID
    const categories = await categoryService.getAll()
    const categoryId = categories.find(c => c.category_name.toLowerCase() === component.category)?.category_id
    
    if (!categoryId) {
      throw new Error('Category not found')
    }

    const dbComponent = await componentService.create({
      component_name: component.name,
      component_price: component.price,
      compatibility_information: component.specifications?.Compatibility || '',
      category_id: categoryId,
      // You might want to add retailer_id if you have retailers set up
    })

    return convertDbComponentToAppComponent(dbComponent)
  } catch (error) {
    console.error('Error creating component in Supabase:', error)
    return null
  }
}

// Update a component in Supabase
export async function updateSupabaseComponent(componentId: string, updates: Partial<Component>): Promise<Component | null> {
  try {
    const id = parseInt(componentId.replace('component-', ''))
    
    const updateData: any = {}
    if (updates.name) updateData.component_name = updates.name
    if (updates.price) updateData.component_price = updates.price
    if (updates.specifications?.Compatibility) updateData.compatibility_information = updates.specifications.Compatibility

    const dbComponent = await componentService.update(id, updateData)
    return convertDbComponentToAppComponent(dbComponent)
  } catch (error) {
    console.error('Error updating component in Supabase:', error)
    return null
  }
}

// Delete a component from Supabase
export async function deleteSupabaseComponent(componentId: string): Promise<boolean> {
  try {
    const id = parseInt(componentId.replace('component-', ''))
    await componentService.delete(id)
    return true
  } catch (error) {
    console.error('Error deleting component from Supabase:', error)
    return false
  }
}
