import { componentService, categoryService } from './database'
import type { Component, ComponentCategory, PerformanceCategory } from './mock-data'

// Convert database component to app component format
function convertDbComponentToAppComponent(dbComponent: any): Component {
  // Parse compatibility information from JSON
  let compatInfo: any = {}
  try {
    const compatStr = dbComponent.compatibility_information
    if (typeof compatStr === 'string') {
      compatInfo = JSON.parse(compatStr)
    } else if (compatStr && typeof compatStr === 'object') {
      compatInfo = compatStr
    }
  } catch (e) {
    console.warn('Could not parse compatibility information:', e)
  }

  // Map database category names to app category names
  const dbCategoryName = dbComponent.component_categories?.category_name?.toLowerCase() || ''
  const categoryMap: Record<string, ComponentCategory> = {
    'cpu': 'cpu',
    'gpu': 'gpu',
    'memory': 'memory',
    'ram': 'memory',
    'storage': 'storage',
    'psu': 'psu',
    'power supply': 'psu',
    'case': 'case',
    'cooling': 'cooling',
    'cpu cooler': 'cooling'
  }
  const appCategory = categoryMap[dbCategoryName] || (dbCategoryName as ComponentCategory) || 'cpu'

  // Extract brand from component name (usually first part before dash)
  const brand = dbComponent.component_name?.split(' - ')[0]?.trim() || 
                dbComponent.retailers?.retailer_name || 
                'Unknown'

  // Build compatibility object from parsed data
  let memoryTypeValue = compatInfo.memoryType || compatInfo.ram_type
  if (appCategory === 'memory' && !memoryTypeValue) {
    memoryTypeValue = compatInfo.type
  }
  
  const compatibility: Component['compatibility'] = {
    socket: compatInfo.socket || 'Standard',
    formFactor: compatInfo.formFactor || (appCategory === 'case' ? compatInfo.type : 'Standard'),
    memoryType: Array.isArray(memoryTypeValue) 
      ? memoryTypeValue[0] 
      : (memoryTypeValue || (appCategory === 'memory' ? 'DDR4' : undefined)),
    powerRequirement: compatInfo.powerRequirement || compatInfo.wattage || compatInfo.tdp || (appCategory === 'psu' ? 500 : 100),
    dimensions: compatInfo.dimensions || {
      length: compatInfo.length || (appCategory === 'gpu' ? 220 : 100),
      width: compatInfo.width || 100,
      height: compatInfo.height || (appCategory === 'gpu' ? 120 : 50)
    },
    memorySupport: compatInfo.memorySupport || compatInfo.ram_type || memoryTypeValue,
    m2Slots: compatInfo.m2Slots?.toString(),
    sataPorts: compatInfo.sataPorts?.toString()
  }

// Map Supabase component_purpose → performanceTags
let performanceTags: PerformanceCategory[] = ['all']

if (dbComponent.component_purpose) {
  const mapPerf = {
    'academic': 'academic',
    'gaming': 'gaming',
    'office': 'office'
  } as Record<string, PerformanceCategory>

  // Normalize the Capitalized string to lowercase for mapping
  const raw = dbComponent.component_purpose.toLowerCase().trim()

  if (mapPerf[raw]) {
    performanceTags = ['all', mapPerf[raw]]
  }
}


  return {
    id: `component-${dbComponent.component_id}`,
    name: dbComponent.component_name,
    brand: brand,
    price: Number(dbComponent.component_price) || 0,
    category: appCategory,
    image: `/placeholder.svg`,
    rating: 4.5,
    reviews: Math.floor(Math.random() * 1000) + 100,
    specifications: {
      'Compatibility': JSON.stringify(compatInfo, null, 2) || 'Standard compatibility',
      'Price': `$${dbComponent.component_price || 0}`,
      'Category': dbComponent.component_categories?.category_name || 'Unknown',
      'Retailer': dbComponent.retailers?.retailer_name || 'Unknown',
      ...(appCategory === 'memory' && compatInfo.type && { 'type': compatInfo.type }),
      ...(compatInfo.tdp && { 'TDP': `${compatInfo.tdp}W` }),
      ...(compatInfo.wattage && { 'Wattage': `${compatInfo.wattage}W` }),
      ...(compatInfo.vram && { 'VRAM': compatInfo.vram }),
      ...(compatInfo.capacity && { 'Capacity': compatInfo.capacity }),
      ...(compatInfo.speed && { 'Speed': compatInfo.speed }),
      ...(compatInfo.interface && { 'Interface': compatInfo.interface }),
      ...(appCategory === 'case' && compatInfo.maxGpuLength && { 'maxGpuLength': compatInfo.maxGpuLength.toString() }),
      ...(appCategory === 'case' && compatInfo.maxCoolerHeight && { 'maxCoolerHeight': compatInfo.maxCoolerHeight.toString() }),
      ...(appCategory === 'cooling' && compatInfo.supportedSockets && { 
        'supportedSockets': JSON.stringify(Array.isArray(compatInfo.supportedSockets) ? compatInfo.supportedSockets : [compatInfo.supportedSockets])
      }),
      ...(appCategory === 'cooling' && compatInfo.supported_sockets && { 
        'supportedSockets': JSON.stringify(Array.isArray(compatInfo.supported_sockets) ? compatInfo.supported_sockets : [compatInfo.supported_sockets])
      })
    },
    compatibility,
    performanceTags: performanceTags
  }
}

// Get all components from Supabase
export async function getSupabaseComponents(): Promise<Component[]> {
  try {
    const dbComponents = await componentService.getAll()
    console.log(`Fetched ${dbComponents.length} components from Supabase`, dbComponents)
    return dbComponents.map(convertDbComponentToAppComponent)
  } catch (error) {
    console.error('Error fetching components from Supabase:', error)
    return []
  }
}

// Get components by category from Supabase
export async function getSupabaseComponentsByCategory(category: ComponentCategory): Promise<Component[]> {
  try {
    const categories = await categoryService.getAll()
    const categoryId = categories.find(c => c.category_name.toLowerCase() === category)?.category_id
    if (!categoryId) return []

    const dbComponents = await componentService.getByCategory(categoryId)
    console.log(`Fetched ${dbComponents.length} components for category "${category}"`, dbComponents)
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
    const categories = await categoryService.getAll()
    const categoryId = categories.find(c => c.category_name.toLowerCase() === component.category)?.category_id
    if (!categoryId) throw new Error('Category not found')

    const dbComponent = await componentService.create({
      component_name: component.name,
      component_price: component.price,
      compatibility_information: component.specifications?.Compatibility || '',
      category_id: categoryId,
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
