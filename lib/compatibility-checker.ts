import type { Component, ComponentCategory } from "./mock-data"

export interface CompatibilityIssue {
  type: "error" | "warning" | "info"
  category: ComponentCategory
  message: string
  affectedComponents: ComponentCategory[]
  suggestion?: string
}

export interface CompatibilityResult {
  isCompatible: boolean
  issues: CompatibilityIssue[]
  score: number // 0-100 compatibility score
  powerRequirement: number
  recommendations: string[]
}

export class CompatibilityChecker {
  private components: Record<ComponentCategory, Component | null>

  constructor(components: Record<ComponentCategory, Component | null>) {
    this.components = components
  }

  // Main compatibility checking method using CSP approach
  checkCompatibility(): CompatibilityResult {
    const issues: CompatibilityIssue[] = []
    const recommendations: string[] = []

    // Check CPU-Motherboard compatibility
    this.checkCpuMotherboardCompatibility(issues)

    // Check Memory compatibility
    this.checkMemoryCompatibility(issues)

    // Check Power Supply compatibility
    this.checkPowerSupplyCompatibility(issues, recommendations)

    // Check GPU-Case compatibility
    this.checkGpuCaseCompatibility(issues)

    // Check Cooling compatibility
    this.checkCoolingCompatibility(issues)

    // Check Storage compatibility
    this.checkStorageCompatibility(issues)

    // Calculate compatibility score
    const score = this.calculateCompatibilityScore(issues)

    // Calculate total power requirement
    const powerRequirement = this.calculatePowerRequirement()

    return {
      isCompatible: issues.filter((issue) => issue.type === "error").length === 0,
      issues,
      score,
      powerRequirement,
      recommendations,
    }
  }

  // Helper methods to parse compatibility information from JSON
  private getMemoryTypeFromCompatibility(component: Component): string | undefined {
    try {
      const compatStr = component.specifications.Compatibility as string
      if (typeof compatStr === 'string') {
        const compat = JSON.parse(compatStr)
        return compat.type || compat.memoryType || compat.ram_type
      }
    } catch (e) {
      // Try to extract from compatibility object directly
      return component.compatibility.memoryType
    }
    return undefined
  }

  private getWattageFromCompatibility(component: Component): number | undefined {
    try {
      const compatStr = component.specifications.Compatibility as string
      if (typeof compatStr === 'string') {
        const compat = JSON.parse(compatStr)
        return compat.wattage || compat.powerRequirement
      }
    } catch (e) {
      // Already checked compatibility.powerRequirement in the main method
    }
    return undefined
  }

  private getDimensionFromCompatibility(component: Component, dimension: 'length' | 'width' | 'height'): number | undefined {
    try {
      const compatStr = component.specifications.Compatibility as string
      if (typeof compatStr === 'string') {
        const compat = JSON.parse(compatStr)
        if (compat.dimensions && compat.dimensions[dimension]) {
          return compat.dimensions[dimension]
        }
        return compat[dimension]
      }
    } catch (e) {
      // Already checked compatibility.dimensions in the main method
    }
    return undefined
  }

  private getCaseMaxGpuLength(caseComponent: Component): number | undefined {
    // Try specifications first (set during component conversion)
    const fromSpecs = Number.parseInt(caseComponent.specifications.maxGpuLength as string)
    if (fromSpecs) return fromSpecs
    
    // Try parsing from Compatibility JSON
    try {
      const compatStr = caseComponent.specifications.Compatibility as string
      if (typeof compatStr === 'string') {
        const compat = JSON.parse(compatStr)
        return compat.maxGpuLength || compat.dimensions?.maxGpuLength
      }
    } catch (e) {
      // Ignore parse errors
    }
    return undefined
  }

  private getCaseMaxGpuHeight(caseComponent: Component): number | undefined {
    // Try specifications first (set during component conversion)
    const fromSpecs = Number.parseInt(caseComponent.specifications.maxCoolerHeight as string)
    if (fromSpecs) return fromSpecs
    
    // Try parsing from Compatibility JSON
    try {
      const compatStr = caseComponent.specifications.Compatibility as string
      if (typeof compatStr === 'string') {
        const compat = JSON.parse(compatStr)
        return compat.maxCoolerHeight || compat.dimensions?.maxCoolerHeight
      }
    } catch (e) {
      // Ignore parse errors
    }
    return undefined
  }

  private checkCpuMotherboardCompatibility(issues: CompatibilityIssue[]) {
    const cpu = this.components.cpu
    const motherboard = this.components.motherboard

    if (!cpu || !motherboard) return

    // Socket compatibility
    if (cpu.compatibility.socket !== motherboard.compatibility.socket) {
      issues.push({
        type: "error",
        category: "cpu",
        message: `CPU socket ${cpu.compatibility.socket} is not compatible with motherboard socket ${motherboard.compatibility.socket}`,
        affectedComponents: ["cpu", "motherboard"],
        suggestion: `Choose a CPU with ${motherboard.compatibility.socket} socket or a motherboard with ${cpu.compatibility.socket} socket`,
      })
    }

    // Memory type compatibility
    if (cpu.specifications.memorySupport && motherboard.compatibility.memoryType) {
      const cpuMemoryType = cpu.specifications.memorySupport
      const mbMemoryType = motherboard.compatibility.memoryType

      if (cpuMemoryType !== mbMemoryType) {
        issues.push({
          type: "error",
          category: "memory",
          message: `CPU supports ${cpuMemoryType} but motherboard supports ${mbMemoryType}`,
          affectedComponents: ["cpu", "motherboard", "memory"],
          suggestion: "Ensure all components support the same memory type",
        })
      }
    }
  }

  private checkMemoryCompatibility(issues: CompatibilityIssue[]) {
    const memory = this.components.memory
    const motherboard = this.components.motherboard

    if (!memory || !motherboard) return

    // Get memory type from compatibility or specifications
    const memoryType = memory.compatibility.memoryType || 
                      (memory.specifications.type as string) ||
                      this.getMemoryTypeFromCompatibility(memory)
    
    // Get motherboard memory type
    const mbMemoryType = motherboard.compatibility.memoryType || 
                        (motherboard.specifications.memoryType as string) ||
                        this.getMemoryTypeFromCompatibility(motherboard)

    // Memory type compatibility
    if (memoryType && mbMemoryType && memoryType !== mbMemoryType) {
      // Check if memory type is in a list (e.g., ["DDR4", "DDR5"])
      const mbSupports = Array.isArray(mbMemoryType) ? mbMemoryType : [mbMemoryType]
      if (!mbSupports.includes(memoryType)) {
        issues.push({
          type: "error",
          category: "memory",
          message: `Memory type ${memoryType || 'undefined'} is not supported by motherboard (supports ${Array.isArray(mbMemoryType) ? mbMemoryType.join('/') : mbMemoryType})`,
          affectedComponents: ["memory", "motherboard"],
          suggestion: `Choose ${Array.isArray(mbMemoryType) ? mbMemoryType.join(' or ') : mbMemoryType} memory modules`,
        })
      }
    }

    // Memory capacity check
    const memoryCapacity = Number.parseInt(memory.specifications.capacity) || 0
    const maxMemory = Number.parseInt(motherboard.specifications.maxMemory) || 0

    if (memoryCapacity > maxMemory) {
      issues.push({
        type: "warning",
        category: "memory",
        message: `Memory capacity (${memory.specifications.capacity}) exceeds motherboard maximum (${motherboard.specifications.maxMemory})`,
        affectedComponents: ["memory", "motherboard"],
        suggestion: "Consider reducing memory capacity or choosing a different motherboard",
      })
    }
  }

  private checkPowerSupplyCompatibility(issues: CompatibilityIssue[], recommendations: string[]) {
    const psu = this.components.psu
    const totalPowerDraw = this.calculatePowerRequirement()

    if (!psu) {
      if (totalPowerDraw > 0) {
        issues.push({
          type: "warning",
          category: "psu",
          message: "No power supply selected",
          affectedComponents: ["psu"],
          suggestion: `Select a power supply with at least ${Math.ceil(totalPowerDraw * 1.2)}W capacity`,
        })
      }
      return
    }

    // Get PSU wattage from multiple sources
    let psuWattage = 0
    
    // Try compatibility.powerRequirement first (set during component conversion)
    if (psu.compatibility.powerRequirement) {
      psuWattage = psu.compatibility.powerRequirement
    }
    
    // Try specifications fields
    if (psuWattage === 0) {
      // Try different specification fields
      psuWattage = Number.parseInt(psu.specifications.Wattage as string) ||
                  Number.parseInt(psu.specifications.wattage as string) ||
                  Number.parseInt(psu.specifications['wattage'] as string) ||
                  0
    }
    
    // Try parsing from compatibility JSON
    if (psuWattage === 0) {
      psuWattage = this.getWattageFromCompatibility(psu) || 0
    }
    
    const recommendedWattage = Math.ceil(totalPowerDraw * 1.2) // 20% headroom

    if (psuWattage === 0) {
      // Only show warning if power requirement is significant
      if (totalPowerDraw > 0) {
        issues.push({
          type: "warning",
          category: "psu",
          message: "Power supply wattage information not available",
          affectedComponents: ["psu"],
          suggestion: `Ensure power supply has at least ${recommendedWattage}W capacity`,
        })
      }
    } else if (psuWattage < totalPowerDraw) {
      issues.push({
        type: "error",
        category: "psu",
        message: `Power supply (${psuWattage}W) insufficient for system requirements (${totalPowerDraw}W)`,
        affectedComponents: ["psu"],
        suggestion: `Choose a power supply with at least ${recommendedWattage}W capacity`,
      })
    } else if (psuWattage < recommendedWattage) {
      issues.push({
        type: "warning",
        category: "psu",
        message: `Power supply (${psuWattage}W) has minimal headroom for system requirements (${totalPowerDraw}W)`,
        affectedComponents: ["psu"],
        suggestion: `Consider a ${recommendedWattage}W+ power supply for better efficiency and future upgrades`,
      })
    } else {
      recommendations.push(`Power supply provides good headroom (${psuWattage}W for ${totalPowerDraw}W system)`)
    }
  }

  private checkGpuCaseCompatibility(issues: CompatibilityIssue[]) {
    const gpu = this.components.gpu
    const pcCase = this.components.case

    if (!gpu || !pcCase) return

    // GPU length compatibility - get from compatibility.dimensions or parse from compatibility info
    const gpuLength = gpu.compatibility.dimensions?.length || 
                     this.getDimensionFromCompatibility(gpu, 'length') ||
                     0
    
    // Case max GPU length - get from compatibility info
    const caseMaxGpuLength = this.getCaseMaxGpuLength(pcCase) || 0

    if (gpuLength > 0 && caseMaxGpuLength > 0 && gpuLength > caseMaxGpuLength) {
      issues.push({
        type: "error",
        category: "gpu",
        message: `Graphics card length (${gpuLength}mm) exceeds case maximum (${caseMaxGpuLength}mm)`,
        affectedComponents: ["gpu", "case"],
        suggestion: "Choose a shorter graphics card or larger case",
      })
    }

    // GPU height compatibility
    const gpuHeight = gpu.compatibility.dimensions?.height || 
                     this.getDimensionFromCompatibility(gpu, 'height') ||
                     0
    
    const caseMaxGpuHeight = this.getCaseMaxGpuHeight(pcCase) || 0

    if (gpuHeight > 0 && caseMaxGpuHeight > 0 && gpuHeight > caseMaxGpuHeight) {
      issues.push({
        type: "error",
        category: "gpu",
        message: `Graphics card height (${gpuHeight}mm) exceeds case clearance (${caseMaxGpuHeight}mm)`,
        affectedComponents: ["gpu", "case"],
        suggestion: "Choose a lower-profile graphics card or different case",
      })
    }
  }

  private checkCoolingCompatibility(issues: CompatibilityIssue[]) {
    const cooling = this.components.cooling
    const cpu = this.components.cpu
    const pcCase = this.components.case

    if (!cooling || !cpu) return

    // CPU socket compatibility - get supported sockets from compatibility info
    const cpuSocket = cpu.compatibility.socket
    if (cpuSocket && cpuSocket !== 'Standard') {
      // Try to get supported sockets from compatibility info
      let supportedSockets: string[] = []
      
      // Try parsing from Compatibility JSON
      try {
        const compatStr = cooling.specifications.Compatibility as string
        if (typeof compatStr === 'string') {
          const compat = JSON.parse(compatStr)
          if (compat.supportedSockets) {
            supportedSockets = Array.isArray(compat.supportedSockets) 
              ? compat.supportedSockets 
              : [compat.supportedSockets]
          } else if (compat.supported_sockets) {
            supportedSockets = Array.isArray(compat.supported_sockets) 
              ? compat.supported_sockets 
              : [compat.supported_sockets]
          }
        }
      } catch (e) {
        // Ignore parse errors
      }
      
      // If no supported sockets found, check specifications for supportedSockets field
      if (supportedSockets.length === 0 && cooling.specifications.supportedSockets) {
        try {
          const parsed = JSON.parse(cooling.specifications.supportedSockets as string)
          if (Array.isArray(parsed)) {
            supportedSockets = parsed
          }
        } catch (e) {
          // Not a JSON string, ignore
        }
      }
      
      // Check compatibility
      if (supportedSockets.length > 0 && !supportedSockets.includes(cpuSocket)) {
        issues.push({
          type: "error",
          category: "cooling",
          message: `CPU cooler is not compatible with ${cpuSocket} socket`,
          affectedComponents: ["cooling", "cpu"],
          suggestion: `Choose a cooler that supports ${cpuSocket} socket`,
        })
      } else if (supportedSockets.length === 0) {
        // Warn if no supported sockets info available
        issues.push({
          type: "warning",
          category: "cooling",
          message: `CPU cooler socket compatibility information not available`,
          affectedComponents: ["cooling", "cpu"],
          suggestion: `Verify that the cooler supports ${cpuSocket} socket`,
        })
      }
    }

    // Cooler height vs case clearance
    if (pcCase && cooling.specifications.height && pcCase.specifications.maxCoolerHeight) {
      const coolerHeight = Number.parseInt(cooling.specifications.height) || 0
      const caseMaxHeight = Number.parseInt(pcCase.specifications.maxCoolerHeight) || 0

      if (coolerHeight > caseMaxHeight) {
        issues.push({
          type: "error",
          category: "cooling",
          message: `CPU cooler height (${coolerHeight}mm) exceeds case clearance (${caseMaxHeight}mm)`,
          affectedComponents: ["cooling", "case"],
          suggestion: "Choose a lower-profile cooler or larger case",
        })
      }
    }

    // Cooling performance vs CPU TDP
    const cpuTdp = Number.parseInt(cpu.specifications.tdp) || 0
    const coolerTdp = Number.parseInt(cooling.specifications.tdpRating) || 0

    if (coolerTdp < cpuTdp) {
      issues.push({
        type: "warning",
        category: "cooling",
        message: `CPU cooler TDP rating (${coolerTdp}W) is below CPU TDP (${cpuTdp}W)`,
        affectedComponents: ["cooling", "cpu"],
        suggestion: "Consider a more powerful cooler for optimal temperatures",
      })
    }
  }

  private checkStorageCompatibility(issues: CompatibilityIssue[]) {
    const storage = this.components.storage
    const motherboard = this.components.motherboard

    if (!storage || !motherboard) return

    // M.2 slot availability
    if (storage.specifications.interface === "M.2" && motherboard.specifications.m2Slots) {
      const m2Slots = Number.parseInt(motherboard.specifications.m2Slots) || 0
      if (m2Slots === 0) {
        issues.push({
          type: "error",
          category: "storage",
          message: "Selected M.2 SSD but motherboard has no M.2 slots",
          affectedComponents: ["storage", "motherboard"],
          suggestion: "Choose a SATA SSD or motherboard with M.2 slots",
        })
      }
    }

    // SATA port availability
    if (storage.specifications.interface === "SATA" && motherboard.specifications.sataPorts) {
      const sataPorts = Number.parseInt(motherboard.specifications.sataPorts) || 0
      if (sataPorts === 0) {
        issues.push({
          type: "error",
          category: "storage",
          message: "Selected SATA drive but motherboard has no SATA ports",
          affectedComponents: ["storage", "motherboard"],
          suggestion: "Choose an M.2 SSD or motherboard with SATA ports",
        })
      }
    }
  }

  private calculateCompatibilityScore(issues: CompatibilityIssue[]): number {
    let score = 100
    const selectedCount = Object.values(this.components).filter(Boolean).length

    // If we have very few components selected, incompatibilities should have more impact
    const isEarlyBuild = selectedCount <= 3

    issues.forEach((issue) => {
      switch (issue.type) {
        case "error":
          // Critical incompatibilities: reduce score more significantly
          // If it's an early build (few components), penalize more heavily
          if (isEarlyBuild) {
            score -= 40 // More severe penalty when only 2-3 components selected
          } else {
            score -= 30 // Standard penalty for errors
          }
          break
        case "warning":
          // Only penalize warnings about actual incompatibilities, not missing information
          if (issue.message.includes("information not available") || 
              issue.message.includes("not available")) {
            // Don't penalize for missing information - these are data issues, not compatibility issues
            score -= 0
          } else if (isEarlyBuild) {
            score -= 15 // More significant when few components
          } else {
            score -= 10 // Standard warning penalty
          }
          break
        case "info":
          score -= 2
          break
      }
    })

    // Additional penalty if there are multiple errors affecting the same components
    // This ensures that incompatible component pairs are properly penalized
    const errorIssues = issues.filter(issue => issue.type === "error")
    if (errorIssues.length > 0 && selectedCount <= 2) {
      // If only 2 components selected and they have errors, reduce score further
      score -= 10
    }

    return Math.max(0, score)
  }

    private calculatePowerRequirement(): number {
      return Object.entries(this.components)
        .filter(([category, component]) => category.toLowerCase() !== "psu" && component) // ✅ skip PSU
        .reduce((total, [_, component]) => {
          const power =
            component!.compatibility.powerRequirement ||
            Number.parseInt(component!.specifications.powerRequirement as string) ||
            Number.parseInt(component!.specifications.tdp as string) || // in case CPU uses TDP
            0
          return total + power
        }, 0)
    }


  // Get component recommendations based on current selection
  getRecommendations(): string[] {
    const recommendations: string[] = []
    const selectedCount = Object.values(this.components).filter(Boolean).length

    if (selectedCount === 0) {
      recommendations.push("Start by selecting a CPU - it determines your motherboard socket compatibility")
    } else if (!this.components.cpu) {
      recommendations.push("Select a CPU to determine motherboard and memory compatibility")
    } else if (!this.components.motherboard) {
      recommendations.push(`Select a motherboard with ${this.components.cpu.compatibility.socket} socket`)
    } else if (!this.components.memory) {
      recommendations.push(`Add ${this.components.motherboard.compatibility.memoryType} memory modules`)
    } else if (!this.components.gpu && selectedCount > 3) {
      recommendations.push("Consider adding a dedicated graphics card for better performance")
    } else if (!this.components.psu && selectedCount > 4) {
      const powerReq = this.calculatePowerRequirement()
      recommendations.push(`Add a power supply with at least ${Math.ceil(powerReq * 1.2)}W capacity`)
    }

    return recommendations
  }
}