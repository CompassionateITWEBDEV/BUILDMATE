"use client"

import { useState, useEffect } from "react"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Input } from "@/components/ui/input"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Cpu, Heart, MessageCircle, Share, Search, Monitor, Users, Eye, BarChart3, ArrowLeft, Plus, X, TrendingUp, TrendingDown, DollarSign, Zap, MemoryStick, HardDrive, Fan, Settings } from "lucide-react"
import { buildService, buildComponentService } from "@/lib/database"
import { formatCurrency, PRICE_RANGES } from "@/lib/currency"
import { useAuth } from "@/contexts/supabase-auth-context"
import { supabase } from "@/lib/supabase"

interface BuildWithDetails {
  build_id: number
  build_name: string
  date_created: string
  user_id: number
  build_type_id: number
  users: {
    user_id: number
    user_name: string
    email: string
    avatar_url: string
  }
  build_types: {
    build_type_id: number
    type_name: string
  }
  components?: any[]
  totalPrice?: number
  likes?: number
  comments?: number
  views?: number
  description?: string
}

export default function BuildsPage() {
  const { user } = useAuth()
  const [builds, setBuilds] = useState<BuildWithDetails[]>([])
  const [statistics, setStatistics] = useState({ totalBuilders: 0, totalBuilds: 0, totalLikes: 0 })
  const [searchTerm, setSearchTerm] = useState("")
  const [sortBy, setSortBy] = useState("popular")
  const [priceFilter, setPriceFilter] = useState("all")
  const [likedBuilds, setLikedBuilds] = useState<number[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [activeTab, setActiveTab] = useState<"browse" | "compare">("browse")
  const [selectedBuildsForCompare, setSelectedBuildsForCompare] = useState<BuildWithDetails[]>([])
  const [compareSearchTerm, setCompareSearchTerm] = useState("")
  const [compareActiveTab, setCompareActiveTab] = useState("overview")

  // Fetch builds and statistics
  useEffect(() => {
    fetchBuilds()
    fetchStatistics()
    
    const buildsChannel = supabase
      .channel('builds-changes')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'builds' }, () => {
        fetchBuilds()
        fetchStatistics()
      })
      .subscribe()

    return () => {
      supabase.removeChannel(buildsChannel)
    }
  }, [])

  // Fetch user's liked builds
  useEffect(() => {
    if (!user) return;
    const fetchLiked = async () => {
      const { data, error } = await supabase
        .from("build_likes")
        .select("build_id")
        .eq("user_id", user.user_id)
      if (!error && data) setLikedBuilds(data.map((r) => r.build_id))
    }
    fetchLiked()
  }, [user])

  const fetchBuilds = async () => {
    try {
      setLoading(true)
      setError(null)
      const allBuilds = await buildService.getAll()
      const buildsWithDetails = await Promise.all(
        allBuilds.map(async (build) => {
          try {
            const components = await buildComponentService.getBuildComponents(build.build_id)
            const totalPrice = components.reduce((sum, bc: any) => sum + (Number(bc.components?.component_price) || 0), 0)
            const { count: commentsCount } = await supabase
              .from('build_comments')
              .select('*', { count: 'exact', head: true })
              .eq('build_id', build.build_id)
            return {
              ...build,
              components,
              totalPrice,
              comments: commentsCount || build.comments || 0,
              likes: build.likes || 0,
              views: build.views || 0
            }
          } catch (err) {
            console.error(err)
            return { ...build, components: [], totalPrice: 0, comments: 0, likes: 0, views: 0 }
          }
        })
      )
      setBuilds(buildsWithDetails)
    } catch (err: any) {
      console.error(err)
      setError(err.message || 'Failed to load builds')
    } finally {
      setLoading(false)
    }
  }

  const fetchStatistics = async () => {
    try { const stats = await buildService.getStatistics(); setStatistics(stats) }
    catch (err) { console.error(err) }
  }

  const handleLike = async (build: BuildWithDetails) => {
    if (!user) {
      alert("Please log in to like builds.")
      return
    }
    const isLiked = likedBuilds.includes(build.build_id)

    if (build.users?.user_id === user.user_id) {
      alert("You cannot like your own build.")
      return
    }

    if (isLiked) {
      const { error: deleteLikeError } = await supabase
        .from("build_likes")
        .delete()
        .eq("build_id", build.build_id)
        .eq("user_id", user.user_id)
      if (!deleteLikeError) {
        const { error: updateError } = await supabase
          .from("builds")
          .update({ likes: build.likes - 1 })
          .eq("build_id", build.build_id)
        if (!updateError) {
          setLikedBuilds(prev => prev.filter(id => id !== build.build_id))
          setBuilds(prev => prev.map(b => b.build_id === build.build_id ? { ...b, likes: (b.likes || 0) - 1 } : b))
        }
      }
    } else {
      const { error: insertLikeError } = await supabase
        .from("build_likes")
        .insert({ build_id: build.build_id, user_id: user.user_id })
      if (!insertLikeError) {
        const { error: updateError } = await supabase
          .from("builds")
          .update({ likes: build.likes + 1 })
          .eq("build_id", build.build_id)
        if (!updateError) {
          setLikedBuilds(prev => [...prev, build.build_id])
          setBuilds(prev => prev.map(b => b.build_id === build.build_id ? { ...b, likes: (b.likes || 0) + 1 } : b))
        }
      }
    }
  }

  const getFilteredBuilds = (): BuildWithDetails[] => {
    let filtered = builds.filter(
      b => b.build_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
           b.build_types?.type_name.toLowerCase().includes(searchTerm.toLowerCase())
    )
    if (priceFilter !== "all") {
      filtered = filtered.filter(build => {
        const price = build.totalPrice || 0
        switch (priceFilter) {
          case "budget": return price < PRICE_RANGES.budget.max
          case "mid": return price >= PRICE_RANGES.mid.min && price < PRICE_RANGES.mid.max
          case "high": return price >= PRICE_RANGES.high.min
          default: return true
        }
      })
    }
    switch (sortBy) {
      case "recent": return filtered.sort((a, b) => new Date(b.date_created).getTime() - new Date(a.date_created).getTime())
      case "price-low": return filtered.sort((a, b) => (a.totalPrice || 0) - (b.totalPrice || 0))
      case "price-high": return filtered.sort((a, b) => (b.totalPrice || 0) - (a.totalPrice || 0))
      case "likes": return filtered.sort((a, b) => (b.likes || 0) - (a.likes || 0))
      default: return filtered.sort((a, b) => (b.likes || 0) - (a.likes || 0))
    }
  }

  const filteredBuilds = getFilteredBuilds()
  const formatNumber = (num: number) => num.toLocaleString()

  if (loading && builds.length === 0) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
        <div className="container mx-auto px-4 py-20 text-center">
          <Cpu className="h-12 w-12 text-blue-600 mx-auto mb-4 animate-pulse" />
          <p className="text-slate-600 dark:text-slate-400">Loading builds...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      
      {/* Page Header */}
      <div className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-2xl font-bold text-slate-900 dark:text-white">Community Builds</h1>
              <p className="text-slate-600 dark:text-slate-400">Discover amazing PC builds from our community</p>
            </div>
            <div className="flex gap-2">
              <Link href="/dashboard">
                <Button variant="outline" size="sm">
                  <ArrowLeft className="h-4 w-4 mr-2" />
                  Back to Home
                </Button>
              </Link>
              <Button asChild>
                <Link href="/builder">Create Build</Link>
              </Button>
            </div>
          </div>
        </div>
      </div>

      <div className="container mx-auto px-4 py-8">
        {error && (
          <div className="mb-4 p-4 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-lg">
            <p className="text-red-800 dark:text-red-200">{error}</p>
          </div>
        )}

        {/* Stats */}
        <div className="mb-8">
          <div className="flex items-center gap-6 text-sm text-slate-600 dark:text-slate-400">
            <div className="flex items-center gap-1">
              <Users className="h-4 w-4" />
              <span>{formatNumber(statistics.totalBuilders)} builders</span>
            </div>
            <div className="flex items-center gap-1">
              <Cpu className="h-4 w-4" />
              <span>{formatNumber(statistics.totalBuilds)} builds</span>
            </div>
            <div className="flex items-center gap-1">
              <Heart className="h-4 w-4" />
              <span>{formatNumber(statistics.totalLikes)} likes</span>
            </div>
          </div>
        </div>

        <Tabs value={activeTab} onValueChange={(v) => setActiveTab(v as "browse" | "compare")} className="mb-8">
          <TabsList className="grid w-full grid-cols-2 max-w-md">
            <TabsTrigger value="browse">Browse Builds</TabsTrigger>
            <TabsTrigger value="compare">Compare Builds</TabsTrigger>
          </TabsList>

          {/* Browse Tab */}
          <TabsContent value="browse" className="space-y-6">
        <div className="flex flex-col lg:flex-row gap-4 mb-8">
          <div className="flex-1 relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-slate-400" />
            <Input
              placeholder="Search builds, components, or tags..."
              className="pl-10"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
          </div>
          <div className="flex gap-2">
            <Select value={sortBy} onValueChange={setSortBy}>
              <SelectTrigger className="w-40">
                <SelectValue placeholder="Sort by" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="popular">Most Popular</SelectItem>
                <SelectItem value="recent">Most Recent</SelectItem>
                <SelectItem value="likes">Most Liked</SelectItem>
                <SelectItem value="price-low">Price: Low to High</SelectItem>
                <SelectItem value="price-high">Price: High to Low</SelectItem>
              </SelectContent>
            </Select>
            <Select value={priceFilter} onValueChange={setPriceFilter}>
              <SelectTrigger className="w-32">
                <SelectValue placeholder="Price" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">All Prices</SelectItem>
                <SelectItem value="budget">{PRICE_RANGES.budget.label}</SelectItem>
                <SelectItem value="mid">{PRICE_RANGES.mid.label}</SelectItem>
                <SelectItem value="high">{PRICE_RANGES.high.label}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          {filteredBuilds.map((build) => {
            const creator = build.users
            const isLiked = likedBuilds.includes(build.build_id)
            const cpuComponent = build.components?.find((bc: any) => 
              bc.components?.component_categories?.category_name === 'CPU'
            )
            const gpuComponent = build.components?.find((bc: any) => 
              bc.components?.component_categories?.category_name === 'GPU'
            )

            return (
              <Card
                key={build.build_id}
                className="border-slate-200 dark:border-slate-700 hover:shadow-lg transition-all duration-200 group"
              >
                <CardHeader className="pb-3">
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <CardTitle className="text-lg group-hover:text-blue-600 transition-colors">
                        {build.build_name}
                      </CardTitle>
                      <div className="flex items-center gap-2 mt-2">
                        <Avatar className="h-6 w-6">
                          <Avatar className="h-6 w-6">
                            <AvatarImage src={creator?.avatar_url || "/placeholder.svg"} />
                            <AvatarFallback className="text-xs">
                              {creator?.user_name?.charAt(0).toUpperCase() || "U"}
                            </AvatarFallback>
                          </Avatar>
                          <span className="text-sm text-slate-600 dark:text-slate-400">
                            {creator?.user_name || "Unknown"}
                          </span>

                        </Avatar>
                        <span className="text-sm text-slate-600 dark:text-slate-400">
                          {creator?.user_name || "Unknown"}
                        </span>
                      </div>
                    </div>
                    <div className="text-right">
                      <Badge variant="secondary" className="font-semibold">
                        {formatCurrency(build.totalPrice || 0)}
                      </Badge>
                      <div className="flex items-center gap-1 mt-1 text-xs text-slate-500">
                        <Eye className="h-3 w-3" />
                        <span>{(build.views || 0).toLocaleString()} views</span>
                      </div>
                    </div>
                  </div>
                </CardHeader>

                <CardContent className="space-y-4">
                  <p className="text-sm text-slate-600 dark:text-slate-400 line-clamp-2">
                    {build?.description || 'PC Build'}
                  </p>

                  {/* Build tags */}
                  <div className="flex flex-wrap gap-1">
                    <Badge variant="outline" className="text-xs">
                      {build.build_types?.type_name || 'build'}
                    </Badge>
                  </div>

                  {/* Key components */}
                  <div className="space-y-1.5">
                    {cpuComponent && (
                      <div className="flex items-center gap-2 text-xs">
                        <Cpu className="h-3 w-3 text-blue-500" />
                        <span className="text-slate-600 dark:text-slate-400 truncate">
                          {cpuComponent.components?.component_name}
                        </span>
                      </div>
                    )}
                    {gpuComponent && (
                      <div className="flex items-center gap-2 text-xs">
                        <Monitor className="h-3 w-3 text-green-500" />
                        <span className="text-slate-600 dark:text-slate-400 truncate">
                          {gpuComponent.components?.component_name}
                        </span>
                      </div>
                    )}
                  </div>

                  {/* Actions */}
                  <div className="flex items-center justify-between pt-2 border-t border-slate-100 dark:border-slate-700">
                    <div className="flex items-center gap-3">
                      <Button
                        variant="ghost"
                        size="sm"
                        className={`h-auto p-0 flex items-center gap-1 text-sm transition-colors ${
                          isLiked ? "text-red-500 hover:text-red-600" : "text-slate-500 hover:text-red-500"
                        }`}
                        onClick={() => handleLike(build)}
                      >
                        <Heart className={`h-4 w-4 ${isLiked ? "fill-current" : ""}`} />
                        <span>{build.likes || 0}</span>
                      </Button>
                      <Button
                        variant="ghost"
                        size="sm"
                        className="h-auto p-0 text-slate-500 hover:text-blue-500"
                        asChild
                      >
                        <Link href={`/builds/${build.build_id}`}>
                          <MessageCircle className="h-4 w-4 mr-1" />
                          <span>{build.comments || 0}</span>
                        </Link>
                      </Button>
                      <Button
                        variant="ghost"
                        size="sm"
                        className="h-auto p-0 text-slate-500 hover:text-green-500"
                        onClick={async () => {
                          const url = `${window.location.origin}/builds/${build.build_id}`
                          try {
                            await navigator.clipboard.writeText(url)
                            alert("Build link copied to clipboard!")
                          } catch (err) {
                            console.error("Failed to copy link:", err)
                            alert("Failed to copy link. Please copy manually: " + url)
                          }
                        }}
                      >
                        <Share className="h-4 w-4" />
                      </Button>
                    </div>
                    <div className="flex items-center gap-2">
                      <Button 
                        size="sm" 
                        variant="outline" 
                        className="text-xs bg-transparent"
                        onClick={() => {
                          if (selectedBuildsForCompare.length >= 3) {
                            alert("You can compare up to 3 builds at once")
                            return
                          }
                          if (selectedBuildsForCompare.some(b => b.build_id === build.build_id)) {
                            alert("This build is already in the comparison")
                            return
                          }
                          setSelectedBuildsForCompare([...selectedBuildsForCompare, build])
                          setActiveTab("compare")
                        }}
                      >
                        <BarChart3 className="h-3 w-3 mr-1" />
                        Compare
                      </Button>
                      <Button size="sm" variant="outline" asChild className="text-xs bg-transparent">
                        <Link href={`/builds/${build.build_id}`}>View Details</Link>
                      </Button>
                    </div>
                  </div>
                </CardContent>
              </Card>
            )
          })}
        </div>

        {filteredBuilds.length === 0 && !loading && (
          <div className="text-center py-12">
            <Cpu className="h-12 w-12 text-slate-400 mx-auto mb-4" />
            <h3 className="text-lg font-medium text-slate-900 dark:text-white mb-2">No builds found</h3>
            <p className="text-slate-600 dark:text-slate-400 mb-4">Try adjusting your search terms or filters</p>
            <Button asChild>
              <Link href="/builder">Create the first build</Link>
            </Button>
          </div>
        )}
          </TabsContent>

          {/* Compare Tab */}
          <TabsContent value="compare" className="space-y-6">
            {selectedBuildsForCompare.length === 0 ? (
              <Card>
                <CardHeader>
                  <CardTitle>Select Builds to Compare</CardTitle>
                  <CardContent>
                    <p className="text-slate-600 dark:text-slate-400 mb-4">
                      Choose builds from the Browse tab to compare them side by side
                    </p>
                    <Button onClick={() => setActiveTab("browse")}>
                      Browse Builds
                    </Button>
                  </CardContent>
                </CardHeader>
              </Card>
            ) : (
              <div className="space-y-6">
                <Card>
                  <CardHeader>
                    <div className="flex items-center justify-between">
                      <div>
                        <CardTitle>Comparing {selectedBuildsForCompare.length} Builds</CardTitle>
                        <p className="text-sm text-slate-600 dark:text-slate-400 mt-1">
                          Analyze differences in specs, performance, and cost
                        </p>
                      </div>
                      <div className="flex items-center gap-2">
                        <Button variant="outline" size="sm" onClick={() => setSelectedBuildsForCompare([])}>
                          <X className="h-4 w-4 mr-2" />
                          Clear All
                        </Button>
                        <Button size="sm" onClick={() => setActiveTab("browse")}>
                          Add More
                        </Button>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent>
                    <div className="flex flex-wrap gap-2">
                      {selectedBuildsForCompare.map((build, index) => (
                        <div key={build.build_id} className="flex items-center gap-2 bg-slate-100 dark:bg-slate-800 rounded-lg px-3 py-2">
                          <Badge variant={index === 0 ? "default" : "secondary"}>
                            Build {index + 1}
                          </Badge>
                          <span className="font-medium">{build.build_name}</span>
                          <Button
                            size="sm"
                            variant="ghost"
                            onClick={() => setSelectedBuildsForCompare(selectedBuildsForCompare.filter(b => b.build_id !== build.build_id))}
                            className="h-6 w-6 p-0"
                          >
                            <X className="h-3 w-3" />
                          </Button>
                        </div>
                      ))}
                    </div>
                  </CardContent>
                </Card>

                <Tabs value={compareActiveTab} onValueChange={setCompareActiveTab}>
                  <TabsList className="grid w-full grid-cols-4">
                    <TabsTrigger value="overview">Overview</TabsTrigger>
                    <TabsTrigger value="components">Components</TabsTrigger>
                    <TabsTrigger value="price">Price</TabsTrigger>
                    <TabsTrigger value="specs">Specs</TabsTrigger>
                  </TabsList>

                  <TabsContent value="overview" className="space-y-6">
                    <div className="grid lg:grid-cols-3 gap-6">
                      {selectedBuildsForCompare.map((build, index) => (
                        <Card key={build.build_id} className="border-slate-200 dark:border-slate-700">
                          <CardHeader>
                            <CardTitle className="text-lg">{build.build_name}</CardTitle>
                            <p className="text-sm text-slate-600 dark:text-slate-400">{build.description || 'PC Build'}</p>
                          </CardHeader>
                          <CardContent className="space-y-4">
                            <div className="flex items-center justify-between">
                              <span className="text-sm text-slate-600 dark:text-slate-400">Total Price</span>
                              <span className="text-xl font-bold text-blue-600">{formatCurrency(build.totalPrice || 0)}</span>
                            </div>
                            <div className="flex items-center justify-between">
                              <span className="text-sm text-slate-600 dark:text-slate-400">Likes</span>
                              <span className="font-medium">{build.likes || 0}</span>
                            </div>
                            <div className="flex items-center justify-between">
                              <span className="text-sm text-slate-600 dark:text-slate-400">Views</span>
                              <span className="font-medium">{(build.views || 0).toLocaleString()}</span>
                            </div>
                            <div className="flex items-center justify-between">
                              <span className="text-sm text-slate-600 dark:text-slate-400">Components</span>
                              <span className="font-medium">{build.components?.length || 0}</span>
                            </div>
                          </CardContent>
                        </Card>
                      ))}
                    </div>
                  </TabsContent>

                  <TabsContent value="price" className="space-y-6">
                    <Card>
                      <CardHeader>
                        <CardTitle className="flex items-center gap-2">
                          <DollarSign className="h-5 w-5" />
                          Price Comparison
                        </CardTitle>
                      </CardHeader>
                      <CardContent>
                        <div className="space-y-4">
                          {selectedBuildsForCompare.map((build, index) => {
                            const maxPrice = Math.max(...selectedBuildsForCompare.map(b => b.totalPrice || 0))
                            const pricePercentage = maxPrice > 0 ? ((build.totalPrice || 0) / maxPrice) * 100 : 0
                            return (
                              <div key={build.build_id} className="space-y-2">
                                <div className="flex items-center justify-between">
                                  <span className="font-medium">{build.build_name}</span>
                                  <span className="text-lg font-bold">{formatCurrency(build.totalPrice || 0)}</span>
                                </div>
                                <div className="w-full bg-slate-200 dark:bg-slate-700 rounded-full h-3">
                                  <div
                                    className="bg-blue-600 h-3 rounded-full"
                                    style={{ width: `${pricePercentage}%` }}
                                  />
                                </div>
                              </div>
                            )
                          })}
                        </div>
                      </CardContent>
                    </Card>
                  </TabsContent>

                  <TabsContent value="components" className="space-y-6">
                    <Card>
                      <CardHeader>
                        <CardTitle>Component Comparison</CardTitle>
                      </CardHeader>
                      <CardContent>
                        <div className="overflow-x-auto">
                          <table className="w-full">
                            <thead>
                              <tr className="border-b">
                                <th className="text-left p-2">Component</th>
                                {selectedBuildsForCompare.map((build, index) => (
                                  <th key={build.build_id} className="text-left p-2">
                                    Build {index + 1}
                                  </th>
                                ))}
                              </tr>
                            </thead>
                            <tbody>
                              {['CPU', 'GPU', 'Memory', 'Storage'].map((category) => (
                                <tr key={category} className="border-b">
                                  <td className="p-2 font-medium">{category}</td>
                                  {selectedBuildsForCompare.map((build) => {
                                    const component = build.components?.find((bc: any) => 
                                      bc.components?.component_categories?.category_name === category
                                    )
                                    return (
                                      <td key={build.build_id} className="p-2">
                                        {component?.components?.component_name || 'N/A'}
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

                  <TabsContent value="specs" className="space-y-6">
                    <Card>
                      <CardHeader>
                        <CardTitle>Detailed Specifications</CardTitle>
                      </CardHeader>
                      <CardContent>
                        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
                          {selectedBuildsForCompare.map((build, index) => (
                            <Card key={build.build_id} className="border-slate-200 dark:border-slate-700">
                              <CardHeader>
                                <CardTitle className="text-lg">{build.build_name}</CardTitle>
                              </CardHeader>
                              <CardContent className="space-y-2">
                                <div className="text-sm">
                                  <span className="font-medium">Price: </span>
                                  <span>{formatCurrency(build.totalPrice || 0)}</span>
                                </div>
                                <div className="text-sm">
                                  <span className="font-medium">Components: </span>
                                  <span>{build.components?.length || 0}</span>
                                </div>
                                <div className="text-sm">
                                  <span className="font-medium">Type: </span>
                                  <span>{build.build_types?.type_name || 'N/A'}</span>
                                </div>
                                <div className="text-sm">
                                  <span className="font-medium">Created: </span>
                                  <span>{new Date(build.date_created).toLocaleDateString()}</span>
                                </div>
                              </CardContent>
                            </Card>
                          ))}
                        </div>
                      </CardContent>
                    </Card>
                  </TabsContent>
                </Tabs>
              </div>
            )}
          </TabsContent>
        </Tabs>
      </div>
    </div>
  )
}
