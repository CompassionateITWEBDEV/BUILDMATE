"use client"

import { useState, useEffect } from "react"
import { useParams, useRouter } from "next/navigation"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Textarea } from "@/components/ui/textarea"
import { Separator } from "@/components/ui/separator"
import {
  ArrowLeft,
  Heart,
  Share,
  Copy,
  Download,
  User,
  Calendar,
  Eye,
  Cpu,
  Monitor,
  MemoryStick,
  HardDrive,
  Zap,
  Fan,
  Box,
  Send,
  BatteryCharging,
  Server as MotherboardIcon,
} from "lucide-react"
import { supabase } from "@/lib/supabase"
import { formatCurrency } from "@/lib/currency"
import { useAuth } from "@/contexts/supabase-auth-context"

const categoryMap = {
  1: "CPU",
  2: "Motherboard",
  3: "RAM",
  4: "Storage",
  5: "GPU",
  6: "PSU",
  7: "Case",
  8: "Cooling",
};


const categoryIcons = {
  CPU: Cpu,
  Motherboard: MotherboardIcon,
  RAM: MemoryStick,
  Storage: HardDrive,
  GPU: Monitor,
  PSU: BatteryCharging,
  Case: Box,
  Cooling: Fan,
}
export default function BuildDetailPage() {
  const params = useParams()
  const router = useRouter()
  const { user } = useAuth()

  const [build, setBuild] = useState<any>(null)
  const [creator, setCreator] = useState<any>(null)
  const [loading, setLoading] = useState(true)
  const [isLiked, setIsLiked] = useState(false)
  const [comment, setComment] = useState("")
  const [totalUserBuilds, setTotalUserBuilds] = useState(0)
  const [comments, setComments] = useState([
    {
      id: "1",
      user: "TechEnthusiast",
      avatar: "/diverse-user-avatars.png",
      content: "Amazing build! The component selection is perfect for 4K gaming.",
      timestamp: "2 hours ago",
      likes: 5,
    },
    {
      id: "2",
      user: "PCBuilder2024",
      avatar: "/diverse-user-avatars.png",
      content: "Great choice on the CPU cooler. How are the temps under load?",
      timestamp: "5 hours ago",
      likes: 2,
    },
  ])

  useEffect(() => {
    const fetchBuild = async () => {
      if (!params.id) return

      // Fetch build with components
      const { data: buildData, error: buildError } = await supabase
        .from("builds")
        .select(`
          *,
          build_components(*, components(*))
        `)
        .eq("build_id", Number(params.id))
        .single()

      if (buildError || !buildData) {
        setBuild(null)
        setLoading(false)
        return
      }

      // Map build_components array into components object and normalize prices
      const componentsObj = (buildData.build_components || []).reduce((acc: any, comp: any) => {
        if (!comp.components) return acc;

        const categoryName = categoryMap[comp.components.category_id]; // <-- correct lookup

        if (!categoryName) return acc;

        if (!acc[categoryName]) acc[categoryName] = [];

        acc[categoryName].push({
          ...comp.components,
          price: comp.components.component_price ?? 0,
        });

        return acc;
      }, {});


      // Set build state with totalPrice
      setBuild({
        ...buildData,
        totalPrice: buildData.total_price ?? 0,
        components: componentsObj,
      })
      console.log("Components:", componentsObj)
      // Fetch the creator
      const { data: userData, error: userError } = await supabase
        .from("users")
        .select("*")
        .eq("user_id", buildData.user_id) // <-- Make sure this matches your DB field
        .single()
      if (!userError && userData) {
        setCreator(userData)
        // Fetch total builds by this user
        const { count, error: countError } = await supabase
          .from("builds")
          .select("*", { count: "exact", head: true })
          .eq("user_id", userData.user_id)
        if (!countError) {
          setTotalUserBuilds(count || 0)
        } else {
          console.log("Error fetching total builds:", countError)
        }
      } else {
        setCreator(null)
      }
      setLoading(false)
    }
    
    fetchBuild()
  }, [params.id])

  const handleAddComment = () => {
    if (!comment.trim()) return

    const newComment = {
      id: Date.now().toString(),
      user: user?.user_name || "Anonymous",
      avatar: "/diverse-user-avatars.png",
      content: comment,
      timestamp: "Just now",
      likes: 0,
    }

    setComments((prev) => [newComment, ...prev])
    setComment("")
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        Loading...
      </div>
    )
  }

  if (!build) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold mb-2">Build not found</h2>
          <Button asChild>
            <Link href="/builds">Back to Builds</Link>
          </Button>
        </div>
      </div>
    )
  }

  const totalComponents = Object.values(build.components || {}).flat().length;

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      {/* Header */}
      <header className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center gap-4">
            <Button variant="ghost" size="sm" onClick={() => router.back()}>
              <ArrowLeft className="h-4 w-4 mr-2" />
              Back
            </Button>
            <div className="flex items-center gap-2">
              <Cpu className="h-6 w-6 text-blue-600" />
              <h1 className="text-xl font-bold text-slate-900 dark:text-white">BuildMate</h1>
            </div>
          </div>
        </div>
      </header>

      <div className="container mx-auto px-4 py-8">
        <div className="grid lg:grid-cols-3 gap-8">
          {/* Main Content */}
          <div className="lg:col-span-2 space-y-6">
            {/* Build Header */}
            <Card>
              <CardHeader>
                <div className="flex items-start justify-between">
                  <div>
                    <CardTitle className="text-2xl mb-2">{build.name}</CardTitle>
                    <div className="flex items-center gap-3 mb-3">
                      <Avatar className="h-8 w-8">
                        <AvatarImage src={creator?.avatar || "/placeholder.svg"} />
                        <AvatarFallback>{creator?.user_name?.charAt(0).toUpperCase() || "U"}</AvatarFallback>
                      </Avatar>
                      <div>
                        <p className="font-medium text-slate-900 dark:text-white">{creator?.user_name || "Unknown"}</p>
                        <div className="flex items-center gap-4 text-sm text-slate-500">
                          <div className="flex items-center gap-1">
                            <Calendar className="h-3 w-3" />
                            <span>Jan 15, 2024</span>
                          </div>
                          <div className="flex items-center gap-1">
                            <Eye className="h-3 w-3" />
                            <span>1.2k views</span>
                          </div>
                        </div>
                      </div>
                    </div>
                    <p className="text-slate-600 dark:text-slate-400">{build.description}</p>
                  </div>
                  <Badge variant="secondary" className="text-lg font-bold px-3 py-1">
                    {formatCurrency(build.totalPrice)}
                  </Badge>
                </div>

                {/* Tags */}
                <div className="flex flex-wrap gap-2">
                  {(build.tags || []).map((tag: string) => (
                    <Badge key={tag} variant="outline">
                      {tag}
                    </Badge>
                  ))}
                </div>

                {/* Actions */}
                <div className="flex items-center gap-4 pt-4">
                  <Button
                    variant={isLiked ? "default" : "outline"}
                    onClick={() => setIsLiked(!isLiked)}
                    className="flex items-center gap-2"
                  >
                    <Heart className={`h-4 w-4 ${isLiked ? "fill-current" : ""}`} />
                    {build.likes + (isLiked ? 1 : 0)} Likes
                  </Button>
                  <Button variant="outline" className="flex items-center gap-2 bg-transparent">
                    <Copy className="h-4 w-4" />
                    Clone Build
                  </Button>
                  <Button variant="outline" className="flex items-center gap-2 bg-transparent">
                    <Share className="h-4 w-4" />
                    Share
                  </Button>
                  <Button variant="outline" className="flex items-center gap-2 bg-transparent">
                    <Download className="h-4 w-4" />
                    Export
                  </Button>
                </div>
              </CardHeader>
            </Card>

            {/* Components List */}
            <Card>
              <CardHeader>
                <CardTitle>Components ({totalComponents}/8)</CardTitle>
                <CardDescription>Complete parts list for this build</CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                {Object.entries(build.components || {}).map(([category, comps]) => {
                  const Icon = categoryIcons[category] || Box;

                  return comps.map((component, idx) => (
                    <div
                      key={`${category}-${idx}`}
                      className="flex items-center gap-4 p-4 border border-slate-200 dark:border-slate-700 rounded-lg"
                    >
                      <Icon className="h-8 w-8 text-slate-500" />
                      <div className="flex-1">
                        <h3 className="font-medium text-slate-900 dark:text-white capitalize">
                          {category === "psu" ? "Power Supply" : category}
                        </h3>
                        <p className="text-sm text-slate-600 dark:text-slate-400">
                          {component.brand} {component.name}
                        </p>
                        <div className="flex items-center gap-4 mt-1 text-xs text-slate-500">
                          <span>★ {component.rating}</span>
                          <span>{component.reviews} reviews</span>
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="font-semibold text-slate-900 dark:text-white">{formatCurrency(component.price)}</p>
                      </div>
                    </div>
                  ));
                })}

              </CardContent>
            </Card>

            {/* Comments Section */}
            <Card>
              <CardHeader>
                <CardTitle>Comments ({comments.length})</CardTitle>
              </CardHeader>
              <CardContent className="space-y-6">
                {/* Add Comment */}
                {user && (
                  <div className="space-y-3">
                    <Textarea
                      placeholder="Share your thoughts about this build..."
                      value={comment}
                      onChange={(e) => setComment(e.target.value)}
                      className="min-h-20"
                    />
                    <div className="flex justify-end">
                      <Button onClick={handleAddComment} disabled={!comment.trim()}>
                        <Send className="h-4 w-4 mr-2" />
                        Post Comment
                      </Button>
                    </div>
                  </div>
                )}

                <Separator />

                {/* Comments List */}
                <div className="space-y-4">
                  {comments.map((comment) => (
                    <div key={comment.id} className="flex gap-3">
                      <Avatar className="h-8 w-8">
                        <AvatarImage src={comment.avatar || "/placeholder.svg"} />
                        <AvatarFallback>{comment.user.charAt(0).toUpperCase()}</AvatarFallback>
                      </Avatar>
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-1">
                          <span className="font-medium text-sm">{comment.user}</span>
                          <span className="text-xs text-slate-500">{comment.timestamp}</span>
                        </div>
                        <p className="text-sm text-slate-600 dark:text-slate-400 mb-2">{comment.content}</p>
                        <div className="flex items-center gap-4 text-xs">
                          <button className="flex items-center gap-1 text-slate-500 hover:text-red-500">
                            <Heart className="h-3 w-3" />
                            {comment.likes}
                          </button>
                          <button className="text-slate-500 hover:text-slate-700">Reply</button>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </div>

          {/* Sidebar */}
          <div className="space-y-6">
            {/* Build Stats */}
            <Card>
              <CardHeader>
                <CardTitle>Build Statistics</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Total Components</span>
                  <span className="font-medium">{totalComponents}/8</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Total Price</span>
                  <span className="font-medium">{formatCurrency(build.totalPrice)}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Likes</span>
                  <span className="font-medium">{build.likes + (isLiked ? 1 : 0)}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Views</span>
                  <span className="font-medium">1,247</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Comments</span>
                  <span className="font-medium">{comments.length}</span>
                </div>
              </CardContent>
            </Card>

            {/* Creator Info */}
            <Card>
              <CardHeader>
                <CardTitle>About the Creator</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="flex items-center gap-3 mb-4">
                  <Avatar className="h-12 w-12">
                    <AvatarImage src={creator?.avatar || "/placeholder.svg"} />
                    <AvatarFallback>{creator?.user_name?.charAt(0).toUpperCase() || "U"}</AvatarFallback>
                  </Avatar>
                  <div>
                    <h3 className="font-medium">{creator?.user_name || "Unknown"}</h3>
                    <p className="text-sm text-slate-500">Member since Jan 2024</p>
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-4 text-sm">
                  <div>
                    <span className="text-slate-600 dark:text-slate-400">Builds</span>
                    <p className="font-medium">{totalUserBuilds}</p>
                  </div>
                  <div>
                    <span className="text-slate-600 dark:text-slate-400">Followers</span>
                    <p className="font-medium">234</p>
                  </div>
                </div>
                <Button className="w-full mt-4 bg-transparent" variant="outline">
                  <User className="h-4 w-4 mr-2" />
                  Follow
                </Button>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  )
}
