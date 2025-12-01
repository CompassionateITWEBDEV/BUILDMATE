import type { Component, PerformanceCategory, PerformanceRequirements } from "./mock-data"

export function filterComponentsByPerformance(
  components: Component[],
  performanceCategory: PerformanceCategory,
  requirements: PerformanceRequirements
): Component[] {
  if (performanceCategory === "all") {
    return components
  }

  // First, try strict filtering
  let filtered = components.filter((component) => {
    return component.performanceTags.includes(performanceCategory) && 
           meetsPerformanceRequirements(component, requirements)
  })

  // For Office and Academic categories, if no results, use fallback
  if (filtered.length === 0 && (performanceCategory === "office" || performanceCategory === "academic")) {
    // Fallback 1: Try with matching performance tags only (more lenient)
    filtered = components.filter((component) => {
      return component.performanceTags.includes(performanceCategory)
    })

    // Fallback 2: If still no results, try with basic requirements only
    if (filtered.length === 0) {
      filtered = components.filter((component) => {
        return meetsBasicRequirements(component, requirements)
      })
    }

    // Fallback 3: If still no results, randomize and return subset (max 20)
    if (filtered.length === 0) {
      const shuffled = [...components].sort(() => Math.random() - 0.5)
      filtered = shuffled.slice(0, Math.min(20, shuffled.length))
    }
  }

  return filtered
}

function meetsPerformanceRequirements(component: Component, requirements: PerformanceRequirements): boolean {
  const specs = component.specifications

  // CPU requirements
  if (component.category === "cpu") {
    const cores = specs.cores as number
    if (requirements.minCpuCores && cores < requirements.minCpuCores) return false
    if (requirements.maxCpuCores && cores > requirements.maxCpuCores) return false
  }

  // Memory requirements
  if (component.category === "memory") {
    const capacity = parseInt(specs.capacity as string) || 0
    if (requirements.minMemoryGB && capacity < requirements.minMemoryGB) return false
    if (requirements.maxMemoryGB && capacity > requirements.maxMemoryGB) return false
  }

  // GPU requirements
  if (component.category === "gpu") {
    const memory = parseInt(specs.memory as string) || 0
    if (requirements.minGpuMemory && memory < requirements.minGpuMemory) return false
    if (requirements.maxGpuMemory && memory > requirements.maxGpuMemory) return false
  }

  // Storage requirements
  if (component.category === "storage") {
    const capacity = parseInt(specs.capacity as string) || 0
    if (requirements.minStorageGB && capacity < requirements.minStorageGB) return false
    if (requirements.maxStorageGB && capacity > requirements.maxStorageGB) return false
  }

  // PSU requirements
  if (component.category === "psu") {
    const wattage = parseInt(specs.wattage as string) || 0
    if (requirements.minPsuWattage && wattage < requirements.minPsuWattage) return false
    if (requirements.maxPsuWattage && wattage > requirements.maxPsuWattage) return false
  }

  // Price requirements
  if (requirements.minPrice && component.price < requirements.minPrice) return false
  if (requirements.maxPrice && component.price > requirements.maxPrice) return false

  // GPU requirement check
  if (requirements.requiresGpu === false && component.category === "gpu") {
    return false
  }

  return true
}

function meetsBasicRequirements(component: Component, requirements: PerformanceRequirements): boolean {
  const specs = component.specifications

  // Only check essential requirements, not strict ranges
  // CPU: just check if cores exist
  if (component.category === "cpu") {
    const cores = specs.cores as number
    if (!cores || cores < 2) return false // At least 2 cores
  }

  // Memory: just check if capacity exists
  if (component.category === "memory") {
    const capacity = parseInt(specs.capacity as string) || 0
    if (capacity < 4) return false // At least 4GB
  }

  // Storage: just check if capacity exists
  if (component.category === "storage") {
    const capacity = parseInt(specs.capacity as string) || 0
    if (capacity < 128) return false // At least 128GB
  }

  // PSU: just check if wattage exists
  if (component.category === "psu") {
    const wattage = parseInt(specs.wattage as string) || 0
    if (wattage < 300) return false // At least 300W
  }

  // Price: basic check
  if (requirements.maxPrice && component.price > requirements.maxPrice * 1.5) return false

  return true
}

export function getPerformanceCategoryDescription(category: PerformanceCategory): string {
  const descriptions = {
    gaming: "High-performance components for gaming and entertainment",
    office: "Efficient components for productivity and business tasks", 
    academic: "Balanced components for research, coding, and educational work",
    all: "Show all available components"
  }
  return descriptions[category]
}
