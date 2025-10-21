import { filterComponentsByPerformance } from '../performance-filter'
import { mockComponents } from '../mock-data'

describe('Performance Filter', () => {
  test('should filter gaming components correctly', () => {
    const gamingComponents = filterComponentsByPerformance(
      mockComponents,
      'gaming',
      {
        minCpuCores: 6,
        minMemoryGB: 16,
        minGpuMemory: 8,
        minStorageGB: 500,
        minPsuWattage: 650,
        requiresGpu: true,
        minPrice: 800,
      }
    )

    // Should include high-end components
    expect(gamingComponents.some(c => c.id === 'cpu-1')).toBe(true) // AMD Ryzen 7 7800X3D
    expect(gamingComponents.some(c => c.id === 'gpu-1')).toBe(true) // RTX 4080 SUPER
    expect(gamingComponents.some(c => c.id === 'psu-1')).toBe(true) // 850W PSU

    // Should exclude low-end components
    expect(gamingComponents.some(c => c.id === 'cpu-3')).toBe(false) // AMD Ryzen 5 5600G
    expect(gamingComponents.some(c => c.id === 'psu-2')).toBe(false) // 500W PSU
  })

  test('should filter office components correctly', () => {
    const officeComponents = filterComponentsByPerformance(
      mockComponents,
      'office',
      {
        minCpuCores: 4,
        maxCpuCores: 8,
        minMemoryGB: 8,
        maxMemoryGB: 32,
        maxGpuMemory: 4,
        minStorageGB: 250,
        maxStorageGB: 1000,
        minPsuWattage: 400,
        maxPsuWattage: 650,
        requiresGpu: false,
        maxPrice: 1200,
      }
    )

    // Should include mid-range components
    expect(officeComponents.some(c => c.id === 'cpu-3')).toBe(true) // AMD Ryzen 5 5600G
    expect(officeComponents.some(c => c.id === 'psu-2')).toBe(true) // 500W PSU
    expect(officeComponents.some(c => c.id === 'storage-2')).toBe(true) // 500GB SATA SSD

    // Should exclude high-end gaming components
    expect(officeComponents.some(c => c.id === 'gpu-1')).toBe(false) // RTX 4080 SUPER
    expect(officeComponents.some(c => c.id === 'psu-1')).toBe(false) // 850W PSU
  })

  test('should return all components when performance category is "all"', () => {
    const allComponents = filterComponentsByPerformance(
      mockComponents,
      'all',
      {}
    )

    expect(allComponents).toHaveLength(mockComponents.length)
  })

  test('should filter by price range correctly', () => {
    const budgetComponents = filterComponentsByPerformance(
      mockComponents,
      'office',
      {
        maxPrice: 200,
      }
    )

    // Should only include components under $200
    budgetComponents.forEach(component => {
      expect(component.price).toBeLessThanOrEqual(200)
    })
  })
})
