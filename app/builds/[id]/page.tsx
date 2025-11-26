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
  const [comments, setComments] = useState<any[]>([]) // empty array initially
  const [isFollowing, setIsFollowing] = useState(false);
  const [isSubmittingComment, setIsSubmittingComment] = useState(false);
  const [followerCount, setFollowerCount] = useState(0);
  const [isTogglingFollow, setIsTogglingFollow] = useState(false);


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
        if (userData.user_id) {
          fetchFollowerData(userData.user_id.toString());
        }
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

  }, [params.id]);

  const fetchComments = async () => {
    if (!params.id) return;

    try {
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

      if (commentsError) {
        console.error("Error fetching comments:", commentsError);
        // Still set empty array to show "No comments yet" message
        setComments([]);
        return;
      }

      if (commentsData) {
        console.log(`✅ Loaded ${commentsData.length} comment(s) for build ${params.id}`);
        const mappedComments = commentsData.map((c: any) => ({
          id: c.comment_id,
          user: c.users?.user_name || "Anonymous",
          avatar: c.users?.avatar_url || "/placeholder.svg",
          content: c.content,
          timestamp: new Date(c.created_at).toLocaleString(),
          likes: c.likes || 0,
        }));
        setComments(mappedComments);
      } else {
        console.log(`ℹ️ No comments found for build ${params.id}`);
        setComments([]);
      }
    } catch (err) {
      console.error("Error in fetchComments:", err);
      setComments([]);
    }
  };

  const fetchFollowerData = async (creatorId: string) => {
    if (!creatorId) {
      // If no user is logged in, still fetch follower count
      const { count: followersCount, error: countError } = await supabase
        .from("followers")
        .select("*", { count: "exact", head: true })
        .eq("user_id", creatorId);

      if (!countError) setFollowerCount(followersCount || 0);
      setIsFollowing(false);
      return;
    }

    if (!user) {
      // Fetch follower count only if user is not logged in
      const { count: followersCount, error: countError } = await supabase
        .from("followers")
        .select("*", { count: "exact", head: true })
        .eq("user_id", creatorId);

      if (!countError) setFollowerCount(followersCount || 0);
      setIsFollowing(false);
      return;
    }

    try {
      // Fetch total followers
      const { count: followersCount, error: countError } = await supabase
        .from("followers")
        .select("*", { count: "exact", head: true })
        .eq("user_id", creatorId);

      if (countError) {
        console.error("Error fetching follower count:", countError);
      } else {
        setFollowerCount(followersCount || 0);
      }

      // Check if current user is following
      const { data: followData, error: followError } = await supabase
        .from("followers")
        .select("*")
        .eq("user_id", creatorId)
        .eq("follower_user_id", user.user_id)
        .maybeSingle(); // Use maybeSingle instead of single to avoid errors when no record exists

      if (followError && followError.code !== 'PGRST116') { // PGRST116 = no rows returned
        console.error("Error checking follow status:", followError);
      } else {
        setIsFollowing(!!followData);
      }
    } catch (err) {
      console.error("Error in fetchFollowerData:", err);
    }
  };


  const handleAddComment = async () => {
    if (!comment.trim() || !user) {
      if (!user) {
        alert("Please log in to post a comment.")
      }
      return;
    }

    setIsSubmittingComment(true);
    try {
      // Insert the new comment
      const { data: newComment, error } = await supabase
        .from("build_comments")
        .insert({
          build_id: build.build_id,
          user_id: user.user_id,
          content: comment.trim(),
          likes: 0,
        })
        .select()
        .single();

      if (error) {
        console.error("Error adding comment:", error);
        alert("Failed to post comment. Please try again.");
        return;
      }

      if (newComment) {
        console.log("✅ Comment posted successfully:", newComment.comment_id);
        
        // Update the comments count in the builds table
        const { error: updateError } = await supabase
          .from("builds")
          .update({
            comments: (build.comments || 0) + 1
          })
          .eq("build_id", build.build_id);

        if (updateError) {
          console.error("Error updating build comments count:", updateError);
        }

        // Fetch user data for the comment
        const { data: userData } = await supabase
          .from("users")
          .select("user_name, avatar_url")
          .eq("user_id", user.user_id)
          .single();

        // Update local state immediately
        const mappedComment = {
          id: newComment.comment_id,
          user: userData?.user_name || user.user_name || "Anonymous",
          avatar: userData?.avatar_url || user.avatar_url || "/placeholder.svg",
          content: newComment.content,
          timestamp: new Date(newComment.created_at).toLocaleString(),
          likes: newComment.likes || 0,
        };

        setComments((prev) => [mappedComment, ...prev]);

        setBuild((prev: any) => ({
          ...prev,
          comments: (prev.comments || 0) + 1,
        }));

        setComment("");
        // Refresh comments to ensure consistency
        fetchComments();
      }
    } catch (err) {
      console.error("Error in handleAddComment:", err);
      alert("An error occurred while posting your comment. Please try again.");
    } finally {
      setIsSubmittingComment(false);
    }
  };

  const handleLikeComment = async (commentId: number, currentLikes: number) => {
    if (!user) {
      alert("Please log in to like comments.");
      return;
    }

    try {
      // Update the comment's like count
      const { error } = await supabase
        .from("build_comments")
        .update({
          likes: currentLikes + 1
        })
        .eq("comment_id", commentId);

      if (error) {
        console.error("Error liking comment:", error);
        return;
      }

      // Update local state
      setComments((prev) =>
        prev.map((c) =>
          c.id === commentId ? { ...c, likes: c.likes + 1 } : c
        )
      );
    } catch (err) {
      console.error("Error in handleLikeComment:", err);
    }
  };

  const handleReply = (commentId: number, userName: string) => {
    if (!user) {
      alert("Please log in to reply to comments.");
      return;
    }
    // Focus the comment textarea and add @mention
    setComment(`@${userName} `);
    const textarea = document.querySelector('textarea[placeholder*="Share your thoughts"]') as HTMLTextAreaElement;
    if (textarea) {
      textarea.focus();
      textarea.setSelectionRange(textarea.value.length, textarea.value.length);
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
    if (!user) {
      alert("Please log in to follow users.");
      return;
    }

    if (!creator) {
      alert("Creator information not available.");
      return;
    }

    if (user.user_id === creator.user_id) {
      alert("You cannot follow yourself.");
      return;
    }

    setIsTogglingFollow(true);
    try {
      if (isFollowing) {
        // Unfollow: Delete the follow relationship
        const { error: deleteError } = await supabase
          .from("followers")
          .delete()
          .eq("user_id", creator.user_id)
          .eq("follower_user_id", user.user_id);

        if (deleteError) {
          console.error("Error unfollowing:", deleteError);
          alert("Failed to unfollow. Please try again.");
          return;
        }

        console.log("✅ Successfully unfollowed user");
        // Update local state immediately
        setIsFollowing(false);
        setFollowerCount((prev) => Math.max(0, prev - 1));
      } else {
        // Follow: Insert the follow relationship
        const { error: insertError } = await supabase
          .from("followers")
          .insert({
            user_id: creator.user_id,
            follower_user_id: user.user_id,
          });

        if (insertError) {
          console.error("Error following:", insertError);
          // Check if it's a duplicate key error (already following)
          if (insertError.code === '23505') {
            alert("You are already following this user.");
            setIsFollowing(true);
          } else {
            alert("Failed to follow. Please try again.");
          }
          return;
        }

        console.log("✅ Successfully followed user");
        // Update local state immediately
        setIsFollowing(true);
        setFollowerCount((prev) => prev + 1);
      }

      // Refresh follow status and count from database to ensure consistency
      await fetchFollowerData(creator.user_id);
    } catch (err) {
      console.error("Error in toggleFollow:", err);
      alert("An error occurred. Please try again.");
    } finally {
      setIsTogglingFollow(false);
    }
  };


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
                    onClick={toggleLike}
                    className="flex items-center gap-2"
                  >
                    <Heart className={`h-4 w-4 ${isLiked ? "fill-current" : ""}`} />
                    {build.likes} Likes
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
                      <Button 
                        onClick={handleAddComment} 
                        disabled={!comment.trim() || isSubmittingComment}
                      >
                        <Send className="h-4 w-4 mr-2" />
                        {isSubmittingComment ? "Posting..." : "Post Comment"}
                      </Button>
                    </div>
                  </div>
                )}

                <Separator />

                {/* Comments List */}
                <div className="space-y-4">
                  {comments.length === 0 ? (
                    <div className="text-center py-8 text-slate-500 dark:text-slate-400">
                      No comments yet. Be the first to comment!
                    </div>
                  ) : (
                    comments.map((comment) => (
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
                          <Button
                            variant="ghost"
                            size="sm"
                            className="h-auto p-0 text-slate-500 hover:text-red-500"
                            onClick={() => handleLikeComment(comment.id, comment.likes)}
                          >
                            <Heart className="h-3 w-3 mr-1" />
                            {comment.likes}
                          </Button>
                          <Button
                            variant="ghost"
                            size="sm"
                            className="h-auto p-0 text-slate-500 hover:text-slate-700"
                            onClick={() => handleReply(comment.id, comment.user)}
                          >
                            Reply
                          </Button>
                        </div>
                      </div>
                    </div>
                    ))
                  )}
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
                  disabled={isTogglingFollow || !user}
                >
                  <User className="h-4 w-4 mr-2" />
                  {isTogglingFollow 
                    ? (isFollowing ? "Unfollowing..." : "Following...") 
                    : (isFollowing ? "Following" : "Follow")
                  }
                </Button>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  )
}
