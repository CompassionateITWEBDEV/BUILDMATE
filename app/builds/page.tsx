"use client"

import { useState } from "react"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Input } from "@/components/ui/input"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Cpu, Heart, MessageCircle, Share, Search, Monitor, Users, Eye } from "lucide-react"
import { mockBuilds, mockUsers, type Build } from "@/lib/mock-data"
import { useAuth } from "@/contexts/auth-context"

export default function BuildsPage() {
  const { user } = useAuth()
  const [searchTerm, setSearchTerm] = useState("")
  const [sortBy, setSortBy] = useState("popular")
  const [priceFilter, setPriceFilter] = useState("all")
  const [likedBuilds, setLikedBuilds] = useState<string[]>([])

  const getFilteredBuilds = (): Build[] => {
    let filtered = mockBuilds.filter(
      (build) =>
        build.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        build.description.toLowerCase().includes(searchTerm.toLowerCase()) ||
        build.tags.some((tag) => tag.toLowerCase().includes(searchTerm.toLowerCase())),
    )

    // Price filtering
    if (priceFilter !== "all") {
      filtered = filtered.filter((build) => {
        switch (priceFilter) {
          case "budget":
            return build.totalPrice < 1000
          case "mid":
            return build.totalPrice >= 1000 && build.totalPrice < 2000
          case "high":
            return build.totalPrice >= 2000
          default:
            return true
        }
      })
    }

    // Sorting
    switch (sortBy) {
      case "recent":
        return filtered.sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime())
      case "price-low":
        return filtered.sort((a, b) => a.totalPrice - b.totalPrice)
      case "price-high":
        return filtered.sort((a, b) => b.totalPrice - a.totalPrice)
      case "likes":
        return filtered.sort((a, b) => b.likes - a.likes)
      default:
        return filtered.sort((a, b) => b.likes - a.likes)
    }
  }

  const handleLike = (buildId: string) => {
    setLikedBuilds((prev) => (prev.includes(buildId) ? prev.filter((id) => id !== buildId) : [...prev, buildId]))
  }

  const filteredBuilds = getFilteredBuilds()

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      {/* Header */}
      <header className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <Link href="/" className="flex items-center gap-2">
              <Cpu className="h-8 w-8 text-blue-600" />
              <h1 className="text-2xl font-bold text-slate-900 dark:text-white">BuildMate</h1>
            </Link>
            <nav className="hidden md:flex items-center gap-6">
              <Link
                href="/builder"
                className="text-slate-600 hover:text-slate-900 dark:text-slate-300 dark:hover:text-white"
              >
                PC Builder
              </Link>
              <Link href="/builds" className="text-slate-900 dark:text-white font-medium">
                Community Builds
              </Link>
              <Link
                href="/guides"
                className="text-slate-600 hover:text-slate-900 dark:text-slate-300 dark:hover:text-white"
              >
                Build Guides
              </Link>
            </nav>
            <Button asChild>
              <Link href="/builder">Create Build</Link>
            </Button>
          </div>
        </div>
      </header>

      <div className="container mx-auto px-4 py-8">
        {/* Page Header */}
        <div className="mb-8">
          <h2 className="text-3xl font-bold text-slate-900 dark:text-white mb-2">Community Builds</h2>
          <p className="text-slate-600 dark:text-slate-400">
            Discover amazing PC builds from our community of enthusiasts
          </p>

          <div className="flex items-center gap-6 mt-4 text-sm text-slate-600 dark:text-slate-400">
            <div className="flex items-center gap-1">
              <Users className="h-4 w-4" />
              <span>1,247 builders</span>
            </div>
            <div className="flex items-center gap-1">
              <Cpu className="h-4 w-4" />
              <span>3,891 builds</span>
            </div>
            <div className="flex items-center gap-1">
              <Heart className="h-4 w-4" />
              <span>15,632 likes</span>
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
                <SelectItem value="budget">Under $1,000</SelectItem>
                <SelectItem value="mid">$1,000 - $2,000</SelectItem>
                <SelectItem value="high">Over $2,000</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          {filteredBuilds.map((build) => {
            const creator = mockUsers.find((user) => user.id === build.createdBy)
            const isLiked = likedBuilds.includes(build.id)

            return (
              <Card
                key={build.id}
                className="border-slate-200 dark:border-slate-700 hover:shadow-lg transition-all duration-200 group"
              >
                <CardHeader className="pb-3">
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <CardTitle className="text-lg group-hover:text-blue-600 transition-colors">
                        {build.name}
                      </CardTitle>
                      <div className="flex items-center gap-2 mt-2">
                        <Avatar className="h-6 w-6">
                          <AvatarImage src={creator?.avatar || "/placeholder.svg"} />
                          <AvatarFallback className="text-xs">
                            {creator?.username?.charAt(0).toUpperCase() || "U"}
                          </AvatarFallback>
                        </Avatar>
                        <span className="text-sm text-slate-600 dark:text-slate-400">
                          {creator?.username || "Unknown"}
                        </span>
                      </div>
                    </div>
                    <div className="text-right">
                      <Badge variant="secondary" className="font-semibold">
                        ${build.totalPrice.toLocaleString()}
                      </Badge>
                      <div className="flex items-center gap-1 mt-1 text-xs text-slate-500">
                        <Eye className="h-3 w-3" />
                        <span>1.2k views</span>
                      </div>
                    </div>
                  </div>
                </CardHeader>

                <CardContent className="space-y-4">
                  <p className="text-sm text-slate-600 dark:text-slate-400 line-clamp-2">{build.description}</p>

                  {/* Build tags */}
                  <div className="flex flex-wrap gap-1">
                    {build.tags.slice(0, 3).map((tag) => (
                      <Badge key={tag} variant="outline" className="text-xs">
                        {tag}
                      </Badge>
                    ))}
                    {build.tags.length > 3 && (
                      <Badge variant="outline" className="text-xs">
                        +{build.tags.length - 3}
                      </Badge>
                    )}
                  </div>

                  {/* Key components */}
                  <div className="space-y-1.5">
                    {build.components.cpu && (
                      <div className="flex items-center gap-2 text-xs">
                        <Cpu className="h-3 w-3 text-blue-500" />
                        <span className="text-slate-600 dark:text-slate-400 truncate">{build.components.cpu.name}</span>
                      </div>
                    )}
                    {build.components.gpu && (
                      <div className="flex items-center gap-2 text-xs">
                        <Monitor className="h-3 w-3 text-green-500" />
                        <span className="text-slate-600 dark:text-slate-400 truncate">{build.components.gpu.name}</span>
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
                        onClick={() => handleLike(build.id)}
                      >
                        <Heart className={`h-4 w-4 ${isLiked ? "fill-current" : ""}`} />
                        <span>{build.likes + (isLiked ? 1 : 0)}</span>
                      </button>
                      <button className="flex items-center gap-1 text-sm text-slate-500 hover:text-blue-500 transition-colors">
                        <MessageCircle className="h-4 w-4" />
                        <span>12</span>
                      </button>
                      <button className="flex items-center gap-1 text-sm text-slate-500 hover:text-green-500 transition-colors">
                        <Share className="h-4 w-4" />
                      </button>
                    </div>
                    <Button size="sm" variant="outline" asChild className="text-xs bg-transparent">
                      <Link href={`/builds/${build.id}`}>View Details</Link>
                    </Button>
                  </div>
                </CardContent>
              </Card>
            )
          })}
        </div>

        {filteredBuilds.length === 0 && (
          <div className="text-center py-12">
            <Cpu className="h-12 w-12 text-slate-400 mx-auto mb-4" />
            <h3 className="text-lg font-medium text-slate-900 dark:text-white mb-2">No builds found</h3>
            <p className="text-slate-600 dark:text-slate-400 mb-4">Try adjusting your search terms or filters</p>
            <Button asChild>
              <Link href="/builder">Create the first build</Link>
            </Button>
          </div>
        )}

        {filteredBuilds.length > 0 && (
          <div className="text-center mt-12">
            <Button variant="outline" size="lg">
              Load More Builds
            </Button>
          </div>
        )}
      </div>
    </div>
  )
}
