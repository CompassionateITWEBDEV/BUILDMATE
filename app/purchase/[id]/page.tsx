"use client"

import { useState, useEffect } from "react"
import { useRouter, useParams } from "next/navigation"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { supabase } from "@/lib/supabase"
import { useAuth } from "@/contexts/supabase-auth-context"
import { formatCurrency } from "@/lib/currency"
import {
  Cpu,
  HardDrive,
  MemoryStick,
  Zap,
  Monitor,
  Fan,
  Clapperboard as Motherboard,
  ShoppingCart,
  Mail,
  ArrowLeft,
  Loader2,
  CheckCircle,
  AlertCircle,
  MessageSquare,
  Send,
  User,
} from "lucide-react"
import { Alert, AlertDescription } from "@/components/ui/alert"
import { Textarea } from "@/components/ui/textarea"
import { Separator } from "@/components/ui/separator"

const categoryIcons = {
  CPU: Cpu,
  Motherboard: Motherboard,
  "Memory (RAM)": MemoryStick,
  Storage: HardDrive,
  "Graphics Card": Monitor,
  "Power Supply": Zap,
  Case: HardDrive,
  Cooling: Fan,
}

interface Component {
  component_id: number
  component_name: string
  component_price: number
  component_categories: {
    category_name: string
  }
  retailers: {
    retailer_name: string
    retailer_address?: string
    retailer_phone?: string
    email?: string
  }
}

interface BuildData {
  build_id: number
  build_name: string
  total_price: number
  date_created: string
  build_types: {
    type_name: string
  }
  build_components: Array<{
    components: Component
  }>
}

export default function PurchasePage() {
  const { id } = useParams()
  const router = useRouter()
  const { user } = useAuth()
  const [buildData, setBuildData] = useState<BuildData | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [isSendingEmail, setIsSendingEmail] = useState(false)
  const [emailSent, setEmailSent] = useState(false)
  const [emailResult, setEmailResult] = useState<{ retailerEmailsSent?: number; retailerEmailsFailed?: number } | null>(null)
  const [error, setError] = useState<string | null>(null)
  
  // Conversation state
  const [conversations, setConversations] = useState<any[]>([])
  const [newMessage, setNewMessage] = useState("")
  const [selectedRetailer, setSelectedRetailer] = useState<string | null>(null)
  const [isSendingMessage, setIsSendingMessage] = useState(false)

  useEffect(() => {
    if (!user) {
      router.push("/login")
      return
    }

    const fetchBuildData = async () => {
      try {
        const { data, error: fetchError } = await supabase
          .from("builds")
          .select(`
            build_id,
            build_name,
            total_price,
            date_created,
            build_types(type_name),
            build_components(
              components(
                component_id,
                component_name,
                component_price,
                component_categories(category_name),
                retailers(
                  retailer_name,
                  retailer_address,
                  retailer_phone,
                  email
                )
              )
            )
          `)
          .eq("build_id", id)
          .eq("user_id", user.user_id)
          .single()

        if (fetchError) throw fetchError
        if (!data) throw new Error("Build not found")

        setBuildData(data as BuildData)
      } catch (err: any) {
        console.error("Error fetching build:", err)
        setError(err.message || "Failed to load build details")
      } finally {
        setIsLoading(false)
      }
    }

    fetchBuildData()
  }, [id, user, router])

  const handleSendPurchaseEmail = async () => {
    if (!user || !buildData) return

    setIsSendingEmail(true)
    setError(null)

    try {
      const response = await fetch("/api/purchase/send-email", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          buildId: buildData.build_id,
          userEmail: user.email,
        }),
      })

      const data = await response.json()

      if (!response.ok) {
        throw new Error(data.error || "Failed to send email")
      }

      setEmailSent(true)
      setEmailResult({
        retailerEmailsSent: data.retailerEmailsSent || 0,
        retailerEmailsFailed: data.retailerEmailsFailed || 0
      })
    } catch (err: any) {
      console.error("Error sending email:", err)
      setError(err.message || "Failed to send purchase details email")
    } finally {
      setIsSendingEmail(false)
    }
  }

  if (isLoading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
        <div className="container mx-auto px-4 py-8">
          <div className="flex items-center justify-center min-h-[60vh]">
            <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
          </div>
        </div>
      </div>
    )
  }

  if (error && !buildData) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
        <div className="container mx-auto px-4 py-8">
          <Alert variant="destructive">
            <AlertCircle className="h-4 w-4" />
            <AlertDescription>{error}</AlertDescription>
          </Alert>
          <Button onClick={() => router.push("/builder")} className="mt-4">
            <ArrowLeft className="h-4 w-4 mr-2" />
            Back to Builder
          </Button>
        </div>
      </div>
    )
  }

  if (!buildData) return null

  const components = buildData.build_components.map((bc) => bc.components)

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      <div className="container mx-auto px-4 py-8">
        <div className="mb-6">
          <Button
            variant="ghost"
            onClick={() => router.push("/builder")}
            className="mb-4"
          >
            <ArrowLeft className="h-4 w-4 mr-2" />
            Back to Builder
          </Button>
          <h1 className="text-3xl font-bold text-slate-900 dark:text-white mb-2">
            Purchase Details
          </h1>
          <p className="text-slate-600 dark:text-slate-400">
            Review your build components and purchase information
          </p>
        </div>

        {error && (
          <Alert variant="destructive" className="mb-6">
            <AlertCircle className="h-4 w-4" />
            <AlertDescription>{error}</AlertDescription>
          </Alert>
        )}

        {emailSent && (
          <Alert className="mb-6 border-green-500 bg-green-50 dark:bg-green-900/20">
            <CheckCircle className="h-4 w-4 text-green-600" />
            <AlertDescription className="text-green-800 dark:text-green-200">
              <div className="space-y-1">
                <p>Purchase details have been sent to your verified email: {user?.email}</p>
                {emailResult && emailResult.retailerEmailsSent > 0 && (
                  <p className="text-sm">
                    ✅ Purchase orders have been sent to {emailResult.retailerEmailsSent} retailer(s)
                  </p>
                )}
                {emailResult && emailResult.retailerEmailsFailed > 0 && (
                  <p className="text-sm text-amber-700 dark:text-amber-300">
                    ⚠️ {emailResult.retailerEmailsFailed} retailer email(s) failed to send
                  </p>
                )}
              </div>
            </AlertDescription>
          </Alert>
        )}

        <div className="grid lg:grid-cols-3 gap-6">
          {/* Main Content */}
          <div className="lg:col-span-2 space-y-6">
            {/* Build Summary */}
            <Card>
              <CardHeader>
                <CardTitle>{buildData.build_name}</CardTitle>
                <CardDescription>
                  Build Type: {buildData.build_types?.type_name || "Custom"}
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {components.map((component, index) => {
                    const categoryName =
                      component.component_categories?.category_name || "Unknown"
                    const Icon = categoryIcons[categoryName as keyof typeof categoryIcons]
                    const retailer = component.retailers

                    return (
                      <div
                        key={component.component_id}
                        className="border rounded-lg p-4 space-y-3"
                      >
                        <div className="flex items-start justify-between">
                          <div className="flex items-start gap-3 flex-1">
                            {Icon && (
                              <Icon className="h-5 w-5 text-slate-500 mt-1" />
                            )}
                            <div className="flex-1">
                              <h3 className="font-semibold text-slate-900 dark:text-white">
                                {component.component_name}
                              </h3>
                              <Badge variant="secondary" className="mt-1">
                                {categoryName}
                              </Badge>
                            </div>
                          </div>
                          <div className="text-right">
                            <p className="font-semibold text-slate-900 dark:text-white">
                              {formatCurrency(component.component_price)}
                            </p>
                          </div>
                        </div>

                        {retailer && (
                          <div className="pt-3 border-t space-y-3">
                            <div className="space-y-1 text-sm text-slate-600 dark:text-slate-400">
                              <p className="font-medium">Retailer: {retailer.retailer_name}</p>
                              {retailer.retailer_address && (
                                <p>Address: {retailer.retailer_address}</p>
                              )}
                              {retailer.retailer_phone && (
                                <p>Phone: {retailer.retailer_phone}</p>
                              )}
                              {retailer.email && (
                                <p>Email: {retailer.email}</p>
                              )}
                            </div>
                            
                            {/* Conversation Section */}
                            {retailer.email && (
                              <div className="mt-4 pt-3 border-t">
                                <div className="flex items-center justify-between mb-3">
                                  <h4 className="font-semibold text-slate-900 dark:text-white flex items-center gap-2">
                                    <MessageSquare className="h-4 w-4" />
                                    Conversation with {retailer.retailer_name}
                                  </h4>
                                  <Button
                                    variant="ghost"
                                    size="sm"
                                    onClick={() => setSelectedRetailer(selectedRetailer === retailer.email ? null : retailer.email || null)}
                                  >
                                    {selectedRetailer === retailer.email ? "Hide" : "Show"} Messages
                                  </Button>
                                </div>
                                
                                {selectedRetailer === retailer.email && (
                                  <div className="space-y-4">
                                    {/* Conversation History */}
                                    {getRetailerConversations(retailer.email).length > 0 ? (
                                      <div className="space-y-3 max-h-60 overflow-y-auto">
                                        {getRetailerConversations(retailer.email).map((conv: any) => (
                                          <div
                                            key={conv.id}
                                            className={`p-3 rounded-lg ${
                                              conv.senderType === 'user'
                                                ? 'bg-blue-50 dark:bg-blue-900/20 ml-4'
                                                : 'bg-slate-100 dark:bg-slate-800 mr-4'
                                            }`}
                                          >
                                            <div className="flex items-center gap-2 mb-1">
                                              <User className="h-3 w-3" />
                                              <span className="text-xs font-medium text-slate-700 dark:text-slate-300">
                                                {conv.senderName} ({conv.senderType === 'user' ? 'You' : 'Retailer'})
                                              </span>
                                              <span className="text-xs text-slate-500">
                                                {new Date(conv.createdAt).toLocaleString()}
                                              </span>
                                            </div>
                                            <p className="text-sm text-slate-700 dark:text-slate-300 whitespace-pre-wrap">
                                              {conv.message}
                                            </p>
                                          </div>
                                        ))}
                                      </div>
                                    ) : (
                                      <div className="text-center py-6 text-slate-500 text-sm">
                                        <MessageSquare className="h-8 w-8 mx-auto mb-2 text-slate-400" />
                                        <p>No messages yet. Start a conversation!</p>
                                      </div>
                                    )}
                                    
                                    <Separator />
                                    
                                    {/* Message Form */}
                                    <div className="space-y-2">
                                      <Textarea
                                        value={newMessage}
                                        onChange={(e) => setNewMessage(e.target.value)}
                                        placeholder={`Type your message to ${retailer.retailer_name}...`}
                                        rows={3}
                                      />
                                      <Button
                                        onClick={() => handleSendMessage(retailer.email || '', retailer.retailer_name)}
                                        disabled={!newMessage.trim() || isSendingMessage}
                                        className="w-full"
                                        size="sm"
                                      >
                                        {isSendingMessage ? (
                                          <>
                                            <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                                            Sending...
                                          </>
                                        ) : (
                                          <>
                                            <Send className="mr-2 h-4 w-4" />
                                            Send Message
                                          </>
                                        )}
                                      </Button>
                                    </div>
                                  </div>
                                )}
                              </div>
                            )}
                          </div>
                        )}
                      </div>
                    )
                  })}
                </div>
              </CardContent>
            </Card>
          </div>

          {/* Sidebar */}
          <div className="space-y-6">
            {/* Order Summary */}
            <Card>
              <CardHeader>
                <CardTitle>Order Summary</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="space-y-2">
                  <div className="flex justify-between text-sm">
                    <span className="text-slate-600 dark:text-slate-400">
                      Components ({components.length})
                    </span>
                    <span className="text-slate-900 dark:text-white">
                      {formatCurrency(buildData.total_price)}
                    </span>
                  </div>
                  <div className="border-t pt-2">
                    <div className="flex justify-between font-semibold text-lg">
                      <span>Total</span>
                      <span className="text-blue-600">
                        {formatCurrency(buildData.total_price)}
                      </span>
                    </div>
                  </div>
                </div>

                <Button
                  onClick={handleSendPurchaseEmail}
                  disabled={isSendingEmail || emailSent}
                  className="w-full"
                >
                  {isSendingEmail ? (
                    <>
                      <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                      Sending...
                    </>
                  ) : emailSent ? (
                    <>
                      <CheckCircle className="h-4 w-4 mr-2" />
                      Email Sent
                    </>
                  ) : (
                    <>
                      <Mail className="h-4 w-4 mr-2" />
                      Send Purchase Details to Email
                    </>
                  )}
                </Button>

                <p className="text-xs text-slate-500 dark:text-slate-400 text-center">
                  Purchase details will be sent to your verified email: {user?.email}
                </p>
              </CardContent>
            </Card>

            {/* Security Notice */}
            <Card className="border-blue-200 dark:border-blue-800 bg-blue-50 dark:bg-blue-900/20">
              <CardHeader>
                <CardTitle className="text-sm flex items-center gap-2">
                  <AlertCircle className="h-4 w-4 text-blue-600" />
                  Security Notice
                </CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-xs text-slate-600 dark:text-slate-400">
                  Purchase details are sent to your verified email. Retailers will also receive purchase orders for components from their stores.
                  address. This ensures that sensitive purchase information remains secure.
                </p>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  )
}

