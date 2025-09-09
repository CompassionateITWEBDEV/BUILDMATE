"use client"

import { useEffect, useState } from "react"
import { useRouter } from "next/navigation"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import {
  Cpu,
  Plus,
  Settings,
  LogOut,
  Wrench,
  Users,
  BookOpen,
  Star,
  Heart,
  MessageCircle,
  Share,
  Edit,
  Eye,
  Calendar,
  Trophy,
} from "lucide-react"
import { useAuth } from "@/contexts/auth-context"
import { mockBuilds } from "@/lib/mock-data"

export default function DashboardPage() {
  const { user, logout, isLoading } = useAuth()
  const router = useRouter()
  const [activeTab, setActiveTab] = useState("overview")

  useEffect(() => {
    if (!isLoading && !user) {
      router.push("/login")
    }
  }, [user, isLoading, router])

  if (isLoading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800 flex items-center justify-center">
        <div className="text-center">
          <Cpu className="h-12 w-12 text-blue-600 mx-auto mb-4 animate-pulse" />
          <p className="text-slate-600 dark:text-slate-400">Loading...</p>
        </div>
      </div>
    )
  }

  if (!user) {
    return null
  }

  const handleLogout = () => {
    logout()
    router.push("/")
  }

  const userBuilds = mockBuilds.filter((build) => build.createdBy === user.id)
  const likedBuilds = mockBuilds.filter((build) => user.likedBuilds.includes(build.id))
  const totalLikes = userBuilds.reduce((sum, build) => sum + build.likes, 0)
  const totalViews = userBuilds.length * 1200 // Mock view count

  const achievements = [
    { id: 1, name: "First Build", description: "Created your first PC build", earned: true, icon: Wrench },
    { id: 2, name: "Community Favorite", description: "Received 100+ likes", earned: totalLikes >= 100, icon: Heart },
    { id: 3, name: "Build Master", description: "Created 10+ builds", earned: userBuilds.length >= 10, icon: Trophy },
    { id: 4, name: "Guide Follower", description: "Completed a build guide", earned: true, icon: BookOpen },
  ]

  const recentActivity = [
    { id: 1, type: "build_created", description: "Created 'Ultimate Gaming Beast'", time: "2 hours ago", icon: Plus },
    { id: 2, type: "build_liked", description: "Liked 'Budget Gaming Starter'", time: "1 day ago", icon: Heart },
    {
      id: 3,
      type: "guide_completed",
      description: "Completed 'First Gaming PC Build' guide",
      time: "3 days ago",
      icon: BookOpen,
    },
    {
      id: 4,
      type: "comment",
      description: "Commented on 'Workstation Build'",
      time: "1 week ago",
      icon: MessageCircle,
    },
  ]

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
            <div className="flex items-center gap-4">
              <div className="flex items-center gap-3">
                <Avatar className="h-8 w-8">
                  <AvatarImage src={user.avatar || "/placeholder.svg"} />
                  <AvatarFallback>{user.username.charAt(0).toUpperCase()}</AvatarFallback>
                </Avatar>
                <span className="text-slate-600 dark:text-slate-300">Welcome, {user.username}!</span>
              </div>
              <Button variant="outline" size="sm">
                <Settings className="h-4 w-4 mr-2" />
                Settings
              </Button>
              <Button variant="outline" size="sm" onClick={handleLogout}>
                <LogOut className="h-4 w-4 mr-2" />
                Logout
              </Button>
            </div>
          </div>
        </div>
      </header>

      <div className="container mx-auto px-4 py-8">
        <div className="mb-8">
          <div className="flex items-center justify-between mb-6">
            <div>
              <h2 className="text-3xl font-bold text-slate-900 dark:text-white mb-2">Dashboard</h2>
              <p className="text-slate-600 dark:text-slate-400">
                Manage your builds, track your progress, and connect with the community.
              </p>
            </div>
            <Button size="lg" asChild>
              <Link href="/builder">
                <Plus className="h-5 w-5 mr-2" />
                New Build
              </Link>
            </Button>
          </div>

          {/* User Stats Cards */}
          <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <Card className="border-slate-200 dark:border-slate-700">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm text-slate-600 dark:text-slate-400">Total Builds</p>
                    <p className="text-2xl font-bold text-slate-900 dark:text-white">{userBuilds.length}</p>
                  </div>
                  <Wrench className="h-8 w-8 text-blue-600" />
                </div>
              </CardContent>
            </Card>

            <Card className="border-slate-200 dark:border-slate-700">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm text-slate-600 dark:text-slate-400">Total Likes</p>
                    <p className="text-2xl font-bold text-slate-900 dark:text-white">{totalLikes}</p>
                  </div>
                  <Heart className="h-8 w-8 text-red-500" />
                </div>
              </CardContent>
            </Card>

            <Card className="border-slate-200 dark:border-slate-700">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm text-slate-600 dark:text-slate-400">Profile Views</p>
                    <p className="text-2xl font-bold text-slate-900 dark:text-white">{totalViews.toLocaleString()}</p>
                  </div>
                  <Eye className="h-8 w-8 text-green-600" />
                </div>
              </CardContent>
            </Card>

            <Card className="border-slate-200 dark:border-slate-700">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm text-slate-600 dark:text-slate-400">Achievements</p>
                    <p className="text-2xl font-bold text-slate-900 dark:text-white">
                      {achievements.filter((a) => a.earned).length}/{achievements.length}
                    </p>
                  </div>
                  <Trophy className="h-8 w-8 text-yellow-600" />
                </div>
              </CardContent>
            </Card>
          </div>
        </div>

        <Tabs value={activeTab} onValueChange={setActiveTab}>
          <TabsList className="grid w-full grid-cols-5">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="builds">My Builds</TabsTrigger>
            <TabsTrigger value="liked">Liked Builds</TabsTrigger>
            <TabsTrigger value="achievements">Achievements</TabsTrigger>
            <TabsTrigger value="activity">Activity</TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-6">
            <div className="grid lg:grid-cols-3 gap-6">
              {/* Quick Actions */}
              <div className="lg:col-span-2">
                <Card>
                  <CardHeader>
                    <CardTitle>Quick Actions</CardTitle>
                    <CardDescription>Jump into your most common tasks</CardDescription>
                  </CardHeader>
                  <CardContent>
                    <div className="grid md:grid-cols-2 gap-4">
                      <Link href="/builder">
                        <Card className="border-slate-200 dark:border-slate-700 hover:shadow-md transition-shadow cursor-pointer">
                          <CardContent className="p-4">
                            <div className="flex items-center gap-3">
                              <Wrench className="h-8 w-8 text-blue-600" />
                              <div>
                                <h3 className="font-medium">New Build</h3>
                                <p className="text-sm text-slate-600 dark:text-slate-400">
                                  Start building your dream PC
                                </p>
                              </div>
                            </div>
                          </CardContent>
                        </Card>
                      </Link>

                      <Link href="/builds">
                        <Card className="border-slate-200 dark:border-slate-700 hover:shadow-md transition-shadow cursor-pointer">
                          <CardContent className="p-4">
                            <div className="flex items-center gap-3">
                              <Users className="h-8 w-8 text-green-600" />
                              <div>
                                <h3 className="font-medium">Browse Community</h3>
                                <p className="text-sm text-slate-600 dark:text-slate-400">Discover popular builds</p>
                              </div>
                            </div>
                          </CardContent>
                        </Card>
                      </Link>

                      <Link href="/guides">
                        <Card className="border-slate-200 dark:border-slate-700 hover:shadow-md transition-shadow cursor-pointer">
                          <CardContent className="p-4">
                            <div className="flex items-center gap-3">
                              <BookOpen className="h-8 w-8 text-purple-600" />
                              <div>
                                <h3 className="font-medium">Build Guides</h3>
                                <p className="text-sm text-slate-600 dark:text-slate-400">Learn step-by-step</p>
                              </div>
                            </div>
                          </CardContent>
                        </Card>
                      </Link>

                      <Card className="border-slate-200 dark:border-slate-700 hover:shadow-md transition-shadow cursor-pointer">
                        <CardContent className="p-4">
                          <div className="flex items-center gap-3">
                            <Star className="h-8 w-8 text-yellow-600" />
                            <div>
                              <h3 className="font-medium">Recommendations</h3>
                              <p className="text-sm text-slate-600 dark:text-slate-400">AI-powered suggestions</p>
                            </div>
                          </div>
                        </CardContent>
                      </Card>
                    </div>
                  </CardContent>
                </Card>
              </div>

              {/* Recent Activity */}
              <Card>
                <CardHeader>
                  <CardTitle>Recent Activity</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {recentActivity.map((activity) => (
                      <div key={activity.id} className="flex items-start gap-3">
                        <activity.icon className="h-4 w-4 text-slate-500 mt-1" />
                        <div className="flex-1">
                          <p className="text-sm text-slate-900 dark:text-white">{activity.description}</p>
                          <p className="text-xs text-slate-500">{activity.time}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          <TabsContent value="builds" className="space-y-6">
            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <div>
                    <CardTitle>My Builds ({userBuilds.length})</CardTitle>
                    <CardDescription>Your saved PC configurations</CardDescription>
                  </div>
                  <Button asChild>
                    <Link href="/builder">
                      <Plus className="h-4 w-4 mr-2" />
                      New Build
                    </Link>
                  </Button>
                </div>
              </CardHeader>
              <CardContent>
                {userBuilds.length === 0 ? (
                  <div className="text-center py-12">
                    <Wrench className="h-12 w-12 text-slate-400 mx-auto mb-4" />
                    <h3 className="text-lg font-medium text-slate-900 dark:text-white mb-2">No builds yet</h3>
                    <p className="text-slate-600 dark:text-slate-400 mb-4">
                      Start building your first PC configuration
                    </p>
                    <Button asChild>
                      <Link href="/builder">Create Your First Build</Link>
                    </Button>
                  </div>
                ) : (
                  <div className="grid md:grid-cols-2 gap-6">
                    {userBuilds.map((build) => (
                      <Card key={build.id} className="border-slate-200 dark:border-slate-700">
                        <CardHeader className="pb-3">
                          <div className="flex items-start justify-between">
                            <div>
                              <CardTitle className="text-lg">{build.name}</CardTitle>
                              <CardDescription className="mt-1">{build.description}</CardDescription>
                            </div>
                            <Badge variant="secondary">${build.totalPrice.toLocaleString()}</Badge>
                          </div>
                        </CardHeader>
                        <CardContent className="space-y-4">
                          <div className="flex flex-wrap gap-1">
                            {build.tags.map((tag) => (
                              <Badge key={tag} variant="outline" className="text-xs">
                                {tag}
                              </Badge>
                            ))}
                          </div>

                          <div className="flex items-center justify-between text-sm text-slate-600 dark:text-slate-400">
                            <div className="flex items-center gap-4">
                              <div className="flex items-center gap-1">
                                <Heart className="h-4 w-4" />
                                {build.likes}
                              </div>
                              <div className="flex items-center gap-1">
                                <Eye className="h-4 w-4" />
                                1.2k
                              </div>
                              <div className="flex items-center gap-1">
                                <Calendar className="h-4 w-4" />
                                {build.createdAt.toLocaleDateString()}
                              </div>
                            </div>
                          </div>

                          <div className="flex gap-2">
                            <Button size="sm" variant="outline" asChild className="flex-1 bg-transparent">
                              <Link href={`/builds/${build.id}`}>
                                <Eye className="h-4 w-4 mr-2" />
                                View
                              </Link>
                            </Button>
                            <Button size="sm" variant="outline" asChild className="flex-1 bg-transparent">
                              <Link href={`/builder?clone=${build.id}`}>
                                <Edit className="h-4 w-4 mr-2" />
                                Edit
                              </Link>
                            </Button>
                            <Button size="sm" variant="outline">
                              <Share className="h-4 w-4 mr-2" />
                              Share
                            </Button>
                          </div>
                        </CardContent>
                      </Card>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="liked" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Liked Builds ({likedBuilds.length})</CardTitle>
                <CardDescription>Builds you've liked from the community</CardDescription>
              </CardHeader>
              <CardContent>
                {likedBuilds.length === 0 ? (
                  <div className="text-center py-12">
                    <Heart className="h-12 w-12 text-slate-400 mx-auto mb-4" />
                    <h3 className="text-lg font-medium text-slate-900 dark:text-white mb-2">No liked builds yet</h3>
                    <p className="text-slate-600 dark:text-slate-400 mb-4">
                      Explore the community and like builds that inspire you
                    </p>
                    <Button asChild>
                      <Link href="/builds">Browse Community Builds</Link>
                    </Button>
                  </div>
                ) : (
                  <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
                    {likedBuilds.map((build) => (
                      <Card key={build.id} className="border-slate-200 dark:border-slate-700">
                        <CardHeader className="pb-3">
                          <CardTitle className="text-base">{build.name}</CardTitle>
                          <CardDescription className="text-sm">${build.totalPrice.toLocaleString()}</CardDescription>
                        </CardHeader>
                        <CardContent>
                          <div className="flex items-center justify-between">
                            <div className="flex items-center gap-2 text-sm text-slate-600 dark:text-slate-400">
                              <Heart className="h-4 w-4 text-red-500" />
                              {build.likes}
                            </div>
                            <Button size="sm" variant="outline" asChild>
                              <Link href={`/builds/${build.id}`}>View</Link>
                            </Button>
                          </div>
                        </CardContent>
                      </Card>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="achievements" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Achievements</CardTitle>
                <CardDescription>Track your progress and unlock new badges</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="grid md:grid-cols-2 gap-6">
                  {achievements.map((achievement) => (
                    <Card
                      key={achievement.id}
                      className={`border-slate-200 dark:border-slate-700 ${
                        achievement.earned ? "bg-green-50 dark:bg-green-900/20" : "opacity-60"
                      }`}
                    >
                      <CardContent className="p-4">
                        <div className="flex items-center gap-3">
                          <achievement.icon
                            className={`h-8 w-8 ${achievement.earned ? "text-green-600" : "text-slate-400"}`}
                          />
                          <div>
                            <h3 className="font-medium">{achievement.name}</h3>
                            <p className="text-sm text-slate-600 dark:text-slate-400">{achievement.description}</p>
                          </div>
                          {achievement.earned && <Badge className="ml-auto bg-green-600">Earned</Badge>}
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="activity" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Activity Timeline</CardTitle>
                <CardDescription>Your recent actions and interactions</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-6">
                  {recentActivity.map((activity, index) => (
                    <div key={activity.id} className="flex items-start gap-4">
                      <div className="flex flex-col items-center">
                        <div className="p-2 bg-blue-100 dark:bg-blue-900/30 rounded-full">
                          <activity.icon className="h-4 w-4 text-blue-600" />
                        </div>
                        {index < recentActivity.length - 1 && (
                          <div className="w-px h-8 bg-slate-200 dark:bg-slate-700 mt-2" />
                        )}
                      </div>
                      <div className="flex-1 pb-4">
                        <p className="text-sm text-slate-900 dark:text-white">{activity.description}</p>
                        <p className="text-xs text-slate-500 mt-1">{activity.time}</p>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  )
}
