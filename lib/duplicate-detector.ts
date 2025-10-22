// Duplicate build detection and prevention system
import { Component, ComponentCategory } from './mock-data'

export interface BuildComparison {
  isDuplicate: boolean
  similarityScore: number
  duplicateReasons: string[]
  suggestedActions: string[]
  existingBuildId?: string
  existingBuildName?: string
}

export interface BuildFingerprint {
  components: Record<ComponentCategory, string | null>
  totalPrice: number
  componentCount: number
  priceRange: 'budget' | 'mid' | 'high'
  performanceCategory: string
}

export class DuplicateDetector {
  private static readonly SIMILARITY_THRESHOLD = 0.85 // 85% similarity threshold
  private static readonly EXACT_DUPLICATE_THRESHOLD = 0.95 // 95% for exact duplicates
  private static readonly PRICE_TOLERANCE = 0.05 // 5% price tolerance

  /**
   * Generate a fingerprint for a build to enable comparison
   */
  static generateFingerprint(components: Record<ComponentCategory, Component | null>): BuildFingerprint {
    const totalPrice = Object.values(components)
      .filter(Boolean)
      .reduce((sum, component) => sum + component!.price, 0)

    const componentCount = Object.values(components).filter(Boolean).length

    const priceRange = totalPrice < 1000 ? 'budget' : totalPrice < 2000 ? 'mid' : 'high'

    // Create component signature
    const componentSignature: Record<ComponentCategory, string | null> = {
      cpu: components.cpu?.id || null,
      motherboard: components.motherboard?.id || null,
      memory: components.memory?.id || null,
      storage: components.storage?.id || null,
      gpu: components.gpu?.id || null,
      psu: components.psu?.id || null,
      case: components.case?.id || null,
      cooling: components.cooling?.id || null,
    }

    return {
      components: componentSignature,
      totalPrice,
      componentCount,
      priceRange,
      performanceCategory: this.determinePerformanceCategory(components)
    }
  }

  /**
   * Compare two builds and determine if they are duplicates
   */
  static compareBuilds(
    newBuild: BuildFingerprint,
    existingBuild: BuildFingerprint
  ): BuildComparison {
    const similarityScore = this.calculateSimilarity(newBuild, existingBuild)
    const isDuplicate = similarityScore >= this.SIMILARITY_THRESHOLD
    const isExactDuplicate = similarityScore >= this.EXACT_DUPLICATE_THRESHOLD

    const duplicateReasons: string[] = []
    const suggestedActions: string[] = []

    // Check component overlap
    const componentOverlap = this.calculateComponentOverlap(newBuild.components, existingBuild.components)
    if (componentOverlap >= 0.8) {
      duplicateReasons.push(`High component overlap (${Math.round(componentOverlap * 100)}%)`)
    }

    // Check price similarity
    const priceDifference = Math.abs(newBuild.totalPrice - existingBuild.totalPrice)
    const priceSimilarity = 1 - (priceDifference / Math.max(newBuild.totalPrice, existingBuild.totalPrice))
    if (priceSimilarity >= 0.9) {
      duplicateReasons.push(`Very similar price (${Math.round(priceSimilarity * 100)}% match)`)
    }

    // Check component count
    if (newBuild.componentCount === existingBuild.componentCount) {
      duplicateReasons.push('Same number of components')
    }

    // Check price range
    if (newBuild.priceRange === existingBuild.priceRange) {
      duplicateReasons.push(`Same price range (${newBuild.priceRange})`)
    }

    // Check performance category
    if (newBuild.performanceCategory === existingBuild.performanceCategory) {
      duplicateReasons.push(`Same performance category (${newBuild.performanceCategory})`)
    }

    // Generate suggestions based on similarity level
    if (isExactDuplicate) {
      suggestedActions.push('This appears to be an exact duplicate. Consider updating the existing build instead.')
      suggestedActions.push('You may want to add a unique description or modify some components.')
    } else if (isDuplicate) {
      suggestedActions.push('This build is very similar to an existing one. Consider adding unique components.')
      suggestedActions.push('You could modify the build name to better differentiate it.')
      suggestedActions.push('Consider adding a unique description or use case.')
    } else if (similarityScore >= 0.6) {
      suggestedActions.push('This build has some similarities. Consider reviewing the differences.')
      suggestedActions.push('You might want to add more unique components to differentiate it.')
    }

    return {
      isDuplicate,
      similarityScore,
      duplicateReasons,
      suggestedActions,
      existingBuildId: existingBuild as any, // This would be the actual build ID in real implementation
      existingBuildName: `Similar Build (${Math.round(similarityScore * 100)}% match)`
    }
  }

  /**
   * Check for duplicates against a list of existing builds
   */
  static checkForDuplicates(
    newBuild: BuildFingerprint,
    existingBuilds: BuildFingerprint[]
  ): BuildComparison[] {
    const comparisons: BuildComparison[] = []

    for (const existingBuild of existingBuilds) {
      const comparison = this.compareBuilds(newBuild, existingBuild)
      if (comparison.isDuplicate || comparison.similarityScore >= 0.6) {
        comparisons.push(comparison)
      }
    }

    // Sort by similarity score (highest first)
    return comparisons.sort((a, b) => b.similarityScore - a.similarityScore)
  }

  /**
   * Calculate similarity score between two builds
   */
  private static calculateSimilarity(build1: BuildFingerprint, build2: BuildFingerprint): number {
    let score = 0
    let weight = 0

    // Component similarity (40% weight)
    const componentSimilarity = this.calculateComponentOverlap(build1.components, build2.components)
    score += componentSimilarity * 0.4
    weight += 0.4

    // Price similarity (25% weight)
    const priceDifference = Math.abs(build1.totalPrice - build2.totalPrice)
    const maxPrice = Math.max(build1.totalPrice, build2.totalPrice)
    const priceSimilarity = maxPrice > 0 ? 1 - (priceDifference / maxPrice) : 1
    score += priceSimilarity * 0.25
    weight += 0.25

    // Component count similarity (15% weight)
    const countDifference = Math.abs(build1.componentCount - build2.componentCount)
    const maxCount = Math.max(build1.componentCount, build2.componentCount)
    const countSimilarity = maxCount > 0 ? 1 - (countDifference / maxCount) : 1
    score += countSimilarity * 0.15
    weight += 0.15

    // Price range similarity (10% weight)
    const rangeSimilarity = build1.priceRange === build2.priceRange ? 1 : 0
    score += rangeSimilarity * 0.1
    weight += 0.1

    // Performance category similarity (10% weight)
    const categorySimilarity = build1.performanceCategory === build2.performanceCategory ? 1 : 0
    score += categorySimilarity * 0.1
    weight += 0.1

    return weight > 0 ? score / weight : 0
  }

  /**
   * Calculate component overlap between two builds
   */
  private static calculateComponentOverlap(
    components1: Record<ComponentCategory, string | null>,
    components2: Record<ComponentCategory, string | null>
  ): number {
    const categories = Object.keys(components1) as ComponentCategory[]
    let matches = 0
    let total = 0

    for (const category of categories) {
      if (components1[category] || components2[category]) {
        total++
        if (components1[category] === components2[category]) {
          matches++
        }
      }
    }

    return total > 0 ? matches / total : 0
  }

  /**
   * Determine performance category based on components
   */
  private static determinePerformanceCategory(components: Record<ComponentCategory, Component | null>): string {
    const totalPrice = Object.values(components)
      .filter(Boolean)
      .reduce((sum, component) => sum + component!.price, 0)

    if (totalPrice < 800) return 'budget'
    if (totalPrice < 1500) return 'mid-range'
    if (totalPrice < 3000) return 'high-end'
    return 'enthusiast'
  }

  /**
   * Generate a unique build name suggestion
   */
  static generateUniqueName(baseName: string, existingNames: string[]): string {
    let counter = 1
    let uniqueName = baseName

    while (existingNames.includes(uniqueName)) {
      uniqueName = `${baseName} (${counter})`
      counter++
    }

    return uniqueName
  }

  /**
   * Validate build before saving to prevent duplicates
   */
  static validateBuildForDuplicates(
    newBuild: BuildFingerprint,
    existingBuilds: BuildFingerprint[]
  ): { isValid: boolean; warnings: string[]; suggestions: string[] } {
    const duplicates = this.checkForDuplicates(newBuild, existingBuilds)
    const exactDuplicates = duplicates.filter(d => d.similarityScore >= this.EXACT_DUPLICATE_THRESHOLD)
    const similarBuilds = duplicates.filter(d => d.similarityScore >= 0.6 && d.similarityScore < this.EXACT_DUPLICATE_THRESHOLD)

    const warnings: string[] = []
    const suggestions: string[] = []

    if (exactDuplicates.length > 0) {
      warnings.push(`Found ${exactDuplicates.length} exact duplicate(s)`)
      suggestions.push('Consider updating the existing build instead of creating a new one')
      suggestions.push('Add unique components or modify the build description')
    } else if (similarBuilds.length > 0) {
      warnings.push(`Found ${similarBuilds.length} similar build(s)`)
      suggestions.push('Review the similar builds to ensure this is truly unique')
      suggestions.push('Consider adding more distinctive components')
    }

    return {
      isValid: exactDuplicates.length === 0,
      warnings,
      suggestions
    }
  }
}
