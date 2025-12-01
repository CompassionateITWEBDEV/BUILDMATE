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
    'graphics card': 'gpu',
    'video card': 'gpu',
    'graphics': 'gpu',
    'memory': 'memory',
    'ram': 'memory',
    'storage': 'storage',
    'psu': 'psu',
    'power supply': 'psu',
    'case': 'case',
    'cooling': 'cooling',
    'cpu cooler': 'cooling',
    'motherboard': 'motherboard',
    'mb': 'motherboard'
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


  // Extract retailer information
  const retailer = dbComponent.retailers ? {
    id: dbComponent.retailers.retailer_id,
    name: dbComponent.retailers.retailer_name || 'Central Juan Solution',
    address: dbComponent.retailers.retailer_address || null,
    phone: dbComponent.retailers.retailer_phone || null,
    contactPerson: dbComponent.retailers.retailer_contact_person || null,
    email: dbComponent.retailers.email || null,
    website: dbComponent.retailers.website || null,
  } : undefined

  return {
    id: `component-${dbComponent.component_id}`,
    name: dbComponent.component_name,
    brand: brand,
    price: Number(dbComponent.component_price) || 0,
    category: appCategory,
    image: dbComponent.component_image || `/placeholder.svg`,
    rating: 4.5,
    reviews: Math.floor(Math.random() * 1000) + 100,
    specifications: {
      'Price': `₱${dbComponent.component_price || 0}`,
      'Category': dbComponent.component_categories?.category_name || 'Unknown',
      'Retailer': dbComponent.retailers?.retailer_name || 'Central Juan Solution',
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
    performanceTags: performanceTags,
    availabilityStatus: dbComponent.availability_status || 'in_stock',
    retailer: retailer
  }
}

// Get all components from Supabase
export async function getSupabaseComponents(): Promise<Component[]> {
  try {
    const dbComponents = await componentService.getAll()
    console.log(`Fetched ${dbComponents.length} components from Supabase`)
    
    // Debug: Log category distribution
    const categoryCounts: Record<string, number> = {}
    dbComponents.forEach((comp: any) => {
      const catName = comp.component_categories?.category_name || 'Unknown'
      categoryCounts[catName] = (categoryCounts[catName] || 0) + 1
    })
    console.log('Category distribution:', categoryCounts)
    
    const converted = dbComponents.map(convertDbComponentToAppComponent)
    
    // Debug: Log converted category distribution
    const convertedCategoryCounts: Record<string, number> = {}
    converted.forEach((comp) => {
      convertedCategoryCounts[comp.category] = (convertedCategoryCounts[comp.category] || 0) + 1
    })
    console.log('Converted category distribution:', convertedCategoryCounts)
    
    // LIMIT CPU components to 40 for performance
    const cpuComponents = converted.filter(c => c.category === 'cpu')
    const gpuComponents = converted.filter(c => c.category === 'gpu')
    const memoryComponents = converted.filter(c => c.category === 'memory')
    const otherComponents = converted.filter(c => !['cpu', 'gpu', 'memory'].includes(c.category))
    
    let limitedCpuComponents = cpuComponents
    if (cpuComponents.length > 40) {
      // Keep top 40 CPUs sorted by price (descending)
      limitedCpuComponents = cpuComponents
        .sort((a, b) => b.price - a.price)
        .slice(0, 40)
      console.log(`Limited CPUs from ${cpuComponents.length} to ${limitedCpuComponents.length} components`)
    }
    
    // LIMIT GPU/Graphics Card components to 40 for performance
    let limitedGpuComponents = gpuComponents
    if (gpuComponents.length > 40) {
      // Keep top 40 GPUs sorted by price (descending)
      limitedGpuComponents = gpuComponents
        .sort((a, b) => b.price - a.price)
        .slice(0, 40)
      console.log(`Limited GPUs from ${gpuComponents.length} to ${limitedGpuComponents.length} components`)
    }
    
    // LIMIT RAM/Memory components: min 12, max 40
    let limitedMemoryComponents = memoryComponents
    if (memoryComponents.length < 12) {
      console.warn(`⚠️ Only ${memoryComponents.length} RAM/Memory components found. Expected at least 12.`)
    } else if (memoryComponents.length > 40) {
      // Keep top 40 RAM modules sorted by price (descending)
      limitedMemoryComponents = memoryComponents
        .sort((a, b) => b.price - a.price)
        .slice(0, 40)
      console.log(`Limited RAM from ${memoryComponents.length} to ${limitedMemoryComponents.length} components`)
    } else {
      console.log(`✅ RAM/Memory components: ${memoryComponents.length}`)
    }
    
    // ENSURE at least 12 GPU/Graphics Card components
    if (gpuComponents.length < 12) {
      console.warn(`⚠️ Only ${gpuComponents.length} GPU/Graphics Card components found. Expected at least 12.`)
    } else {
      console.log(`✅ GPU/Graphics Card components: ${gpuComponents.length}`)
    }
    
    return [...limitedCpuComponents, ...limitedGpuComponents, ...limitedMemoryComponents, ...otherComponents]
  } catch (error: any) {
    // Check if error has meaningful content
    const hasMessage = error?.message && typeof error.message === 'string' && error.message.trim().length > 0;
    const hasCode = error?.code && typeof error.code === 'string' && error.code.trim().length > 0;
    const hasStack = error?.stack && typeof error.stack === 'string' && error.stack.trim().length > 0;
    const hasName = error?.name && typeof error.name === 'string' && error.name.trim().length > 0;
    
    // Check if error object is empty (no meaningful properties)
    const isEmpty = !hasMessage && !hasCode && !hasStack && !hasName && 
                   (!error || (typeof error === 'object' && Object.keys(error).length === 0));
    
    // Only log if error has meaningful content
    if (!isEmpty && (hasMessage || hasCode || hasStack || hasName)) {
      console.error('Error fetching components from Supabase:', error)
    }
    // Silently return empty array for empty errors
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