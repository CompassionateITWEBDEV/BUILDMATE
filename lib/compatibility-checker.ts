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

    // Memory type compatibility
    if (memory.specifications.type !== motherboard.compatibility.memoryType) {
      issues.push({
        type: "error",
        category: "memory",
        message: `Memory type ${memory.specifications.type} is not supported by motherboard (supports ${motherboard.compatibility.memoryType})`,
        affectedComponents: ["memory", "motherboard"],
        suggestion: `Choose ${motherboard.compatibility.memoryType} memory modules`,
      })
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

    const psuWattage = Number.parseInt(psu.specifications.wattage) || 0
    const recommendedWattage = Math.ceil(totalPowerDraw * 1.2) // 20% headroom

    if (psuWattage < totalPowerDraw) {
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

    // GPU length compatibility
    const gpuLength = gpu.compatibility.dimensions?.length || 0
    const caseMaxGpuLength = pcCase.specifications.maxGpuLength || 0

    if (gpuLength > caseMaxGpuLength) {
      issues.push({
        type: "error",
        category: "gpu",
        message: `Graphics card length (${gpuLength}mm) exceeds case maximum (${caseMaxGpuLength}mm)`,
        affectedComponents: ["gpu", "case"],
        suggestion: "Choose a shorter graphics card or larger case",
      })
    }

    // GPU height compatibility
    const gpuHeight = gpu.compatibility.dimensions?.height || 0
    const caseMaxGpuHeight = pcCase.specifications.maxGpuHeight || 0

    if (gpuHeight > caseMaxGpuHeight) {
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

    // CPU socket compatibility
    if (cooling.compatibility.socket && !cooling.compatibility.socket.includes(cpu.compatibility.socket || "")) {
      issues.push({
        type: "error",
        category: "cooling",
        message: `CPU cooler is not compatible with ${cpu.compatibility.socket} socket`,
        affectedComponents: ["cooling", "cpu"],
        suggestion: `Choose a cooler that supports ${cpu.compatibility.socket} socket`,
      })
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

    issues.forEach((issue) => {
      switch (issue.type) {
        case "error":
          score -= 25
          break
        case "warning":
          score -= 10
          break
        case "info":
          score -= 2
          break
      }
    })

    return Math.max(0, score)
  }

  private calculatePowerRequirement(): number {
    return Object.values(this.components)
      .filter(Boolean)
      .reduce((total, component) => total + (component!.compatibility.powerRequirement || 0), 0)
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