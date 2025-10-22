// Tests for duplicate detection system
import { DuplicateDetector, type BuildFingerprint } from '../duplicate-detector'
import { Component, ComponentCategory } from '../mock-data'

// Mock components for testing
const mockComponents: Record<ComponentCategory, Component | null> = {
  cpu: {
    id: 'cpu-1',
    name: 'Intel Core i7-12700K',
    category: 'cpu',
    brand: 'Intel',
    price: 350,
    image: '/cpu.jpg',
    specifications: { cores: 12, threads: 20, baseClock: 3.6 },
    compatibility: { socket: 'LGA1700' },
    rating: 4.5,
    reviews: 1200,
    performanceTags: ['gaming', 'workstation']
  },
  motherboard: {
    id: 'mobo-1',
    name: 'ASUS ROG Strix Z690-E',
    category: 'motherboard',
    brand: 'ASUS',
    price: 400,
    image: '/mobo.jpg',
    specifications: { socket: 'LGA1700', formFactor: 'ATX' },
    compatibility: { socket: 'LGA1700', formFactor: 'ATX' },
    rating: 4.3,
    reviews: 800,
    performanceTags: ['gaming']
  },
  memory: {
    id: 'ram-1',
    name: 'Corsair Vengeance LPX 32GB',
    category: 'memory',
    brand: 'Corsair',
    price: 150,
    image: '/ram.jpg',
    specifications: { capacity: 32, speed: 3200 },
    compatibility: { memoryType: 'DDR4' },
    rating: 4.2,
    reviews: 600,
    performanceTags: ['gaming']
  },
  storage: {
    id: 'ssd-1',
    name: 'Samsung 980 Pro 1TB',
    category: 'storage',
    brand: 'Samsung',
    price: 200,
    image: '/ssd.jpg',
    specifications: { capacity: 1000, type: 'NVMe' },
    compatibility: { m2Slots: 'PCIe 4.0' },
    rating: 4.7,
    reviews: 1500,
    performanceTags: ['gaming', 'workstation']
  },
  gpu: {
    id: 'gpu-1',
    name: 'NVIDIA RTX 4080',
    category: 'gpu',
    brand: 'NVIDIA',
    price: 1200,
    image: '/gpu.jpg',
    specifications: { vram: 16, memoryType: 'GDDR6X' },
    compatibility: { powerRequirement: 320 },
    rating: 4.6,
    reviews: 2000,
    performanceTags: ['gaming', 'workstation']
  },
  psu: {
    id: 'psu-1',
    name: 'Corsair RM850x',
    category: 'psu',
    brand: 'Corsair',
    price: 150,
    image: '/psu.jpg',
    specifications: { wattage: 850, efficiency: '80+ Gold' },
    compatibility: { powerRequirement: 850 },
    rating: 4.4,
    reviews: 900,
    performanceTags: ['gaming']
  },
  case: {
    id: 'case-1',
    name: 'Fractal Design Define 7',
    category: 'case',
    brand: 'Fractal Design',
    price: 180,
    image: '/case.jpg',
    specifications: { formFactor: 'ATX', fans: 2 },
    compatibility: { formFactor: 'ATX' },
    rating: 4.3,
    reviews: 400,
    performanceTags: ['gaming']
  },
  cooling: {
    id: 'cooling-1',
    name: 'Noctua NH-D15',
    category: 'cooling',
    brand: 'Noctua',
    price: 100,
    image: '/cooling.jpg',
    specifications: { type: 'Air', tdp: 250 },
    compatibility: { socket: 'LGA1700' },
    rating: 4.8,
    reviews: 700,
    performanceTags: ['gaming', 'workstation']
  }
}

describe('DuplicateDetector', () => {
  describe('generateFingerprint', () => {
    it('should generate a fingerprint for a complete build', () => {
      const fingerprint = DuplicateDetector.generateFingerprint(mockComponents)
      
      expect(fingerprint.totalPrice).toBe(2730) // Sum of all component prices
      expect(fingerprint.componentCount).toBe(8)
      expect(fingerprint.priceRange).toBe('high')
      expect(fingerprint.performanceCategory).toBe('enthusiast')
      expect(fingerprint.components.cpu).toBe('cpu-1')
      expect(fingerprint.components.motherboard).toBe('mobo-1')
    })

    it('should generate a fingerprint for a partial build', () => {
      const partialComponents = {
        ...mockComponents,
        gpu: null,
        cooling: null
      }
      
      const fingerprint = DuplicateDetector.generateFingerprint(partialComponents)
      
      expect(fingerprint.totalPrice).toBe(1430) // Sum without GPU and cooling
      expect(fingerprint.componentCount).toBe(6)
      expect(fingerprint.components.gpu).toBeNull()
      expect(fingerprint.components.cooling).toBeNull()
    })
  })

  describe('compareBuilds', () => {
    it('should detect exact duplicates', () => {
      const build1 = DuplicateDetector.generateFingerprint(mockComponents)
      const build2 = DuplicateDetector.generateFingerprint(mockComponents)
      
      const comparison = DuplicateDetector.compareBuilds(build1, build2)
      
      expect(comparison.isDuplicate).toBe(true)
      expect(comparison.similarityScore).toBe(1.0)
      expect(comparison.duplicateReasons).toContain('High component overlap (100%)')
    })

    it('should detect similar builds', () => {
      const build1 = DuplicateDetector.generateFingerprint(mockComponents)
      
      // Create a similar build with different GPU
      const similarComponents = {
        ...mockComponents,
        gpu: {
          ...mockComponents.gpu!,
          id: 'gpu-2',
          name: 'NVIDIA RTX 4070',
          price: 600
        }
      }
      const build2 = DuplicateDetector.generateFingerprint(similarComponents)
      
      const comparison = DuplicateDetector.compareBuilds(build1, build2)
      
      expect(comparison.similarityScore).toBeGreaterThan(0.8)
      expect(comparison.duplicateReasons.length).toBeGreaterThan(0)
    })

    it('should not detect different builds as duplicates', () => {
      const build1 = DuplicateDetector.generateFingerprint(mockComponents)
      
      // Create a completely different build
      const differentComponents = {
        cpu: null,
        motherboard: null,
        memory: null,
        storage: null,
        gpu: null,
        psu: null,
        case: null,
        cooling: null
      }
      const build2 = DuplicateDetector.generateFingerprint(differentComponents)
      
      const comparison = DuplicateDetector.compareBuilds(build1, build2)
      
      expect(comparison.isDuplicate).toBe(false)
      expect(comparison.similarityScore).toBeLessThan(0.5)
    })
  })

  describe('checkForDuplicates', () => {
    it('should find duplicates in a list of builds', () => {
      const currentBuild = DuplicateDetector.generateFingerprint(mockComponents)
      
      const existingBuilds = [
        DuplicateDetector.generateFingerprint(mockComponents), // Exact duplicate
        DuplicateDetector.generateFingerprint({
          ...mockComponents,
          gpu: { ...mockComponents.gpu!, id: 'gpu-2' }
        }) // Similar build
      ]
      
      const duplicates = DuplicateDetector.checkForDuplicates(currentBuild, existingBuilds)
      
      expect(duplicates.length).toBeGreaterThan(0)
      expect(duplicates[0].isDuplicate).toBe(true)
    })

    it('should return empty array when no duplicates found', () => {
      const currentBuild = DuplicateDetector.generateFingerprint(mockComponents)
      
      const existingBuilds = [
        DuplicateDetector.generateFingerprint({
          cpu: null,
          motherboard: null,
          memory: null,
          storage: null,
          gpu: null,
          psu: null,
          case: null,
          cooling: null
        })
      ]
      
      const duplicates = DuplicateDetector.checkForDuplicates(currentBuild, existingBuilds)
      
      expect(duplicates.length).toBe(0)
    })
  })

  describe('generateUniqueName', () => {
    it('should generate unique name when base name is unique', () => {
      const existingNames = ['Build 1', 'Build 2']
      const uniqueName = DuplicateDetector.generateUniqueName('My Build', existingNames)
      
      expect(uniqueName).toBe('My Build')
    })

    it('should generate unique name with counter when base name exists', () => {
      const existingNames = ['My Build', 'Build 2']
      const uniqueName = DuplicateDetector.generateUniqueName('My Build', existingNames)
      
      expect(uniqueName).toBe('My Build (1)')
    })

    it('should increment counter for multiple duplicates', () => {
      const existingNames = ['My Build', 'My Build (1)', 'My Build (2)']
      const uniqueName = DuplicateDetector.generateUniqueName('My Build', existingNames)
      
      expect(uniqueName).toBe('My Build (3)')
    })
  })

  describe('validateBuildForDuplicates', () => {
    it('should validate build with no duplicates', () => {
      const currentBuild = DuplicateDetector.generateFingerprint(mockComponents)
      const existingBuilds = [
        DuplicateDetector.generateFingerprint({
          cpu: null,
          motherboard: null,
          memory: null,
          storage: null,
          gpu: null,
          psu: null,
          case: null,
          cooling: null
        })
      ]
      
      const validation = DuplicateDetector.validateBuildForDuplicates(currentBuild, existingBuilds)
      
      expect(validation.isValid).toBe(true)
      expect(validation.warnings.length).toBe(0)
    })

    it('should invalidate build with exact duplicates', () => {
      const currentBuild = DuplicateDetector.generateFingerprint(mockComponents)
      const existingBuilds = [
        DuplicateDetector.generateFingerprint(mockComponents)
      ]
      
      const validation = DuplicateDetector.validateBuildForDuplicates(currentBuild, existingBuilds)
      
      expect(validation.isValid).toBe(false)
      expect(validation.warnings.length).toBeGreaterThan(0)
      expect(validation.warnings[0]).toContain('exact duplicate')
    })

    it('should warn about similar builds', () => {
      const currentBuild = DuplicateDetector.generateFingerprint(mockComponents)
      const similarBuild = DuplicateDetector.generateFingerprint({
        ...mockComponents,
        gpu: { ...mockComponents.gpu!, id: 'gpu-2' }
      })
      
      const validation = DuplicateDetector.validateBuildForDuplicates(currentBuild, [similarBuild])
      
      expect(validation.warnings.length).toBeGreaterThan(0)
      expect(validation.suggestions.length).toBeGreaterThan(0)
    })
  })
})
