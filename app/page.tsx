"use client"

import { useState, useEffect } from "react"
import { useRouter } from "next/navigation"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { WelcomeScreen } from "@/components/welcome-screen"
import { useAuth } from "@/contexts/supabase-auth-context"
import { Cpu, HardDrive, Monitor, Zap, Users, BookOpen, Star } from "lucide-react"

export default function HomePage() {
  const { user, isLoading } = useAuth()
  const router = useRouter()

  // Redirect logged-in users to dashboard
  useEffect(() => {
    if (!isLoading && user) {
      router.push("/dashboard")
    }
  }, [user, isLoading, router])
  const [showWelcome, setShowWelcome] = useState(true)
  const [isFaded, setIsFaded] = useState(false)

  useEffect(() => {
    // Check if user has seen welcome screen before
    const hasSeenWelcome = typeof window !== 'undefined' && localStorage.getItem('buildmate-welcome-seen') === 'true'
    if (hasSeenWelcome) {
      setShowWelcome(false)
      setIsFaded(true)
    }
  }, [])

  const handleWelcomeComplete = () => {
    if (typeof window !== 'undefined') {
      localStorage.setItem('buildmate-welcome-seen', 'true')
    }
    setShowWelcome(false)
    setTimeout(() => setIsFaded(true), 100)
  }

  // Don't render landing page if user is logged in (will redirect)
  if (!isLoading && user) {
    return null
  }

  return (
    <>
      {showWelcome && <WelcomeScreen onComplete={handleWelcomeComplete} />}
      <div className={`min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800 transition-opacity duration-1000 ${isFaded ? 'opacity-100' : 'opacity-0'}`}>

        {/* Hero Section with Background */}
        <section className={`relative py-32 md:py-40 overflow-hidden transition-opacity duration-1000 ${isFaded ? 'opacity-100 animate-fade-in-up animation-delay-200' : 'opacity-0'}`}>
          {/* Background Image with Fade Overlay */}
          <div className="absolute inset-0 z-0">
            <div 
              className="absolute inset-0 bg-cover bg-center bg-no-repeat"
              style={{
                backgroundImage: 'url(/professional-workstation-pc.jpg)',
                opacity: 0.3
              }}
            />
            {/* Fade Overlay Gradient */}
            <div className="absolute inset-0 bg-gradient-to-b from-slate-50/90 via-slate-50/80 to-slate-50 dark:from-slate-900/95 dark:via-slate-900/90 dark:to-slate-900/95" />
            {/* Additional fade effect */}
            <div className="absolute inset-0 bg-gradient-to-r from-blue-600/10 via-transparent to-blue-600/10" />
          </div>

          {/* Content */}
          <div className="relative z-10 container mx-auto px-4 text-center">
            {/* Slogan */}
            <div className={`mb-6 transition-opacity duration-1000 delay-300 ${isFaded ? 'opacity-100 animate-fade-in-up' : 'opacity-0'}`}>
              <p className="text-lg md:text-xl font-semibold text-blue-600 dark:text-blue-400 mb-2 tracking-wide uppercase">
                Your Dream PC, Built Right
              </p>
            </div>

            {/* Main Heading */}
            <h2 className="text-4xl md:text-5xl lg:text-6xl font-bold text-slate-900 dark:text-white mb-6 text-balance drop-shadow-lg">
              Build Your Perfect PC with Confidence
            </h2>
            
            {/* Description */}
            <p className="text-lg md:text-xl text-slate-700 dark:text-slate-300 mb-6 max-w-2xl mx-auto text-pretty drop-shadow-md">
              Advanced compatibility checking, graph-based recommendations with CSP algorithms, and a thriving community to help you create the
              ultimate custom PC build.
            </p>
            
            {/* Tutorial Emphasis */}
            <div className="mb-10 max-w-2xl mx-auto">
              <div className="bg-gradient-to-r from-blue-50 to-indigo-50 dark:from-blue-900/30 dark:to-indigo-900/30 border-2 border-blue-200 dark:border-blue-700 rounded-lg p-4 sm:p-6 shadow-lg">
                <div className="flex items-start gap-3">
                  <BookOpen className="h-6 w-6 sm:h-8 sm:w-8 text-blue-600 dark:text-blue-400 flex-shrink-0 mt-1" />
                  <div className="flex-1">
                    <h3 className="text-lg sm:text-xl font-bold text-slate-900 dark:text-white mb-2">
                      📚 Complete Step-by-Step PC Building Tutorial
                    </h3>
                    <p className="text-sm sm:text-base text-slate-700 dark:text-slate-300 mb-3">
                      Our comprehensive guide walks you through every step of building your PC, from unboxing components to first boot. Perfect for beginners and DIY enthusiasts.
                    </p>
                    <Button size="sm" asChild className="bg-blue-600 hover:bg-blue-700 text-white">
                      <Link href="/guides/pc-assembly-guide">
                        <BookOpen className="mr-2 h-4 w-4" />
                        View Complete Guide
                      </Link>
                    </Button>
                  </div>
                </div>
              </div>
            </div>

            {/* CTA Buttons */}
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Button size="lg" asChild className="bg-blue-600 hover:bg-blue-700 text-white shadow-lg hover:shadow-xl transition-all">
                <Link href="/builder">
                  <Cpu className="mr-2 h-5 w-5" />
                  Start Building
                </Link>
              </Button>
              <Button size="lg" variant="outline" asChild className="bg-white/80 dark:bg-slate-800/80 backdrop-blur-sm border-2 shadow-lg hover:shadow-xl transition-all">
                <Link href="/builds">
                  <Users className="mr-2 h-5 w-5" />
                  Browse Builds
                </Link>
              </Button>
            </div>
          </div>
        </section>

      {/* Features Grid */}
      <section className={`py-16 bg-white dark:bg-slate-900 transition-opacity duration-1000 ${isFaded ? 'opacity-100 animate-fade-in-up animation-delay-300' : 'opacity-0'}`}>
        <div className="container mx-auto px-4">
          <h3 className="text-3xl font-bold text-center text-slate-900 dark:text-white mb-12">Why Choose BuildMate?</h3>
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
            <Card className={`border-slate-200 dark:border-slate-700 transition-opacity duration-1000 ${isFaded ? 'opacity-100 animate-fade-in-up animation-delay-400' : 'opacity-0'}`}>
              <CardHeader>
                <Zap className="h-10 w-10 text-blue-600 mb-2" />
                <CardTitle>Smart Compatibility</CardTitle>
                <CardDescription>
                  algorithms check component compatibility, preventing costly mistakes before you
                  buy.
                </CardDescription>
              </CardHeader>
            </Card>

            <Card className={`border-slate-200 dark:border-slate-700 transition-opacity duration-1000 ${isFaded ? 'opacity-100 animate-fade-in-up animation-delay-500' : 'opacity-0'}`}>
              <CardHeader>
                <HardDrive className="h-10 w-10 text-green-600 mb-2" />
                <CardTitle>Curated Components</CardTitle>
                <CardDescription>
                  Extensive database of verified PC components with real-time pricing and availability from trusted
                  retailers.
                </CardDescription>
              </CardHeader>
            </Card>

            <Card className={`border-slate-200 dark:border-slate-700 transition-opacity duration-1000 ${isFaded ? 'opacity-100 animate-fade-in-up animation-delay-600' : 'opacity-0'}`}>
              <CardHeader>
                <Users className="h-10 w-10 text-purple-600 mb-2" />
                <CardTitle>Community Driven</CardTitle>
                <CardDescription>
                  Share builds, get feedback, and discover popular configurations from our community of PC enthusiasts.
                </CardDescription>
              </CardHeader>
            </Card>

            <Card className={`border-slate-200 dark:border-slate-700 transition-opacity duration-1000 ${isFaded ? 'opacity-100 animate-fade-in-up animation-delay-700' : 'opacity-0'} border-2 border-orange-200 dark:border-orange-800 bg-gradient-to-br from-orange-50 to-orange-100/50 dark:from-orange-900/20 dark:to-orange-800/10`}>
              <CardHeader>
                <div className="flex items-center justify-between mb-2">
                  <BookOpen className="h-10 w-10 text-orange-600 dark:text-orange-400" />
                  <Badge className="bg-orange-600 text-white">Core Feature</Badge>
                </div>
                <CardTitle className="text-xl">Step-by-Step Tutorial</CardTitle>
                <CardDescription className="text-base">
                  <strong>Our core value:</strong> Comprehensive, beginner-friendly guide with videos, diagrams, and auto-progressing steps. Learn to build your PC from start to finish.
                </CardDescription>
                <Button size="sm" variant="outline" className="mt-3 border-orange-300 text-orange-700 hover:bg-orange-100 dark:border-orange-700 dark:text-orange-300 dark:hover:bg-orange-900/30" asChild>
                  <Link href="/guides/pc-assembly-guide">Explore Tutorial →</Link>
                </Button>
              </CardHeader>
            </Card>

            <Card className={`border-slate-200 dark:border-slate-700 transition-opacity duration-1000 ${isFaded ? 'opacity-100 animate-fade-in-up animation-delay-800' : 'opacity-0'}`}>
              <CardHeader>
                <Monitor className="h-10 w-10 text-red-600 mb-2" />
                <CardTitle>Performance Insights</CardTitle>
                <CardDescription>
                  Get detailed performance predictions and benchmarks for your custom configuration.
                </CardDescription>
              </CardHeader>
            </Card>

            <Card className={`border-slate-200 dark:border-slate-700 transition-opacity duration-1000 ${isFaded ? 'opacity-100 animate-fade-in-up animation-delay-900' : 'opacity-0'}`}>
              <CardHeader>
                <Star className="h-10 w-10 text-yellow-600 mb-2" />
                <CardTitle>Expert Recommendations</CardTitle>
                <CardDescription>
                  Graph-Based Matching Algorithm and CSP (Constraint Satisfaction Problem) with Backtracking and Pruning for optimal component suggestions based on your budget, use case, and performance requirements.
                </CardDescription>
              </CardHeader>
            </Card>
          </div>
        </div>
      </section>

      {/* CTA & Footer Combined - Blue Footer */}
      <footer className={`bg-gradient-to-br from-blue-600 via-blue-700 to-blue-800 dark:from-blue-800 dark:via-blue-900 dark:to-blue-950 transition-opacity duration-1000 ${isFaded ? 'opacity-100 animate-fade-in-up animation-delay-1000' : 'opacity-0'}`}>
        <div className="container mx-auto px-4 py-20">
          {/* CTA Section */}
          <div className="text-center mb-16">
            <h3 className="text-3xl font-bold text-white mb-6">Ready to Build Your Dream PC?</h3>
            <p className="text-blue-100 mb-8 max-w-xl mx-auto">
              Join of builders who trust BuildMate for their custom PC projects.
            </p>
            <Button size="lg" className="bg-white text-blue-600 hover:bg-blue-50" asChild>
              <Link href="/register">Get Started Free</Link>
            </Button>
          </div>

          {/* Footer Content */}
          <div className="border-t border-blue-500/30 pt-8">
            <div className="flex flex-col md:flex-row justify-between items-center">
              <div className="flex items-center gap-2 mb-4 md:mb-0">
                <Cpu className="h-6 w-6 text-white" />
                <span className="font-semibold text-white text-lg">BuildMate</span>
              </div>
              <p className="text-blue-100 text-sm">
                © 2025 BuildMate. Built for PC enthusiasts, by PC enthusiasts.
              </p>
            </div>
          </div>
        </div>
      </footer>
      </div>
    </>
  )
}
