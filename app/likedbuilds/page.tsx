"use client"

import { useState, useEffect } from "react"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Input } from "@/components/ui/input"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Navigation } from "@/components/navigation"
import { Cpu, Heart, MessageCircle, Share, Search, Monitor, Users, Eye, BarChart3 } from "lucide-react"
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
  description: string
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
    if (!user) return;
    try {
        setLoading(true);
        setError(null);

        // 1️⃣ Get liked build IDs
        const { data: likedData, error: likedError } = await supabase
        .from("build_likes")
        .select("build_id")
        .eq("user_id", user.user_id);

        if (likedError) throw likedError;
        const likedIds = likedData?.map((r) => r.build_id) || [];

        if (likedIds.length === 0) {
        setBuilds([]);
        return;
        }

        // 2️⃣ Fetch builds by these IDs
        const { data: buildsData, error: buildsError } = await supabase
        .from("builds")
        .select(`
            *,
            users:user_id (
            user_id,
            user_name,
            email,
            avatar_url
            ),
            build_types:build_type_id (
            build_type_id,
            type_name
            )
        `)
        .in("build_id", likedIds);


        if (buildsError) throw buildsError;

        // 3️⃣ Add components, total price, comments
        const buildsWithDetails = await Promise.all(
        buildsData.map(async (build: any) => {
            try {
            const components = await buildComponentService.getBuildComponents(build.build_id);
            const totalPrice = components.reduce(
                (sum, bc: any) => sum + (Number(bc.components?.component_price) || 0),
                0
            );

            const { count: commentsCount } = await supabase
                .from('build_comments')
                .select('*', { count: 'exact', head: true })
                .eq('build_id', build.build_id);

            return {
                ...build,
                components,
                totalPrice,
                comments: commentsCount || build.comments || 0,
                likes: build.likes || 0,
                views: build.views || 0
            };
            } catch (err) {
            console.error(err);
            return { ...build, components: [], totalPrice: 0, comments: 0, likes: 0, views: 0 };
            }
        })
        );

        setBuilds(buildsWithDetails);
    } catch (err: any) {
        console.error(err);
        setError(err.message || 'Failed to load builds');
    } finally {
        setLoading(false);
    }
    };



    const fetchStatistics = async () => {
    try {
        if (!user) return;

        // 1️⃣ Get IDs of builds the user liked
        const { data: likedData, error: likedError } = await supabase
        .from("build_likes")
        .select("build_id")
        .eq("user_id", user.user_id);

        if (likedError) throw likedError;

        const likedIds = likedData?.map((r) => r.build_id) || [];

        if (likedIds.length === 0) {
        setStatistics({ totalBuilders: 0, totalBuilds: 0, totalLikes: 0 });
        return;
        }

        // 2️⃣ Fetch builds that the user liked
        const { data: buildsData, error: buildsError } = await supabase
        .from("builds")
        .select("user_id, likes")
        .in("build_id", likedIds);

        if (buildsError) throw buildsError;

        // 3️⃣ Total builds you liked
        const totalBuilds = buildsData.length;

        // 4️⃣ Sum of likes of all liked builds
        const totalLikes = buildsData.reduce((sum, b) => sum + (b.likes || 0), 0);

        // 5️⃣ Total unique builders of liked builds
        const uniqueBuilders = new Set(buildsData.map((b) => b.user_id));
        const totalBuilders = uniqueBuilders.size;

        setStatistics({
        totalBuilders,
        totalBuilds,
        totalLikes
        });
    } catch (err) {
        console.error(err);
        setStatistics({ totalBuilders: 0, totalBuilds: 0, totalLikes: 0 });
    }
    };



  const handleLike = async (build: BuildWithDetails) => {
    if (!user) return
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
        <Navigation />
        <div className="container mx-auto px-4 py-20 text-center">
          <Cpu className="h-12 w-12 text-blue-600 mx-auto mb-4 animate-pulse" />
          <p className="text-slate-600 dark:text-slate-400">Loading builds...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      <Navigation />
      
      {/* Page Header */}
      <div className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-2xl font-bold text-slate-900 dark:text-white">Liked Builds</h1>
              <p className="text-slate-600 dark:text-slate-400">These are the PC builds you've liked from the community</p>
            </div>
            <div className="flex gap-2">
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
                      <button
                        className={`flex items-center gap-1 text-sm transition-colors ${
                          isLiked ? "text-red-500 hover:text-red-600" : "text-slate-500 hover:text-red-500"
                        }`}
                        onClick={() => handleLike(build)}
                      >
                        <Heart className={`h-4 w-4 ${isLiked ? "fill-current" : ""}`} />
                        <span>{build.likes}</span>
                      </button>
                      <button className="flex items-center gap-1 text-sm text-slate-500 hover:text-blue-500 transition-colors">
                        <MessageCircle className="h-4 w-4" />
                        <span>{build.comments || 0}</span>
                      </button>
                      <button className="flex items-center gap-1 text-sm text-slate-500 hover:text-green-500 transition-colors">
                        <Share className="h-4 w-4" />
                      </button>
                    </div>
                    <div className="flex items-center gap-2">
                      <Button size="sm" variant="outline" asChild className="text-xs bg-transparent">
                        <Link href={`/compare?add=${build.build_id}`}>
                          <BarChart3 className="h-3 w-3 mr-1" />
                          Compare
                        </Link>
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
            <h3 className="text-lg font-medium text-slate-900 dark:text-white mb-2">No liked builds found</h3>
            <p className="text-slate-600 dark:text-slate-400 mb-4">Try adjusting your search terms or filters</p>
          </div>
        )}
      </div>
    </div>
  )
}
