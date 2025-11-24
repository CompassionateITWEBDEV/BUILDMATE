"use client"

import { useEffect, useState } from "react"
import { useRouter } from "next/navigation"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Navigation } from "@/components/navigation"
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
import { useAuth } from "@/contexts/supabase-auth-context"
import { mockBuilds } from "@/lib/mock-data"
import { supabase } from "@/lib/supabase"
import { time } from "console"

export default function DashboardPage() {
  const { user, logout, isLoading } = useAuth()
  const router = useRouter()
  const [activeTab, setActiveTab] = useState("overview")

  const [userBuilds, setUserBuilds] = useState<any[]>([])
  const [likedBuilds, setLikedBuilds] = useState<any[]>([])
  const [totalLikes, setTotalLikes] = useState(0)
  const [loadingBuilds, setLoadingBuilds] = useState(false)
  const [loadingLikes, setLoadingLikes] = useState(false)
  const [recentActivity, setRecentActivity] = useState<any[]>([]);
  const [followers, setFollowers] = useState<any[]>([]);

  useEffect(() => {
    if (!isLoading && !user) {
      router.push("/login")
    }
  }, [user, isLoading, router])

  // Fetch user builds
  useEffect(() => {
    const fetchUserBuilds = async () => {
      if (!user) return
      setLoadingBuilds(true)

      const { data, error } = await supabase
        .from("builds")
        .select("*, build_types(type_name)")
        .eq("user_id", user.user_id) // make sure type matches column (number or uuid)
        .order("date_created", { ascending: false })

      if (error) console.error("Error fetching builds:", error)
      if (data) {
        setUserBuilds(data)
        const likes = data.reduce((sum, build) => sum + (build.likes || 0), 0)
        setTotalLikes(likes)
      }

      setLoadingBuilds(false)
    }

    fetchUserBuilds()
  }, [user, supabase])

  // Fetch total likes received on user builds
  useEffect(() => {
    const fetchTotalLikes = async () => {
      if (!user) return

      setLoadingLikes(true)

      // Get all builds created by this user
      const { data: buildsData, error: buildsError } = await supabase
        .from("builds")
        .select("likes") // only need the likes column
        .eq("user_id", user.user_id)

      if (buildsError) {
        console.error("Error fetching user builds for likes:", buildsError)
        setLoadingLikes(false)
        return
      }

      if (buildsData) {
        // Sum up all likes
        const likesSum = buildsData.reduce((sum, build) => sum + (build.likes || 0), 0)
        setTotalLikes(likesSum)
      }

      setLoadingLikes(false)
    }

    fetchTotalLikes()
  }, [user, supabase])

  // Fetch liked builds
  useEffect(() => {
    const fetchLikedBuilds = async () => {
      if (!user) return;
      setLoadingLikes(true);

      const { data: likedData, error: likedError } = await supabase
        .from("build_likes")
        .select("*, builds(*, build_types(type_name))") // fetch related builds
        .eq("user_id", user.user_id)
        .order("created_at", { ascending: false });

      if (likedError) console.error("Error fetching liked builds:", likedError);
      if (likedData) {
        // Keep both build info and like timestamp
        const likes = likedData.map((row: any) => ({
          build: row.builds,
          liked_at: row.created_at,
        }));
        setLikedBuilds(likes);
      }

      setLoadingLikes(false);
    };

    fetchLikedBuilds();
  }, [user, supabase]);

  useEffect(() => {
    const fetchFollowers = async () => {
      if (!user) return;

      // 1. Get followers
      const { data: followData, error: followError } = await supabase
        .from("followers")
        .select("*")
        .eq("user_id", user.user_id) // people who follow THIS user
        .order("created_at", { ascending: false });

      if (followError) {
        console.error("Error fetching followers:", followError);
        return;
      }

      if (!followData || followData.length === 0) {
        setFollowers([]);
        return;
      }

      // 2. Fetch usernames of follower_user_id
      const followerIds = followData.map((f) => f.follower_user_id);
      const { data: usersData } = await supabase
        .from("users")
        .select("user_id, username")
        .in("user_id", followerIds);

      // 3. Map followers with username
      const followersWithNames = followData.map((f) => {
        const userInfo = usersData?.find((u) => u.user_id === f.follower_user_id);
        return {
          ...f,
          username: userInfo?.username || "Unknown",
        };
      });

      setFollowers(followersWithNames);
    };

    fetchFollowers();
  }, [user]);




  useEffect(() => {
    const fetchRecentActivity = async () => {
      if (!user) return;

      let activity: any[] = [];

      // 1. Builds created
      userBuilds.forEach((build) => {
        activity.push({
          id: `build_${build.build_id}`,
          type: "build_created",
          description: `Created '${build.build_name}'`,
          time: timeAgo(build.date_created),
          icon: Plus,
        });
      });

      // 2. Builds liked
      likedBuilds.forEach((row: any) => {
        activity.push({
          id: `liked_${row.build.build_id}`,
          type: "build_liked",
          description: `Liked '${row.build.build_name}'`,
          time: timeAgo(row.liked_at), // use the like timestamp
          icon: Heart,
        });
      });


      // 3. Comments from build_comment table
      const { data: commentsData, error: commentsError } = await supabase
        .from("build_comments")
        .select("*, builds(build_name)")
        .eq("user_id", user.user_id)
        .order("created_at", { ascending: false });

      if (commentsError) {
        console.error("Error fetching comments:", commentsError);
      } else if (commentsData) {
        commentsData.forEach((comment: any) => {
          activity.push({
            id: `comment_${comment.comment_id}`,
            type: "comment",
            description: `Commented on '${comment.builds?.build_name}'`,
            time: timeAgo(comment.created_at),
            icon: MessageCircle,
          });
        });
      }

      // Follows activity
      const { data: followActivity, error: followActivityError } = await supabase
        .from("followers")
        .select("*")
        .eq("follower_user_id", user.user_id) // follows made by the user
        .order("created_at", { ascending: false });

      if (!followActivityError && followActivity) {
        // fetch usernames of the followed users
        const followedIds = followActivity.map((f) => f.user_id);
        const { data: usersData } = await supabase
          .from("users")
          .select("user_id, user_name")
          .in("user_id", followedIds);

        followActivity.forEach((f) => {
          const followedUser = usersData?.find((u) => u.user_id === f.user_id);
          activity.push({
            id: `follow_${f.user_id}`,
            type: "follow",
            description: `Followed ${followedUser?.user_name || "someone"}`,
            time: timeAgo(f.created_at),
            icon: Users,
          });
        });
      }


      // 5. Optional: Guides completed (if static)
      //activity.push({
      //  id: "guide_1",
      //  type: "guide_completed",
      //  description: "Completed 'First Gaming PC Build' guide",
      //  time: new Date().toISOString(), // you can adjust to actual completion date
      //  icon: BookOpen,
      //});

      // Sort by most recent
      activity.sort((a, b) => new Date(b.time).getTime() - new Date(a.time).getTime());

      setRecentActivity(activity);
    };

    fetchRecentActivity();
  }, [user, userBuilds, likedBuilds]);


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

  const handleLogout = async () => {
    await logout()
    router.push("/")
    router.refresh()
  }

  function timeAgo(dateString: string | null) {
    if (!dateString) return "-";

    const now = new Date();
    const date = new Date(dateString); // JS parses UTC and converts to local automatically
    const seconds = Math.floor((now.getTime() - date.getTime()) / 1000);

    if (seconds < 5) return "just now"; // very recent

    const intervals: { [key: string]: number } = {
      year: 31536000,
      month: 2592000,
      week: 604800,
      day: 86400,
      hour: 3600,
      minute: 60,
      second: 1,
    };

    for (const key in intervals) {
      const interval = Math.floor(seconds / intervals[key]);
      if (interval >= 1) {
        return `${interval} ${key}${interval !== 1 ? "s" : ""} ago`;
      }
    }

    return "just now";
  }




  // For now, using mock data - will be replaced with Supabase queries
  const totalViews = userBuilds.length * 1200 // Mock view count

  // Dynamic achievements based on Supabase data
  const achievements = [
    {
      id: 1,
      name: "First Build",
      description: "Created your first PC build",
      earned: userBuilds.length >= 1,
      icon: Wrench,
    },
    {
      id: 2,
      name: "Community Favorite",
      description: "Received 100+ likes",
      earned: totalLikes >= 100,
      icon: Heart,
    },
    {
      id: 3,
      name: "Build Master",
      description: "Created 10+ builds",
      earned: userBuilds.length >= 10,
      icon: Trophy,
    },
    {
      id: 4,
      name: "Guide Follower",
      description: "Completed a build guide",
      earned: true, // still static
      icon: BookOpen,
    },
  ]

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      <Navigation variant="dashboard" />

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
                    <p className="text-sm text-slate-600 dark:text-slate-400">Followers</p>
                    <p className="text-2xl font-bold text-slate-900 dark:text-white">
                      {followers.length}
                    </p>
                  </div>
                  <Users className="h-8 w-8 text-green-600" />
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
                    {recentActivity.slice(0, 5).map((activity) => (
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
                      <Card key={build.build_id} className="border-slate-200 dark:border-slate-700">
                        <CardHeader className="pb-3">
                          <div className="flex items-start justify-between">
                            <div>
                              <CardTitle className="text-lg">{build.build_name}</CardTitle>
                              <CardDescription className="mt-1">{build.description}</CardDescription>
                            </div>
                            <Badge variant="secondary">${build.total_price.toLocaleString()}</Badge>
                          </div>
                        </CardHeader>
                        <CardContent className="space-y-4">
                          <div className="flex flex-wrap gap-1">
                            {build.build_types?.type_name && (
                              <Badge variant="outline" className="text-xs">
                                {build.build_types.type_name}
                              </Badge>
                            )}
                          </div>

                          <div className="flex items-center justify-between text-sm text-slate-600 dark:text-slate-400">
                            <div className="flex items-center gap-4">
                              <div className="flex items-center gap-1">
                                <Heart className="h-4 w-4" />
                                {build.likes}
                              </div>
                              <div className="flex items-center gap-1">
                                <Eye className="h-4 w-4" />
                                {build.views}
                              </div>
                              <div className="flex items-center gap-1">
                                <Calendar className="h-4 w-4" />
                                {build.date_created ? new Date(build.date_created).toLocaleDateString() : "-"}
                              </div>
                            </div>
                          </div>

                          <div className="flex gap-2">
                            <Button size="sm" variant="outline" asChild className="flex-1 bg-transparent">
                              <Link href={`/builds/${build.build_id}`}>
                                <Eye className="h-4 w-4 mr-2" />
                                View
                              </Link>
                            </Button>
                            <Button size="sm" variant="outline" asChild className="flex-1 bg-transparent">
                              <Link href={`/builder?clone=${build.build_id}`}>
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
                    <h3 className="text-lg font-medium text-slate-900 dark:text-white mb-2">
                      No liked builds yet
                    </h3>
                    <p className="text-slate-600 dark:text-slate-400 mb-4">
                      Explore the community and like builds that inspire you
                    </p>
                    <Button asChild>
                      <Link href="/builds">Browse Community Builds</Link>
                    </Button>
                  </div>
                ) : (
                  <div className="grid md:grid-cols-2 gap-6">
                    {likedBuilds.map((row: any) => {
                      const build = row.build;
                      return (
                        <Card key={build.build_id} className="border-slate-200 dark:border-slate-700">
                          <CardHeader className="pb-3">
                            <div className="flex items-start justify-between">
                              <div>
                                <CardTitle className="text-lg">{build.build_name}</CardTitle>
                                <CardDescription className="mt-1">{build.description}</CardDescription>
                              </div>
                              <Badge variant="secondary">${build.total_price?.toLocaleString()}</Badge>
                            </div>
                          </CardHeader>
                          <CardContent className="space-y-4">
                            <div className="flex flex-wrap gap-1">
                              {build.build_types?.type_name && (
                                <Badge variant="outline" className="text-xs">
                                  {build.build_types.type_name}
                                </Badge>
                              )}
                            </div>

                            <div className="flex items-center justify-between text-sm text-slate-600 dark:text-slate-400">
                              <div className="flex items-center gap-4">
                                <div className="flex items-center gap-1">
                                  <Heart className="h-4 w-4 text-red-500" />
                                  {build.likes || 0}
                                </div>
                                <div className="flex items-center gap-1">
                                  <Eye className="h-4 w-4" />
                                  {build.views || 0}
                                </div>
                                <div className="flex items-center gap-1">
                                  <Calendar className="h-4 w-4" />
                                  {row.liked_at ? new Date(row.liked_at).toLocaleDateString() : "-"}
                                </div>
                              </div>
                            </div>

                            <div className="flex gap-2">
                              <Button size="sm" variant="outline" asChild className="flex-1 bg-transparent">
                                <Link href={`/builds/${build.build_id}`}>
                                  <Eye className="h-4 w-4 mr-2" />
                                  View
                                </Link>
                              </Button>
                              <Button size="sm" variant="outline" asChild className="flex-1 bg-transparent">
                                <Link href={`/builder?clone=${build.build_id}`}>
                                  <Edit className="h-4 w-4 mr-2" />
                                  Clone
                                </Link>
                              </Button>
                              <Button size="sm" variant="outline">
                                <Share className="h-4 w-4 mr-2" />
                                Share
                              </Button>
                            </div>
                          </CardContent>
                        </Card>
                      )
                    })}
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
