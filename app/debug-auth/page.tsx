"use client"

import { useState, useEffect } from "react"
import { useAuth } from "@/contexts/supabase-auth-context"
import { supabase } from "@/lib/supabase"
import { addVerifiedUser } from "@/lib/add-verified-user"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Alert, AlertDescription } from "@/components/ui/alert"

export default function DebugAuthPage() {
  const { user, login, register, logout, isLoading } = useAuth()
  const [email, setEmail] = useState("")
  const [password, setPassword] = useState("")
  const [debugInfo, setDebugInfo] = useState<any>({})
  const [error, setError] = useState("")
  const [addUserEmail, setAddUserEmail] = useState("")
  const [addUserPassword, setAddUserPassword] = useState("")
  const [addUserUsername, setAddUserUsername] = useState("")

  useEffect(() => {
    // Get debug information about Supabase connection
    const getDebugInfo = async () => {
      try {
        const { data: { session }, error: sessionError } = await supabase.auth.getSession()
        const { data: { user: authUser }, error: userError } = await supabase.auth.getUser()
        
        setDebugInfo({
          session: session ? "Present" : "None",
          sessionError: sessionError?.message || "None",
          authUser: authUser ? "Present" : "None",
          userError: userError?.message || "None",
          supabaseUrl: process.env.NEXT_PUBLIC_SUPABASE_URL || "Using fallback",
          supabaseKey: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ? "Present" : "Using fallback",
          currentUser: user ? "Present" : "None"
        })
      } catch (err) {
        setDebugInfo({ error: err instanceof Error ? err.message : "Unknown error" })
      }
    }

    getDebugInfo()
  }, [user])

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault()
    setError("")
    
    try {
      const success = await login(email, password)
      if (!success) {
        setError("Login failed")
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : "Login error")
    }
  }

  const handleRegister = async (e: React.FormEvent) => {
    e.preventDefault()
    setError("")
    
    try {
      const success = await register(email.split('@')[0], email, password)
      if (!success) {
        setError("Registration failed")
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : "Registration error")
    }
  }

  const testSupabaseConnection = async () => {
    try {
      const { data, error } = await supabase.auth.signInWithPassword({
        email: "test@example.com",
        password: "testpassword"
      })
      
      setDebugInfo(prev => ({
        ...prev,
        testConnection: error ? `Error: ${error.message}` : "Success"
      }))
    } catch (err) {
      setDebugInfo(prev => ({
        ...prev,
        testConnection: `Error: ${err instanceof Error ? err.message : "Unknown error"}`
      }))
    }
  }

  const handleAddVerifiedUser = async (e: React.FormEvent) => {
    e.preventDefault()
    setError("")
    
    if (!addUserUsername || !addUserEmail || !addUserPassword) {
      setError("All fields are required")
      return
    }

    try {
      const result = await addVerifiedUser(addUserUsername, addUserEmail, addUserPassword)
      if (result.success) {
        setError("")
        alert("User added successfully! You can now log in with these credentials.")
        setAddUserUsername("")
        setAddUserEmail("")
        setAddUserPassword("")
      } else {
        setError(result.error || "Failed to add user")
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to add user")
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800 p-8">
      <div className="max-w-4xl mx-auto space-y-6">
        <h1 className="text-3xl font-bold text-slate-900 dark:text-white">Authentication Debug</h1>
        
        {/* Debug Information */}
        <Card>
          <CardHeader>
            <CardTitle>Debug Information</CardTitle>
            <CardDescription>Current authentication state and Supabase connection</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-2">
              {Object.entries(debugInfo).map(([key, value]) => (
                <div key={key} className="flex justify-between">
                  <span className="font-medium">{key}:</span>
                  <span className="text-sm text-slate-600 dark:text-slate-400">{String(value)}</span>
                </div>
              ))}
            </div>
            <Button onClick={testSupabaseConnection} className="mt-4">
              Test Supabase Connection
            </Button>
          </CardContent>
        </Card>

        {/* Current User */}
        <Card>
          <CardHeader>
            <CardTitle>Current User</CardTitle>
          </CardHeader>
          <CardContent>
            {user ? (
              <div className="space-y-2">
                <p><strong>Email:</strong> {user.email}</p>
                <p><strong>ID:</strong> {user.id}</p>
                <p><strong>Created:</strong> {user.created_at}</p>
                <p><strong>Last Sign In:</strong> {user.last_sign_in_at}</p>
                <p><strong>Email Confirmed:</strong> {user.email_confirmed_at ? "Yes" : "No"}</p>
                <Button onClick={logout} variant="destructive">
                  Logout
                </Button>
              </div>
            ) : (
              <p>No user logged in</p>
            )}
          </CardContent>
        </Card>

        {/* Login Form */}
        <Card>
          <CardHeader>
            <CardTitle>Test Login</CardTitle>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleLogin} className="space-y-4">
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
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="Enter email"
                />
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="password">Password</Label>
                <Input
                  id="password"
                  type="password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="Enter password"
                />
              </div>
              
              <div className="flex gap-2">
                <Button type="submit" disabled={isLoading}>
                  {isLoading ? "Logging in..." : "Login"}
                </Button>
                <Button type="button" onClick={handleRegister} disabled={isLoading}>
                  Register
                </Button>
              </div>
            </form>
          </CardContent>
        </Card>

        {/* Add Verified User */}
        <Card>
          <CardHeader>
            <CardTitle>Add Verified User</CardTitle>
            <CardDescription>Add a user to both Supabase Auth and your custom users table</CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleAddVerifiedUser} className="space-y-4">
              {error && (
                <Alert variant="destructive">
                  <AlertDescription>{error}</AlertDescription>
                </Alert>
              )}
              
              <div className="space-y-2">
                <Label htmlFor="addUsername">Username</Label>
                <Input
                  id="addUsername"
                  value={addUserUsername}
                  onChange={(e) => setAddUserUsername(e.target.value)}
                  placeholder="Enter username"
                />
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="addEmail">Email</Label>
                <Input
                  id="addEmail"
                  type="email"
                  value={addUserEmail}
                  onChange={(e) => setAddUserEmail(e.target.value)}
                  placeholder="Enter email"
                />
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="addPassword">Password</Label>
                <Input
                  id="addPassword"
                  type="password"
                  value={addUserPassword}
                  onChange={(e) => setAddUserPassword(e.target.value)}
                  placeholder="Enter password"
                />
              </div>
              
              <Button type="submit" disabled={isLoading}>
                {isLoading ? "Adding User..." : "Add Verified User"}
              </Button>
            </form>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}
