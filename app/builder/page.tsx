
"use client"

import * as React from "react"
import { useState } from "react"
import { useRouter } from "next/navigation"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
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
} from "lucide-react"
// Removed authentication - using mock user data
import { mockComponents, type Component, type ComponentCategory, type PerformanceCategory, performanceCategories } from "@/lib/mock-data"
import { CompatibilityChecker, type CompatibilityResult } from "@/lib/compatibility-checker"
import { filterComponentsByPerformance } from "@/lib/performance-filter"
import { DuplicateDetector, type BuildComparison } from "@/lib/duplicate-detector"
import { DuplicateCheckDialog } from "@/components/duplicate-warning"

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
  cpu: "Processor",
  motherboard: "Motherboard",
  memory: "Memory (RAM)",
  storage: "Storage",
  gpu: "Graphics Card",
  psu: "Power Supply",
  case: "Case",
  cooling: "Cooling",
}

export default function BuilderPage() {
  // Mock user data instead of authentication
  const user = { id: "1", username: "PC Builder", email: "builder@example.com" }
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
  const [activeCategory, setActiveCategory] = useState<ComponentCategory>("cpu")
  const [searchTerm, setSearchTerm] = useState("")
  const [buildName, setBuildName] = useState("My Custom Build")
  const [isSaveDialogOpen, setIsSaveDialogOpen] = useState(false)
  const [performanceCategory, setPerformanceCategory] = useState<PerformanceCategory>("all")
  const [budget, setBudget] = useState<number>(0)
  const [budgetEnabled, setBudgetEnabled] = useState(false)
  const [duplicateComparisons, setDuplicateComparisons] = useState<BuildComparison[]>([])
  const [showDuplicateDialog, setShowDuplicateDialog] = useState(false)
  const [isCheckingDuplicates, setIsCheckingDuplicates] = useState(false)

  // Filter components by category, search term, performance category, and budget
  const getFilteredComponents = (category: ComponentCategory) => {
    const categoryFiltered = mockComponents.filter((component) => component.category === category)
    
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

    // Apply budget filtering if enabled
    if (budgetEnabled && budget > 0) {
      const currentSpent = Object.values(selectedComponents)
        .filter(Boolean)
        .reduce((sum, component) => sum + component!.price, 0)
      
      const remainingBudget = budget - currentSpent
      
      return searchFiltered.filter((component) => {
        // If this component is already selected, always show it
        if (selectedComponents[category]?.id === component.id) {
          return true
        }
        // Otherwise, only show if it fits within remaining budget
        return component.price <= remainingBudget
      })
    }
    
    return searchFiltered
  }

  // Calculate total price
  const totalPrice = Object.values(selectedComponents)
    .filter(Boolean)
    .reduce((sum, component) => sum + component!.price, 0)

  // Calculate remaining budget
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

  const checkForDuplicates = async () => {
    if (!user) return

    setIsCheckingDuplicates(true)
    
    try {
      // Generate fingerprint for current build
      const currentBuildFingerprint = DuplicateDetector.generateFingerprint(selectedComponents)
      
      // In a real app, this would fetch existing builds from the database
      // For now, we'll simulate with mock data
      const mockExistingBuilds = [
        {
          components: { cpu: "cpu-1", motherboard: "mobo-1", memory: "ram-1", storage: "ssd-1", gpu: "gpu-1", psu: "psu-1", case: "case-1", cooling: "cooling-1" },
          totalPrice: 1200,
          componentCount: 8,
          priceRange: 'mid' as const,
          performanceCategory: 'gaming'
        },
        {
          components: { cpu: "cpu-2", motherboard: "mobo-2", memory: "ram-2", storage: "ssd-2", gpu: "gpu-2", psu: "psu-2", case: "case-2", cooling: "cooling-2" },
          totalPrice: 800,
          componentCount: 6,
          priceRange: 'budget' as const,
          performanceCategory: 'office'
        }
      ]

      // Check for duplicates
      const comparisons = DuplicateDetector.checkForDuplicates(currentBuildFingerprint, mockExistingBuilds)
      
      if (comparisons.length > 0) {
        setDuplicateComparisons(comparisons)
        setShowDuplicateDialog(true)
        return false // Don't proceed with save
      }
      
      return true // No duplicates found, proceed with save
    } catch (error) {
      console.error("Error checking for duplicates:", error)
      return true // Proceed anyway if there's an error
    } finally {
      setIsCheckingDuplicates(false)
    }
  }

  const handleSaveBuild = async () => {
    if (!user) {
      router.push("/login")
      return
    }

    // Check for duplicates first
    const canProceed = await checkForDuplicates()
    if (!canProceed) {
      return // Duplicate dialog will be shown
    }

    // In a real app, this would save to the backend
    console.log("Saving build:", { name: buildName, components: selectedComponents, totalPrice })
    setIsSaveDialogOpen(false)
    // Show success message or redirect
  }

  const handleProceedAnyway = () => {
    // In a real app, this would save to the backend
    console.log("Saving build despite duplicates:", { name: buildName, components: selectedComponents, totalPrice })
    setIsSaveDialogOpen(false)
    setShowDuplicateDialog(false)
    // Show success message or redirect
  }

  const handleModifyBuild = () => {
    // Reset some components to make the build more unique
    setSelectedComponents(prev => ({
      ...prev,
      cooling: null // Remove cooling to make it different
    }))
    setShowDuplicateDialog(false)
  }

  const handleViewSimilar = (buildId: string) => {
    // Navigate to similar build
    console.log("Viewing similar build:", buildId)
  }

  const handleEditSimilar = (buildId: string) => {
    // Navigate to edit similar build
    console.log("Editing similar build:", buildId)
  }

  const compatibilityResult = getCompatibilityResult()
  const recommendations = new CompatibilityChecker(selectedComponents).getRecommendations()

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      {/* Header */}
      <header className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <Button variant="ghost" size="sm" asChild>
                <Link href={user ? "/dashboard" : "/"}>
                  <ArrowLeft className="h-4 w-4 mr-2" />
                  Back
                </Link>
              </Button>
              <div className="flex items-center gap-2">
                <Cpu className="h-6 w-6 text-blue-600" />
                <h1 className="text-xl font-bold text-slate-900 dark:text-white">PC Builder</h1>
              </div>
            </div>
            <div className="flex items-center gap-2">
              <Button variant="outline" size="sm" asChild>
                <Link href="/support">
                  <MessageSquare className="h-4 w-4 mr-2" />
                  Get Help
                </Link>
              </Button>
              <Dialog open={isSaveDialogOpen} onOpenChange={setIsSaveDialogOpen}>
                <DialogTrigger asChild>
                  <Button variant="outline" size="sm">
                    <Save className="h-4 w-4 mr-2" />
                    Save Build
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
                    <div className="flex justify-end gap-2">
                      <Button variant="outline" onClick={() => setIsSaveDialogOpen(false)}>
                        Cancel
                      </Button>
                      <Button onClick={handleSaveBuild}>Save Build</Button>
                    </div>
                  </div>
                </DialogContent>
              </Dialog>
              <Button variant="outline" size="sm">
                <Share className="h-4 w-4 mr-2" />
                Share
              </Button>
            </div>
          </div>
        </div>
      </header>

      <div className="container mx-auto px-4 py-6">
        <div className="grid lg:grid-cols-3 gap-6">
          {/* Component Selection */}
          <div className="lg:col-span-2">
            <Card className="border-slate-200 dark:border-slate-700">
              <CardHeader>
                <div className="space-y-4">
                  <div className="flex items-center justify-between">
                    <CardTitle>Select Components</CardTitle>
                    <div className="flex items-center gap-2">
                      <Search className="h-4 w-4 text-slate-400" />
                      <Input
                        placeholder="Search components..."
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                        className="w-64"
                      />
                    </div>
                  </div>
                  
                  {/* Performance Category Selector */}
                  <div className="flex items-center gap-4">
                    <Label htmlFor="performance-category" className="text-sm font-medium">
                      Performance Category:
                    </Label>
                    <Select value={performanceCategory} onValueChange={(value) => setPerformanceCategory(value as PerformanceCategory)}>
                      <SelectTrigger className="w-64">
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
                  <div className="flex items-center gap-4 p-4 bg-slate-50 dark:bg-slate-800 rounded-lg">
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
                          <span className="text-sm text-slate-600 dark:text-slate-400">$</span>
                          <Input
                            type="number"
                            value={budget}
                            onChange={(e) => setBudget(Number(e.target.value))}
                            placeholder="Enter budget"
                            className="w-32"
                            min="0"
                            step="50"
                          />
                        </div>
                        <div className="flex items-center gap-2 text-sm">
                          <span className={`font-medium ${isOverBudget ? 'text-red-600' : 'text-slate-600 dark:text-slate-400'}`}>
                            Spent: ${totalPrice.toLocaleString()}
                          </span>
                          <span className="text-slate-400">|</span>
                          <span className={`font-medium ${isOverBudget ? 'text-red-600' : 'text-green-600'}`}>
                            {isOverBudget ? `Over by $${Math.abs(remainingBudget).toLocaleString()}` : `Remaining: $${remainingBudget.toLocaleString()}`}
                          </span>
                        </div>
                        <div className="flex-1">
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
                </div>
              </CardHeader>
              <CardContent>
                <Tabs value={activeCategory} onValueChange={(value) => setActiveCategory(value as ComponentCategory)}>
                  <TabsList className="grid grid-cols-4 lg:grid-cols-8 mb-6">
                    {Object.entries(categoryIcons).map(([category, Icon]) => (
                      <TabsTrigger key={category} value={category} className="flex flex-col gap-1 p-2">
                        <Icon className="h-4 w-4" />
                        <span className="text-xs hidden sm:block">{categoryNames[category as ComponentCategory]}</span>
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
                                  : "matching your search criteria"
                                }
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
                            <CardContent className="p-4">
                              <div className="flex items-start gap-4">
                                <img
                                  src={component.image || "/placeholder.svg"}
                                  alt={component.name}
                                  className="w-16 h-16 object-cover rounded-lg bg-slate-100 dark:bg-slate-800"
                                />
                                <div className="flex-1">
                                  <div className="flex items-start justify-between">
                                    <div>
                                      <h3 className="font-semibold text-slate-900 dark:text-white">{component.name}</h3>
                                      <p className="text-sm text-slate-600 dark:text-slate-400 mb-2">
                                        {component.brand}
                                      </p>
                                      <div className="flex items-center gap-2 mb-2">
                                        <div className="flex items-center">
                                          {[...Array(5)].map((_, i) => (
                                            <div
                                              key={i}
                                              className={`w-3 h-3 ${
                                                i < Math.floor(component.rating) ? "text-yellow-400" : "text-slate-300"
                                              }`}
                                            >
                                              ★
                                            </div>
                                          ))}
                                        </div>
                                        <span className="text-xs text-slate-500">({component.reviews} reviews)</span>
                                      </div>
                                    </div>
                                    <div className="text-right">
                                      <div className="flex items-center gap-2">
                                        <p className={`text-lg font-bold ${
                                          budgetEnabled && budget > 0 && component.price > (budget - totalPrice + (selectedComponents[component.category]?.price || 0))
                                            ? 'text-red-600'
                                            : 'text-slate-900 dark:text-white'
                                        }`}>
                                          ${component.price}
                                        </p>
                                        {budgetEnabled && budget > 0 && component.price > (budget - totalPrice + (selectedComponents[component.category]?.price || 0)) && (
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
                                  <div className="grid grid-cols-2 gap-2 text-xs text-slate-600 dark:text-slate-400">
                                    {Object.entries(component.specifications)
                                      .slice(0, 4)
                                      .map(([key, value]) => (
                                        <div key={key}>
                                          <span className="font-medium">{key}:</span> {value}
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
                  <CardTitle className="text-lg flex items-center gap-2">
                    <Lightbulb className="h-5 w-5 text-yellow-500" />
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
                  <CardTitle className="text-lg flex items-center gap-2">
                    <Lightbulb className="h-5 w-5 text-blue-500" />
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
                        <Icon className="h-4 w-4 text-slate-500" />
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
                            <p className="text-sm font-medium">${component.price}</p>
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
                          <p className="text-sm text-slate-400">$0</p>
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
                        ${totalPrice.toLocaleString()}
                      </p>
                      {budgetEnabled && budget > 0 && (
                        <p className={`text-sm ${isOverBudget ? 'text-red-500' : 'text-green-600'}`}>
                          {isOverBudget 
                            ? `Over budget by $${Math.abs(remainingBudget).toLocaleString()}`
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
                    <Save className="h-4 w-4 mr-2" />
                    {isCheckingDuplicates ? "Checking..." : "Save Build"}
                  </Button>
                  <Button variant="outline" className="w-full bg-transparent">
                    <Share className="h-4 w-4 mr-2" />
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
    </div>
  )
}
