"use client"

import { useState, useEffect } from "react"
import { useParams, useRouter, usePathname } from "next/navigation"
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
import { getUpgradeRecommendations } from "@/lib/algorithm-service"
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog"
import { TrendingUp, Loader2 } from "lucide-react"

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
  const pathname = usePathname()
  const { user } = useAuth()

  const [build, setBuild] = useState<any>(null)
  const [creator, setCreator] = useState<any>(null)
  const [loading, setLoading] = useState(true)
  const [isLiked, setIsLiked] = useState(false)
  const [comment, setComment] = useState("")
  const [totalUserBuilds, setTotalUserBuilds] = useState(0)
  const [comments, setComments] = useState<any[]>([]) // empty array initially
  const [isFollowing, setIsFollowing] = useState(false);
  const [followerCount, setFollowerCount] = useState(0);
  const [upgradeRecommendations, setUpgradeRecommendations] = useState<any[]>([])
  const [showUpgradeDialog, setShowUpgradeDialog] = useState(false)
  const [isLoadingUpgrades, setIsLoadingUpgrades] = useState(false)
  const [upgradeError, setUpgradeError] = useState<string | null>(null)


  useEffect(() => {
    const fetchBuild = async () => {
      if (!params.id) return;

      const { data: buildData, error: buildError } = await supabase
        .from("builds")
        .select(`
          *,
          build_components(*, components(*))
        `)
        .eq("build_id", Number(params.id))
        .single();

      if (buildError || !buildData) {
        setBuild(null);
        setLoading(false);
        return;
      }

      // Map build_components into components object
      const componentsObj = (buildData.build_components || []).reduce((acc: any, comp: any) => {
        if (!comp.components) return acc;

        const categoryName = categoryMap[comp.components.category_id];
        if (!categoryName) return acc;

        if (!acc[categoryName]) acc[categoryName] = [];

        acc[categoryName].push({
          ...comp.components,
          price: comp.components.component_price ?? 0,
        });

        return acc;
      }, {});

      setBuild({
        ...buildData,
        totalPrice: buildData.total_price ?? 0,
        components: componentsObj,
      });

      // Fetch creator
      const { data: userData, error: userError } = await supabase
        .from("users")
        .select("*")
        .eq("user_id", buildData.user_id)
        .single();

      if (!userError && userData) {
        setCreator(userData);

        const { count, error: countError } = await supabase
          .from("builds")
          .select("*", { count: "exact", head: true })
          .eq("user_id", userData.user_id);

        if (!countError) setTotalUserBuilds(count || 0);

        // Fetch followers AFTER setting creator
        fetchFollowerData(userData.user_id);
      }


      if (user && creator) {
        const { data: followData, error: followError } = await supabase
          .from("followers")
          .select("*")
          .eq("user_id", creator.user_id)
          .eq("follower_user_id", user.user_id)
          .single();

        setIsFollowing(!followError && !!followData);
      }


      // check if current user already liked
      if (user) {
        const { data: likedData, error: likedError } = await supabase
          .from("build_likes")
          .select("*")
          .eq("build_id", buildData.build_id)
          .eq("user_id", user.user_id)
          .single();

        setIsLiked(!likedError && !!likedData);
      }

      setLoading(false);
    };

    fetchBuild();
    fetchComments(); // fetch comments separately

    // Increase views (unique per user)
    const incrementViews = async () => {
      if (!params.id || !user) return;

      const buildId = Number(params.id);

      // Check if user already viewed this build
      const { data: existingView, error: viewError } = await supabase
        .from("build_views")
        .select("*")
        .eq("build_id", buildId)
        .eq("user_id", user.user_id)
        .single();

      if (existingView) return; // already viewed

      // Insert new view record (Supabase will auto-generate view_id and created_at)
      await supabase
        .from("build_views")
        .insert({
          build_id: buildId,
          user_id: user.user_id,
        });

      // Increment views in builds table
      await supabase
        .from("builds")
        .update({
          views: (build?.views || 0) + 1,
        })
        .eq("build_id", buildId);

      // Update local state
      setBuild(prev => ({
        ...prev,
        views: (prev?.views || 0) + 1
      }));
    };

  incrementViews();

  }, [params.id, pathname, user]); // Refetch when params.id, pathname, or user changes

  const fetchComments = async () => {
    if (!params.id) return;

    const { data: commentsData, error: commentsError } = await supabase
      .from("build_comments")
      .select(`
        *,
        users:user_id (
          user_name,
          avatar_url
        )
      `)
      .eq("build_id", Number(params.id))
      .order("created_at", { ascending: false }); // latest first

    if (!commentsError && commentsData) {
      const mappedComments = commentsData.map((c: any) => ({
        id: c.comment_id,
        user: c.users?.user_name || "Anonymous",
        avatar: c.users?.avatar_url || "/placeholder.svg",
        content: c.content,
        timestamp: new Date(c.created_at).toLocaleString(),
        likes: c.likes || 0,
      }));
      setComments(mappedComments);
    }
  };

  const fetchFollowerData = async (creatorId: string) => {
    if (!creatorId || !user) return;

    // Fetch total followers
    const { count: followersCount, error: countError } = await supabase
      .from("followers")
      .select("*", { count: "exact", head: true })
      .eq("user_id", creatorId);

    if (!countError) setFollowerCount(followersCount || 0);

    // Check if current user is following
    const { data: followData, error: followError } = await supabase
      .from("followers")
      .select("*")
      .eq("user_id", creatorId)
      .eq("follower_user_id", user.user_id)
      .single();

    setIsFollowing(!followError && !!followData);
  };


  const handleAddComment = async () => {
    if (!comment.trim() || !user) return;

    // Insert the new comment
    const { data: newComment, error } = await supabase
      .from("build_comments")
      .insert({
        build_id: build.build_id,
        user_id: user.user_id,
        content: comment,
        likes: 0,
      })
      .select(`*, users:user_id(user_name)`)
      .single();

    if (!error && newComment) {
      // Update the comments count in the builds table
      await supabase
        .from("builds")
        .update({
          comments: (build.comments || 0) + 1
        })
        .eq("build_id", build.build_id);

      // Update local state
      setComments((prev) => [
        {
          id: newComment.comment_id,
          user: newComment.users?.user_name || "Anonymous",
          avatar: newComment.users?.avatar || "/placeholder.svg",
          content: newComment.content,
          timestamp: new Date(newComment.created_at).toLocaleString(),
          likes: newComment.likes || 0,
        },
        ...prev,
      ]);

      setBuild((prev: any) => ({
        ...prev,
        comments: (prev.comments || 0) + 1, // increment locally
      }));

      setComment("");
      fetchComments(); // optional, in case you want to refetch all comments
    }
  };

  const formatDate = (isoDate: string) => {
    const date = new Date(isoDate);
    return date.toLocaleDateString("en-US", {
      year: "numeric",
      month: "short",
      day: "numeric",
    });
  };


  const toggleLike = async () => {
    if (!user) return;

    if (creator?.user_id === user.user_id) {
      alert("You cannot like your own build.");
      return;
    }

    if (isLiked) {
      // unlike
      const { error: deleteLikeError } = await supabase
        .from("build_likes")
        .delete()
        .eq("build_id", build.build_id)
        .eq("user_id", user.user_id);

      if (!deleteLikeError) {
        // decrement likes in builds table
        const { error: updateError } = await supabase
          .from("builds")
          .update({ likes: build.likes - 1 })
          .eq("build_id", build.build_id);

        if (!updateError) {
          setIsLiked(false);
          setBuild((prev: any) => ({
            ...prev,
            likes: prev.likes - 1,
          }));
        }
      }
    } else {
      // like
      const { error: insertLikeError } = await supabase
        .from("build_likes")
        .insert({ 
          build_id: build.build_id, 
          user_id: user.user_id, 
         });

        

      if (!insertLikeError) {
        // increment likes in builds table
        const { error: updateError } = await supabase
          .from("builds")
          .update({ likes: build.likes + 1 })
          .eq("build_id", build.build_id);

        if (!updateError) {
          setIsLiked(true);
          setBuild((prev: any) => ({
            ...prev,
            likes: prev.likes + 1,
          }));
        }
      }
    }
  };

  const toggleFollow = async () => {
    if (!user || !creator) return;
    if (user.user_id === creator.user_id) {
      alert("You cannot follow yourself.");
      return;
    }

    if (isFollowing) {
      await supabase
        .from("followers")
        .delete()
        .eq("user_id", creator.user_id)
        .eq("follower_user_id", user.user_id);
    } else {
      await supabase
        .from("followers")
        .insert({
          user_id: creator.user_id,
          follower_user_id: user.user_id,
        });
    }
    // Refresh follow status and count
    fetchFollowerData(creator.user_id);
  };

  const handleGetUpgradeRecommendations = async () => {
    if (!build || !build.components) {
      setUpgradeError("Build data not available")
      setTimeout(() => setUpgradeError(null), 5000)
      return
    }

    setIsLoadingUpgrades(true)
    setUpgradeError(null)
    setUpgradeRecommendations([])

    try {
      // Convert build components to upgrade API format
      const currentBuild: any[] = []
      Object.entries(build.components).forEach(([categoryName, components]: [string, any]) => {
        if (Array.isArray(components) && components.length > 0) {
          const comp = components[0] // Take first component of each category
          const componentId = Number(String(comp.component_id).replace(/\D/g, '')) || 0
          currentBuild.push({
            component_id: componentId,
            component_name: comp.component_name || comp.name || 'Unknown',
            component_price: comp.component_price || comp.price || 0,
            category_name: categoryName,
          })
        }
      })

      if (currentBuild.length === 0) {
        setUpgradeError("No components found in this build")
        setTimeout(() => setUpgradeError(null), 5000)
        return
      }

      console.log("Requesting upgrade recommendations for build:", currentBuild)
      const recommendations = await getUpgradeRecommendations(currentBuild)
      console.log("Received upgrade recommendations:", recommendations)

      if (!recommendations || recommendations.length === 0) {
        setUpgradeError("No upgrade recommendations available for this build")
        setTimeout(() => setUpgradeError(null), 5000)
        return
      }

      setUpgradeRecommendations(recommendations)
      setShowUpgradeDialog(true)
    } catch (error: any) {
      console.error("Error getting upgrade recommendations:", error)
      setUpgradeError(error.message || "Failed to get upgrade recommendations")
      setTimeout(() => setUpgradeError(null), 5000)
    } finally {
      setIsLoadingUpgrades(false)
    }
  }

  const handleApplyUpgrade = async (recIndex: number, recommendedComponentName: string) => {
    if (!build || !user) {
      alert("Please log in to apply upgrades")
      return
    }

    // Check if user owns this build
    if (build.user_id !== user.user_id) {
      alert("You can only apply upgrades to your own builds")
      return
    }

    setIsLoadingUpgrades(true)

    try {
      // Find the component in the build that matches this recommendation
      const rec = upgradeRecommendations[recIndex]
      if (!rec) {
        alert("Recommendation not found")
        setIsLoadingUpgrades(false)
        return
      }

      // Find matching component in build
      let targetComponent: any = null
      let targetBuildComponentId: number | null = null

      Object.entries(build.components).forEach(([categoryName, components]: [string, any]) => {
        if (Array.isArray(components)) {
          const matching = components.find((comp: any) => {
            const compName = comp.component_name || comp.name || ''
            return compName.toLowerCase().includes(rec.current_component.toLowerCase()) ||
                   rec.current_component.toLowerCase().includes(compName.toLowerCase())
          })
          if (matching) {
            targetComponent = matching
            // Get the build_component_id from the build_components relationship
            targetBuildComponentId = matching.component_id || matching.build_component_id
          }
        }
      })

      if (!targetComponent || !targetBuildComponentId) {
        alert("Could not find component to upgrade in this build")
        setIsLoadingUpgrades(false)
        return
      }

      // Find the recommended component in database - try multiple search strategies
      let recommendedComponent: any = null
      
      // Strategy 1: Exact or partial name match
      const { data: componentsByName, error: nameError } = await supabase
        .from("components")
        .select("*")
        .ilike("component_name", `%${recommendedComponentName}%`)

      if (!nameError && componentsByName && componentsByName.length > 0) {
        // Try to find best match
        recommendedComponent = componentsByName.find((comp: any) => {
          const compName = (comp.component_name || '').toLowerCase()
          const searchName = recommendedComponentName.toLowerCase()
          return compName.includes(searchName) || searchName.includes(compName)
        }) || componentsByName[0]
      }

      // Strategy 2: If not found, search by category and price range
      if (!recommendedComponent && rec.new_price) {
        const categoryId = targetComponent.category_id
        const priceRange = rec.new_price * 0.9 // 10% tolerance
        const { data: componentsByPrice, error: priceError } = await supabase
          .from("components")
          .select("*")
          .eq("category_id", categoryId)
          .gte("component_price", priceRange)
          .order("component_price", { ascending: true })
          .limit(5)

        if (!priceError && componentsByPrice && componentsByPrice.length > 0) {
          // Find component with name similar to recommendation
          recommendedComponent = componentsByPrice.find((comp: any) => {
            const compName = (comp.component_name || '').toLowerCase()
            const searchName = recommendedComponentName.toLowerCase()
            return compName.includes(searchName.split(' ')[0]) || searchName.includes(compName.split(' ')[0])
          }) || componentsByPrice[0]
        }
      }

      if (!recommendedComponent) {
        alert(`Could not find recommended component "${recommendedComponentName}" in database. Please check if the component exists.`)
        setIsLoadingUpgrades(false)
        return
      }

      console.log("Applying upgrade:", {
        from: targetComponent.component_name,
        to: recommendedComponent.component_name,
        oldPrice: targetComponent.component_price || targetComponent.price,
        newPrice: recommendedComponent.component_price
      })

      // Update build_components table - find the build_component entry first
      const { data: buildComponents, error: bcFetchError } = await supabase
        .from("build_components")
        .select("*")
        .eq("build_id", build.build_id)
        .eq("component_id", targetComponent.component_id || targetBuildComponentId)

      if (bcFetchError || !buildComponents || buildComponents.length === 0) {
        alert("Could not find build component to update")
        setIsLoadingUpgrades(false)
        return
      }

      const buildComponentId = buildComponents[0].build_component_id || buildComponents[0].id

      // Update the component in build_components
      const { error: updateError } = await supabase
        .from("build_components")
        .update({ component_id: recommendedComponent.component_id })
        .eq("build_component_id", buildComponentId)

      if (updateError) {
        console.error("Update error:", updateError)
        throw updateError
      }

      // Calculate new total price
      const oldComponentPrice = Number(targetComponent.component_price || targetComponent.price || 0)
      const newComponentPrice = Number(recommendedComponent.component_price || 0)
      const priceDifference = newComponentPrice - oldComponentPrice
      const newTotalPrice = (build.totalPrice || build.total_price || 0) + priceDifference

      // Update build's total price
      const { error: buildUpdateError } = await supabase
        .from("builds")
        .update({ total_price: newTotalPrice })
        .eq("build_id", build.build_id)

      if (buildUpdateError) {
        console.error("Build update error:", buildUpdateError)
        // Don't throw - the component was updated, just the price wasn't
      }

      // Refresh build data
      const { data: buildData, error: buildError } = await supabase
        .from("builds")
        .select(`
          *,
          build_components(*, components(*))
        `)
        .eq("build_id", Number(params.id))
        .single()

      if (!buildError && buildData) {
        const componentsObj = (buildData.build_components || []).reduce((acc: any, comp: any) => {
          if (!comp.components) return acc
          const categoryName = categoryMap[comp.components.category_id]
          if (!categoryName) return acc
          if (!acc[categoryName]) acc[categoryName] = []
          acc[categoryName].push({
            ...comp.components,
            component_id: comp.components.component_id,
            component_name: comp.components.component_name,
            component_price: comp.components.component_price,
            price: comp.components.component_price ?? 0,
            category_id: comp.components.category_id,
          })
          return acc
        }, {})

        const newTotal = Object.values(componentsObj).flat().reduce((sum: number, comp: any) => {
          return sum + (Number(comp.component_price || comp.price) || 0)
        }, 0)

        setBuild({
          ...buildData,
          totalPrice: newTotal,
          total_price: newTotal,
          components: componentsObj,
        })

        alert(`✅ Upgrade applied successfully!\n\n${targetComponent.component_name || targetComponent.name}\n→ ${recommendedComponent.component_name}\n\nPrice change: ${formatCurrency(priceDifference)}`)
        setShowUpgradeDialog(false)
        setUpgradeRecommendations([]) // Clear recommendations after applying
      } else {
        throw buildError || new Error("Failed to refresh build data")
      }
    } catch (error: any) {
      console.error("Error applying upgrade:", error)
      alert("Failed to apply upgrade: " + (error.message || "Unknown error"))
    } finally {
      setIsLoadingUpgrades(false)
    }
  }

  const handleSaveAsNewBuild = async (recIndex: number, recommendedComponentName: string) => {
    if (!build || !user) return

    try {
      const rec = upgradeRecommendations[recIndex]
      if (!rec) return

      // Find matching component in build
      let targetComponent: any = null
      let targetCategory: string | null = null

      Object.entries(build.components).forEach(([categoryName, components]: [string, any]) => {
        if (Array.isArray(components)) {
          const matching = components.find((comp: any) => {
            const compName = comp.component_name || comp.name || ''
            return compName.toLowerCase().includes(rec.current_component.toLowerCase()) ||
                   rec.current_component.toLowerCase().includes(compName.toLowerCase())
          })
          if (matching) {
            targetComponent = matching
            targetCategory = categoryName
          }
        }
      })

      if (!targetComponent || !targetCategory) {
        alert("Could not find component to upgrade in this build")
        return
      }

      // Find the recommended component in database
      const { data: recommendedComponents, error: compError } = await supabase
        .from("components")
        .select("*")
        .ilike("component_name", `%${recommendedComponentName}%`)
        .limit(1)
        .single()

      if (compError || !recommendedComponents) {
        alert("Could not find recommended component in database")
        return
      }

      // Create new build with upgraded component
      const buildComponents = Object.values(build.components).flat() as any[]
      const updatedComponents = buildComponents.map((comp: any) => {
        if (comp.component_id === targetComponent.component_id) {
          return { ...comp, component_id: recommendedComponents.component_id }
        }
        return comp
      })

      // Calculate new total price
      const newTotalPrice = updatedComponents.reduce((sum: number, comp: any) => {
        return sum + (Number(comp.component_price || comp.price) || 0)
      }, 0)

      // Create new build
      const { data: newBuild, error: buildError } = await supabase
        .from("builds")
        .insert({
          build_name: `${build.build_name} (Upgraded)`,
          user_id: user.user_id,
          total_price: newTotalPrice,
          build_type_id: build.build_type_id,
          description: build.description || "",
        })
        .select("build_id")
        .single()

      if (buildError || !newBuild) {
        throw buildError || new Error("Failed to create new build")
      }

      // Insert build_components
      const buildComponentsRows = updatedComponents.map((comp: any) => ({
        build_id: newBuild.build_id,
        component_id: comp.component_id,
      }))

      const { error: bcError } = await supabase
        .from("build_components")
        .insert(buildComponentsRows)

      if (bcError) {
        throw bcError
      }

      alert("New upgraded build created successfully!")
      setShowUpgradeDialog(false)
      router.push(`/mybuilds/${newBuild.build_id}`)
      router.refresh()
    } catch (error: any) {
      console.error("Error saving as new build:", error)
      alert("Failed to save as new build: " + (error.message || "Unknown error"))
    }
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
                        <AvatarImage src={creator?.avatar_url || "/placeholder.svg"} />
                        <AvatarFallback>{creator?.user_name?.charAt(0).toUpperCase() || "U"}</AvatarFallback>
                      </Avatar>
                      <div>
                        <p className="font-medium text-slate-900 dark:text-white">{creator?.user_name || "Unknown"}</p>
                        <div className="flex items-center gap-4 text-sm text-slate-500">
                          <div className="flex items-center gap-1">
                            <Calendar className="h-3 w-3" />
                            <span>{formatDate(creator?.created_at)}</span>
                          </div>
                          <div className="flex items-center gap-1">
                            <Eye className="h-3 w-3" />
                            <span>{build.views} views</span>
                          </div>
                        </div>
                      </div>
                    </div>
                    <p className="text-slate-600 dark:text-slate-400">{build.description || "No description provided."}</p>
                  </div>
                  <Badge variant="secondary" className="text-lg font-bold px-3 py-1">
                    {formatCurrency(build.totalPrice)}
                  </Badge>
                </div>

                {/* Upgrade Suggestions Button - More Visible */}
                <div className="pt-4 border-t border-slate-200 dark:border-slate-700">
                  <Button
                    onClick={handleGetUpgradeRecommendations}
                    disabled={isLoadingUpgrades}
                    variant="default"
                    className="gap-2 w-full sm:w-auto"
                  >
                    {isLoadingUpgrades ? (
                      <>
                        <Loader2 className="h-4 w-4 animate-spin" />
                        Loading...
                      </>
                    ) : (
                      <>
                        <TrendingUp className="h-4 w-4" />
                        Get Upgrade Suggestions
                      </>
                    )}
                  </Button>
                  {upgradeError && (
                    <p className="text-sm text-red-600 mt-2">{upgradeError}</p>
                  )}
                </div>

                {/* Tags */}
                <div className="flex flex-wrap gap-2 pt-4">
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
                    onClick={toggleLike}
                    className="flex items-center gap-2"
                  >
                    <Heart className={`h-4 w-4 ${isLiked ? "fill-current" : ""}`} />
                    {build.likes} Likes
                  </Button>

                  <Button variant="outline" className="flex items-center gap-2">
                    <Copy className="h-4 w-4" />
                    Clone Build
                  </Button>
                  <Button 
                    variant="outline" 
                    className="flex items-center gap-2"
                    onClick={async () => {
                      const shareUrl = typeof window !== 'undefined' ? `${window.location.origin}/builder?share=${build.build_id}` : ''
                      try {
                        await navigator.clipboard.writeText(shareUrl)
                        alert("Build link copied to clipboard! Share this link to let others import this build.")
                      } catch (err) {
                        console.error("Failed to copy link:", err)
                        alert("Failed to copy link. Please copy manually: " + shareUrl)
                      }
                    }}
                  >
                    <Share className="h-4 w-4" />
                    Share
                  </Button>
                  <Button variant="outline" className="flex items-center gap-2">
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
                      {component.image && component.image !== '/placeholder.svg' ? (
                        <img
                          src={component.image}
                          alt={component.component_name || component.name || 'Component'}
                          className="w-16 h-16 object-cover rounded-lg bg-slate-100 dark:bg-slate-800 flex-shrink-0"
                          onError={(e) => {
                            (e.target as HTMLImageElement).src = '/placeholder.svg'
                          }}
                        />
                      ) : (
                        <Icon className="h-8 w-8 text-slate-500 flex-shrink-0" />
                      )}
                      <div className="flex-1">
                        <h3 className="font-medium text-slate-900 dark:text-white capitalize">
                          {category === "psu" ? "Power Supply" : category}
                        </h3>
                        <p className="text-sm text-slate-600 dark:text-slate-400">
                          {component.component_brand ? `${component.component_brand} ` : ''}{component.component_name || component.name || 'Unknown Component'}
                        </p>
                        {(component.rating || component.reviews) && (
                          <div className="flex items-center gap-4 mt-1 text-xs text-slate-500">
                            {component.rating && <span>★ {component.rating}</span>}
                            {component.reviews && <span>{component.reviews} reviews</span>}
                          </div>
                        )}
                      </div>
                      <div className="text-right">
                        <p className="font-semibold text-slate-900 dark:text-white">{formatCurrency(component.price || component.component_price || 0)}</p>
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
                  <span className="font-medium">{build.likes}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Views</span>
                  <span className="font-medium">{build.views}</span>
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
                    <AvatarImage src={creator?.avatar_url || "/placeholder.svg"} />
                    <AvatarFallback>{creator?.user_name?.charAt(0).toUpperCase() || "U"}</AvatarFallback>
                  </Avatar>
                  <div>
                    <h3 className="font-medium">{creator?.user_name || "Unknown"}</h3>
                    <p className="text-sm text-slate-500">{formatDate(creator?.created_at)}</p>
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-4 text-sm">
                  <div>
                    <span className="text-slate-600 dark:text-slate-400">Builds</span>
                    <p className="font-medium">{totalUserBuilds}</p>
                  </div>
                  <div>
                    <span className="text-slate-600 dark:text-slate-400">Followers</span>
                    <p className="font-medium">{followerCount}</p>
                  </div>
                </div>
                <Button
                  className="w-full mt-4"
                  variant={isFollowing ? "default" : "outline"}
                  onClick={toggleFollow}
                >
                  <User className="h-4 w-4 mr-2" />
                  {isFollowing ? "Following" : "Follow"}
                </Button>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>

      {/* Upgrade Recommendations Dialog */}
      <Dialog open={showUpgradeDialog} onOpenChange={setShowUpgradeDialog}>
        <DialogContent className="max-w-4xl max-h-[80vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2">
              <TrendingUp className="h-5 w-5 text-green-600" />
              Upgrade Recommendations
            </DialogTitle>
            <DialogDescription>
              Suggested component upgrades for this build
            </DialogDescription>
          </DialogHeader>
          {upgradeRecommendations.length === 0 ? (
            <div className="text-center py-8">
              <p className="text-slate-600 dark:text-slate-400">No upgrade recommendations available.</p>
            </div>
          ) : (
            <div className="space-y-4">
              {upgradeRecommendations.map((rec, index) => (
                <Card
                  key={index}
                  className={`border-slate-200 dark:border-slate-700 ${
                    rec.recommended_upgrade ? 'hover:border-green-500 hover:shadow-md transition-all' : 'opacity-75'
                  }`}
                >
                  <CardContent className="p-4">
                    <div className="flex items-start justify-between gap-4">
                      <div className="flex-1 min-w-0">
                        <div className="flex items-center gap-2 mb-2">
                          <p className="text-sm font-semibold text-slate-900 dark:text-white">
                            {rec.current_component}
                          </p>
                        </div>
                        {rec.recommended_upgrade ? (
                          <div className="space-y-2">
                            <div className="flex items-center gap-2">
                              <span className="text-sm text-slate-500">→</span>
                              <p className="text-sm font-medium text-green-600 dark:text-green-400">
                                {rec.recommended_upgrade}
                              </p>
                            </div>
                            <div className="flex flex-col gap-1 ml-4">
                              {rec.new_price && (
                                <div className="flex items-center gap-2">
                                  <span className="text-xs text-slate-500">New price:</span>
                                  <span className="text-xs font-semibold text-slate-700 dark:text-slate-300">
                                    {formatCurrency(rec.new_price)}
                                  </span>
                                </div>
                              )}
                              {rec.upgrade_cost && (
                                <div className="flex items-center gap-2">
                                  <span className="text-xs text-slate-500">Upgrade cost:</span>
                                  <span className="text-xs font-semibold text-blue-600 dark:text-blue-400">
                                    {formatCurrency(rec.upgrade_cost)}
                                  </span>
                                </div>
                              )}
                            </div>
                          </div>
                        ) : (
                          <p className="text-xs text-slate-500 italic">No upgrade available for this component</p>
                        )}
                      </div>
                      {rec.recommended_upgrade && (
                        <div className="flex flex-col gap-2 flex-shrink-0">
                          <Button
                            size="sm"
                            onClick={() => handleApplyUpgrade(index, rec.recommended_upgrade!)}
                            disabled={isLoadingUpgrades}
                          >
                            {isLoadingUpgrades ? (
                              <>
                                <Loader2 className="h-3 w-3 animate-spin mr-1" />
                                Applying...
                              </>
                            ) : (
                              "Apply to This Build"
                            )}
                          </Button>
                          <Button
                            size="sm"
                            variant="outline"
                            onClick={() => handleSaveAsNewBuild(index, rec.recommended_upgrade!)}
                            disabled={isLoadingUpgrades}
                          >
                            Save as New Build
                          </Button>
                        </div>
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
