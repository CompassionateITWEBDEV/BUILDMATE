"use client"

import { useState, useEffect } from "react"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Navigation } from "@/components/navigation"
import { WelcomeScreen } from "@/components/welcome-screen"
import { Cpu, HardDrive, Monitor, Zap, Users, BookOpen, Star } from "lucide-react"

export default function HomePage() {
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

  return (
    <>
      {showWelcome && <WelcomeScreen onComplete={handleWelcomeComplete} />}
      <div className={`min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800 transition-opacity duration-1000 ${isFaded ? 'opacity-100' : 'opacity-0'}`}>
        <div className={`transition-opacity duration-1000 ${isFaded ? 'opacity-100 animate-fade-in-up' : 'opacity-0'}`}>
          <Navigation />
        </div>

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
            <p className="text-lg md:text-xl text-slate-700 dark:text-slate-300 mb-10 max-w-2xl mx-auto text-pretty drop-shadow-md">
              Advanced compatibility checking, graph-based recommendations with CSP algorithms, and a thriving community to help you create the
              ultimate custom PC build.
            </p>

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
                  Advanced algorithms check component compatibility in real-time, preventing costly mistakes before you
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

            <Card className={`border-slate-200 dark:border-slate-700 transition-opacity duration-1000 ${isFaded ? 'opacity-100 animate-fade-in-up animation-delay-700' : 'opacity-0'}`}>
              <CardHeader>
                <BookOpen className="h-10 w-10 text-orange-600 mb-2" />
                <CardTitle>Step-by-Step Guides</CardTitle>
                <CardDescription>
                  Detailed assembly instructions with photos and videos to guide you through your first build.
                </CardDescription>
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
              Join thousands of builders who trust BuildMate for their custom PC projects.
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
                © 2024 BuildMate. Built for PC enthusiasts, by PC enthusiasts.
              </p>
            </div>
          </div>
        </div>
      </footer>
      </div>
    </>
  )
}
