"use client"

import { useState } from "react"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Input } from "@/components/ui/input"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Cpu, BookOpen, Play, Clock, Users, Wrench, Zap, Shield, Search, Star, CheckCircle } from "lucide-react"
import { formatCurrency } from "@/lib/currency"
import { type PerformanceCategory, performanceCategories } from "@/lib/mock-data"

const buildGuides = [
  {
    id: "beginner-gaming-build",
    title: "Your First Gaming PC Build",
    description:
      "Complete step-by-step guide for building your first gaming PC from scratch with detailed explanations",
    difficulty: "Beginner",
    duration: "2-3 hours",
    views: "45.2k",
    rating: 4.8,
    reviews: 1247,
    category: "Gaming",
    performanceCategory: "gaming" as PerformanceCategory,
    image: "/gaming-pc-build-guide.png",
    steps: 12,
    tools: ["Phillips screwdriver", "Anti-static wrist strap", "Zip ties"],
    estimatedCost: "₱44,000-66,000",
    lastUpdated: "2 weeks ago",
    tags: ["first-build", "gaming", "budget-friendly"],
  },
  {
    id: "high-end-workstation",
    title: "Professional Workstation Build",
    description: "Build a powerful workstation for content creation, 3D rendering, and professional workflows",
    difficulty: "Advanced",
    duration: "3-4 hours",
    views: "23.1k",
    rating: 4.9,
    reviews: 567,
    category: "Workstation",
    performanceCategory: "academic" as PerformanceCategory,
    image: "/professional-workstation-pc.jpg",
    steps: 15,
    tools: ["Phillips screwdriver", "Anti-static wrist strap", "Thermal paste", "Cable management kit"],
    estimatedCost: "₱137,500-220,000",
    lastUpdated: "1 week ago",
    tags: ["professional", "high-performance", "content-creation"],
  },
  {
    id: "budget-office-pc",
    title: "Budget Office PC Build",
    description: "Build an efficient and affordable PC for office work, web browsing, and basic productivity tasks",
    difficulty: "Beginner",
    duration: "1-2 hours",
    views: "32.8k",
    rating: 4.6,
    reviews: 892,
    category: "Office",
    performanceCategory: "office" as PerformanceCategory,
    image: "/budget-office-computer.jpg",
    steps: 8,
    tools: ["Phillips screwdriver", "Anti-static wrist strap"],
    estimatedCost: "₱22,000-33,000",
    lastUpdated: "3 days ago",
    tags: ["budget", "office", "productivity"],
  },
  {
    id: "mini-itx-build",
    title: "Compact Mini-ITX Gaming Build",
    description: "Build a powerful gaming PC in a small form factor case perfect for limited space",
    difficulty: "Intermediate",
    duration: "3-4 hours",
    views: "18.7k",
    rating: 4.7,
    reviews: 423,
    category: "Gaming",
    performanceCategory: "gaming" as PerformanceCategory,
    image: "/gaming-pc-build-guide.png",
    steps: 14,
    tools: ["Phillips screwdriver", "Anti-static wrist strap", "Zip ties", "Small flashlight"],
    estimatedCost: "₱66,000-99,000",
    lastUpdated: "5 days ago",
    tags: ["mini-itx", "compact", "space-saving"],
  },
  {
    id: "rgb-showcase-build",
    title: "RGB Gaming Showcase Build",
    description: "Create a stunning RGB gaming build with synchronized lighting and tempered glass showcase",
    difficulty: "Intermediate",
    duration: "4-5 hours",
    views: "29.3k",
    rating: 4.5,
    reviews: 734,
    category: "Gaming",
    performanceCategory: "gaming" as PerformanceCategory,
    image: "/gaming-pc-build-guide.png",
    steps: 16,
    tools: ["Phillips screwdriver", "Anti-static wrist strap", "RGB controller", "Cable management kit"],
    estimatedCost: "₱82,500-137,500",
    lastUpdated: "1 week ago",
    tags: ["rgb", "showcase", "aesthetics"],
  },
  {
    id: "silent-build",
    title: "Ultra-Quiet Silent PC Build",
    description: "Build a whisper-quiet PC for noise-sensitive environments without compromising performance",
    difficulty: "Advanced",
    duration: "3-4 hours",
    views: "15.9k",
    rating: 4.8,
    reviews: 298,
    category: "Office",
    performanceCategory: "office" as PerformanceCategory,
    image: "/budget-office-computer.jpg",
    steps: 13,
    tools: ["Phillips screwdriver", "Anti-static wrist strap", "Sound dampening material", "Fan controller"],
    estimatedCost: "₱55,000-88,000",
    lastUpdated: "4 days ago",
    tags: ["silent", "quiet", "noise-reduction"],
  },
  {
    id: "academic-research-build",
    title: "Academic Research & Development PC",
    description: "Build a powerful PC optimized for research, data analysis, coding, and educational workloads",
    difficulty: "Intermediate",
    duration: "3-4 hours",
    views: "12.5k",
    rating: 4.7,
    reviews: 234,
    category: "Academic",
    performanceCategory: "academic" as PerformanceCategory,
    image: "/professional-workstation-pc.jpg",
    steps: 14,
    tools: ["Phillips screwdriver", "Anti-static wrist strap", "Thermal paste", "Cable management kit"],
    estimatedCost: "₱99,000-165,000",
    lastUpdated: "1 week ago",
    tags: ["research", "academic", "development", "coding"],
  },
  {
    id: "student-coding-build",
    title: "Student Coding & Learning PC",
    description: "Perfect build for students learning programming, running VMs, and handling multiple development tools",
    difficulty: "Beginner",
    duration: "2-3 hours",
    views: "19.3k",
    rating: 4.6,
    reviews: 456,
    category: "Academic",
    performanceCategory: "academic" as PerformanceCategory,
    image: "/budget-office-computer.jpg",
    steps: 11,
    tools: ["Phillips screwdriver", "Anti-static wrist strap", "Zip ties"],
    estimatedCost: "₱77,000-110,000",
    lastUpdated: "5 days ago",
    tags: ["student", "coding", "learning", "development"],
  },
]

const quickTips = [
  {
    icon: Wrench,
    title: "Essential Tools",
    description: "What you need before starting your build",
    tips: ["Phillips head screwdriver", "Anti-static wrist strap", "Good lighting", "Clean workspace"],
  },
  {
    icon: Zap,
    title: "Safety First",
    description: "Protect your components from static damage",
    tips: ["Ground yourself regularly", "Work on hard surfaces", "Avoid carpeted areas", "Handle components by edges"],
  },
  {
    icon: Shield,
    title: "Cable Management",
    description: "Keep your build clean and improve airflow",
    tips: [
      "Plan cable routes first",
      "Use zip ties sparingly",
      "Route behind motherboard tray",
      "Leave room for airflow",
    ],
  },
]

export default function GuidesPage() {
  const [searchTerm, setSearchTerm] = useState("")
  const [selectedPerformanceCategory, setSelectedPerformanceCategory] = useState<PerformanceCategory>("all")
  const [selectedDifficulty, setSelectedDifficulty] = useState("all")
  const [sortBy, setSortBy] = useState("popular")

  const getFilteredGuides = () => {
    const filtered = buildGuides.filter((guide) => {
      const matchesSearch =
        guide.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
        guide.description.toLowerCase().includes(searchTerm.toLowerCase()) ||
        guide.tags.some((tag) => tag.toLowerCase().includes(searchTerm.toLowerCase()))

      const matchesPerformanceCategory = selectedPerformanceCategory === "all" || guide.performanceCategory === selectedPerformanceCategory
      const matchesDifficulty = selectedDifficulty === "all" || guide.difficulty.toLowerCase() === selectedDifficulty

      return matchesSearch && matchesPerformanceCategory && matchesDifficulty
    })

    // Sort guides
    switch (sortBy) {
      case "newest":
        return filtered.sort((a, b) => new Date(b.lastUpdated).getTime() - new Date(a.lastUpdated).getTime())
      case "rating":
        return filtered.sort((a, b) => b.rating - a.rating)
      case "duration":
        return filtered.sort((a, b) => a.duration.localeCompare(b.duration))
      default: // popular
        return filtered.sort(
          (a, b) => Number.parseInt(b.views.replace("k", "000")) - Number.parseInt(a.views.replace("k", "000")),
        )
    }
  }

  const filteredGuides = getFilteredGuides()

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">

      <div className="container mx-auto px-4 py-8">
        {/* Page Header */}
        <div className="text-center mb-12">
          <h2 className="text-4xl font-bold text-slate-900 dark:text-white mb-4">Build Guides</h2>
          <p className="text-xl text-slate-600 dark:text-slate-400 max-w-2xl mx-auto">
            Step-by-step tutorials to help you build your perfect PC with confidence
          </p>
          <div className="flex items-center justify-center gap-8 mt-6 text-sm text-slate-600 dark:text-slate-400">
            <div className="flex items-center gap-1">
              <BookOpen className="h-4 w-4" />
              <span>{buildGuides.length} guides available</span>
            </div>
            <div className="flex items-center gap-1">
              <Users className="h-4 w-4" />
              <span>150k+ builders helped</span>
            </div>
            <div className="flex items-center gap-1">
              <Star className="h-4 w-4" />
              <span>4.7 average rating</span>
            </div>
          </div>
        </div>

        {/* Quick Tips */}
        <div className="grid md:grid-cols-3 gap-6 mb-12">
          {quickTips.map((tip, index) => (
            <Card key={index} className="border-slate-200 dark:border-slate-700">
              <CardHeader className="text-center">
                <tip.icon className="h-12 w-12 text-blue-600 mx-auto mb-2" />
                <CardTitle className="text-lg">{tip.title}</CardTitle>
                <CardDescription>{tip.description}</CardDescription>
              </CardHeader>
              <CardContent>
                <ul className="space-y-1 text-sm text-slate-600 dark:text-slate-400">
                  {tip.tips.map((tipItem, tipIndex) => (
                    <li key={tipIndex} className="flex items-center gap-2">
                      <CheckCircle className="h-3 w-3 text-green-500 flex-shrink-0" />
                      {tipItem}
                    </li>
                  ))}
                </ul>
              </CardContent>
            </Card>
          ))}
        </div>

        <div className="mb-8">
          <div className="flex flex-col lg:flex-row gap-4 mb-6">
            <div className="flex-1 relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-slate-400" />
              <Input
                placeholder="Search guides, topics, or tags..."
                className="pl-10"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
            </div>
            <div className="flex gap-2">
              <Select value={selectedPerformanceCategory} onValueChange={(value) => setSelectedPerformanceCategory(value as PerformanceCategory)}>
                <SelectTrigger className="w-48">
                  <SelectValue placeholder="Performance Category" />
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
              <Select value={selectedDifficulty} onValueChange={setSelectedDifficulty}>
                <SelectTrigger className="w-32">
                  <SelectValue placeholder="Difficulty" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Levels</SelectItem>
                  <SelectItem value="beginner">Beginner</SelectItem>
                  <SelectItem value="intermediate">Intermediate</SelectItem>
                  <SelectItem value="advanced">Advanced</SelectItem>
                </SelectContent>
              </Select>
              <Select value={sortBy} onValueChange={setSortBy}>
                <SelectTrigger className="w-32">
                  <SelectValue placeholder="Sort by" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="popular">Most Popular</SelectItem>
                  <SelectItem value="newest">Newest</SelectItem>
                  <SelectItem value="rating">Highest Rated</SelectItem>
                  <SelectItem value="duration">Duration</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>
        </div>

        {/* Build Guides */}
        <div className="mb-8">
          <div className="flex items-center justify-between mb-6">
            <h3 className="text-2xl font-bold text-slate-900 dark:text-white">
              {selectedPerformanceCategory === "all"
                ? "All Guides"
                : `${performanceCategories[selectedPerformanceCategory].name} Guides`}
            </h3>
            <span className="text-sm text-slate-600 dark:text-slate-400">
              {filteredGuides.length} guide{filteredGuides.length !== 1 ? "s" : ""} found
            </span>
          </div>

          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredGuides.map((guide) => (
              <Card
                key={guide.id}
                className="border-slate-200 dark:border-slate-700 hover:shadow-lg transition-all duration-200 group"
              >
                <div className="relative">
                  <img
                    src={guide.image || "/placeholder.svg"}
                    alt={guide.title}
                    className="w-full h-48 object-cover rounded-t-lg"
                  />
                  <div className="absolute top-4 left-4 flex gap-2">
                    <Badge className="bg-blue-600">{performanceCategories[guide.performanceCategory].name}</Badge>
                    <Badge
                      variant={
                        guide.difficulty === "Beginner"
                          ? "secondary"
                          : guide.difficulty === "Advanced"
                            ? "destructive"
                            : "default"
                      }
                    >
                      {guide.difficulty}
                    </Badge>
                  </div>
                  <div className="absolute top-4 right-4">
                    <Badge variant="outline" className="bg-white/90 text-slate-900">
                      {guide.estimatedCost}
                    </Badge>
                  </div>
                </div>

                <CardHeader className="pb-3">
                  <CardTitle className="text-lg group-hover:text-blue-600 transition-colors">{guide.title}</CardTitle>
                  <CardDescription className="line-clamp-2">{guide.description}</CardDescription>

                  <div className="flex items-center gap-2 mt-2">
                    <div className="flex items-center">
                      {[...Array(5)].map((_, i) => (
                        <Star
                          key={i}
                          className={`w-3 h-3 ${
                            i < Math.floor(guide.rating) ? "text-yellow-400 fill-current" : "text-slate-300"
                          }`}
                        />
                      ))}
                    </div>
                    <span className="text-xs text-slate-600 dark:text-slate-400">
                      {guide.rating} ({guide.reviews} reviews)
                    </span>
                  </div>
                </CardHeader>

                <CardContent className="space-y-4">
                  {/* Guide stats */}
                  <div className="grid grid-cols-2 gap-4 text-sm text-slate-600 dark:text-slate-400">
                    <div className="flex items-center gap-1">
                      <Clock className="h-4 w-4" />
                      <span>{guide.duration}</span>
                    </div>
                    <div className="flex items-center gap-1">
                      <BookOpen className="h-4 w-4" />
                      <span>{guide.steps} steps</span>
                    </div>
                    <div className="flex items-center gap-1">
                      <Users className="h-4 w-4" />
                      <span>{guide.views} views</span>
                    </div>
                    <div className="flex items-center gap-1">
                      <Wrench className="h-4 w-4" />
                      <span>{guide.tools.length} tools</span>
                    </div>
                  </div>

                  {/* Tags */}
                  <div className="flex flex-wrap gap-1">
                    {guide.tags.slice(0, 3).map((tag) => (
                      <Badge key={tag} variant="outline" className="text-xs">
                        {tag}
                      </Badge>
                    ))}
                  </div>

                  <div className="flex items-center justify-between pt-2 border-t border-slate-100 dark:border-slate-700">
                    <span className="text-xs text-slate-500">Updated {guide.lastUpdated}</span>
                    <Button size="sm" asChild className="bg-blue-600 hover:bg-blue-700">
                      <Link href={`/guides/${guide.id}`}>
                        <Play className="h-4 w-4 mr-2" />
                        Start Guide
                      </Link>
                    </Button>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>

          {filteredGuides.length === 0 && (
            <div className="text-center py-12">
              <BookOpen className="h-12 w-12 text-slate-400 mx-auto mb-4" />
              <h3 className="text-lg font-medium text-slate-900 dark:text-white mb-2">No guides found</h3>
              <p className="text-slate-600 dark:text-slate-400 mb-4">Try adjusting your search terms or filters</p>
              <Button
                variant="outline"
                onClick={() => {
                  setSearchTerm("")
                  setSelectedPerformanceCategory("all")
                  setSelectedDifficulty("all")
                }}
              >
                Clear Filters
              </Button>
            </div>
          )}
        </div>

        {/* CTA Section */}
        <div className="text-center py-12 bg-white dark:bg-slate-900 rounded-lg">
          <h3 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">Ready to Start Building?</h3>
          <p className="text-slate-600 dark:text-slate-400 mb-6 max-w-xl mx-auto">
            Use our PC Builder tool to select compatible components and get real-time compatibility checking
          </p>
          <Button size="lg" asChild>
            <Link href="/builder">
              <Cpu className="h-5 w-5 mr-2" />
              Open PC Builder
            </Link>
          </Button>
        </div>
      </div>
    </div>
  )
}
