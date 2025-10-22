"use client"

import { useState, useEffect } from "react"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Alert, AlertDescription } from "@/components/ui/alert"
import {
  Cpu,
  ArrowLeft,
  Search,
  Plus,
  X,
  TrendingUp,
  TrendingDown,
  Minus,
  Equal,
  BarChart3,
  DollarSign,
  Zap,
  Monitor,
  HardDrive,
  MemoryStick,
  Fan,
  Clapperboard as Motherboard,
  Settings,
  Star,
  Eye,
  Heart,
  Share,
  AlertTriangle,
  CheckCircle,
  Info,
} from "lucide-react"
import { mockBuilds, mockComponents, type Build, type Component } from "@/lib/mock-data"

const categoryIcons = {
  cpu: Cpu,
  motherboard: Motherboard,
  memory: MemoryStick,
  storage: HardDrive,
  gpu: Monitor,
  psu: Zap,
  case: Settings,
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

interface ComparisonBuild extends Build {
  components: Record<string, Component | null>
}

export default function ComparePage() {
  const [selectedBuilds, setSelectedBuilds] = useState<ComparisonBuild[]>([])
  const [searchTerm, setSearchTerm] = useState("")
  const [filteredBuilds, setFilteredBuilds] = useState<Build[]>([])
  const [activeTab, setActiveTab] = useState("overview")

  // Mock current user build (in real app, this would come from user's saved builds)
  const currentUserBuild: ComparisonBuild = {
    id: "user-build",
    name: "My Current Build",
    description: "My personal PC build",
    totalPrice: 1250,
    tags: ["gaming", "budget"],
    likes: 0,
    createdAt: new Date(),
    createdBy: "1",
    components: {
      cpu: mockComponents.find(c => c.id === "cpu-1") || null,
      motherboard: mockComponents.find(c => c.id === "motherboard-1") || null,
      memory: mockComponents.find(c => c.id === "memory-1") || null,
      storage: mockComponents.find(c => c.id === "storage-1") || null,
      gpu: mockComponents.find(c => c.id === "gpu-1") || null,
      psu: mockComponents.find(c => c.id === "psu-1") || null,
      case: mockComponents.find(c => c.id === "case-1") || null,
      cooling: mockComponents.find(c => c.id === "cooling-1") || null,
    }
  }

  useEffect(() => {
    // Filter builds based on search term
    const filtered = mockBuilds.filter(build =>
      build.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      build.description.toLowerCase().includes(searchTerm.toLowerCase()) ||
      build.tags.some(tag => tag.toLowerCase().includes(searchTerm.toLowerCase()))
    )
    setFilteredBuilds(filtered)
  }, [searchTerm])

  const addBuildToComparison = (build: Build) => {
    if (selectedBuilds.length >= 3) {
      alert("You can compare up to 3 builds at once")
      return
    }

    if (selectedBuilds.some(b => b.id === build.id)) {
      alert("This build is already in the comparison")
      return
    }

    // Convert build to comparison build with mock components
    const comparisonBuild: ComparisonBuild = {
      ...build,
      components: {
        cpu: mockComponents.find(c => c.category === "cpu" && Math.random() > 0.5) || null,
        motherboard: mockComponents.find(c => c.category === "motherboard" && Math.random() > 0.5) || null,
        memory: mockComponents.find(c => c.category === "memory" && Math.random() > 0.5) || null,
        storage: mockComponents.find(c => c.category === "storage" && Math.random() > 0.5) || null,
        gpu: mockComponents.find(c => c.category === "gpu" && Math.random() > 0.5) || null,
        psu: mockComponents.find(c => c.category === "psu" && Math.random() > 0.5) || null,
        case: mockComponents.find(c => c.category === "case" && Math.random() > 0.5) || null,
        cooling: mockComponents.find(c => c.category === "cooling" && Math.random() > 0.5) || null,
      }
    }

    setSelectedBuilds([...selectedBuilds, comparisonBuild])
  }

  const removeBuildFromComparison = (buildId: string) => {
    setSelectedBuilds(selectedBuilds.filter(build => build.id !== buildId))
  }

  const getComparisonValue = (builds: ComparisonBuild[], category: string, spec: string) => {
    return builds.map(build => {
      const component = build.components[category]
      if (!component) return null
      return component.specifications[spec] || "N/A"
    })
  }

  const getPriceComparison = (builds: ComparisonBuild[]) => {
    const prices = builds.map(build => build.totalPrice)
    const min = Math.min(...prices)
    const max = Math.max(...prices)
    const avg = prices.reduce((sum, price) => sum + price, 0) / prices.length

    return { min, max, avg, prices }
  }

  const getPerformanceScore = (build: ComparisonBuild) => {
    // Mock performance calculation based on components
    let score = 0
    Object.values(build.components).forEach(component => {
      if (component) {
        score += component.rating * 20 // Convert 5-star rating to 100-point scale
      }
    })
    return Math.round(score / Object.keys(build.components).length)
  }

  const getValueScore = (build: ComparisonBuild) => {
    const performanceScore = getPerformanceScore(build)
    const pricePerPerformance = build.totalPrice / performanceScore
    return Math.round(100 - (pricePerPerformance / 20)) // Higher score = better value
  }

  const allBuilds = [currentUserBuild, ...selectedBuilds]

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      {/* Header */}
      <header className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <Link href="/" className="flex items-center gap-2">
                <Cpu className="h-8 w-8 text-blue-600" />
                <h1 className="text-2xl font-bold text-slate-900 dark:text-white">BuildMate</h1>
              </Link>
              <div className="h-8 w-px bg-slate-300 dark:bg-slate-600" />
              <h2 className="text-xl font-semibold text-slate-700 dark:text-slate-300">Build Comparison</h2>
            </div>
            <div className="flex items-center gap-2">
              <Link href="/builds">
                <Button variant="outline" size="sm">
                  <ArrowLeft className="h-4 w-4 mr-2" />
                  Back to Builds
                </Button>
              </Link>
              <Link href="/builder">
                <Button size="sm">
                  <Plus className="h-4 w-4 mr-2" />
                  New Build
                </Button>
              </Link>
            </div>
          </div>
        </div>
      </header>

      <div className="container mx-auto px-4 py-8">
        {allBuilds.length === 1 ? (
          // Build Selection View
          <div className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Select Builds to Compare</CardTitle>
                <CardDescription>
                  Choose up to 3 builds to compare with your current build
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  <div className="flex items-center gap-4">
                    <Search className="h-4 w-4 text-slate-400" />
                    <Input
                      placeholder="Search builds..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="flex-1"
                    />
                  </div>

                  <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
                    {filteredBuilds.map((build) => (
                      <Card key={build.id} className="border-slate-200 dark:border-slate-700 hover:shadow-md transition-shadow">
                        <CardContent className="p-4">
                          <div className="flex items-start justify-between mb-3">
                            <div>
                              <h3 className="font-semibold text-slate-900 dark:text-white">{build.name}</h3>
                              <p className="text-sm text-slate-600 dark:text-slate-400">{build.description}</p>
                            </div>
                            <Badge variant="secondary">${build.totalPrice.toLocaleString()}</Badge>
                          </div>

                          <div className="flex flex-wrap gap-1 mb-3">
                            {build.tags.map((tag) => (
                              <Badge key={tag} variant="outline" className="text-xs">
                                {tag}
                              </Badge>
                            ))}
                          </div>

                          <div className="flex items-center justify-between text-sm text-slate-600 dark:text-slate-400 mb-3">
                            <div className="flex items-center gap-1">
                              <Heart className="h-4 w-4" />
                              {build.likes}
                            </div>
                            <div className="flex items-center gap-1">
                              <Eye className="h-4 w-4" />
                              1.2k
                            </div>
                          </div>

                          <Button
                            size="sm"
                            className="w-full"
                            onClick={() => addBuildToComparison(build)}
                          >
                            <Plus className="h-4 w-4 mr-2" />
                            Add to Comparison
                          </Button>
                        </CardContent>
                      </Card>
                    ))}
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        ) : (
          // Comparison View
          <div className="space-y-6">
            {/* Build Selection Header */}
            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <div>
                    <CardTitle>Comparing {allBuilds.length} Builds</CardTitle>
                    <CardDescription>Analyze differences in specs, performance, and cost</CardDescription>
                  </div>
                  <div className="flex items-center gap-2">
                    <Button variant="outline" size="sm" onClick={() => setSelectedBuilds([])}>
                      <X className="h-4 w-4 mr-2" />
                      Clear All
                    </Button>
                    <Button size="sm" onClick={() => setSelectedBuilds([])}>
                      <Plus className="h-4 w-4 mr-2" />
                      Add More
                    </Button>
                  </div>
                </div>
              </CardHeader>
              <CardContent>
                <div className="flex flex-wrap gap-2">
                  {allBuilds.map((build, index) => (
                    <div key={build.id} className="flex items-center gap-2 bg-slate-100 dark:bg-slate-800 rounded-lg px-3 py-2">
                      <Badge variant={index === 0 ? "default" : "secondary"}>
                        {index === 0 ? "Your Build" : `Build ${index}`}
                      </Badge>
                      <span className="font-medium">{build.name}</span>
                      {index > 0 && (
                        <Button
                          size="sm"
                          variant="ghost"
                          onClick={() => removeBuildFromComparison(build.id)}
                          className="h-6 w-6 p-0"
                        >
                          <X className="h-3 w-3" />
                        </Button>
                      )}
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>

            <Tabs value={activeTab} onValueChange={setActiveTab}>
              <TabsList className="grid w-full grid-cols-4">
                <TabsTrigger value="overview">Overview</TabsTrigger>
                <TabsTrigger value="components">Components</TabsTrigger>
                <TabsTrigger value="performance">Performance</TabsTrigger>
                <TabsTrigger value="value">Value Analysis</TabsTrigger>
              </TabsList>

              {/* Overview Tab */}
              <TabsContent value="overview" className="space-y-6">
                <div className="grid lg:grid-cols-3 gap-6">
                  {allBuilds.map((build, index) => (
                    <Card key={build.id} className="border-slate-200 dark:border-slate-700">
                      <CardHeader>
                        <div className="flex items-center justify-between">
                          <CardTitle className="text-lg">{build.name}</CardTitle>
                          <Badge variant={index === 0 ? "default" : "secondary"}>
                            {index === 0 ? "Your Build" : `Build ${index}`}
                          </Badge>
                        </div>
                        <CardDescription>{build.description}</CardDescription>
                      </CardHeader>
                      <CardContent className="space-y-4">
                        <div className="flex items-center justify-between">
                          <span className="text-sm text-slate-600 dark:text-slate-400">Total Price</span>
                          <span className="text-xl font-bold text-blue-600">${build.totalPrice.toLocaleString()}</span>
                        </div>

                        <div className="flex items-center justify-between">
                          <span className="text-sm text-slate-600 dark:text-slate-400">Performance Score</span>
                          <div className="flex items-center gap-2">
                            <span className="font-medium">{getPerformanceScore(build)}/100</span>
                            <div className="w-20 bg-slate-200 dark:bg-slate-700 rounded-full h-2">
                              <div
                                className="bg-blue-600 h-2 rounded-full"
                                style={{ width: `${getPerformanceScore(build)}%` }}
                              />
                            </div>
                          </div>
                        </div>

                        <div className="flex items-center justify-between">
                          <span className="text-sm text-slate-600 dark:text-slate-400">Value Score</span>
                          <div className="flex items-center gap-2">
                            <span className="font-medium">{getValueScore(build)}/100</span>
                            <div className="w-20 bg-slate-200 dark:bg-slate-700 rounded-full h-2">
                              <div
                                className="bg-green-600 h-2 rounded-full"
                                style={{ width: `${getValueScore(build)}%` }}
                              />
                            </div>
                          </div>
                        </div>

                        <div className="flex flex-wrap gap-1">
                          {build.tags.map((tag) => (
                            <Badge key={tag} variant="outline" className="text-xs">
                              {tag}
                            </Badge>
                          ))}
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </div>

                {/* Price Comparison Chart */}
                <Card>
                  <CardHeader>
                    <CardTitle className="flex items-center gap-2">
                      <DollarSign className="h-5 w-5" />
                      Price Comparison
                    </CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-4">
                      {(() => {
                        const priceData = getPriceComparison(allBuilds)
                        return (
                          <>
                            <div className="grid grid-cols-3 gap-4 text-center">
                              <div>
                                <p className="text-sm text-slate-600 dark:text-slate-400">Lowest</p>
                                <p className="text-2xl font-bold text-green-600">${priceData.min.toLocaleString()}</p>
                              </div>
                              <div>
                                <p className="text-sm text-slate-600 dark:text-slate-400">Average</p>
                                <p className="text-2xl font-bold text-blue-600">${Math.round(priceData.avg).toLocaleString()}</p>
                              </div>
                              <div>
                                <p className="text-sm text-slate-600 dark:text-slate-400">Highest</p>
                                <p className="text-2xl font-bold text-red-600">${priceData.max.toLocaleString()}</p>
                              </div>
                            </div>
                            <div className="space-y-2">
                              {allBuilds.map((build, index) => (
                                <div key={build.id} className="flex items-center justify-between">
                                  <span className="text-sm font-medium">{build.name}</span>
                                  <div className="flex items-center gap-2">
                                    <div className="w-32 bg-slate-200 dark:bg-slate-700 rounded-full h-3">
                                      <div
                                        className="bg-blue-600 h-3 rounded-full"
                                        style={{ width: `${((build.totalPrice - priceData.min) / (priceData.max - priceData.min)) * 100}%` }}
                                      />
                                    </div>
                                    <span className="text-sm font-medium w-20 text-right">${build.totalPrice.toLocaleString()}</span>
                                  </div>
                                </div>
                              ))}
                            </div>
                          </>
                        )
                      })()}
                    </div>
                  </CardContent>
                </Card>
              </TabsContent>

              {/* Components Tab */}
              <TabsContent value="components" className="space-y-6">
                <Card>
                  <CardHeader>
                    <CardTitle>Component Comparison</CardTitle>
                    <CardDescription>Compare individual components across builds</CardDescription>
                  </CardHeader>
                  <CardContent>
                    <div className="overflow-x-auto">
                      <table className="w-full">
                        <thead>
                          <tr className="border-b">
                            <th className="text-left p-3 font-medium">Component</th>
                            {allBuilds.map((build, index) => (
                              <th key={build.id} className="text-center p-3 font-medium">
                                {index === 0 ? "Your Build" : `Build ${index}`}
                              </th>
                            ))}
                          </tr>
                        </thead>
                        <tbody>
                          {Object.entries(categoryNames).map(([category, name]) => (
                            <tr key={category} className="border-b">
                              <td className="p-3">
                                <div className="flex items-center gap-2">
                                  {React.createElement(categoryIcons[category as keyof typeof categoryIcons], {
                                    className: "h-4 w-4 text-slate-600"
                                  })}
                                  <span className="font-medium">{name}</span>
                                </div>
                              </td>
                              {allBuilds.map((build) => {
                                const component = build.components[category]
                                return (
                                  <td key={build.id} className="p-3 text-center">
                                    {component ? (
                                      <div className="space-y-1">
                                        <p className="text-sm font-medium">{component.name}</p>
                                        <p className="text-xs text-slate-600 dark:text-slate-400">${component.price}</p>
                                        <div className="flex items-center justify-center">
                                          {[...Array(5)].map((_, i) => (
                                            <Star
                                              key={i}
                                              className={`h-3 w-3 ${
                                                i < Math.floor(component.rating) ? "text-yellow-400" : "text-slate-300"
                                              }`}
                                              fill="currentColor"
                                            />
                                          ))}
                                        </div>
                                      </div>
                                    ) : (
                                      <span className="text-sm text-slate-400">Not selected</span>
                                    )}
                                  </td>
                                )
                              })}
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  </CardContent>
                </Card>
              </TabsContent>

              {/* Performance Tab */}
              <TabsContent value="performance" className="space-y-6">
                <div className="grid md:grid-cols-2 gap-6">
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <Zap className="h-5 w-5" />
                        Performance Scores
                      </CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-4">
                        {allBuilds.map((build, index) => (
                          <div key={build.id} className="space-y-2">
                            <div className="flex items-center justify-between">
                              <span className="font-medium">{build.name}</span>
                              <span className="text-lg font-bold">{getPerformanceScore(build)}/100</span>
                            </div>
                            <div className="w-full bg-slate-200 dark:bg-slate-700 rounded-full h-3">
                              <div
                                className="bg-blue-600 h-3 rounded-full transition-all duration-300"
                                style={{ width: `${getPerformanceScore(build)}%` }}
                              />
                            </div>
                          </div>
                        ))}
                      </div>
                    </CardContent>
                  </Card>

                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <BarChart3 className="h-5 w-5" />
                        Performance Breakdown
                      </CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-3">
                        {allBuilds.map((build, index) => (
                          <div key={build.id} className="p-3 bg-slate-50 dark:bg-slate-800 rounded-lg">
                            <div className="flex items-center justify-between mb-2">
                              <span className="font-medium">{build.name}</span>
                              <Badge variant={index === 0 ? "default" : "secondary"}>
                                {index === 0 ? "Your Build" : `Build ${index}`}
                              </Badge>
                            </div>
                            <div className="grid grid-cols-2 gap-2 text-sm">
                              <div>
                                <span className="text-slate-600 dark:text-slate-400">CPU Score:</span>
                                <span className="ml-2 font-medium">
                                  {build.components.cpu ? Math.round(build.components.cpu.rating * 20) : "N/A"}
                                </span>
                              </div>
                              <div>
                                <span className="text-slate-600 dark:text-slate-400">GPU Score:</span>
                                <span className="ml-2 font-medium">
                                  {build.components.gpu ? Math.round(build.components.gpu.rating * 20) : "N/A"}
                                </span>
                              </div>
                              <div>
                                <span className="text-slate-600 dark:text-slate-400">RAM Score:</span>
                                <span className="ml-2 font-medium">
                                  {build.components.memory ? Math.round(build.components.memory.rating * 20) : "N/A"}
                                </span>
                              </div>
                              <div>
                                <span className="text-slate-600 dark:text-slate-400">Storage Score:</span>
                                <span className="ml-2 font-medium">
                                  {build.components.storage ? Math.round(build.components.storage.rating * 20) : "N/A"}
                                </span>
                              </div>
                            </div>
                          </div>
                        ))}
                      </div>
                    </CardContent>
                  </Card>
                </div>
              </TabsContent>

              {/* Value Analysis Tab */}
              <TabsContent value="value" className="space-y-6">
                <Card>
                  <CardHeader>
                    <CardTitle className="flex items-center gap-2">
                      <TrendingUp className="h-5 w-5" />
                      Value Analysis
                    </CardTitle>
                    <CardDescription>Compare performance per dollar spent</CardDescription>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-6">
                      {allBuilds.map((build, index) => {
                        const performanceScore = getPerformanceScore(build)
                        const valueScore = getValueScore(build)
                        const pricePerPerformance = build.totalPrice / performanceScore
                        
                        return (
                          <div key={build.id} className="p-4 border border-slate-200 dark:border-slate-700 rounded-lg">
                            <div className="flex items-center justify-between mb-4">
                              <div>
                                <h3 className="font-semibold text-lg">{build.name}</h3>
                                <p className="text-sm text-slate-600 dark:text-slate-400">
                                  ${build.totalPrice.toLocaleString()} • {performanceScore}/100 Performance
                                </p>
                              </div>
                              <Badge variant={index === 0 ? "default" : "secondary"}>
                                {index === 0 ? "Your Build" : `Build ${index}`}
                              </Badge>
                            </div>

                            <div className="grid md:grid-cols-3 gap-4">
                              <div className="text-center">
                                <p className="text-sm text-slate-600 dark:text-slate-400">Value Score</p>
                                <p className="text-2xl font-bold text-green-600">{valueScore}/100</p>
                                <div className="w-full bg-slate-200 dark:bg-slate-700 rounded-full h-2 mt-2">
                                  <div
                                    className="bg-green-600 h-2 rounded-full"
                                    style={{ width: `${valueScore}%` }}
                                  />
                                </div>
                              </div>
                              <div className="text-center">
                                <p className="text-sm text-slate-600 dark:text-slate-400">Price per Performance</p>
                                <p className="text-2xl font-bold text-blue-600">${Math.round(pricePerPerformance)}</p>
                                <p className="text-xs text-slate-500">per performance point</p>
                              </div>
                              <div className="text-center">
                                <p className="text-sm text-slate-600 dark:text-slate-400">Efficiency</p>
                                <p className="text-2xl font-bold text-purple-600">
                                  {valueScore > 80 ? "Excellent" : valueScore > 60 ? "Good" : valueScore > 40 ? "Fair" : "Poor"}
                                </p>
                                <p className="text-xs text-slate-500">value rating</p>
                              </div>
                            </div>
                          </div>
                        )
                      })}
                    </div>
                  </CardContent>
                </Card>

                {/* Recommendations */}
                <Card>
                  <CardHeader>
                    <CardTitle className="flex items-center gap-2">
                      <Info className="h-5 w-5" />
                      Recommendations
                    </CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-3">
                      <Alert>
                        <CheckCircle className="h-4 w-4" />
                        <AlertDescription>
                          <strong>Best Value:</strong> The build with the highest value score offers the best performance per dollar spent.
                        </AlertDescription>
                      </Alert>
                      <Alert>
                        <TrendingUp className="h-4 w-4" />
                        <AlertDescription>
                          <strong>Performance Leader:</strong> The build with the highest performance score is best for demanding tasks.
                        </AlertDescription>
                      </Alert>
                      <Alert>
                        <DollarSign className="h-4 w-4" />
                        <AlertDescription>
                          <strong>Budget Option:</strong> The lowest-priced build is ideal for budget-conscious users.
                        </AlertDescription>
                      </Alert>
                    </div>
                  </CardContent>
                </Card>
              </TabsContent>
            </Tabs>
          </div>
        )}
      </div>
    </div>
  )
}

