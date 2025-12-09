"use client"

import { useState, useEffect } from "react"
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
  LogIn,
  Shield,
} from "lucide-react"
import { useAuth } from "@/contexts/supabase-auth-context"
import { useLoading } from "@/contexts/loading-context"

interface NavigationProps {
  variant?: "default" | "minimal" | "dashboard"
}

export function Navigation({ variant = "default" }: NavigationProps) {
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false)
  const [isScrolled, setIsScrolled] = useState(false)
  const { user, logout } = useAuth()
  const pathname = usePathname()
  const router = useRouter()
  const { startLoading, stopLoading } = useLoading()

  // Get page title based on current pathname
  const getPageTitle = () => {
    if (pathname === '/builder') return 'PC Builder'
    if (pathname === '/builds') return 'Community Builds'
    if (pathname?.startsWith('/builds/')) return 'Build Details'
    if (pathname === '/guides') return 'Build Guides'
    if (pathname?.startsWith('/guides/')) return 'Build Guide'
    if (pathname === '/support') return 'Support'
    if (pathname === '/dashboard') return 'Dashboard'
    if (pathname === '/profile') return 'Profile'
    if (pathname === '/mybuilds') return 'My Builds'
    if (pathname?.startsWith('/mybuilds/')) return 'Build Details'
    if (pathname === '/likedbuilds') return 'Liked Builds'
    if (pathname === '/admin') return 'Admin Dashboard'
    if (pathname === '/login') return 'Login'
    if (pathname === '/register') return 'Register'
    return 'BuildMate'
  }

  // Handle scroll effect like Facebook
  useEffect(() => {
    const handleScroll = () => {
      const scrollPosition = window.scrollY
      setIsScrolled(scrollPosition > 10)
    }

    window.addEventListener('scroll', handleScroll, { passive: true })
    return () => window.removeEventListener('scroll', handleScroll)
  }, [])

  const isActive = (path: string) => pathname === path

  const handleLinkClick = (href: string, label: string) => {
    if (pathname !== href) {
      startLoading(`Loading ${label.toLowerCase()}...`)
      // Navigation will be handled by Next.js Link component
      // Loading will be managed by LoadingProvider based on pathname change
    }
  }

  const mainNavItems = [
    { href: "/builder", label: "PC Builder", icon: Wrench },
    { href: "/builds", label: "Community Builds", icon: Users },
    { href: "/guides", label: "Build Guides", icon: BookOpen },
    { href: "/support", label: "Support", icon: MessageSquare },
  ]

  const userNavItems = [
    { href: "/dashboard", label: "Dashboard", icon: Home },
    { href: "/profile", label: "Profile", icon: User },
    { href: "/mybuilds", label: "My Builds", icon: Wrench },
    { href: "/likedbuilds", label: "Liked Builds", icon: Heart },
    ...(user?.user_type === 'admin' ? [{ href: "/admin", label: "Admin Dashboard", icon: Shield }] : []),
  ]

  const handleLogout = async () => {
    await logout()
    setIsMobileMenuOpen(false)
    router.push("/")
    router.refresh()
  }

  if (variant === "minimal") {
    return (
      <header className={`sticky top-0 z-50 border-b transition-all duration-200 ${
        isScrolled 
          ? 'bg-white/98 backdrop-blur-md dark:bg-slate-900/98 shadow-md' 
          : 'bg-white/95 backdrop-blur-sm dark:bg-slate-900/95 shadow-sm'
      }`}>
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between gap-4">
            <Link href="/" className="flex items-center gap-2 flex-shrink-0">
              <Cpu className="h-8 w-8 text-blue-600 flex-shrink-0" />
              <h1 className="text-2xl font-bold text-slate-900 dark:text-white whitespace-nowrap">{getPageTitle()}</h1>
            </Link>
            <div className="flex items-center gap-2 flex-shrink-0">
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
                      <Link href="/dashboard" onClick={() => handleLinkClick("/dashboard", "Dashboard")}>
                        Dashboard
                      </Link>
                    </DropdownMenuItem>
                    <DropdownMenuItem asChild>
                      <Link href="/profile" onClick={() => handleLinkClick("/profile", "Profile")}>
                        Profile
                      </Link>
                    </DropdownMenuItem>
                    <DropdownMenuSeparator />
                    <DropdownMenuItem onClick={handleLogout}>
                      Log out
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              ) : (
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="outline">
                      <User className="mr-2 h-4 w-4" />
                      Account
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent className="w-48" align="end" forceMount>
                    <DropdownMenuItem asChild>
                      <Link href="/login" onClick={() => handleLinkClick("/login", "Login")}>
                        <LogIn className="mr-2 h-4 w-4" />
                        Login
                      </Link>
                    </DropdownMenuItem>
                    <DropdownMenuItem asChild>
                      <Link href="/register" onClick={() => handleLinkClick("/register", "Sign Up")}>
                        <Plus className="mr-2 h-4 w-4" />
                        Sign Up
                      </Link>
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              )}
            </div>
          </div>
        </div>
      </header>
    )
  }

  if (variant === "dashboard") {
    return (
      <header className={`sticky top-0 z-50 border-b transition-all duration-200 ${
        isScrolled 
          ? 'bg-white/98 backdrop-blur-md dark:bg-slate-900/98 shadow-md' 
          : 'bg-white/95 backdrop-blur-sm dark:bg-slate-900/95 shadow-sm'
      }`}>
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between gap-4">
            <div className="flex items-center gap-4 flex-shrink-0">
              <Link href="/" className="flex items-center gap-2 flex-shrink-0">
                <Cpu className="h-8 w-8 text-blue-600 flex-shrink-0" />
                <h1 className="text-2xl font-bold text-slate-900 dark:text-white whitespace-nowrap">{getPageTitle()}</h1>
              </Link>
              <nav className="hidden md:flex items-center gap-6 flex-shrink-0">
                {mainNavItems.map((item) => (
                  <Link
                    key={item.href}
                    href={item.href}
                    onClick={() => handleLinkClick(item.href, item.label)}
                    className={`text-sm font-medium transition-colors hover:text-slate-900 dark:hover:text-white whitespace-nowrap ${
                      isActive(item.href)
                        ? "text-slate-900 dark:text-white"
                        : "text-slate-600 dark:text-slate-300"
                    }`}
                  >
                    {item.label}
                  </Link>
                ))}
              </nav>
            </div>
            <div className="flex items-center gap-2 flex-shrink-0">
              {user ? (
                <div className="flex items-center gap-3">
                  <Button variant="outline" size="sm" asChild>
                    <Link href="/builder" onClick={() => handleLinkClick("/builder", "PC Builder")}>
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
                          <Link href={item.href} onClick={() => handleLinkClick(item.href, item.label)}>
                            {item.label}
                          </Link>
                        </DropdownMenuItem>
                      ))}
                      <DropdownMenuSeparator />
                      <DropdownMenuItem onClick={handleLogout}>
                        Log out
                      </DropdownMenuItem>
                    </DropdownMenuContent>
                  </DropdownMenu>
                </div>
              ) : (
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="outline">
                      <User className="mr-2 h-4 w-4" />
                      Account
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent className="w-48" align="end" forceMount>
                    <DropdownMenuItem asChild>
                      <Link href="/login" onClick={() => handleLinkClick("/login", "Login")}>
                        <LogIn className="mr-2 h-4 w-4" />
                        Login
                      </Link>
                    </DropdownMenuItem>
                    <DropdownMenuItem asChild>
                      <Link href="/register" onClick={() => handleLinkClick("/register", "Sign Up")}>
                        <Plus className="mr-2 h-4 w-4" />
                        Sign Up
                      </Link>
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              )}
            </div>
          </div>
        </div>
      </header>
    )
  }

  // Default variant
  return (
    <header className={`sticky top-0 z-50 border-b transition-all duration-200 ${
      isScrolled 
        ? 'bg-white/98 backdrop-blur-md dark:bg-slate-900/98 shadow-md' 
        : 'bg-white/95 backdrop-blur-sm dark:bg-slate-900/95 shadow-sm'
    }`}>
      <div className="container mx-auto px-4 py-4">
        <div className="flex items-center justify-between gap-4">
          <Link href="/" className="flex items-center gap-2 flex-shrink-0">
            <Cpu className="h-8 w-8 text-blue-600 flex-shrink-0" />
            <h1 className="text-2xl font-bold text-slate-900 dark:text-white whitespace-nowrap">{getPageTitle()}</h1>
          </Link>
          
          {/* Desktop Navigation */}
          <nav className="hidden md:flex items-center gap-6 flex-shrink-0">
            {mainNavItems.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                onClick={() => handleLinkClick(item.href, item.label)}
                className={`flex items-center gap-2 text-sm font-medium transition-colors hover:text-slate-900 dark:hover:text-white whitespace-nowrap ${
                  isActive(item.href)
                    ? "text-slate-900 dark:text-white"
                    : "text-slate-600 dark:text-slate-300"
                }`}
              >
                <item.icon className="h-4 w-4 flex-shrink-0" />
                {item.label}
              </Link>
            ))}
          </nav>

          <div className="flex items-center gap-2 flex-shrink-0">
            {user ? (
              <div className="flex items-center gap-3">
                <Button variant="outline" size="sm" asChild>
                  <Link href="/builder" onClick={() => handleLinkClick("/builder", "PC Builder")}>
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
                        <Link href={item.href} onClick={() => handleLinkClick(item.href, item.label)}>
                          <item.icon className="mr-2 h-4 w-4" />
                          {item.label}
                        </Link>
                      </DropdownMenuItem>
                    ))}
                    <DropdownMenuSeparator />
                    <DropdownMenuItem onClick={handleLogout}>
                      Log out
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              </div>
            ) : (
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="outline">
                    <User className="mr-2 h-4 w-4" />
                    Account
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent className="w-48" align="end" forceMount>
                  <DropdownMenuItem asChild>
                    <Link href="/login" onClick={() => handleLinkClick("/login", "Login")}>
                      <LogIn className="mr-2 h-4 w-4" />
                      Login
                    </Link>
                  </DropdownMenuItem>
                  <DropdownMenuItem asChild>
                    <Link href="/register" onClick={() => handleLinkClick("/register", "Sign Up")}>
                      <Plus className="mr-2 h-4 w-4" />
                      Sign Up
                    </Link>
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
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
                        className={`px-3 py-2 rounded-lg text-sm font-medium transition-colors ${
                          isActive(item.href)
                            ? "bg-blue-50 text-blue-700 dark:bg-blue-900/20 dark:text-blue-300"
                            : "text-slate-700 hover:bg-slate-100 dark:text-slate-300 dark:hover:bg-slate-800"
                        }`}
                        onClick={() => {
                          handleLinkClick(item.href, item.label)
                          setIsMobileMenuOpen(false)
                        }}
                      >
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
                          className={`px-3 py-2 rounded-lg text-sm font-medium transition-colors ${
                            isActive(item.href)
                              ? "bg-blue-50 text-blue-700 dark:bg-blue-900/20 dark:text-blue-300"
                              : "text-slate-700 hover:bg-slate-100 dark:text-slate-300 dark:hover:bg-slate-800"
                          }`}
                          onClick={() => {
                            handleLinkClick(item.href, item.label)
                            setIsMobileMenuOpen(false)
                          }}
                        >
                          {item.label}
                        </Link>
                      ))}
                      <button
                        onClick={handleLogout}
                        className="px-3 py-2 rounded-lg text-sm font-medium text-red-600 hover:bg-red-50 dark:text-red-400 dark:hover:bg-red-900/20 w-full text-left"
                      >
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
                        className="px-3 py-2 rounded-lg text-sm font-medium text-slate-700 hover:bg-slate-100 dark:text-slate-300 dark:hover:bg-slate-800"
                        onClick={() => setIsMobileMenuOpen(false)}
                      >
                        Login
                      </Link>
                      <Link
                        href="/register"
                        className="px-3 py-2 rounded-lg text-sm font-medium text-slate-700 hover:bg-slate-100 dark:text-slate-300 dark:hover:bg-slate-800"
                        onClick={() => setIsMobileMenuOpen(false)}
                      >
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
