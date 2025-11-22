"use client"

import { useState } from "react"
import Link from "next/link"
import { usePathname, useRouter } from "next/navigation"
import { Button } from "@/components/ui/button"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Badge } from "@/components/ui/badge"
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import {
  Sheet,
  SheetContent,
  SheetDescription,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from "@/components/ui/sheet"
import {
  Cpu,
  Menu,
  X,
  User,
  Settings,
  LogOut,
  Wrench,
  Users,
  BookOpen,
  MessageSquare,
  BarChart3,
  Home,
  Heart,
  Eye,
  Plus,
  Search,
} from "lucide-react"
import { useAuth } from "@/contexts/supabase-auth-context"

interface NavigationProps {
  variant?: "default" | "minimal" | "dashboard"
}

export function Navigation({ variant = "default" }: NavigationProps) {
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false)
  const { user, logout } = useAuth()
  const pathname = usePathname()
  const router = useRouter()

  const isActive = (path: string) => pathname === path

  const mainNavItems = [
    { href: "/builder", label: "PC Builder", icon: Wrench },
    { href: "/builds", label: "Community Builds", icon: Users },
    { href: "/guides", label: "Build Guides", icon: BookOpen },
    { href: "/compare", label: "Compare", icon: BarChart3 },
    { href: "/support", label: "Support", icon: MessageSquare },
  ]

  const userNavItems = [
    { href: "/dashboard", label: "Dashboard", icon: Home },
    { href: "/profile", label: "Profile", icon: User },
    { href: "/mybuilds", label: "My Builds", icon: Wrench },
    { href: "/builds?liked=true", label: "Liked Builds", icon: Heart },
  ]

  const handleLogout = async () => {
    await logout()
    setIsMobileMenuOpen(false)
    router.push("./")
    router.refresh()
  }

  if (variant === "minimal") {
    return (
      <header className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <Link href="/" className="flex items-center gap-2">
              <Cpu className="h-8 w-8 text-blue-600" />
              <h1 className="text-2xl font-bold text-slate-900 dark:text-white">BuildMate</h1>
            </Link>
            <div className="flex items-center gap-2">
              {user ? (
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="ghost" className="relative h-8 w-8 rounded-full">
                      <Avatar className="h-8 w-8">
                        <Avatar>
                          <AvatarImage src={user.avatar_url || "/placeholder.svg"} />
                          <AvatarFallback>
                            {(user.user_name || user.email || "U").charAt(0).toUpperCase()}
                          </AvatarFallback>
                        </Avatar>
                      </Avatar>
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent className="w-56" align="end" forceMount>
                    <DropdownMenuLabel className="font-normal">
                      <div className="flex flex-col space-y-1">
                        <p className="text-sm font-medium leading-none">{user.user_name || user.email?.split('@')[0] || "User"}</p>
                        <p className="text-xs leading-none text-muted-foreground">{user.email}</p>
                      </div>
                    </DropdownMenuLabel>
                    <DropdownMenuSeparator />
                    <DropdownMenuItem asChild>
                      <Link href="/dashboard">
                        <Home className="mr-2 h-4 w-4" />
                        Dashboard
                      </Link>
                    </DropdownMenuItem>
                    <DropdownMenuItem asChild>
                      <Link href="/profile">
                        <User className="mr-2 h-4 w-4" />
                        Profile
                      </Link>
                    </DropdownMenuItem>
                    <DropdownMenuSeparator />
                    <DropdownMenuItem onClick={handleLogout}>
                      <LogOut className="mr-2 h-4 w-4" />
                      Log out
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              ) : (
                <>
                  <Button variant="outline" asChild>
                    <Link href="/login">Login</Link>
                  </Button>
                  <Button asChild>
                    <Link href="/register">Sign Up</Link>
                  </Button>
                </>
              )}
            </div>
          </div>
        </div>
      </header>
    )
  }

  if (variant === "dashboard") {
    return (
      <header className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <Link href="/" className="flex items-center gap-2">
                <Cpu className="h-8 w-8 text-blue-600" />
                <h1 className="text-2xl font-bold text-slate-900 dark:text-white">BuildMate</h1>
              </Link>
              <nav className="hidden md:flex items-center gap-6">
                {mainNavItems.map((item) => (
                  <Link
                    key={item.href}
                    href={item.href}
                    className={`flex items-center gap-2 text-sm font-medium transition-colors hover:text-slate-900 dark:hover:text-white ${
                      isActive(item.href)
                        ? "text-slate-900 dark:text-white"
                        : "text-slate-600 dark:text-slate-300"
                    }`}
                  >
                    <item.icon className="h-4 w-4" />
                    {item.label}
                  </Link>
                ))}
              </nav>
            </div>
            <div className="flex items-center gap-2">
              {user ? (
                <div className="flex items-center gap-3">
                  <Button variant="outline" size="sm" asChild>
                    <Link href="/builder">
                      <Plus className="h-4 w-4 mr-2" />
                      New Build
                    </Link>
                  </Button>
                  <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                      <Button variant="ghost" className="relative h-8 w-8 rounded-full">
                        <Avatar>
                          <AvatarImage src={user.avatar_url || "/placeholder.svg"} />
                          <AvatarFallback>
                            {(user.user_name || user.email || "U").charAt(0).toUpperCase()}
                          </AvatarFallback>
                        </Avatar>
                      </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent className="w-56" align="end" forceMount>
                      <DropdownMenuLabel className="font-normal">
                        <div className="flex flex-col space-y-1">
                          <p className="text-sm font-medium leading-none">{user.user_name}</p>
                          <p className="text-xs leading-none text-muted-foreground">{user.email}</p>
                        </div>
                      </DropdownMenuLabel>
                      <DropdownMenuSeparator />
                      {userNavItems.map((item) => (
                        <DropdownMenuItem key={item.href} asChild>
                          <Link href={item.href}>
                            <item.icon className="mr-2 h-4 w-4" />
                            {item.label}
                          </Link>
                        </DropdownMenuItem>
                      ))}
                      <DropdownMenuSeparator />
                      <DropdownMenuItem onClick={handleLogout}>
                        <LogOut className="mr-2 h-4 w-4" />
                        Log out
                      </DropdownMenuItem>
                    </DropdownMenuContent>
                  </DropdownMenu>
                </div>
              ) : (
                <>
                  <Button variant="outline" asChild>
                    <Link href="/login">Login</Link>
                  </Button>
                  <Button asChild>
                    <Link href="/register">Sign Up</Link>
                  </Button>
                </>
              )}
            </div>
          </div>
        </div>
      </header>
    )
  }

  // Default variant
  return (
    <header className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
      <div className="container mx-auto px-4 py-4">
        <div className="flex items-center justify-between">
          <Link href="/" className="flex items-center gap-2">
            <Cpu className="h-8 w-8 text-blue-600" />
            <h1 className="text-2xl font-bold text-slate-900 dark:text-white">BuildMate</h1>
          </Link>
          
          {/* Desktop Navigation */}
          <nav className="hidden md:flex items-center gap-6">
            {mainNavItems.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                className={`flex items-center gap-2 text-sm font-medium transition-colors hover:text-slate-900 dark:hover:text-white ${
                  isActive(item.href)
                    ? "text-slate-900 dark:text-white"
                    : "text-slate-600 dark:text-slate-300"
                }`}
              >
                <item.icon className="h-4 w-4" />
                {item.label}
              </Link>
            ))}
          </nav>

          <div className="flex items-center gap-2">
            {user ? (
              <div className="flex items-center gap-3">
                <Button variant="outline" size="sm" asChild>
                  <Link href="/builder">
                    <Plus className="h-4 w-4 mr-2" />
                    New Build
                  </Link>
                </Button>
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="ghost" className="relative h-8 w-8 rounded-full">
                      <Avatar className="h-8 w-8">
                        <Avatar>
                          <AvatarImage src={user.avatar_url || "/placeholder.svg"} />
                          <AvatarFallback>
                            {(user.user_name || user.email || "U").charAt(0).toUpperCase()}
                          </AvatarFallback>
                        </Avatar>
                      </Avatar>
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent className="w-56" align="end" forceMount>
                    <DropdownMenuLabel className="font-normal">
                      <div className="flex flex-col space-y-1">
                        <p className="text-sm font-medium leading-none">{user.user_name || user.email?.split('@')[0] || "User"}</p>
                        <p className="text-xs leading-none text-muted-foreground">{user.email}</p>
                      </div>
                    </DropdownMenuLabel>
                    <DropdownMenuSeparator />
                    {userNavItems.map((item) => (
                      <DropdownMenuItem key={item.href} asChild>
                        <Link href={item.href}>
                          <item.icon className="mr-2 h-4 w-4" />
                          {item.label}
                        </Link>
                      </DropdownMenuItem>
                    ))}
                    <DropdownMenuSeparator />
                    <DropdownMenuItem onClick={handleLogout}>
                      <LogOut className="mr-2 h-4 w-4" />
                      Log out
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              </div>
            ) : (
              <>
                <Button variant="outline" asChild>
                  <Link href="/login">Login</Link>
                </Button>
                <Button asChild>
                  <Link href="/register">Sign Up</Link>
                </Button>
              </>
            )}

            {/* Mobile Menu */}
            <Sheet open={isMobileMenuOpen} onOpenChange={setIsMobileMenuOpen}>
              <SheetTrigger asChild>
                <Button variant="ghost" size="sm" className="md:hidden">
                  <Menu className="h-5 w-5" />
                </Button>
              </SheetTrigger>
              <SheetContent side="right" className="w-[300px] sm:w-[400px]">
                <SheetHeader>
                  <SheetTitle className="flex items-center gap-2">
                    <Cpu className="h-6 w-6 text-blue-600" />
                    BuildMate
                  </SheetTitle>
                  <SheetDescription>
                    Navigate through the application
                  </SheetDescription>
                </SheetHeader>
                <div className="mt-6 space-y-4">
                  {/* Main Navigation */}
                  <div className="space-y-2">
                    <h3 className="text-sm font-medium text-slate-500 dark:text-slate-400">Main Menu</h3>
                    {mainNavItems.map((item) => (
                      <Link
                        key={item.href}
                        href={item.href}
                        className={`flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium transition-colors ${
                          isActive(item.href)
                            ? "bg-blue-50 text-blue-700 dark:bg-blue-900/20 dark:text-blue-300"
                            : "text-slate-700 hover:bg-slate-100 dark:text-slate-300 dark:hover:bg-slate-800"
                        }`}
                        onClick={() => setIsMobileMenuOpen(false)}
                      >
                        <item.icon className="h-4 w-4" />
                        {item.label}
                      </Link>
                    ))}
                  </div>

                  {/* User Navigation */}
                  {user && (
                    <div className="space-y-2">
                      <h3 className="text-sm font-medium text-slate-500 dark:text-slate-400">Account</h3>
                      {userNavItems.map((item) => (
                        <Link
                          key={item.href}
                          href={item.href}
                          className={`flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium transition-colors ${
                            isActive(item.href)
                              ? "bg-blue-50 text-blue-700 dark:bg-blue-900/20 dark:text-blue-300"
                              : "text-slate-700 hover:bg-slate-100 dark:text-slate-300 dark:hover:bg-slate-800"
                          }`}
                          onClick={() => setIsMobileMenuOpen(false)}
                        >
                          <item.icon className="h-4 w-4" />
                          {item.label}
                        </Link>
                      ))}
                      <button
                        onClick={handleLogout}
                        className="flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium text-red-600 hover:bg-red-50 dark:text-red-400 dark:hover:bg-red-900/20 w-full text-left"
                      >
                        <LogOut className="h-4 w-4" />
                        Log out
                      </button>
                    </div>
                  )}

                  {/* Guest Navigation */}
                  {!user && (
                    <div className="space-y-2">
                      <h3 className="text-sm font-medium text-slate-500 dark:text-slate-400">Account</h3>
                      <Link
                        href="/login"
                        className="flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium text-slate-700 hover:bg-slate-100 dark:text-slate-300 dark:hover:bg-slate-800"
                        onClick={() => setIsMobileMenuOpen(false)}
                      >
                        <User className="h-4 w-4" />
                        Login
                      </Link>
                      <Link
                        href="/register"
                        className="flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium text-slate-700 hover:bg-slate-100 dark:text-slate-300 dark:hover:bg-slate-800"
                        onClick={() => setIsMobileMenuOpen(false)}
                      >
                        <Plus className="h-4 w-4" />
                        Sign Up
                      </Link>
                    </div>
                  )}
                </div>
              </SheetContent>
            </Sheet>
          </div>
        </div>
      </div>
    </header>
  )
}
