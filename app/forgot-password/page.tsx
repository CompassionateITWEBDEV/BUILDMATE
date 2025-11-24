"use client"

import type React from "react"
import { useState, useEffect, Suspense } from "react"
import { useRouter, useSearchParams } from "next/navigation"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Alert, AlertDescription } from "@/components/ui/alert"
import { Mail, Loader2, CheckCircle, ArrowLeft, Shield, Cpu } from "lucide-react"

function ForgotPasswordContent() {
  const [step, setStep] = useState<'email' | 'verify'>('email')
  const [email, setEmail] = useState("")
  const [resetCode, setResetCode] = useState("")
  const [isLoading, setIsLoading] = useState(false)
  const [isVerifying, setIsVerifying] = useState(false)
  const [error, setError] = useState("")
  const [success, setSuccess] = useState(false)
  const [resetToken, setResetToken] = useState<string | null>(null)
  const router = useRouter()
  const searchParams = useSearchParams()

  // Pre-fill email from URL parameter if provided
  useEffect(() => {
    const emailParam = searchParams.get('email')
    if (emailParam && !email) {
      setEmail(emailParam)
    }
  }, [searchParams, email])

  // Step 1: Send reset code
  const handleSendCode = async (e: React.FormEvent) => {
    e.preventDefault()
    setError("")
    setSuccess(false)

    // Client-side validation
    if (!email) {
      setError("Email is required")
      return
    }

    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if (!emailRegex.test(email)) {
      setError("Please enter a valid email address (Gmail, Yahoo, etc.)")
      return
    }

    setIsLoading(true)

    try {
      const response = await fetch("/api/auth/send-reset-code", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ email }),
      })

      // Check if response has valid JSON
      const contentType = response.headers.get('content-type')
      let data
      
      if (contentType && contentType.includes('application/json')) {
        data = await response.json()
      } else {
        const text = await response.text()
        throw new Error(text || `Server error: ${response.status}`)
      }

      if (!response.ok) {
        throw new Error(data.error || data.message || "Failed to send password reset code")
      }

      setSuccess(true)
      setStep('verify')
    } catch (err: any) {
      console.error("Send reset code error:", err)
      setError(err.message || "Failed to send password reset code. Please try again.")
    } finally {
      setIsLoading(false)
    }
  }

  // Step 2: Verify code and redirect to reset password
  const handleVerifyCode = async (e: React.FormEvent) => {
    e.preventDefault()
    setError("")
    setSuccess(false)

    if (!resetCode || resetCode.length !== 6) {
      setError("Please enter the 6-digit verification code")
      return
    }

    setIsVerifying(true)

    try {
      // Ensure we have valid data before sending
      if (!email || !resetCode) {
        setError("Email and verification code are required")
        setIsVerifying(false)
        return
      }

      const requestBody = JSON.stringify({ email: email.trim(), code: resetCode.trim() })
      
      const response = await fetch("/api/auth/verify-reset-code", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: requestBody,
      })

      // Check if response has valid JSON
      const contentType = response.headers.get('content-type')
      let data
      
      if (contentType && contentType.includes('application/json')) {
        data = await response.json()
      } else {
        const text = await response.text()
        throw new Error(text || `Server error: ${response.status}`)
      }

      if (!response.ok) {
        // Show detailed error message
        const errorMessage = data.error || data.message || "Invalid verification code"
        const errorDetails = data.details ? ` ${data.details}` : ''
        throw new Error(`${errorMessage}${errorDetails}`)
      }

      if (data.token) {
        setResetToken(data.token)
        // Redirect to reset password page with email and token
        router.push(`/reset-password?email=${encodeURIComponent(email)}&token=${data.token}`)
      }
    } catch (err: any) {
      console.error("Verify reset code error:", err)
      setError(err.message || "Invalid verification code. Please try again.")
    } finally {
      setIsVerifying(false)
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
            <h2 className="text-3xl font-bold text-slate-900 dark:text-white mb-2">Forgot Password</h2>
            <p className="text-slate-600 dark:text-slate-400">
              {step === 'email' 
                ? 'Enter your verified email address and we\'ll send you a reset code'
                : 'Enter the verification code sent to your email'}
            </p>
          </div>

          {/* Forgot Password Form */}
          <Card className="border-slate-200 dark:border-slate-700">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Shield className="h-5 w-5" />
                {step === 'email' ? 'Step 1: Enter Email' : 'Step 2: Verify Code'}
              </CardTitle>
              <CardDescription>
                {step === 'email' 
                  ? 'We\'ll send a 6-digit verification code to your verified email (Gmail, Yahoo, etc.)'
                  : `Code sent to ${email}`}
              </CardDescription>
            </CardHeader>
            <CardContent>
              {error && (
                <Alert variant="destructive" className="mb-4">
                  <AlertDescription>{error}</AlertDescription>
                </Alert>
              )}

              {success && step === 'email' && (
                <Alert className="mb-4 border-green-500 bg-green-50 dark:bg-green-900/20">
                  <CheckCircle className="h-4 w-4 text-green-600" />
                  <AlertDescription className="text-green-800 dark:text-green-200">
                    Password reset code sent! Please check your inbox (and spam folder).
                  </AlertDescription>
                </Alert>
              )}

              {/* Step 1: Email Input */}
              {step === 'email' && (
                <form onSubmit={handleSendCode} className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="email">Email Address</Label>
                    <Input
                      id="email"
                      type="email"
                      placeholder="Enter your verified email (Gmail, Yahoo, etc.)"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      required
                      disabled={isLoading}
                    />
                    <p className="text-xs text-slate-500 dark:text-slate-400">
                      We'll send a 6-digit verification code to verify your email address
                    </p>
                  </div>

                  <Button type="submit" className="w-full" disabled={isLoading}>
                    {isLoading ? (
                      <>
                        <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                        Sending Code...
                      </>
                    ) : (
                      <>
                        <Mail className="mr-2 h-4 w-4" />
                        Send Verification Code
                      </>
                    )}
                  </Button>
                </form>
              )}

              {/* Step 2: Code Verification */}
              {step === 'verify' && (
                <form onSubmit={handleVerifyCode} className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="code">Verification Code</Label>
                    <Input
                      id="code"
                      type="text"
                      placeholder="Enter 6-digit code"
                      value={resetCode}
                      onChange={(e) => {
                        // Only allow digits, max 6 characters
                        const cleaned = e.target.value.replace(/\D/g, '').slice(0, 6)
                        setResetCode(cleaned)
                      }}
                      onBlur={(e) => {
                        // Trim whitespace on blur
                        setResetCode(e.target.value.trim())
                      }}
                      required
                      maxLength={6}
                      disabled={isVerifying}
                      className="text-center text-2xl font-mono tracking-widest"
                    />
                    <p className="text-xs text-slate-500 dark:text-slate-400">
                      Check your email inbox for the verification code
                    </p>
                    {error && error.includes("Invalid or expired") && (
                      <p className="text-xs text-amber-600 dark:text-amber-400 mt-2">
                        💡 Tip: Make sure you use the exact same email address. If the server restarted, request a new code.
                      </p>
                    )}
                  </div>

                  <div className="flex gap-2">
                    <Button
                      type="button"
                      variant="outline"
                      onClick={() => {
                        setStep('email')
                        setResetCode("")
                        setError("")
                      }}
                      className="flex-1"
                      disabled={isVerifying}
                    >
                      Back
                    </Button>
                    <Button
                      type="button"
                      variant="ghost"
                      onClick={handleSendCode}
                      disabled={isLoading || isVerifying}
                      className="flex-1"
                    >
                      {isLoading ? "Sending..." : "Resend Code"}
                    </Button>
                    <Button 
                      type="submit" 
                      className="flex-1" 
                      disabled={isVerifying || resetCode.length !== 6}
                    >
                      {isVerifying ? (
                        <>
                          <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                          Verifying...
                        </>
                      ) : (
                        "Verify Code"
                      )}
                    </Button>
                  </div>
                </form>
              )}

              <div className="mt-6 text-center">
                <Link
                  href="/login"
                  className="inline-flex items-center text-sm text-slate-600 dark:text-slate-400 hover:text-slate-900 dark:hover:text-white"
                >
                  <ArrowLeft className="h-4 w-4 mr-1" />
                  Back to Login
                </Link>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  )
}

export default function ForgotPasswordPage() {
  return (
    <Suspense fallback={
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
        <div className="flex items-center justify-center p-4 min-h-[calc(100vh-80px)]">
          <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
        </div>
      </div>
    }>
      <ForgotPasswordContent />
    </Suspense>
  )
}

