import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Cpu, HardDrive, Monitor, Zap, Users, BookOpen, Star } from "lucide-react"

export default function HomePage() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      {/* Header */}
      <header className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <Cpu className="h-8 w-8 text-blue-600" />
              <h1 className="text-2xl font-bold text-slate-900 dark:text-white">BuildMate</h1>
            </div>
            <nav className="hidden md:flex items-center gap-6">
              <Link
                href="/builder"
                className="text-slate-600 hover:text-slate-900 dark:text-slate-300 dark:hover:text-white"
              >
                PC Builder
              </Link>
              <Link
                href="/builds"
                className="text-slate-600 hover:text-slate-900 dark:text-slate-300 dark:hover:text-white"
              >
                Community Builds
              </Link>
              <Link
                href="/guides"
                className="text-slate-600 hover:text-slate-900 dark:text-slate-300 dark:hover:text-white"
              >
                Build Guides
              </Link>
              <Link
                href="/support"
                className="text-slate-600 hover:text-slate-900 dark:text-slate-300 dark:hover:text-white"
              >
                Support
              </Link>
              <Link
                href="/compare"
                className="text-slate-600 hover:text-slate-900 dark:text-slate-300 dark:hover:text-white"
              >
                Compare
              </Link>
            </nav>
            <div className="flex items-center gap-2">
              <Button variant="outline" asChild>
                <Link href="/login">Login</Link>
              </Button>
              <Button asChild>
                <Link href="/register">Sign Up</Link>
              </Button>
            </div>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <section className="py-20">
        <div className="container mx-auto px-4 text-center">
          <h2 className="text-5xl font-bold text-slate-900 dark:text-white mb-6 text-balance">
            Build Your Perfect PC with Confidence
          </h2>
          <p className="text-xl text-slate-600 dark:text-slate-300 mb-8 max-w-2xl mx-auto text-pretty">
            Advanced compatibility checking, expert recommendations, and a thriving community to help you create the
            ultimate custom PC build.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Button size="lg" asChild className="bg-blue-600 hover:bg-blue-700">
              <Link href="/builder">
                <Cpu className="mr-2 h-5 w-5" />
                Start Building
              </Link>
            </Button>
            <Button size="lg" variant="outline" asChild>
              <Link href="/builds">
                <Users className="mr-2 h-5 w-5" />
                Browse Builds
              </Link>
            </Button>
          </div>
        </div>
      </section>

      {/* Features Grid */}
      <section className="py-16 bg-white dark:bg-slate-900">
        <div className="container mx-auto px-4">
          <h3 className="text-3xl font-bold text-center text-slate-900 dark:text-white mb-12">Why Choose BuildMate?</h3>
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
            <Card className="border-slate-200 dark:border-slate-700">
              <CardHeader>
                <Zap className="h-10 w-10 text-blue-600 mb-2" />
                <CardTitle>Smart Compatibility</CardTitle>
                <CardDescription>
                  Advanced algorithms check component compatibility in real-time, preventing costly mistakes before you
                  buy.
                </CardDescription>
              </CardHeader>
            </Card>

            <Card className="border-slate-200 dark:border-slate-700">
              <CardHeader>
                <HardDrive className="h-10 w-10 text-green-600 mb-2" />
                <CardTitle>Curated Components</CardTitle>
                <CardDescription>
                  Extensive database of verified PC components with real-time pricing and availability from trusted
                  retailers.
                </CardDescription>
              </CardHeader>
            </Card>

            <Card className="border-slate-200 dark:border-slate-700">
              <CardHeader>
                <Users className="h-10 w-10 text-purple-600 mb-2" />
                <CardTitle>Community Driven</CardTitle>
                <CardDescription>
                  Share builds, get feedback, and discover popular configurations from our community of PC enthusiasts.
                </CardDescription>
              </CardHeader>
            </Card>

            <Card className="border-slate-200 dark:border-slate-700">
              <CardHeader>
                <BookOpen className="h-10 w-10 text-orange-600 mb-2" />
                <CardTitle>Step-by-Step Guides</CardTitle>
                <CardDescription>
                  Detailed assembly instructions with photos and videos to guide you through your first build.
                </CardDescription>
              </CardHeader>
            </Card>

            <Card className="border-slate-200 dark:border-slate-700">
              <CardHeader>
                <Monitor className="h-10 w-10 text-red-600 mb-2" />
                <CardTitle>Performance Insights</CardTitle>
                <CardDescription>
                  Get detailed performance predictions and benchmarks for your custom configuration.
                </CardDescription>
              </CardHeader>
            </Card>

            <Card className="border-slate-200 dark:border-slate-700">
              <CardHeader>
                <Star className="h-10 w-10 text-yellow-600 mb-2" />
                <CardTitle>Expert Recommendations</CardTitle>
                <CardDescription>
                  AI-powered suggestions based on your budget, use case, and performance requirements.
                </CardDescription>
              </CardHeader>
            </Card>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 bg-slate-900 dark:bg-slate-800">
        <div className="container mx-auto px-4 text-center">
          <h3 className="text-3xl font-bold text-white mb-6">Ready to Build Your Dream PC?</h3>
          <p className="text-slate-300 mb-8 max-w-xl mx-auto">
            Join thousands of builders who trust BuildMate for their custom PC projects.
          </p>
          <Button size="lg" className="bg-blue-600 hover:bg-blue-700" asChild>
            <Link href="/register">Get Started Free</Link>
          </Button>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-slate-50 dark:bg-slate-900 py-12">
        <div className="container mx-auto px-4">
          <div className="flex flex-col md:flex-row justify-between items-center">
            <div className="flex items-center gap-2 mb-4 md:mb-0">
              <Cpu className="h-6 w-6 text-blue-600" />
              <span className="font-semibold text-slate-900 dark:text-white">BuildMate</span>
            </div>
            <p className="text-slate-600 dark:text-slate-400 text-sm">
              © 2024 BuildMate. Built for PC enthusiasts, by PC enthusiasts.
            </p>
          </div>
        </div>
      </footer>
    </div>
  )
}
