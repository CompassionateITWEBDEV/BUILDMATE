"use client"

import { useState } from "react"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Textarea } from "@/components/ui/textarea"
import { Separator } from "@/components/ui/separator"
import { Switch } from "@/components/ui/switch"
import { Navigation } from "@/components/navigation"
import { ProtectedRoute } from "@/components/protected-route"
import { useAuth } from "@/contexts/supabase-auth-context"
import { ArrowLeft, Camera, Save, Calendar, MapPin, LinkIcon, Bell, Shield } from "lucide-react"

import { useEffect } from "react";
import { supabase } from "@/lib/supabase";
import Cropper from "react-easy-crop";
import { getCroppedImg } from "@/lib/crop";

export default function ProfilePage() {
  const { user } = useAuth()   
  // Use actual user data or fallback to mock data
  const userData = user;
  const [userBuilds, setUserBuilds] = useState<any[]>([]);
  const [loadingBuilds, setLoadingBuilds] = useState(true);
  const [uploading, setUploading] = useState(false);
  const [avatarUrl, setAvatarUrl] = useState(user?.avatar_url || "");

  const [isEditing, setIsEditing] = useState(false)
  const [profileData, setProfileData] = useState({
    username: userData?.user_name || "",
    email: userData?.email || "",
    bio: userData?.bio || "",
    location: userData?.location || "",
    website: userData?.website || "",
    joinDate: userData?.created_at ? new Date(userData.created_at) : new Date(),
  });


  const [notifications, setNotifications] = useState({
    emailUpdates: true,
    buildLikes: true,
    comments: true,
    followers: false,
    newsletter: true,
  })

  const [privacy, setPrivacy] = useState({
    profilePublic: true,
    showBuilds: true,
    showActivity: false,
    showEmail: false,
  })

  const [imageSrc, setImageSrc] = useState<string | null>(null);
  const [crop, setCrop] = useState({ x: 0, y: 0 });
  const [zoom, setZoom] = useState(1);
  const [croppedAreaPixels, setCroppedAreaPixels] = useState<any>(null);
  const [followers, setFollowers] = useState(0);
  const [following, setFollowing] = useState(0);


  // When file is selected
  const handleFileChange = async (event: React.ChangeEvent<HTMLInputElement>) => {
    if (!event.target.files || event.target.files.length === 0) return;

    const file = event.target.files[0];
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => {
      setImageSrc(reader.result as string);
    };
  };

  // Called when crop is done
  const onCropComplete = (_croppedArea: any, croppedPixels: any) => {
    setCroppedAreaPixels(croppedPixels);
  };

  // Upload cropped image
  const handleUpload = async () => {
    if (!imageSrc || !user?.supabase_id) return;

    const croppedBlob = await getCroppedImg(imageSrc, croppedAreaPixels);

    const fileExt = "png"; // or extract from original file
    const fileName = `${user.supabase_id}-${Date.now()}.${fileExt}`;
    const filePath = `avatars/${fileName}`;

    try {
      // Delete old avatar if exists
      if (user.avatar_url) {
        const oldFileName = user.avatar_url.split("/").pop();
        if (oldFileName) {
          await supabase.storage.from("profile_pictures").remove([`avatars/${oldFileName}`]);
        }
      }

      // Upload new avatar
      const { data: uploadData, error: uploadError } = await supabase.storage
        .from("profile_pictures")
        .upload(filePath, croppedBlob, {
          cacheControl: "3600",
          upsert: true,
        });

      if (uploadError) throw uploadError;

      // Get public URL
      const { data: urlData } = supabase.storage.from("profile_pictures").getPublicUrl(filePath);
      setAvatarUrl(urlData.publicUrl);

      // Update user table
      await supabase.from("users").update({ avatar_url: urlData.publicUrl }).eq("user_id", user.user_id);

      // Clear crop state
      setImageSrc(null);
      setCrop({ x: 0, y: 0 });
      setZoom(1);
      setCroppedAreaPixels(null);

      console.log("Avatar updated successfully!");
    } catch (err) {
      console.error("Upload error:", err);
    }
  };

  const fetchFollowerStats = async (profileUserId: number) => {
    // Count Followers (people who follow YOU)
    const { count: followersCount, error: followersError } = await supabase
      .from("followers")
      .select("*", { count: "exact", head: true })
      .eq("user_id", profileUserId);

    // Count Following (people YOU follow)
    const { count: followingCount, error: followingError } = await supabase
      .from("followers")
      .select("*", { count: "exact", head: true })
      .eq("follower_user_id", profileUserId);

    if (followersError || followingError) {
      console.error("Failed to fetch follower stats:", followersError || followingError);
    }

    setFollowers(followersCount || 0);
    setFollowing(followingCount || 0);
  };

  useEffect(() => {
    if (!user) return;

    fetchFollowerStats(user.user_id);
  }, [user]);


  useEffect(() => {
    const fetchUserBuilds = async () => {
      if (!user) return;

      setLoadingBuilds(true);

      const { data, error } = await supabase
        .from("builds")
        .select("*")
        .eq("user_id", user.user_id)
        .order("date_created", { ascending: false });

      if (!error && data) {
        setUserBuilds(data);
      }

      setLoadingBuilds(false);
    };

    fetchUserBuilds();

  }, [user]);

  useEffect(() => {
    if (!user) return;

    setAvatarUrl(user.avatar_url || "");
    setProfileData({
      username: user.user_name || "",
      email: user.email || "",
      bio: user.bio || "",
      location: user.location || "",
      website: user.website || "",
      joinDate: user.created_at ? new Date(user.created_at) : new Date(),
    });
  }, [user]);


  const handleSave = async () => {
    if (!user) return;

    // Update auth email (only if changed)
    if (profileData.email !== user.email) {
      await supabase.auth.updateUser({
        email: profileData.email,
      });
    }

    // Update user table
    const { error } = await supabase
      .from("users")
      .update({
        user_name: profileData.username,
        bio: profileData.bio,
        location: profileData.location,
        website: profileData.website,
       // email: profileData.email,
      })
      .eq("user_id", user.user_id);

    if (error) {
      console.error("Failed to update profile:", error);
    } else {
      console.log("Profile updated successfully!");
    }

    setIsEditing(false);
  };


  useEffect(() => {
    if (!user) return;

    setAvatarUrl(user.avatar_url || "");
    setProfileData((prev) => ({
      ...prev,
      username: user.user_name || "",
      email: user.email || "",
      joinDate: user.created_at ? new Date(user.created_at) : new Date(),
    }));
  }, [user]);


  if (!user) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold mb-2">Please log in</h2>
          <Button asChild>
            <Link href="/login">Go to Login</Link>
          </Button>
        </div>
      </div>
    )
  }

  return (
    <ProtectedRoute>
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
        <Navigation variant="dashboard" />
        
        {/* Page Header */}
        <div className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
          <div className="container mx-auto px-4 py-4">
            <div className="flex items-center gap-4">
              <Button variant="ghost" size="sm" asChild>
                <Link href="/dashboard">
                  <ArrowLeft className="h-4 w-4 mr-2" />
                  Back to Dashboard
                </Link>
              </Button>
              <h1 className="text-xl font-bold text-slate-900 dark:text-white">Profile Settings</h1>
            </div>
          </div>
        </div>

      <div className="container mx-auto px-4 py-8 max-w-4xl">
        <div className="grid lg:grid-cols-3 gap-8">
          {/* Profile Overview */}
          <Card className="lg:col-span-1">
            <CardHeader className="text-center">
              <div className="relative mx-auto mb-4">
                <Avatar className="h-24 w-24">
                  <AvatarImage src={avatarUrl || "/placeholder.svg"} />
                  <AvatarFallback className="text-2xl">
                    {userData.user_name.charAt(0).toUpperCase()}
                  </AvatarFallback>
                </Avatar>

                <label className="absolute -bottom-2 -right-2 rounded-full p-2 bg-white dark:bg-slate-800 shadow cursor-pointer">
                  <Camera className="h-4 w-4" />
                  <input 
                    type="file" 
                    accept="image/*"
                    className="hidden"
                    onChange={handleFileChange} // <-- use this
                  />
                </label>
                {imageSrc && (
                  <div
                    className="fixed inset-0 z-50 flex items-center justify-center bg-black/50"
                  >
                    <div className="relative w-80 h-auto bg-white rounded shadow-lg p-4 flex flex-col items-center">
                      <div className="w-full h-64 relative">
                        <Cropper
                          image={imageSrc}
                          crop={crop}
                          zoom={zoom}
                          aspect={1}
                          onCropChange={setCrop}
                          onZoomChange={setZoom}
                          onCropComplete={onCropComplete}
                        />
                      </div>

                      {/* Buttons outside cropper area */}
                      <div className="mt-4 flex gap-2">
                        <Button
                          variant="outline"
                          onClick={() => setImageSrc(null)} // Cancel cropping
                        >
                          Cancel
                        </Button>
                        <Button onClick={handleUpload}>Upload</Button>
                      </div>
                    </div>
                  </div>
                )}


              </div>

              <CardTitle>{profileData.username}</CardTitle>
              <CardDescription>{profileData.email}</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="text-center">
                <p className="text-sm text-slate-600 dark:text-slate-400 mb-4">{profileData.bio}</p>
              </div>

              <Separator />

              <div className="space-y-2 text-sm">
                <div className="flex items-center gap-2">
                  <MapPin className="h-4 w-4 text-slate-500" />
                  <span>{profileData.location}</span>
                </div>
                <div className="flex items-center gap-2">
                  <LinkIcon className="h-4 w-4 text-slate-500" />
                  <a href={profileData.website} className="text-blue-600 hover:underline">
                    {profileData.website}
                  </a>
                </div>
                <div className="flex items-center gap-2">
                  <Calendar className="h-4 w-4 text-slate-500" />
                  <span>Joined {profileData.joinDate.toLocaleDateString()}</span>
                </div>
              </div>

              <Separator />

              <div className="grid grid-cols-3 gap-4 text-center">
                <div>
                  <p className="text-lg font-bold text-slate-900 dark:text-white">{loadingBuilds ? "..." : userBuilds.length}</p>
                  <p className="text-xs text-slate-600 dark:text-slate-400">Builds</p>
                </div>
                <div>
                  <p className="text-lg font-bold text-slate-900 dark:text-white">
                    {followers}
                  </p>
                  <p className="text-xs text-slate-600 dark:text-slate-400">Followers</p>
                </div>

                <div>
                  <p className="text-lg font-bold text-slate-900 dark:text-white">
                    {following}
                  </p>
                  <p className="text-xs text-slate-600 dark:text-slate-400">Following</p>
                </div>
              </div>
            </CardContent>
          </Card>

          {/* Settings */}
          <div className="lg:col-span-2 space-y-6">
            {/* Profile Information */}
            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <div>
                    <CardTitle>Profile Information</CardTitle>
                    <CardDescription>Update your personal information and bio</CardDescription>
                  </div>
                  <Button
                    variant={isEditing ? "default" : "outline"}
                    onClick={() => (isEditing ? handleSave() : setIsEditing(true))}
                  >
                    {isEditing ? (
                      <>
                        <Save className="h-4 w-4 mr-2" />
                        Save Changes
                      </>
                    ) : (
                      "Edit Profile"
                    )}
                  </Button>
                </div>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="grid md:grid-cols-2 gap-4">
                  <div>
                    <Label htmlFor="username">Username</Label>
                    <Input
                      id="username"
                      value={profileData.username}
                      onChange={(e) => setProfileData((prev) => ({ ...prev, username: e.target.value }))}
                      disabled={!isEditing}
                    />
                  </div>
                  {/* 
                  <div>
                    <Label htmlFor="email">Email</Label>
                    <Input
                      id="email"
                      type="email"
                      value={profileData.email}
                      onChange={(e) => setProfileData((prev) => ({ ...prev, email: e.target.value }))}
                      disabled={!isEditing}
                    />
                  </div>
                  */}
                </div>

                <div>
                  <Label htmlFor="bio">Bio</Label>
                  <Textarea
                    id="bio"
                    value={profileData.bio}
                    onChange={(e) => setProfileData((prev) => ({ ...prev, bio: e.target.value }))}
                    disabled={!isEditing}
                    rows={3}
                  />
                </div>

                <div className="grid md:grid-cols-2 gap-4">
                  <div>
                    <Label htmlFor="location">Location</Label>
                    <Input
                      id="location"
                      value={profileData.location}
                      onChange={(e) => setProfileData((prev) => ({ ...prev, location: e.target.value }))}
                      disabled={!isEditing}
                    />
                  </div>
                  <div>
                    <Label htmlFor="website">Website</Label>
                    <Input
                      id="website"
                      value={profileData.website}
                      onChange={(e) => setProfileData((prev) => ({ ...prev, website: e.target.value }))}
                      disabled={!isEditing}
                    />
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* Notification Settings */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Bell className="h-5 w-5" />
                  Notification Preferences
                </CardTitle>
                <CardDescription>Choose what notifications you want to receive</CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex items-center justify-between">
                  <div>
                    <Label htmlFor="email-updates">Email Updates</Label>
                    <p className="text-sm text-slate-600 dark:text-slate-400">Receive general updates via email</p>
                  </div>
                  <Switch
                    id="email-updates"
                    checked={notifications.emailUpdates}
                    onCheckedChange={(checked) => setNotifications((prev) => ({ ...prev, emailUpdates: checked }))}
                  />
                </div>

                <div className="flex items-center justify-between">
                  <div>
                    <Label htmlFor="build-likes">Build Likes</Label>
                    <p className="text-sm text-slate-600 dark:text-slate-400">When someone likes your builds</p>
                  </div>
                  <Switch
                    id="build-likes"
                    checked={notifications.buildLikes}
                    onCheckedChange={(checked) => setNotifications((prev) => ({ ...prev, buildLikes: checked }))}
                  />
                </div>

                <div className="flex items-center justify-between">
                  <div>
                    <Label htmlFor="comments">Comments</Label>
                    <p className="text-sm text-slate-600 dark:text-slate-400">When someone comments on your builds</p>
                  </div>
                  <Switch
                    id="comments"
                    checked={notifications.comments}
                    onCheckedChange={(checked) => setNotifications((prev) => ({ ...prev, comments: checked }))}
                  />
                </div>

                <div className="flex items-center justify-between">
                  <div>
                    <Label htmlFor="followers">New Followers</Label>
                    <p className="text-sm text-slate-600 dark:text-slate-400">When someone follows you</p>
                  </div>
                  <Switch
                    id="followers"
                    checked={notifications.followers}
                    onCheckedChange={(checked) => setNotifications((prev) => ({ ...prev, followers: checked }))}
                  />
                </div>

                <div className="flex items-center justify-between">
                  <div>
                    <Label htmlFor="newsletter">Newsletter</Label>
                    <p className="text-sm text-slate-600 dark:text-slate-400">
                      Monthly newsletter with tips and updates
                    </p>
                  </div>
                  <Switch
                    id="newsletter"
                    checked={notifications.newsletter}
                    onCheckedChange={(checked) => setNotifications((prev) => ({ ...prev, newsletter: checked }))}
                  />
                </div>
              </CardContent>
            </Card>

            {/* Privacy Settings */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Shield className="h-5 w-5" />
                  Privacy Settings
                </CardTitle>
                <CardDescription>Control who can see your information and activity</CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex items-center justify-between">
                  <div>
                    <Label htmlFor="profile-public">Public Profile</Label>
                    <p className="text-sm text-slate-600 dark:text-slate-400">Make your profile visible to everyone</p>
                  </div>
                  <Switch
                    id="profile-public"
                    checked={privacy.profilePublic}
                    onCheckedChange={(checked) => setPrivacy((prev) => ({ ...prev, profilePublic: checked }))}
                  />
                </div>

                <div className="flex items-center justify-between">
                  <div>
                    <Label htmlFor="show-builds">Show Builds</Label>
                    <p className="text-sm text-slate-600 dark:text-slate-400">Display your builds on your profile</p>
                  </div>
                  <Switch
                    id="show-builds"
                    checked={privacy.showBuilds}
                    onCheckedChange={(checked) => setPrivacy((prev) => ({ ...prev, showBuilds: checked }))}
                  />
                </div>

                <div className="flex items-center justify-between">
                  <div>
                    <Label htmlFor="show-activity">Show Activity</Label>
                    <p className="text-sm text-slate-600 dark:text-slate-400">Display your recent activity</p>
                  </div>
                  <Switch
                    id="show-activity"
                    checked={privacy.showActivity}
                    onCheckedChange={(checked) => setPrivacy((prev) => ({ ...prev, showActivity: checked }))}
                  />
                </div>

                <div className="flex items-center justify-between">
                  <div>
                    <Label htmlFor="show-email">Show Email</Label>
                    <p className="text-sm text-slate-600 dark:text-slate-400">Make your email visible to other users</p>
                  </div>
                  <Switch
                    id="show-email"
                    checked={privacy.showEmail}
                    onCheckedChange={(checked) => setPrivacy((prev) => ({ ...prev, showEmail: checked }))}
                  />
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
      </div>
    </ProtectedRoute>
  )
}
