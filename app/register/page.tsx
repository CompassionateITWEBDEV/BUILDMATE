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
import { Checkbox } from "@/components/ui/checkbox"
import { useAuth } from "@/contexts/supabase-auth-context"
import { Cpu, Eye, EyeOff, Loader2, Mail, CheckCircle } from "lucide-react"

export default function RegisterPage() {
  const [step, setStep] = useState<'register' | 'verify'>('register')
  const [email, setEmail] = useState("")
  const [verificationCode, setVerificationCode] = useState("")
  const [username, setUsername] = useState("")
  const [password, setPassword] = useState("")
  const [confirmPassword, setConfirmPassword] = useState("")
  const [showPassword, setShowPassword] = useState(false)
  const [showConfirmPassword, setShowConfirmPassword] = useState(false)
  const [acceptTerms, setAcceptTerms] = useState(false)
  const [error, setError] = useState("")
  const [successMessage, setSuccessMessage] = useState("")
  const [isSendingCode, setIsSendingCode] = useState(false)
  const [isVerifying, setIsVerifying] = useState(false)
  const [verificationToken, setVerificationToken] = useState<string | null>(null)
  const router = useRouter()
  const { register, sendVerificationCode, verifyCode, isLoading } = useAuth()

  // Step 1: Submit user details and send verification code
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setError("")
    setSuccessMessage("")

    if (!username || !email || !password || !confirmPassword) {
      setError("All fields are required")
      return
    }

    if (password !== confirmPassword) {
      setError("Passwords do not match")
      return
    }

    if (password.length < 6) {
      setError("Password must be at least 6 characters long")
      return
    }

    if (!acceptTerms) {
      setError("Please accept the terms and conditions")
      return
    }

    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if (!emailRegex.test(email)) {
      setError("Please enter a valid email address")
      return
    }

    // Send verification code
    setIsSendingCode(true)
    const result = await sendVerificationCode(email)
    setIsSendingCode(false)

    if (result.success) {
      setStep('verify')
      setSuccessMessage("Verification code sent to your email. Please check your inbox.")
    } else {
      setError(result.error || "Failed to send verification code")
    }
  }

  // Step 2: Verify code and complete registration
  const handleVerifyCode = async (e: React.FormEvent) => {
    e.preventDefault()
    setError("")
    setSuccessMessage("")

    if (!verificationCode || verificationCode.length !== 6) {
      setError("Please enter the 6-digit verification code")
      return
    }

    setIsVerifying(true)
    const verifyResult = await verifyCode(email, verificationCode)
    
    if (verifyResult.success && verifyResult.token) {
      setVerificationToken(verifyResult.token)
      
      // Now complete registration with the token
      const registerResult = await register(username, email, password, verifyResult.token)
      setIsVerifying(false)

      if (registerResult.success) {
        setSuccessMessage("Account created successfully! Redirecting to login...")
        setTimeout(() => {
          router.push("/login")
        }, 2000)
      } else {
        setError(registerResult.error || "Registration failed")
      }
    } else {
      setIsVerifying(false)
      setError(verifyResult.error || "Invalid verification code")
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
            <h2 className="text-3xl font-bold text-slate-900 dark:text-white mb-2">Create Account</h2>
            <p className="text-slate-600 dark:text-slate-400">
              {step === 'register' && 'Enter your details to create your account'}
              {step === 'verify' && 'Enter the verification code sent to your email'}
            </p>
          </div>

          <Card className="border-slate-200 dark:border-slate-700">
            <CardHeader>
              <CardTitle>
                {step === 'register' && 'Step 1: Enter Your Details'}
                {step === 'verify' && 'Step 2: Verify Email'}
              </CardTitle>
              <CardDescription>
                {step === 'register' && 'We\'ll send a verification code to your email after you submit'}
                {step === 'verify' && `Code sent to ${email}. Enter the 6-digit code to complete registration.`}
              </CardDescription>
            </CardHeader>
            <CardContent>
              {error && (
                <Alert variant="destructive" className="mb-4">
                  <AlertDescription>{error}</AlertDescription>
                </Alert>
              )}
              {successMessage && (
                <Alert className="mb-4 border-green-500 bg-green-50 dark:bg-green-900/20">
                  <CheckCircle className="h-4 w-4 text-green-600" />
                  <AlertDescription className="text-green-800 dark:text-green-200">
                    {successMessage}
                  </AlertDescription>
                </Alert>
              )}

              {/* Step 1: Registration Form */}
              {step === 'register' && (
                <form onSubmit={handleSubmit} className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="username">Username</Label>
                    <Input
                      id="username"
                      type="text"
                      placeholder="Enter your username"
                      value={username}
                      onChange={(e) => setUsername(e.target.value)}
                      required
                      disabled={isSendingCode}
                    />
                  </div>

                              <div className="space-y-2">
                                <Label htmlFor="email">Email Address</Label>
                                <Input
                                  id="email"
                                  type="email"
                                  placeholder="Enter your email: "
                                  value={email}
                                  onChange={(e) => setEmail(e.target.value)}
                                  required
                                  disabled={isSendingCode}
                                />
                                <p className="text-xs text-slate-500 dark:text-slate-400">
                                  We'll send a 6-digit verification code to your verified email address (Gmail, Yahoo, Outlook, etc.)
                                </p>
                              </div>

                  <div className="space-y-2">
                    <Label htmlFor="password">Password</Label>
                    <div className="relative">
                      <Input
                        id="password"
                        type={showPassword ? "text" : "password"}
                        placeholder="Create a password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        required
                        disabled={isSendingCode}
                      />
                      <Button
                        type="button"
                        variant="ghost"
                        size="sm"
                        className="absolute right-0 top-0 h-full px-3 py-2 hover:bg-transparent"
                        onClick={() => setShowPassword(!showPassword)}
                      >
                        {showPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                      </Button>
                    </div>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="confirmPassword">Confirm Password</Label>
                    <div className="relative">
                      <Input
                        id="confirmPassword"
                        type={showConfirmPassword ? "text" : "password"}
                        placeholder="Confirm your password"
                        value={confirmPassword}
                        onChange={(e) => setConfirmPassword(e.target.value)}
                        required
                        disabled={isSendingCode}
                      />
                      <Button
                        type="button"
                        variant="ghost"
                        size="sm"
                        className="absolute right-0 top-0 h-full px-3 py-2 hover:bg-transparent"
                        onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                      >
                        {showConfirmPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                      </Button>
                    </div>
                  </div>

                  <div className="flex items-center space-x-2">
                    <Checkbox
                      id="terms"
                      checked={acceptTerms}
                      onCheckedChange={(checked) => setAcceptTerms(checked as boolean)}
                      disabled={isSendingCode}
                    />
                    <Label htmlFor="terms" className="text-sm">
                      I agree to the{" "}
                      <Link href="/terms" className="text-blue-600 hover:underline">
                        Terms of Service
                      </Link>{" "}
                      and{" "}
                      <Link href="/privacy" className="text-blue-600 hover:underline">
                        Privacy Policy
                      </Link>
                    </Label>
                  </div>

                  <Button type="submit" className="w-full" disabled={isSendingCode}>
                    {isSendingCode ? (
                      <>
                        <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                        Sending Verification Code...
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

              {/* Step 2: Verification Code */}
              {step === 'verify' && (
                <form onSubmit={handleVerifyCode} className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="code">Verification Code</Label>
                    <Input
                      id="code"
                      type="text"
                      placeholder="Enter 6-digit code"
                      value={verificationCode}
                      onChange={(e) => setVerificationCode(e.target.value.replace(/\D/g, '').slice(0, 6))}
                      required
                      maxLength={6}
                      disabled={isVerifying}
                      className="text-center text-2xl font-mono tracking-widest"
                    />
                    <p className="text-xs text-slate-500 dark:text-slate-400">
                      Check your email inbox for the verification code
                    </p>
                  </div>
                  <div className="flex gap-2">
                    <Button
                      type="button"
                      variant="outline"
                      onClick={() => {
                        setStep('register')
                        setVerificationCode("")
                        setError("")
                      }}
                      className="flex-1"
                    >
                      Back
                    </Button>
                    <Button
                      type="button"
                      variant="ghost"
                      onClick={async () => {
                        setIsSendingCode(true)
                        const result = await sendVerificationCode(email)
                        setIsSendingCode(false)
                        if (result.success) {
                          setSuccessMessage("Verification code resent to your email.")
                        } else {
                          setError(result.error || "Failed to resend code")
                        }
                      }}
                      disabled={isSendingCode || isVerifying}
                      className="flex-1"
                    >
                      {isSendingCode ? "Sending..." : "Resend Code"}
                    </Button>
                    <Button type="submit" className="flex-1" disabled={isVerifying || verificationCode.length !== 6}>
                      {isVerifying ? (
                        <>
                          <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                          Verifying & Creating...
                        </>
                      ) : (
                        "Verify & Create Account"
                      )}
                    </Button>
                  </div>
                </form>
              )}

            <div className="mt-6 text-center">
              <p className="text-sm text-slate-600 dark:text-slate-400">
                Already have an account?{" "}
                <Link href="/login" className="text-blue-600 hover:underline font-medium">
                  Sign in
                </Link>
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