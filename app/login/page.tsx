"use client"

import type React from "react"
import { useState } from "react"
import { useRouter } from "next/navigation"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Alert, AlertDescription } from "@/components/ui/alert"
import { useAuth } from "@/contexts/supabase-auth-context"
import { Cpu, Eye, EyeOff, Loader2 } from "lucide-react"

export default function LoginPage() {
  const [email, setEmail] = useState("")
  const [password, setPassword] = useState("")
  const [showPassword, setShowPassword] = useState(false)
  const [rememberMe, setRememberMe] = useState(false)
  const [error, setError] = useState("")
  const [step, setStep] = useState<'login' | 'verify'>('login')
  const [verificationCode, setVerificationCode] = useState("")
  const [userId, setUserId] = useState<number | null>(null)
  const [isSendingCode, setIsSendingCode] = useState(false)
  const [isVerifying, setIsVerifying] = useState(false)
  const router = useRouter()
  const { login, sendLoginVerificationCode, verifyLoginCode, isLoading } = useAuth()

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setError("")

    // Client-side validation
    if (!email || !password) {
      setError("Email and password are required")
      return
    }

    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if (!emailRegex.test(email)) {
      setError("Please enter a valid email address")
      return
    }

    // Validate password length
    if (password.length < 6) {
      setError("Password must be at least 6 characters long")
      return
    }

    try {
      const result = await login(email, password, rememberMe)
      
      if (result.success && result.requiresVerification && result.userId) {
        // Credentials are valid, now send verification code
        setUserId(result.userId)
        setIsSendingCode(true)
        
        const codeResult = await sendLoginVerificationCode(email, result.userId)
        setIsSendingCode(false)
        
        if (codeResult.success) {
          setStep('verify')
        } else {
          setError(codeResult.error || "Failed to send verification code")
        }
      } else if (result.success) {
        // No verification needed (shouldn't happen with new flow)
        router.push("/dashboard")
      } else {
        setError(result.error || "Invalid email or password. Please try again.")
      }
    } catch (err: any) {
      console.error("Login error:", err)
      setError(err.message || "Login failed. Please try again.")
    }
  }

  const handleVerifyCode = async (e: React.FormEvent) => {
    e.preventDefault()
    setError("")

    if (!verificationCode || verificationCode.length !== 6) {
      setError("Please enter the 6-digit verification code")
      return
    }

    setIsVerifying(true)
    try {
      const verifyResult = await verifyLoginCode(email, verificationCode)
      
      if (verifyResult.success) {
        // Verification successful, now complete login (skip verification this time)
        const loginResult = await login(email, password, rememberMe, true)
        
        if (loginResult.success) {
          router.push("/dashboard")
        } else {
          setError(loginResult.error || "Login verification successful but failed to complete login. Please try again.")
        }
      } else {
        setError(verifyResult.error || "Invalid verification code")
      }
    } catch (err: any) {
      console.error("Verify code error:", err)
      setError(err.message || "Failed to verify code")
    } finally {
      setIsVerifying(false)
    }
  }

  const handleResendCode = async () => {
    if (!userId) return
    
    setError("")
    setIsSendingCode(true)
    
    try {
      const codeResult = await sendLoginVerificationCode(email, userId)
      if (codeResult.success) {
        setError("") // Clear any previous errors
      } else {
        setError(codeResult.error || "Failed to resend verification code")
      }
    } catch (err: any) {
      setError(err.message || "Failed to resend code")
    } finally {
      setIsSendingCode(false)
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      <div className="flex items-center justify-center p-4 min-h-screen">
        <div className="w-full max-w-md">
          {/* BuildMate Logo - Centered */}
          <div className="text-center mb-8">
            <Link href="/" className="inline-flex items-center justify-center gap-3 mb-6">
              <Cpu className="h-12 w-12 text-blue-600 dark:text-blue-400" />
              <h1 className="text-4xl font-bold text-slate-900 dark:text-white">BuildMate</h1>
            </Link>
          </div>

          {/* Header */}
          <div className="text-center mb-8">
            <h2 className="text-3xl font-bold text-slate-900 dark:text-white mb-2">Welcome Back</h2>
            <p className="text-slate-600 dark:text-slate-400">Sign in to continue building your dream PC</p>
          </div>

        {/* Login Form or Verification Form */}
        <Card className="border-slate-200 dark:border-slate-700">
          <CardHeader>
            <CardTitle>{step === 'login' ? 'Sign In' : 'Verify Email'}</CardTitle>
            <CardDescription>
              {step === 'login' 
                ? 'Enter your credentials to access your account'
                : `Enter the 6-digit verification code sent to ${email}`
              }
            </CardDescription>
          </CardHeader>
          <CardContent>
            {step === 'login' ? (
            <form onSubmit={handleSubmit} className="space-y-4">
              {error && (
                <Alert variant="destructive">
                  <AlertDescription>{error}</AlertDescription>
                </Alert>
              )}

              <div className="space-y-2">
                <Label htmlFor="email">Email</Label>
                <Input
                  id="email"
                  type="email"
                  placeholder="Enter your email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="password">Password</Label>
                <div className="relative">
                  <Input
                    id="password"
                    type={showPassword ? "text" : "password"}
                    placeholder="Enter your password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                  />
                  <Button
                    type="button"
                    variant="ghost"
                    size="sm"
                    className="absolute right-0 top-0 h-full px-3 py-2 hover:bg-transparent"
                    onClick={() => setShowPassword(!showPassword)}
                  >
                    {showPassword ? (
                      <EyeOff className="h-4 w-4" />
                    ) : (
                      <Eye className="h-4 w-4" />
                    )}
                  </Button>
                </div>
              </div>

              <div className="flex items-center justify-between">
                <div className="flex items-center space-x-2">
                  <input
                    id="remember"
                    type="checkbox"
                    checked={rememberMe}
                    onChange={(e) => setRememberMe(e.target.checked)}
                    className="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                  />
                  <Label htmlFor="remember" className="text-sm cursor-pointer">
                    Remember me
                  </Label>
                </div>
                <Link href="/forgot-password" className="text-sm text-blue-600 hover:underline">
                  Forgot password?
                </Link>
              </div>

              <Button type="submit" className="w-full" disabled={isLoading || isSendingCode}>
                {isLoading || isSendingCode ? (
                  <>
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                    {isSendingCode ? 'Sending verification code...' : 'Signing in...'}
                  </>
                ) : (
                  "Sign In"
                )}
              </Button>
            </form>
            ) : (
            <form onSubmit={handleVerifyCode} className="space-y-4">
              {error && (
                <Alert variant="destructive">
                  <AlertDescription>{error}</AlertDescription>
                </Alert>
              )}

              <div className="space-y-2">
                <Label htmlFor="verificationCode">Verification Code</Label>
                <Input
                  id="verificationCode"
                  type="text"
                  placeholder="Enter 6-digit code"
                  value={verificationCode}
                  onChange={(e) => {
                    const value = e.target.value.replace(/\D/g, '').slice(0, 6)
                    setVerificationCode(value)
                  }}
                  maxLength={6}
                  className="text-center text-2xl tracking-widest font-mono"
                  required
                />
                <p className="text-xs text-slate-500 text-center">
                  Check your email for the verification code
                </p>
              </div>

              <Button type="submit" className="w-full" disabled={isVerifying || isLoading}>
                {isVerifying || isLoading ? (
                  <>
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                    Verifying...
                  </>
                ) : (
                  "Verify & Sign In"
                )}
              </Button>

              <div className="text-center">
                <Button
                  type="button"
                  variant="ghost"
                  size="sm"
                  onClick={handleResendCode}
                  disabled={isSendingCode}
                  className="text-sm"
                >
                  {isSendingCode ? (
                    <>
                      <Loader2 className="mr-2 h-3 w-3 animate-spin" />
                      Sending...
                    </>
                  ) : (
                    "Resend Code"
                  )}
                </Button>
              </div>

              <div className="text-center">
                <Button
                  type="button"
                  variant="ghost"
                  size="sm"
                  onClick={() => {
                    setStep('login')
                    setVerificationCode("")
                    setError("")
                  }}
                  className="text-sm"
                >
                  ← Back to Login
                </Button>
              </div>
            </form>
            )}

            <div className="mt-6 text-center">
              <p className="text-sm text-slate-600 dark:text-slate-400">
                Don't have an account?{" "}
                <Link href="/register" className="text-blue-600 hover:underline font-medium">
                  Sign up
                </Link>
              </p>
            </div>

            {/* Demo Credentials */}
            <div className="mt-4 p-3 bg-slate-50 dark:bg-slate-800 rounded-lg">
              <p className="text-xs text-slate-600 dark:text-slate-400 text-center">
                Demo credentials: Email: pcmaster@example.com | Password: password
              </p>
            </div>
          </CardContent>
        </Card>

          <div className="mt-6 text-center">
            <Link
              href="/"
              className="inline-flex items-center text-sm text-slate-600 dark:text-slate-400 hover:text-slate-900 dark:hover:text-white"
            >
              ← Back to Home
            </Link>
          </div>
        </div>
      </div>
    </div>
  )
}
