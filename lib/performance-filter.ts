import type { Component, PerformanceCategory, PerformanceRequirements } from "./mock-data"

export function filterComponentsByPerformance(
  components: Component[],
  performanceCategory: PerformanceCategory,
  requirements: PerformanceRequirements
): Component[] {
  if (performanceCategory === "all") {
    return components
  }

  return components.filter((component) => {
    return component.performanceTags.includes(performanceCategory) && 
           meetsPerformanceRequirements(component, requirements)
  })
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

export function getPerformanceCategoryDescription(category: PerformanceCategory): string {
  const descriptions = {
    gaming: "High-performance components for gaming and entertainment",
    office: "Efficient components for productivity and business tasks", 
    academic: "Balanced components for research, coding, and educational work",
    all: "Show all available components"
  }
  return descriptions[category]
}
