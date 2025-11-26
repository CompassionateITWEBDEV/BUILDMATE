"use client"

import * as React from "react"
import { useState, useEffect } from "react"
import { useRouter } from "next/navigation"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { supabase } from "@/lib/supabase"
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog"
import {
  Cpu,
  HardDrive,
  MemoryStick,
  Zap,
  Monitor,
  Fan,
  Clapperboard as Motherboard,
  Save,
  Share,
  AlertTriangle,
  CheckCircle,
  Search,
  ArrowLeft,
  AlertCircle,
  Info,
  Lightbulb,
  MessageSquare,
  TrendingUp,
  Loader2,
  CheckCircle2,
  ShoppingCart,
  MapPin
} from "lucide-react"

import { mockComponents, type Component, type ComponentCategory, type PerformanceCategory, performanceCategories } from "@/lib/mock-data"
import { CompatibilityChecker, type CompatibilityResult } from "@/lib/compatibility-checker"
import { filterComponentsByPerformance } from "@/lib/performance-filter"
import { DuplicateDetector, type BuildComparison } from "@/lib/duplicate-detector"
import { DuplicateCheckDialog } from "@/components/duplicate-warning"
import { formatCurrency } from "@/lib/currency"
import { getCSPRecommendations, getUpgradeRecommendations, type CSPSolution } from "@/lib/algorithm-service"
import { getSupabaseComponents, getSupabaseComponentsByCategory } from "@/lib/supabase-components"
import { useAuth } from "@/contexts/supabase-auth-context"
import { Textarea } from "@/components/ui/textarea"
import { AvailabilityBadge } from "@/components/availability-badge"
import { RetailerLocation } from "@/components/retailer-location"

const categoryIcons = {
  cpu: Cpu,
  motherboard: Motherboard,
  memory: MemoryStick,
  storage: HardDrive,
  gpu: Monitor,
  psu: Zap,
  case: HardDrive,
  cooling: Fan,
}

const categoryNames = {
  cpu: "Processors",
  motherboard: "Motherboard",
  memory: "Memory (RAM)",
  storage: "Storage",
  gpu: "Graphics Card",
  psu: "Power Supply",
  case: "Case",
  cooling: "Cooling",
}

export default function BuilderPage() {
  const { user } = useAuth()
  const router = useRouter()

  const [selectedComponents, setSelectedComponents] = useState<Record<ComponentCategory, Component | null>>({
    cpu: null,
    motherboard: null,
    memory: null,
    storage: null,
    gpu: null,
    psu: null,
    case: null,
    cooling: null,
  })

  const [components, setComponents] = useState<Component[]>([])
  const [isLoadingComponents, setIsLoadingComponents] = useState(false)
  const [fetchError, setFetchError] = useState<string | null>(null)
  const [activeCategory, setActiveCategory] = useState<ComponentCategory>("cpu")
  const [searchTerm, setSearchTerm] = useState("")
  const [locationFilter, setLocationFilter] = useState<string>("")
  const [buildName, setBuildName] = useState("My Custom Build")
  const [buildType, setBuildType] = useState<string>("4")
  const [isSaveDialogOpen, setIsSaveDialogOpen] = useState(false)
  const [savedBuildId, setSavedBuildId] = useState<number | null>(null)
  const [showSuccessDialog, setShowSuccessDialog] = useState(false)
  const [performanceCategory, setPerformanceCategory] = useState<PerformanceCategory>("all")
  const [budget, setBudget] = useState<number>(0)
  const [budgetEnabled, setBudgetEnabled] = useState(false)
  const [duplicateComparisons, setDuplicateComparisons] = useState<BuildComparison[]>([])
  const [showDuplicateDialog, setShowDuplicateDialog] = useState(false)
  const [isCheckingDuplicates, setIsCheckingDuplicates] = useState(false)
  const [cspSolutions, setCspSolutions] = useState<CSPSolution[]>([])
  const [isCSPDialogOpen, setIsCSPDialogOpen] = useState(false)
  const [isLoadingCSP, setIsLoadingCSP] = useState(false)
  const [upgradeRecommendations, setUpgradeRecommendations] = useState<any[]>([])
  const [upgradeCategoryMap, setUpgradeCategoryMap] = useState<Map<number, ComponentCategory>>(new Map())
  const [isLoadingUpgrades, setIsLoadingUpgrades] = useState(false)
  const [showUpgradeDialog, setShowUpgradeDialog] = useState(false)
  const [algorithmError, setAlgorithmError] = useState<string | null>(null)
  const [buildDescription, setBuildDescription] = useState("")
  const [showPurchasePreview, setShowPurchasePreview] = useState(false)

  const [cspPage, setCspPage] = useState(0)
  const SOLUTIONS_PER_PAGE = 2

  // Check if a component is compatible with currently selected components
  const isComponentCompatible = (component: Component, category: ComponentCategory): boolean => {
    // If no components are selected, show all components
    const hasSelectedComponents = Object.values(selectedComponents).some(comp => comp !== null)
    if (!hasSelectedComponents) return true

    // CPU-Motherboard compatibility
    if (category === "motherboard" && selectedComponents.cpu) {
      const cpuSocket = selectedComponents.cpu.compatibility.socket
      const mbSocket = component.compatibility.socket
      if (cpuSocket && mbSocket && cpuSocket !== mbSocket) {
        return false
      }
    }

    if (category === "cpu" && selectedComponents.motherboard) {
      const cpuSocket = component.compatibility.socket
      const mbSocket = selectedComponents.motherboard.compatibility.socket
      if (cpuSocket && mbSocket && cpuSocket !== mbSocket) {
        return false
      }
    }

    // Memory-Motherboard compatibility
    if (category === "memory" && selectedComponents.motherboard) {
      const memoryType = component.compatibility.memoryType || 
                        (component.specifications.type as string)
      const mbMemoryType = selectedComponents.motherboard.compatibility.memoryType ||
                          (selectedComponents.motherboard.specifications.memoryType as string)
      
      if (memoryType && mbMemoryType) {
        const mbSupports = Array.isArray(mbMemoryType) ? mbMemoryType : [mbMemoryType]
        if (!mbSupports.includes(memoryType)) {
          return false
        }
      }
    }

    if (category === "motherboard" && selectedComponents.memory) {
      const memoryType = selectedComponents.memory.compatibility.memoryType ||
                        (selectedComponents.memory.specifications.type as string)
      const mbMemoryType = component.compatibility.memoryType ||
                          (component.specifications.memoryType as string)
      
      if (memoryType && mbMemoryType) {
        const mbSupports = Array.isArray(mbMemoryType) ? mbMemoryType : [mbMemoryType]
        if (!mbSupports.includes(memoryType)) {
          return false
        }
      }
    }

    // GPU-Case compatibility (dimensions)
    if (category === "gpu" && selectedComponents.case) {
      const gpuLength = component.compatibility.dimensions?.length || 0
      const caseMaxGpuLength = Number.parseInt(selectedComponents.case.specifications.maxGpuLength as string) || 0
      
      if (gpuLength > 0 && caseMaxGpuLength > 0 && gpuLength > caseMaxGpuLength) {
        return false
      }

      const gpuHeight = component.compatibility.dimensions?.height || 0
      const caseMaxGpuHeight = Number.parseInt(selectedComponents.case.specifications.maxCoolerHeight as string) || 0
      
      if (gpuHeight > 0 && caseMaxGpuHeight > 0 && gpuHeight > caseMaxGpuHeight) {
        return false
      }
    }

    if (category === "case" && selectedComponents.gpu) {
      const gpuLength = selectedComponents.gpu.compatibility.dimensions?.length || 0
      const caseMaxGpuLength = Number.parseInt(component.specifications.maxGpuLength as string) || 0
      
      if (gpuLength > 0 && caseMaxGpuLength > 0 && gpuLength > caseMaxGpuLength) {
        return false
      }

      const gpuHeight = selectedComponents.gpu.compatibility.dimensions?.height || 0
      const caseMaxGpuHeight = Number.parseInt(component.specifications.maxCoolerHeight as string) || 0
      
      if (gpuHeight > 0 && caseMaxGpuHeight > 0 && gpuHeight > caseMaxGpuHeight) {
        return false
      }
    }

    // Cooling-CPU compatibility (socket)
    if (category === "cooling" && selectedComponents.cpu) {
      const cpuSocket = selectedComponents.cpu.compatibility.socket
      if (cpuSocket && cpuSocket !== 'Standard') {
        // Try to get supported sockets from cooling component
        let supportedSockets: string[] = []
        
        // Method 1: Check compatibility.socket (may be comma-separated string like "AM4,LGA1700")
        if (component.compatibility.socket) {
          const socketStr = component.compatibility.socket
          if (socketStr.includes(',')) {
            supportedSockets = socketStr.split(',').map(s => s.trim())
          } else if (socketStr !== 'Standard') {
            supportedSockets = [socketStr]
          }
        }
        
        // Method 2: Try parsing from Compatibility JSON in specifications
        if (supportedSockets.length === 0) {
          try {
            const compatStr = component.specifications.Compatibility as string
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
        }
        
        // Method 3: Check specifications for supportedSockets field (JSON string)
        if (supportedSockets.length === 0 && component.specifications.supportedSockets) {
          try {
            const parsed = JSON.parse(component.specifications.supportedSockets as string)
            if (Array.isArray(parsed)) {
              supportedSockets = parsed
            } else if (typeof parsed === 'string') {
              // Handle comma-separated string
              supportedSockets = parsed.includes(',') 
                ? parsed.split(',').map(s => s.trim())
                : [parsed]
            }
          } catch (e) {
            // Not a JSON string, try as direct array or string
            if (Array.isArray(component.specifications.supportedSockets)) {
              supportedSockets = component.specifications.supportedSockets as string[]
            } else if (typeof component.specifications.supportedSockets === 'string') {
              const socketStr = component.specifications.supportedSockets
              supportedSockets = socketStr.includes(',')
                ? socketStr.split(',').map(s => s.trim())
                : [socketStr]
            }
          }
        }
        
        // Check compatibility - if we have socket info and it doesn't match, filter out
        if (supportedSockets.length > 0 && !supportedSockets.includes(cpuSocket)) {
          return false
        }
      }
    }

    // CPU-Cooling compatibility (when CPU is selected, filter coolers)
    if (category === "cpu" && selectedComponents.cooling) {
      const cpuSocket = component.compatibility.socket
      if (cpuSocket && cpuSocket !== 'Standard') {
        let supportedSockets: string[] = []
        
        // Method 1: Check compatibility.socket (may be comma-separated string)
        if (selectedComponents.cooling.compatibility.socket) {
          const socketStr = selectedComponents.cooling.compatibility.socket
          if (socketStr.includes(',')) {
            supportedSockets = socketStr.split(',').map(s => s.trim())
          } else if (socketStr !== 'Standard') {
            supportedSockets = [socketStr]
          }
        }
        
        // Method 2: Try parsing from Compatibility JSON
        if (supportedSockets.length === 0) {
          try {
            const compatStr = selectedComponents.cooling.specifications.Compatibility as string
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
        }
        
        // Method 3: Check specifications for supportedSockets
        if (supportedSockets.length === 0 && selectedComponents.cooling.specifications.supportedSockets) {
          try {
            const parsed = JSON.parse(selectedComponents.cooling.specifications.supportedSockets as string)
            if (Array.isArray(parsed)) {
              supportedSockets = parsed
            } else if (typeof parsed === 'string') {
              supportedSockets = parsed.includes(',')
                ? parsed.split(',').map(s => s.trim())
                : [parsed]
            }
          } catch (e) {
            if (Array.isArray(selectedComponents.cooling.specifications.supportedSockets)) {
              supportedSockets = selectedComponents.cooling.specifications.supportedSockets as string[]
            } else if (typeof selectedComponents.cooling.specifications.supportedSockets === 'string') {
              const socketStr = selectedComponents.cooling.specifications.supportedSockets
              supportedSockets = socketStr.includes(',')
                ? socketStr.split(',').map(s => s.trim())
                : [socketStr]
            }
          }
        }
        
        if (supportedSockets.length > 0 && !supportedSockets.includes(cpuSocket)) {
          return false
        }
      }
    }

    // Cooling-Case compatibility (height)
    if (category === "cooling" && selectedComponents.case) {
      const coolerHeight = Number.parseInt(component.specifications.height as string) || 0
      const caseMaxHeight = Number.parseInt(selectedComponents.case.specifications.maxCoolerHeight as string) || 0
      
      if (coolerHeight > 0 && caseMaxHeight > 0 && coolerHeight > caseMaxHeight) {
        return false
      }
    }

    if (category === "case" && selectedComponents.cooling) {
      const coolerHeight = Number.parseInt(selectedComponents.cooling.specifications.height as string) || 0
      const caseMaxHeight = Number.parseInt(component.specifications.maxCoolerHeight as string) || 0
      
      if (coolerHeight > 0 && caseMaxHeight > 0 && coolerHeight > caseMaxHeight) {
        return false
      }
    }

    // Storage-Motherboard compatibility (M.2/SATA slots)
    if (category === "storage" && selectedComponents.motherboard) {
      const storageInterface = component.specifications.interface as string
      if (storageInterface === "M.2") {
        const m2Slots = Number.parseInt(selectedComponents.motherboard.specifications.m2Slots as string) || 0
        if (m2Slots === 0) {
          return false
        }
      }
      if (storageInterface === "SATA") {
        const sataPorts = Number.parseInt(selectedComponents.motherboard.specifications.sataPorts as string) || 0
        if (sataPorts === 0) {
          return false
        }
      }
    }

    if (category === "motherboard" && selectedComponents.storage) {
      const storageInterface = selectedComponents.storage.specifications.interface as string
      if (storageInterface === "M.2") {
        const m2Slots = Number.parseInt(component.specifications.m2Slots as string) || 0
        if (m2Slots === 0) {
          return false
        }
      }
      if (storageInterface === "SATA") {
        const sataPorts = Number.parseInt(component.specifications.sataPorts as string) || 0
        if (sataPorts === 0) {
          return false
        }
      }
    }

    return true
  }

  const getFilteredComponents = (category: ComponentCategory) => {
    const categoryFiltered = components.filter((component) => component.category === category)

    const performanceFiltered = filterComponentsByPerformance(
      categoryFiltered,
      performanceCategory,
      performanceCategories[performanceCategory].requirements
    )

    const searchFiltered = performanceFiltered.filter(
      (component) =>
        component.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        component.brand.toLowerCase().includes(searchTerm.toLowerCase()),
    )

    // Location-based filtering
    const locationFiltered = locationFilter
      ? searchFiltered.filter(
          (component) =>
            component.retailer?.address?.toLowerCase().includes(locationFilter.toLowerCase()) ||
            component.retailer?.name?.toLowerCase().includes(locationFilter.toLowerCase())
        )
      : searchFiltered

    // Compatibility-based filtering - remove incompatible components
    const compatibilityFiltered = locationFiltered.filter(
      (component) => isComponentCompatible(component, category)
    )

    return compatibilityFiltered
  }


  const totalPrice = Object.values(selectedComponents)
    .filter(Boolean)
    .reduce((sum, component) => sum + component!.price, 0)

  const remainingBudget = budgetEnabled ? budget - totalPrice : 0
  const isOverBudget = budgetEnabled && totalPrice > budget
  const budgetPercentage = budgetEnabled && budget > 0 ? (totalPrice / budget) * 100 : 0

  const getCompatibilityResult = (): CompatibilityResult => {
    const checker = new CompatibilityChecker(selectedComponents)
    return checker.checkCompatibility()
  }

  const handleComponentSelect = (component: Component) => {
    setSelectedComponents((prev) => ({
      ...prev,
      [component.category]: component,
    }))
  }

  const handleComponentRemove = (category: ComponentCategory) => {
    setSelectedComponents((prev) => ({
      ...prev,
      [category]: null,
    }))
  }

  const handleGetCSPRecommendations = async () => {
    if (!budgetEnabled || budget <= 0) {
      setAlgorithmError("Please set a budget first")
      return
    }

    if (budget < 10000) {
      setAlgorithmError("CSP recommendations require a minimum budget of ₱10,000")
      return
    }

    setIsLoadingCSP(true)
    setAlgorithmError(null)

    try {
      // Build user_inputs map - extract numeric ID from component-{id} format
      const userInputs: Record<string, number> = {}
      if (selectedComponents.cpu) {
        userInputs["CPU"] = typeof selectedComponents.cpu.id === 'number' ? selectedComponents.cpu.id : parseInt(String(selectedComponents.cpu.id).replace(/\D/g, '')) || 0
      }
      if (selectedComponents.gpu) {
        userInputs["Video Card"] = typeof selectedComponents.gpu.id === 'number' ? selectedComponents.gpu.id : parseInt(String(selectedComponents.gpu.id).replace(/\D/g, '')) || 0
      }
      if (selectedComponents.motherboard) {
        userInputs["Motherboard"] = typeof selectedComponents.motherboard.id === 'number' ? selectedComponents.motherboard.id : parseInt(String(selectedComponents.motherboard.id).replace(/\D/g, '')) || 0
      }
      if (selectedComponents.memory) {
        userInputs["Memory"] = typeof selectedComponents.memory.id === 'number' ? selectedComponents.memory.id : parseInt(String(selectedComponents.memory.id).replace(/\D/g, '')) || 0
      }
      if (selectedComponents.storage) {
        userInputs["Storage"] = typeof selectedComponents.storage.id === 'number' ? selectedComponents.storage.id : parseInt(String(selectedComponents.storage.id).replace(/\D/g, '')) || 0
      }
      if (selectedComponents.psu) {
        userInputs["Power Supply"] = typeof selectedComponents.psu.id === 'number' ? selectedComponents.psu.id : parseInt(String(selectedComponents.psu.id).replace(/\D/g, '')) || 0
      }
      if (selectedComponents.case) {
        userInputs["Case"] = typeof selectedComponents.case.id === 'number' ? selectedComponents.case.id : parseInt(String(selectedComponents.case.id).replace(/\D/g, '')) || 0
      }
      if (selectedComponents.cooling) {
        userInputs["CPU Cooler"] = typeof selectedComponents.cooling.id === 'number' ? selectedComponents.cooling.id : parseInt(String(selectedComponents.cooling.id).replace(/\D/g, '')) || 0
      }

      // Use algorithm service instead of direct fetch
      const solutions = await getCSPRecommendations(budget, userInputs)
      
      setCspSolutions(solutions)
      setCspPage(0)
      setIsCSPDialogOpen(true)
    } catch (error: any) {
      console.error("Error getting CSP recommendations:", error)
      setAlgorithmError(error.message || "Failed to get recommendations. Make sure Python backend is running.")
    } finally {
      setIsLoadingCSP(false)
    }
  }


  const handleApplyCSPSolution = (solution: CSPSolution) => {
    // Map solution categories to ComponentCategory keys
    const newSelected: Record<ComponentCategory, Component | null> = { ...selectedComponents }

    Object.entries(solution).forEach(([category, comp]: [string, any]) => {
      // Convert the solution category string to your ComponentCategory keys if needed
      const key = category.toLowerCase() as ComponentCategory
        newSelected[key] = {
          id: comp.id,
          name: comp.name,
          brand: comp.brand || "",
          price: comp.price,
          category: key,
          image: comp.image || "",
          rating: comp.rating || 0,
          reviews: comp.reviews || 0,
          specifications: comp.specifications || {},
          compatibility: comp.compatibility || {}, // << add this
          performanceTags: comp.performanceTags || ['all'] as PerformanceCategory[],
        }
    })

    setSelectedComponents(newSelected)
    setIsCSPDialogOpen(false)
  }


  const handleGetUpgradeRecommendations = async () => {
    const selectedComponentsList = Object.values(selectedComponents).filter(Boolean)
    
    if (selectedComponentsList.length === 0) {
      setAlgorithmError("Please select some components first")
      return
    }

    setIsLoadingUpgrades(true)
    setAlgorithmError(null)

    try {
      const currentBuild = selectedComponentsList.map((comp) => ({
        component_id: typeof comp!.id === 'number' ? comp!.id : parseInt(String(comp!.id).replace(/\D/g, '')) || 0,
        component_name: comp!.name,
        component_price: comp!.price,
        category_name: comp!.category.charAt(0).toUpperCase() + comp!.category.slice(1),
      }))

      const recommendations = await getUpgradeRecommendations(currentBuild)
      setUpgradeRecommendations(recommendations)
      
      // Create a map of recommendation index to category by matching component names
      const categoryMap = new Map<number, ComponentCategory>()
      recommendations.forEach((rec, recIndex) => {
        // Find the component in selectedComponentsList that matches this recommendation
        const matchingComponent = selectedComponentsList.find(comp => 
          comp!.name === rec.current_component
        )
        if (matchingComponent) {
          categoryMap.set(recIndex, matchingComponent.category)
        }
      })
      setUpgradeCategoryMap(categoryMap)
      
      setShowUpgradeDialog(true)
    } catch (error: any) {
      console.error("Error getting upgrade recommendations:", error)
      setAlgorithmError(error.message || "Failed to get upgrade recommendations. Make sure Python backend is running.")
    } finally {
      setIsLoadingUpgrades(false)
    }
  }

  const handleApplyUpgrade = async (recIndex: number, recommendedName: string) => {
    const category = upgradeCategoryMap.get(recIndex)
    if (!category) {
      setAlgorithmError("Could not determine component category for upgrade")
      return
    }

    try {
      // Fetch all components in this category from Supabase
      const categoryComponents = await getSupabaseComponentsByCategory(category)
      
      // Find the component by name (case-insensitive partial match)
      const upgradedComponent = categoryComponents.find(comp => 
        comp.name.toLowerCase().includes(recommendedName.toLowerCase()) ||
        recommendedName.toLowerCase().includes(comp.name.toLowerCase())
      )

      if (!upgradedComponent) {
        setAlgorithmError(`Could not find component "${recommendedName}" in ${category} category`)
        return
      }

      // Apply the upgrade to the selected components
      setSelectedComponents(prev => ({
        ...prev,
        [category]: upgradedComponent
      }))

      // Show success message and close dialog
      setShowUpgradeDialog(false)
      setAlgorithmError(null)
    } catch (error: any) {
      console.error("Error applying upgrade:", error)
      setAlgorithmError(error.message || "Failed to apply upgrade")
    }
  }

  const checkForDuplicates = async () => {
    if (!user) return
    setIsCheckingDuplicates(true)
    
    try {
      const currentBuildFingerprint = DuplicateDetector.generateFingerprint(selectedComponents)
      const mockExistingBuilds = [
        {
          components: { cpu: "cpu-1", motherboard: "mobo-1", memory: "ram-1", storage: "ssd-1", gpu: "gpu-1", psu: "psu-1", case: "case-1", cooling: "cooling-1" },
          totalPrice: 1200,
          componentCount: 8,
          priceRange: 'mid' as const,
          performanceCategory: 'gaming'
        }
      ]
      const comparisons = DuplicateDetector.checkForDuplicates(currentBuildFingerprint, mockExistingBuilds)
      if (comparisons.length > 0) {
        setDuplicateComparisons(comparisons)
        setShowDuplicateDialog(true)
        return false
      }
      return true
    } catch (error) {
      console.error("Error checking for duplicates:", error)
      return true
    } finally {
      setIsCheckingDuplicates(false)
    }
  }

  const handleSaveBuild = async () => {
    if (!user) {
      router.push("/login")
      return
    }

    const canProceed = await checkForDuplicates()
    if (!canProceed) return

    setIsSaveDialogOpen(false)

    // 1. Insert a row into builds table
    const { data: buildData, error: buildError } = await supabase
      .from("builds")
      .insert({
        build_name: buildName,
        user_id: user.user_id,
        total_price: totalPrice,
        build_type_id: parseInt(buildType),
        description: buildDescription,
      })
      .select("build_id")       
      .single()

    if (buildError || !buildData) {
      console.error("Error creating build:", buildError)
      setAlgorithmError("Failed to save build")
      return
    }

    const buildId = buildData.build_id

    console.log("Selected components:", selectedComponents)

    // 2. Prepare build_components rows
    const rowsToInsert = Object.values(selectedComponents)
      .filter((comp): comp is Component => comp !== null)
      .map((comp) => {
        const numericId = Number(String(comp.id).replace("component-", ""));
        return {
          build_id: buildId,
          component_id: numericId,
        };
      });


    console.log("Rows to insert into build_components:", rowsToInsert)
    // 3. Insert into build_components table
    const { data: bcData, error: bcError } = await supabase
      .from("build_components")
      .insert(rowsToInsert)

    if (bcError) {
      console.error("Error inserting build_components:", bcError)
      setAlgorithmError("Failed to save build components")
      return
    }

    console.log("Build saved successfully:", { buildId, bcData })
    setSavedBuildId(buildId)
    setShowSuccessDialog(true)
  }


  const handleProceedAnyway = () => {
    console.log("Saving build despite duplicates:", { name: buildName, components: selectedComponents, totalPrice })
    setIsSaveDialogOpen(false)
    setShowDuplicateDialog(false)
  }

  const handleModifyBuild = () => {
    setSelectedComponents(prev => ({ ...prev, cooling: null }))
    setShowDuplicateDialog(false)
  }

  const handleViewSimilar = (buildId: string) => console.log("Viewing similar build:", buildId)
  const handleEditSimilar = (buildId: string) => console.log("Editing similar build:", buildId)

  const compatibilityResult = getCompatibilityResult()
  const recommendations = new CompatibilityChecker(selectedComponents).getRecommendations()

  useEffect(() => {
    const fetchComponents = async () => {
      setIsLoadingComponents(true)
      try {
        // Fetch components from Supabase database
        const dbComponents = await getSupabaseComponents()
        
        if (dbComponents.length > 0) {
          setComponents(dbComponents)
          console.log("Fetched components from database:", dbComponents)
          console.log(`Loaded ${dbComponents.length} components from database`)
        } else {
          // Fallback to mock data if database is empty
          console.warn("No components found in database, using mock data")
          setComponents(mockComponents)
        }
      } catch (err) {
        console.error("Error fetching components:", err)
        setFetchError("Failed to fetch components")
        // Fallback to mock data on error
        setComponents(mockComponents)
      } finally {
        setIsLoadingComponents(false)
      }
    }
    fetchComponents()
  }, [])





  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      {/* Builder Header */}
      <div className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
        <div className="container mx-auto px-4 py-4">
          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
            <div className="flex items-center gap-2 sm:gap-4">
              <Button variant="ghost" size="sm" asChild>
                <Link href={user ? "/dashboard" : "/"}>
                  <ArrowLeft className="h-4 w-4 sm:mr-2" />
                  <span className="hidden sm:inline">Back</span>
                </Link>
              </Button>
              <div className="flex items-center gap-2">
                <Cpu className="h-5 w-5 sm:h-6 sm:w-6 text-blue-600" />
                <h1 className="text-lg sm:text-xl font-bold text-slate-900 dark:text-white">PC Builder</h1>
              </div>
            </div>
            <div className="flex items-center gap-2 flex-wrap">
              <Button variant="outline" size="sm" asChild className="text-xs sm:text-sm">
                <Link href="/support">
                  <span className="hidden sm:inline">Get Help</span>
                  <span className="sm:hidden">Help</span>
                </Link>
              </Button>
              <Dialog open={showPurchasePreview} onOpenChange={setShowPurchasePreview}>
                <DialogTrigger asChild>
                  <Button variant="outline" size="sm" className="text-xs sm:text-sm" disabled={totalPrice === 0}>
                    <ShoppingCart className="h-4 w-4 sm:mr-2" />
                    <span className="hidden sm:inline">Preview Purchase</span>
                    <span className="sm:hidden">Purchase</span>
                  </Button>
                </DialogTrigger>
                <DialogContent className="max-w-4xl max-h-[90vh] overflow-y-auto">
                  <DialogHeader>
                    <DialogTitle>Purchase Details Preview</DialogTitle>
                    <DialogDescription>
                      Review your build components and purchase information before saving
                    </DialogDescription>
                  </DialogHeader>
                  <div className="space-y-6">
                    {/* Build Summary */}
                    <Card>
                      <CardHeader>
                        <CardTitle>{buildName}</CardTitle>
                        <CardDescription>
                          Build Type: {buildType === "1" ? "Academic" : buildType === "2" ? "Office" : buildType === "3" ? "Gaming" : "Custom"}
                        </CardDescription>
                      </CardHeader>
                      <CardContent>
                        <div className="space-y-4">
                          {Object.entries(selectedComponents)
                            .filter(([_, component]) => component !== null)
                            .map(([category, component]) => {
                              const categoryName = categoryNames[category as ComponentCategory]
                              const Icon = categoryIcons[category as ComponentCategory]
                              
                              return (
                                <div
                                  key={category}
                                  className="border rounded-lg p-4 space-y-3"
                                >
                                  <div className="flex items-start justify-between">
                                    <div className="flex items-start gap-3 flex-1">
                                      <div className="flex-1">
                                        <div className="flex items-center gap-2 mb-1">
                                          <h3 className="font-semibold text-slate-900 dark:text-white">
                                            {component!.name}
                                          </h3>
                                          <AvailabilityBadge status={component!.availabilityStatus} className="text-xs" />
                                        </div>
                                        <Badge variant="secondary" className="mt-1">
                                          {categoryName}
                                        </Badge>
                                        {component!.brand && (
                                          <p className="text-sm text-slate-600 dark:text-slate-400 mt-1">
                                            Brand: {component!.brand}
                                          </p>
                                        )}
                                        {component!.retailer && (
                                          <p className="text-xs text-slate-500 dark:text-slate-400 mt-1">
                                            Retailer: {component!.retailer.name}
                                            {component!.retailer.address && ` • ${component!.retailer.address.split(',')[0]}`}
                                          </p>
                                        )}
                                      </div>
                                    </div>
                                    <div className="text-right">
                                      <p className="font-semibold text-slate-900 dark:text-white">
                                        {formatCurrency(component!.price)}
                                      </p>
                                    </div>
                                  </div>
                                  
                                  {component!.specifications && Object.keys(component!.specifications).length > 0 && (
                                    <div className="pt-3 border-t">
                                      <p className="text-xs font-medium text-slate-600 dark:text-slate-400 mb-2">Specifications:</p>
                                      <div className="text-xs text-slate-500 dark:text-slate-400 space-y-1">
                                        {Object.entries(component!.specifications)
                                          .filter(([key]) => key !== 'Compatibility')
                                          .slice(0, 3)
                                          .map(([key, value]) => (
                                            <p key={key}>
                                              <span className="font-medium">{key}:</span> {String(value)}
                                            </p>
                                          ))}
                                      </div>
                                    </div>
                                  )}
                                  
                                  {component!.retailer && (
                                    <div className="pt-3 border-t">
                                      <RetailerLocation retailer={component!.retailer} className="border-0 shadow-none" />
                                    </div>
                                  )}
                                </div>
                              )
                            })}
                        </div>
                      </CardContent>
                    </Card>

                    {/* Order Summary */}
                    <Card>
                      <CardHeader>
                        <CardTitle>Order Summary</CardTitle>
                      </CardHeader>
                      <CardContent className="space-y-4">
                        <div className="space-y-2">
                          <div className="flex justify-between text-sm">
                            <span className="text-slate-600 dark:text-slate-400">
                              Components ({Object.values(selectedComponents).filter(Boolean).length})
                            </span>
                            <span className="text-slate-900 dark:text-white">
                              {formatCurrency(totalPrice)}
                            </span>
                          </div>
                          <div className="border-t pt-2">
                            <div className="flex justify-between font-semibold text-lg">
                              <span>Total</span>
                              <span className="text-blue-600">
                                {formatCurrency(totalPrice)}
                              </span>
                            </div>
                          </div>
                        </div>

                        <div className="pt-4 border-t space-y-2">
                          <Button
                            onClick={() => {
                              setShowPurchasePreview(false)
                              setIsSaveDialogOpen(true)
                            }}
                            className="w-full"
                          >
                            Save Build to Purchase
                          </Button>
                          <p className="text-xs text-slate-500 dark:text-slate-400 text-center">
                            Save your build first to access full purchase features and send purchase details to retailers
                          </p>
                        </div>
                      </CardContent>
                    </Card>
                  </div>
                </DialogContent>
              </Dialog>
              <Dialog open={isSaveDialogOpen} onOpenChange={setIsSaveDialogOpen}>
                <DialogTrigger asChild>
                  <Button variant="outline" size="sm" className="text-xs sm:text-sm">
                    <span className="hidden sm:inline">Save Build</span>
                    <span className="sm:hidden">Save</span>
                  </Button>
                </DialogTrigger>
                <DialogContent>
                  <DialogHeader>
                    <DialogTitle>Save Your Build</DialogTitle>
                    <DialogDescription>Give your build a name to save it to your profile</DialogDescription>
                  </DialogHeader>
                  <div className="space-y-4">
                    <div>
                      <Label htmlFor="buildName">Build Name</Label>
                      <Input
                        id="buildName"
                        value={buildName}
                        onChange={(e) => setBuildName(e.target.value)}
                        placeholder="Enter build name"
                      />
                    </div>
                    <div>
                      <Label htmlFor="buildDescription">Build Description</Label>
                      <Textarea
                        id="buildDescription"
                        value={buildDescription}
                        onChange={(e) => setBuildDescription(e.target.value)}
                        placeholder="Enter a description for your build"
                        className="w-full"
                        rows={3}
                      />
                    </div>
                    <div>
                      <Label htmlFor="buildType">Build Type</Label>
                      <Select
                        value={buildType}
                        onValueChange={(value) => setBuildType(value)}
                      >
                        <SelectTrigger className="w-full">
                          <SelectValue placeholder="Select build type" />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="1">Academic</SelectItem>
                          <SelectItem value="2">Office</SelectItem>
                          <SelectItem value="3">Gaming</SelectItem>
                          <SelectItem value="4">Custom</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>

                    <div className="flex justify-end gap-2">
                      <Button variant="outline" onClick={() => setIsSaveDialogOpen(false)}>
                        Cancel
                      </Button>
                      <Button onClick={handleSaveBuild}>Save Build</Button>
                    </div>
                  </div>
                </DialogContent>
              </Dialog>

              {/* Success Dialog after saving */}
              <Dialog open={showSuccessDialog} onOpenChange={setShowSuccessDialog}>
                <DialogContent>
                  <DialogHeader>
                    <DialogTitle className="flex items-center gap-2">
                      <CheckCircle2 className="h-5 w-5 text-green-600" />
                      Build Saved Successfully!
                    </DialogTitle>
                    <DialogDescription>
                      Your build has been saved. You can now view details and proceed to purchase.
                    </DialogDescription>
                  </DialogHeader>
                  <div className="space-y-4">
                    <div className="flex flex-col gap-2">
                      <Button
                        onClick={() => {
                          setShowSuccessDialog(false)
                          router.push(`/purchase/${savedBuildId}`)
                        }}
                        className="w-full"
                      >
                        View Purchase Details
                      </Button>
                      <Button
                        variant="outline"
                        onClick={() => {
                          setShowSuccessDialog(false)
                          router.push(`/mybuilds/${savedBuildId}`)
                        }}
                        className="w-full"
                      >
                        View Build Details
                      </Button>
                      <Button
                        variant="ghost"
                        onClick={() => setShowSuccessDialog(false)}
                        className="w-full"
                      >
                        Continue Building
                      </Button>
                    </div>
                  </div>
                </DialogContent>
              </Dialog>

              <Button variant="outline" size="sm" className="text-xs sm:text-sm">
                <span className="hidden sm:inline">Share</span>
              </Button>
            </div>
          </div>
        </div>
      </div>

      <div className="container mx-auto px-4 py-6">
        <div className="grid lg:grid-cols-3 gap-6">
          {/* Component Selection */}
          <div className="lg:col-span-2">
            <Card className="border-slate-200 dark:border-slate-700">
              <CardHeader>
                <div className="space-y-4">
                  <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                    <CardTitle className="text-lg sm:text-xl">Select Components</CardTitle>
                    <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-2 w-full sm:w-auto">
                      <div className="flex items-center gap-2 flex-1 sm:flex-initial">
                      <Search className="h-4 w-4 text-slate-400" />
                      <Input
                        placeholder="Search components..."
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                          className="w-full sm:w-64"
                        />
                      </div>
                      <div className="flex items-center gap-2 flex-1 sm:flex-initial">
                        <MapPin className="h-4 w-4 text-slate-400" />
                        <Input
                          placeholder="Filter by location..."
                          value={locationFilter}
                          onChange={(e) => setLocationFilter(e.target.value)}
                          className="w-full sm:w-64"
                      />
                      </div>
                    </div>
                  </div>
                  
                  {/* Performance Category Selector */}
                  <div className="flex flex-col sm:flex-row sm:items-center gap-4">
                    <Label htmlFor="performance-category" className="text-sm font-medium whitespace-nowrap">
                      Performance Category:
                    </Label>
                    <Select value={performanceCategory} onValueChange={(value) => setPerformanceCategory(value as PerformanceCategory)}>
                      <SelectTrigger className="w-full sm:w-64">
                        <SelectValue placeholder="Select performance category" />
                      </SelectTrigger>
                      <SelectContent>
                        {Object.entries(performanceCategories).map(([key, category]) => (
                          <SelectItem key={key} value={key}>
                            <div className="flex flex-col">
                              <span className="font-medium">{category.name}</span>
                              <span className="text-xs text-slate-500">{category.description}</span>
                            </div>
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    {performanceCategory !== "all" && (
                      <Badge variant="secondary" className="ml-2">
                        {performanceCategories[performanceCategory].name}
                      </Badge>
                    )}
                  </div>

                  {/* Budget Controls */}
                  <div className="flex flex-col sm:flex-row sm:items-center gap-4 p-4 bg-slate-50 dark:bg-slate-800 rounded-lg">
                    <div className="flex items-center gap-2">
                      <input
                        type="checkbox"
                        id="budget-enabled"
                        checked={budgetEnabled}
                        onChange={(e) => setBudgetEnabled(e.target.checked)}
                        className="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                      />
                      <Label htmlFor="budget-enabled" className="text-sm font-medium">
                        Set Budget:
                      </Label>
                    </div>
                    {budgetEnabled && (
                      <>
                        <div className="flex items-center gap-2">
                          <span className="text-sm text-slate-600 dark:text-slate-400">₱</span>
                          <Input
                            type="number"
                            value={budget}
                            onChange={(e) => setBudget(Number(e.target.value))}
                            placeholder="Min ₱10,000 for CSP"
                            className="w-full sm:w-32"
                            min="10000"
                            step="1000"
                          />
                        </div>
                        <div className="flex flex-col sm:flex-row sm:items-center gap-2 text-sm">
                          <span className={`font-medium ${isOverBudget ? 'text-red-600' : 'text-slate-600 dark:text-slate-400'}`}>
                            Spent: {formatCurrency(totalPrice)}
                          </span>
                          <span className="hidden sm:inline text-slate-400">|</span>
                          <span className={`font-medium ${isOverBudget ? 'text-red-600' : 'text-green-600'}`}>
                            {isOverBudget ? `Over by ${formatCurrency(Math.abs(remainingBudget))}` : `Remaining: ${formatCurrency(remainingBudget)}`}
                          </span>
                        </div>
                        <div className="flex-1 w-full sm:w-auto">
                          <div className="w-full bg-slate-200 dark:bg-slate-700 rounded-full h-2">
                            <div
                              className={`h-2 rounded-full transition-all duration-300 ${
                                isOverBudget ? 'bg-red-500' : budgetPercentage > 80 ? 'bg-yellow-500' : 'bg-green-500'
                              }`}
                              style={{ width: `${Math.min(budgetPercentage, 100)}%` }}
                            />
                          </div>
                        </div>
                      </>
                    )}
                  </div>

                  {/* Algorithm Buttons */}
                  <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-2 pt-2 border-t border-slate-200 dark:border-slate-700">
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={handleGetCSPRecommendations}
                      disabled={!budgetEnabled || budget < 10000 || isLoadingCSP}
                      className="flex items-center justify-center gap-2 w-full sm:w-auto"
                      title={budgetEnabled && budget < 10000 ? "CSP requires minimum budget of ₱10,000" : ""}
                    >
                      {isLoadingCSP ? (
                        <>
                          <Loader2 className="h-4 w-4 animate-spin" />
                          <span className="hidden sm:inline">Finding solutions... (may take up to 5 min)</span>
                          <span className="sm:hidden">Finding solutions...</span>
                        </>
                      ) : (
                        <>
                          <CheckCircle2 className="h-4 w-4" />
                          <span className="hidden sm:inline">CSP Recommendation Checker</span>
                          <span className="sm:hidden">CSP Checker</span>
                        </>
                      )}
                    </Button>
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={handleGetUpgradeRecommendations}
                      disabled={Object.values(selectedComponents).filter(Boolean).length === 0 || isLoadingUpgrades}
                      className="flex items-center justify-center gap-2 w-full sm:w-auto"
                    >
                      {isLoadingUpgrades ? (
                        <>
                          <Loader2 className="h-4 w-4 animate-spin" />
                          Loading...
                        </>
                      ) : (
                        <>
                          <span className="hidden sm:inline">Get Upgrade Suggestions</span>
                          <span className="sm:hidden">Upgrade Suggestions</span>
                        </>
                      )}
                    </Button>
                  </div>
                  {algorithmError && (
                    <div className="p-3 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-lg">
                      <p className="text-sm text-red-800 dark:text-red-200">{algorithmError}</p>
                    </div>
                  )}
                </div>
              </CardHeader>
              <CardContent>
                <Tabs value={activeCategory} onValueChange={(value) => setActiveCategory(value as ComponentCategory)}>
                  <TabsList className="grid grid-cols-4 lg:grid-cols-8 mb-6 gap-1">
                    {Object.entries(categoryIcons).map(([category, Icon]) => (
                      <TabsTrigger key={category} value={category} className="p-2 text-xs">
                        <span className="text-[10px] sm:text-xs">{categoryNames[category as ComponentCategory]}</span>
                      </TabsTrigger>
                    ))}
                  </TabsList>

                  {Object.keys(categoryIcons).map((category) => {
                    const filteredComponents = getFilteredComponents(category as ComponentCategory)
                    return (
                      <TabsContent key={category} value={category} className="space-y-4">
                        {filteredComponents.length === 0 ? (
                          <div className="text-center py-8 text-slate-500 dark:text-slate-400">
                            <div className="flex flex-col items-center gap-2">
                              <Search className="h-8 w-8 text-slate-300" />
                              <p className="text-sm">
                                No {categoryNames[category as ComponentCategory].toLowerCase()} components found
                              </p>
                              <p className="text-xs">
                                {performanceCategory !== "all"
                                  ? `for ${performanceCategories[performanceCategory].name} performance category`
                                  : "matching your search criteria"}
                              </p>
                            </div>
                          </div>
                        ) : (
                          <div className="grid gap-4">
                            {filteredComponents.map((component) => (
                              <Card
                                key={component.id}
                                className={`border-slate-200 dark:border-slate-700 cursor-pointer transition-all hover:shadow-md ${
                                  selectedComponents[component.category]?.id === component.id
                                    ? "ring-2 ring-blue-500 border-blue-500"
                                    : ""
                                }`}
                                onClick={() => handleComponentSelect(component)}
                              >
                                <CardContent className="p-3 sm:p-4">
                                  <div className="flex items-start gap-3 sm:gap-4">
                                    <img
                                      src={component.image || "/placeholder.svg"}
                                      alt={component.name}
                                      className="w-12 h-12 sm:w-16 sm:h-16 object-cover rounded-lg bg-slate-100 dark:bg-slate-800 flex-shrink-0"
                                    />
                                    <div className="flex-1 min-w-0">
                                      <div className="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-2">
                                        <div>
                                          <div className="flex items-start gap-2 mb-1">
                                          <h3 className="font-semibold text-slate-900 dark:text-white">{component.name}</h3>
                                            <AvailabilityBadge status={component.availabilityStatus} className="text-xs" />
                                          </div>
                                          <p className="text-sm text-slate-600 dark:text-slate-400 mb-2">{component.brand}</p>
                                          {component.retailer && (
                                            <p className="text-xs text-slate-500 dark:text-slate-400">
                                              {component.retailer.name}
                                              {component.retailer.address && ` • ${component.retailer.address.split(',')[0]}`}
                                            </p>
                                          )}
                                        </div>
                                        <div className="text-right">
                                          <div className="flex items-center gap-2">
                                            <p className="text-lg font-bold text-slate-900 dark:text-white">
                                              {formatCurrency(component.price)}
                                            </p>
                                            {budgetEnabled && component.price > (budget - totalPrice + (selectedComponents[component.category]?.price || 0)) && (
                                              <Badge variant="destructive" className="text-xs">
                                                Over Budget
                                              </Badge>
                                            )}
                                          </div>
                                          {selectedComponents[component.category]?.id === component.id && (
                                            <Badge className="mt-1">Selected</Badge>
                                          )}
                                        </div>
                                      </div>

                                      {/* Component specifications */}
                                      <div className="grid grid-cols-1 sm:grid-cols-2 gap-2 text-xs text-slate-600 dark:text-slate-400">
                                        {Object.entries(component.specifications || {})
                                          .filter(([key]) => key !== 'Compatibility') // Exclude Compatibility description
                                          .slice(0, 4)
                                          .map(([key, value]) => (
                                            <div key={key} className="truncate">
                                              <span className="font-medium">{key}:</span> <span className="truncate">{String(value)}</span>
                                            </div>
                                          ))}
                                      </div>
                                    </div>
                                  </div>
                                </CardContent>
                              </Card>
                            ))}
                          </div>
                        )}
                      </TabsContent>

                    )
                  })}
                </Tabs>
              </CardContent>
            </Card>
          </div>

          {/* Build Summary */}
          <div className="space-y-6">
            <Card className="border-slate-200 dark:border-slate-700">
              <CardHeader className="pb-3">
                <CardTitle className="text-lg flex items-center gap-2">
                  {compatibilityResult.isCompatible ? (
                    <CheckCircle className="h-5 w-5 text-green-600" />
                  ) : (
                    <AlertTriangle className="h-5 w-5 text-red-600" />
                  )}
                  Compatibility
                  <Badge
                    variant={
                      compatibilityResult.score >= 80
                        ? "default"
                        : compatibilityResult.score >= 60
                          ? "secondary"
                          : "destructive"
                    }
                  >
                    {compatibilityResult.score}%
                  </Badge>
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                {compatibilityResult.issues.length === 0 ? (
                  <p className="text-sm text-green-600">No compatibility issues detected</p>
                ) : (
                  <div className="space-y-2">
                    {compatibilityResult.issues.slice(0, 3).map((issue, index) => (
                      <div key={index} className="flex items-start gap-2">
                        {issue.type === "error" && (
                          <AlertTriangle className="h-4 w-4 text-red-500 mt-0.5 flex-shrink-0" />
                        )}
                        {issue.type === "warning" && (
                          <AlertCircle className="h-4 w-4 text-yellow-500 mt-0.5 flex-shrink-0" />
                        )}
                        {issue.type === "info" && <Info className="h-4 w-4 text-blue-500 mt-0.5 flex-shrink-0" />}
                        <div>
                          <p
                            className={`text-xs font-medium ${
                              issue.type === "error"
                                ? "text-red-600"
                                : issue.type === "warning"
                                  ? "text-yellow-600"
                                  : "text-blue-600"
                            }`}
                          >
                            {issue.message}
                          </p>
                          {issue.suggestion && <p className="text-xs text-slate-500 mt-1">{issue.suggestion}</p>}
                        </div>
                      </div>
                    ))}
                    {compatibilityResult.issues.length > 3 && (
                      <p className="text-xs text-slate-500">+{compatibilityResult.issues.length - 3} more issues</p>
                    )}
                  </div>
                )}
              </CardContent>
            </Card>

            {recommendations.length > 0 && (
              <Card className="border-slate-200 dark:border-slate-700">
                <CardHeader className="pb-3">
                  <CardTitle className="text-lg">
                    Recommendations
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-2">
                    {recommendations.slice(0, 3).map((recommendation, index) => (
                      <div key={index} className="flex items-start gap-2">
                        <div className="w-1.5 h-1.5 bg-blue-500 rounded-full mt-2 flex-shrink-0" />
                        <p className="text-sm text-slate-600 dark:text-slate-400">{recommendation}</p>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            )}

            {/* Performance Category Info */}
            {performanceCategory !== "all" && (
              <Card className="border-slate-200 dark:border-slate-700">
                <CardHeader className="pb-3">
                  <CardTitle className="text-lg">
                    Performance Category
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-2">
                    <div className="flex items-center gap-2">
                      <Badge variant="secondary">{performanceCategories[performanceCategory].name}</Badge>
                    </div>
                    <p className="text-sm text-slate-600 dark:text-slate-400">
                      {performanceCategories[performanceCategory].description}
                    </p>
                    <div className="text-xs text-slate-500">
                      Components are filtered to match your selected performance requirements
                    </div>
                  </div>
                </CardContent>
              </Card>
            )}

            {/* Build Summary */}
            <Card className="border-slate-200 dark:border-slate-700">
              <CardHeader>
                <CardTitle className="text-lg">Your Build</CardTitle>
                <CardDescription>Selected components</CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                {Object.entries(selectedComponents).map(([category, component]) => {
                  const Icon = categoryIcons[category as ComponentCategory]
                  return (
                    <div key={category} className="flex items-center justify-between">
                      <div className="flex items-center gap-3">
                        <div>
                          <p className="text-sm font-medium text-slate-900 dark:text-white">
                            {categoryNames[category as ComponentCategory]}
                          </p>
                          {component ? (
                            <p className="text-xs text-slate-600 dark:text-slate-400">{component.name}</p>
                          ) : (
                            <p className="text-xs text-slate-400">Not selected</p>
                          )}
                        </div>
                      </div>
                      <div className="text-right">
                        {component ? (
                          <div>
                            <p className="text-sm font-medium">{formatCurrency(component.price)}</p>
                            <Button
                              variant="ghost"
                              size="sm"
                              onClick={() => handleComponentRemove(category as ComponentCategory)}
                              className="text-xs text-red-600 hover:text-red-700 p-0 h-auto"
                            >
                              Remove
                            </Button>
                          </div>
                        ) : (
                          <p className="text-sm text-slate-400">{formatCurrency(0)}</p>
                        )}
                      </div>
                    </div>
                  )
                })}

                <div className="border-t pt-4">
                  <div className="flex items-center justify-between">
                    <p className="font-semibold text-slate-900 dark:text-white">Total Price</p>
                    <div className="text-right">
                      <p className={`text-xl font-bold ${isOverBudget ? 'text-red-600' : 'text-blue-600'}`}>
                        {formatCurrency(totalPrice)}
                      </p>
                      {budgetEnabled && budget > 0 && (
                        <p className={`text-sm ${isOverBudget ? 'text-red-500' : 'text-green-600'}`}>
                          {isOverBudget 
                            ? `Over budget by ${formatCurrency(Math.abs(remainingBudget))}`
                            : `Within budget (${Math.round(100 - budgetPercentage)}% remaining)`
                          }
                        </p>
                      )}
                    </div>
                  </div>
                  {budgetEnabled && budget > 0 && (
                    <div className="mt-2">
                      <div className="flex justify-between text-sm text-slate-600 dark:text-slate-400 mb-1">
                        <span>Budget Progress</span>
                        <span>{Math.round(budgetPercentage)}%</span>
                      </div>
                      <div className="w-full bg-slate-200 dark:bg-slate-700 rounded-full h-2">
                        <div
                          className={`h-2 rounded-full transition-all duration-300 ${
                            isOverBudget ? 'bg-red-500' : budgetPercentage > 80 ? 'bg-yellow-500' : 'bg-green-500'
                          }`}
                          style={{ width: `${Math.min(budgetPercentage, 100)}%` }}
                        />
                      </div>
                    </div>
                  )}
                </div>

                <div className="space-y-2">
                  <Button 
                    className="w-full bg-blue-600 hover:bg-blue-700" 
                    onClick={() => setIsSaveDialogOpen(true)}
                    disabled={isCheckingDuplicates}
                  >
                    {isCheckingDuplicates ? "Checking..." : "Save Build"}
                  </Button>
                  <Button variant="outline" className="w-full bg-transparent">
                    Share Build
                  </Button>
                </div>
              </CardContent>
            </Card>

            <Card className="border-slate-200 dark:border-slate-700">
              <CardHeader>
                <CardTitle className="text-lg">Build Stats</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Components</span>
                  <span className="font-medium">{Object.values(selectedComponents).filter(Boolean).length}/8</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Power Draw</span>
                  <span className="font-medium">{compatibilityResult.powerRequirement}W</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Recommended PSU</span>
                  <span className="font-medium">{Math.ceil(compatibilityResult.powerRequirement * 1.2)}W+</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Completion</span>
                  <span className="font-medium">
                    {Math.round((Object.values(selectedComponents).filter(Boolean).length / 8) * 100)}%
                  </span>
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>

      {/* Duplicate Check Dialog */}
      <DuplicateCheckDialog
        open={showDuplicateDialog}
        onOpenChange={setShowDuplicateDialog}
        comparisons={duplicateComparisons}
        onViewSimilar={handleViewSimilar}
        onEditSimilar={handleEditSimilar}
        onProceedAnyway={handleProceedAnyway}
        onModifyBuild={handleModifyBuild}
      />

      {/* CSP Recommendation Checker Dialog */}
      <Dialog open={isCSPDialogOpen} onOpenChange={setIsCSPDialogOpen}>
        <DialogContent className="max-w-4xl max-h-[80vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2">
              <CheckCircle2 className="h-5 w-5 text-blue-600" />
              CSP Recommendation Checker
            </DialogTitle>
            <DialogDescription>
              Compatible component combinations that fit your budget using Constraint Satisfaction Problem algorithm
            </DialogDescription>
          </DialogHeader>
          {cspSolutions.length === 0 ? (
            <div className="text-center py-8">
              <p className="text-slate-600 dark:text-slate-400">No solutions found. Try adjusting your budget or selected components.</p>
            </div>
          ) : (
            <div className="space-y-4">
              {cspSolutions
                .slice(cspPage * SOLUTIONS_PER_PAGE, (cspPage + 1) * SOLUTIONS_PER_PAGE)
                .map((solution, index) => {
                  const solutionPrice = Object.values(solution).reduce((sum: number, comp: any) => sum + (comp.price || 0), 0)
                  return (
                    <Card key={index} className="border-slate-200 dark:border-slate-700">
                      <CardHeader>
                        <div className="flex items-center justify-between">
                          <CardTitle className="text-lg">Solution {cspPage * SOLUTIONS_PER_PAGE + index + 1}</CardTitle>
                          <Badge variant="secondary" className="text-lg font-semibold">
                            {formatCurrency(solutionPrice)}
                          </Badge>
                        </div>
                      </CardHeader>
                      <CardContent>
                        <div className="grid md:grid-cols-2 gap-3">
                          {Object.entries(solution).map(([category, comp]: [string, any]) => (
                            <div key={category} className="flex items-center gap-2 p-2 bg-slate-50 dark:bg-slate-800 rounded">
                              <Cpu className="h-4 w-4 text-blue-500" />
                              <div className="flex-1">
                                <p className="text-sm font-medium">{category}</p>
                                <p className="text-xs text-slate-600 dark:text-slate-400">{comp.name}</p>
                              </div>
                              <span className="text-sm font-semibold">{formatCurrency(comp.price)}</span>
                            </div>
                          ))}
                        </div>
                        <Button
                          className="w-full mt-4"
                          onClick={() => handleApplyCSPSolution(solution)}
                        >
                          Apply This Solution
                        </Button>
                      </CardContent>
                    </Card>
                  )
              })}

              {/* Pagination Controls */}
              <div className="flex justify-between mt-4">
                <Button
                  variant="outline"
                  onClick={() => setCspPage((prev) => Math.max(prev - 1, 0))}
                  disabled={cspPage === 0}
                >
                  Previous
                </Button>
                <Button
                  variant="outline"
                  onClick={() => setCspPage((prev) => (prev + 1) * SOLUTIONS_PER_PAGE < cspSolutions.length ? prev + 1 : prev)}
                  disabled={(cspPage + 1) * SOLUTIONS_PER_PAGE >= cspSolutions.length}
                >
                  Next
                </Button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* Upgrade Recommendations Dialog */}
      <Dialog open={showUpgradeDialog} onOpenChange={setShowUpgradeDialog}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>
              Upgrade Recommendations
            </DialogTitle>
            <DialogDescription>
              Suggested component upgrades for your current build
            </DialogDescription>
          </DialogHeader>
          {upgradeRecommendations.length === 0 ? (
            <div className="text-center py-8">
              <p className="text-slate-600 dark:text-slate-400">No upgrade recommendations available.</p>
            </div>
          ) : (
            <div className="space-y-3">
              {upgradeRecommendations.map((rec, index) => (
                <Card 
                  key={index} 
                  className={`border-slate-200 dark:border-slate-700 ${
                    rec.recommended_upgrade ? 'hover:border-green-500 hover:shadow-md transition-all cursor-pointer' : ''
                  }`}
                >
                  <CardContent className="p-4">
                    <div className="flex items-center justify-between">
                      <div className="flex-1">
                        <p className="text-sm font-medium text-slate-900 dark:text-white">
                          {rec.current_component}
                        </p>
                        {rec.recommended_upgrade ? (
                          <>
                            <div className="flex items-center gap-2 mt-1">
                              <span className="text-xs text-slate-500">→</span>
                              <p className="text-sm text-green-600 dark:text-green-400 font-medium">
                                {rec.recommended_upgrade}
                              </p>
                            </div>
                            {rec.new_price && (
                              <p className="text-xs text-slate-600 dark:text-slate-400 mt-1">
                                New price: {formatCurrency(rec.new_price)}
                              </p>
                            )}
                            {rec.upgrade_cost && (
                              <p className="text-xs text-blue-600 dark:text-blue-400 mt-1">
                                Upgrade cost: {formatCurrency(rec.upgrade_cost)}
                              </p>
                            )}
                          </>
                        ) : (
                          <p className="text-xs text-slate-500 mt-1">No upgrade available</p>
                        )}
                      </div>
                      {rec.recommended_upgrade && (
                        <Button
                          size="sm"
                          onClick={() => handleApplyUpgrade(index, rec.recommended_upgrade!)}
                          className="ml-4"
                        >
                          Apply
                        </Button>
                      )}
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </DialogContent>
      </Dialog>
    </div>
  )
}
