"use client"

import { useState, useEffect } from "react"
import Link from "next/link"
import { useLoading } from "@/contexts/loading-context"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Textarea } from "@/components/ui/textarea"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Badge } from "@/components/ui/badge"
import { Alert, AlertDescription } from "@/components/ui/alert"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { useAuth } from "@/contexts/supabase-auth-context"
import {
  Cpu,
  ArrowLeft,
  Plus,
  MessageSquare,
  Wrench,
  Truck,
  AlertTriangle,
  CheckCircle,
  Clock,
  Search,
  Filter,
  FileText,
  Phone,
  Mail,
  HelpCircle,
  Settings,
  User,
  Calendar,
  Tag,
  Star,
} from "lucide-react"

// Mock support ticket data
const mockTickets = [
  {
    id: "TKT-001",
    title: "PC won't boot after assembly",
    type: "troubleshooting",
    priority: "high",
    status: "open",
    createdAt: "2024-01-15",
    updatedAt: "2024-01-16",
    description: "My PC won't turn on after I assembled all the components. No lights or fans spinning.",
    assignedTo: "Tech Support",
    replies: 2,
  },
  {
    id: "TKT-002",
    title: "Request for delivery service",
    type: "delivery",
    priority: "medium",
    status: "in_progress",
    createdAt: "2024-01-14",
    updatedAt: "2024-01-15",
    description: "I need help with delivery options for my completed build.",
    assignedTo: "Delivery Team",
    replies: 1,
  },
  {
    id: "TKT-003",
    title: "Component compatibility issue",
    type: "build_problem",
    priority: "low",
    status: "resolved",
    createdAt: "2024-01-10",
    updatedAt: "2024-01-12",
    description: "RAM not fitting properly in motherboard slots.",
    assignedTo: "Build Support",
    replies: 3,
  },
]

const supportTypes = [
  { value: "troubleshooting", label: "Troubleshooting", icon: Wrench, description: "Technical issues and problems" },
  { value: "build_problem", label: "Build Problem", icon: Settings, description: "Assembly and compatibility issues" },
  { value: "delivery", label: "Delivery/Repair", icon: Truck, description: "Shipping and repair services" },
  { value: "general", label: "General Inquiry", icon: HelpCircle, description: "General questions and support" },
]

const priorityLevels = [
  { value: "low", label: "Low", color: "bg-green-100 text-green-800" },
  { value: "medium", label: "Medium", color: "bg-yellow-100 text-yellow-800" },
  { value: "high", label: "High", color: "bg-orange-100 text-orange-800" },
  { value: "urgent", label: "Urgent", color: "bg-red-100 text-red-800" },
]

const statusOptions = [
  { value: "open", label: "Open", color: "bg-blue-100 text-blue-800" },
  { value: "in_progress", label: "In Progress", color: "bg-yellow-100 text-yellow-800" },
  { value: "resolved", label: "Resolved", color: "bg-green-100 text-green-800" },
  { value: "closed", label: "Closed", color: "bg-gray-100 text-gray-800" },
]

export default function SupportPage() {
  const { user } = useAuth()
  const [activeTab, setActiveTab] = useState("create")
  const [searchTerm, setSearchTerm] = useState("")
  const [statusFilter, setStatusFilter] = useState("all")
  const [typeFilter, setTypeFilter] = useState("all")
  const { startLoading } = useLoading()

  // Load tickets from localStorage or use mock data
  const loadTickets = () => {
    if (typeof window !== 'undefined') {
      const savedTickets = localStorage.getItem('buildmate-support-tickets')
      if (savedTickets) {
        try {
          const tickets = JSON.parse(savedTickets)
          // Normalize replies: if it's an array, convert to count; if missing, set to 0
          return tickets.map((ticket: any) => ({
            ...ticket,
            replies: Array.isArray(ticket.replies) ? ticket.replies.length : (typeof ticket.replies === 'number' ? ticket.replies : 0)
          }))
        } catch (e) {
          console.error('Error loading tickets from localStorage:', e)
        }
      }
    }
    return mockTickets
  }

  const [tickets, setTickets] = useState(() => loadTickets())

  // Save tickets to localStorage whenever they change
  useEffect(() => {
    if (typeof window !== 'undefined') {
      localStorage.setItem('buildmate-support-tickets', JSON.stringify(tickets))
    }
  }, [tickets])

  // New ticket form state
  const [newTicket, setNewTicket] = useState({
    title: "",
    type: "",
    priority: "medium",
    description: "",
    buildId: "",
  })

  const [isSubmitting, setIsSubmitting] = useState(false)
  const [submitSuccess, setSubmitSuccess] = useState(false)

  const handleSubmitTicket = async (e: React.FormEvent) => {
    e.preventDefault()
    setIsSubmitting(true)

    // Generate ticket ID
    const ticketId = `TKT-${String(tickets.length + 1).padStart(3, '0')}`
    const today = new Date().toISOString().split('T')[0]

    // Create new ticket
    const createdTicket = {
      id: ticketId,
      title: newTicket.title,
      type: newTicket.type,
      priority: newTicket.priority,
      status: "open",
      createdAt: today,
      updatedAt: today,
      description: newTicket.description,
      assignedTo: "Tech Support",
      replies: 0,
      buildId: newTicket.buildId || null,
      userId: user?.user_id || null,
    }

    // Add ticket to the list
    setTickets(prevTickets => [createdTicket, ...prevTickets])
    
    console.log("Creating support ticket:", createdTicket)

    // Send email notification to sales.centraljuan.net@gmail.com
    try {
      const emailResponse = await fetch("/api/support/send-ticket-email", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          ...createdTicket,
          userName: user?.user_name || null,
          userEmail: user?.email || null,
        }),
      })

      const emailData = await emailResponse.json()
      if (emailResponse.ok) {
        console.log("✅ Support ticket email sent successfully:", emailData)
      } else {
        console.error("⚠️ Failed to send support ticket email:", emailData.error)
        // Don't fail the ticket creation if email fails
      }
    } catch (emailError) {
      console.error("⚠️ Error sending support ticket email:", emailError)
      // Don't fail the ticket creation if email fails
    }

    setSubmitSuccess(true)
    setIsSubmitting(false)

    // Reset form
    setNewTicket({
      title: "",
      type: "",
      priority: "medium",
      description: "",
      buildId: "",
    })

    // Redirect to profile to view tickets
    setTimeout(() => {
      setSubmitSuccess(false)
      window.location.href = "/profile"
    }, 2000)
  }

  const filteredTickets = tickets.filter(ticket => {
    const matchesSearch = ticket.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         ticket.description.toLowerCase().includes(searchTerm.toLowerCase())
    const matchesStatus = statusFilter === "all" || ticket.status === statusFilter
    const matchesType = typeFilter === "all" || ticket.type === typeFilter

    return matchesSearch && matchesStatus && matchesType
  })

  const getStatusIcon = (status: string) => {
    switch (status) {
      case "open": return <Clock className="h-4 w-4" />
      case "in_progress": return <Settings className="h-4 w-4" />
      case "resolved": return <CheckCircle className="h-4 w-4" />
      case "closed": return <FileText className="h-4 w-4" />
      default: return <Clock className="h-4 w-4" />
    }
  }

  const getPriorityColor = (priority: string) => {
    const level = priorityLevels.find(p => p.value === priority)
    return level?.color || "bg-gray-100 text-gray-800"
  }

  const getStatusColor = (status: string) => {
    const option = statusOptions.find(s => s.value === status)
    return option?.color || "bg-gray-100 text-gray-800"
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      {/* Page Header */}
      <div className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <h2 className="text-xl font-semibold text-slate-700 dark:text-slate-300">Help & Support</h2>
            </div>
            <Link href="/dashboard">
              <Button variant="outline" size="sm">
                <ArrowLeft className="h-4 w-4 mr-2" />
                Back to Home
              </Button>
            </Link>
          </div>
        </div>
      </div>

      <div className="container mx-auto px-4 py-8">
        <Tabs value={activeTab} onValueChange={setActiveTab}>
          <TabsList className="grid w-full grid-cols-2">
            <TabsTrigger value="create">Create Ticket</TabsTrigger>
            <TabsTrigger value="help">Help Center</TabsTrigger>
          </TabsList>

          {/* Create Ticket Tab */}
          <TabsContent value="create" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Plus className="h-5 w-5" />
                  Create Support Ticket
                </CardTitle>
                <CardDescription>
                  Describe your issue and we'll help you resolve it quickly
                </CardDescription>
              </CardHeader>
              <CardContent>
                {submitSuccess && (
                  <Alert className="mb-6 border-green-200 bg-green-50 dark:bg-green-900/20">
                    <CheckCircle className="h-4 w-4 text-green-600" />
                    <AlertDescription className="text-green-800 dark:text-green-200">
                      Your support ticket has been created successfully! We'll get back to you soon.
                    </AlertDescription>
                  </Alert>
                )}

                <form onSubmit={handleSubmitTicket} className="space-y-6">
                  <div className="grid md:grid-cols-2 gap-6">
                    <div className="space-y-2">
                      <Label htmlFor="title">Ticket Title *</Label>
                      <Input
                        id="title"
                        value={newTicket.title}
                        onChange={(e) => setNewTicket({ ...newTicket, title: e.target.value })}
                        placeholder="Brief description of your issue"
                        required
                      />
                    </div>

                    <div className="space-y-2">
                      <Label htmlFor="type">Support Type *</Label>
                      <Select value={newTicket.type} onValueChange={(value) => setNewTicket({ ...newTicket, type: value })}>
                        <SelectTrigger>
                          <SelectValue placeholder="Select support type" />
                        </SelectTrigger>
                        <SelectContent>
                          {supportTypes.map((type) => (
                            <SelectItem key={type.value} value={type.value}>
                              <div className="flex items-center gap-2">
                                <type.icon className="h-4 w-4" />
                                <div>
                                  <div className="font-medium">{type.label}</div>
                                  <div className="text-xs text-slate-500">{type.description}</div>
                                </div>
                              </div>
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>
                    </div>
                  </div>

                  <div className="grid md:grid-cols-2 gap-6">
                    <div className="space-y-2">
                      <Label htmlFor="priority">Priority Level</Label>
                      <Select value={newTicket.priority} onValueChange={(value) => setNewTicket({ ...newTicket, priority: value })}>
                        <SelectTrigger>
                          <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                          {priorityLevels.map((priority) => (
                            <SelectItem key={priority.value} value={priority.value}>
                              <div className="flex items-center gap-2">
                                <Badge className={priority.color}>{priority.label}</Badge>
                              </div>
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>
                    </div>

                    <div className="space-y-2">
                      <Label htmlFor="buildId">Build ID (Optional)</Label>
                      <Input
                        id="buildId"
                        value={newTicket.buildId}
                        onChange={(e) => setNewTicket({ ...newTicket, buildId: e.target.value })}
                        placeholder="If related to a specific build"
                      />
                    </div>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="description">Detailed Description *</Label>
                    <Textarea
                      id="description"
                      value={newTicket.description}
                      onChange={(e) => setNewTicket({ ...newTicket, description: e.target.value })}
                      placeholder="Please provide as much detail as possible about your issue..."
                      rows={6}
                      required
                    />
                  </div>

                  <div className="flex justify-end gap-4">
                    <Button type="button" variant="outline" onClick={() => setNewTicket({
                      title: "",
                      type: "",
                      priority: "medium",
                      description: "",
                      buildId: "",
                    })}>
                      Clear Form
                    </Button>
                    <Button type="submit" disabled={isSubmitting || !newTicket.title || !newTicket.type || !newTicket.description}>
                      {isSubmitting ? (
                        <>
                          <Clock className="h-4 w-4 mr-2 animate-spin" />
                          Creating Ticket...
                        </>
                      ) : (
                        <>
                          <Plus className="h-4 w-4 mr-2" />
                          Create Ticket
                        </>
                      )}
                    </Button>
                  </div>
                </form>
              </CardContent>
            </Card>

            {/* Quick Help Cards */}
            <div className="grid md:grid-cols-3 gap-6">
              <Card className="border-slate-200 dark:border-slate-700">
                <CardHeader className="pb-3">
                  <div className="flex items-center gap-2">
                    <Wrench className="h-5 w-5 text-blue-600" />
                    <CardTitle className="text-lg">Troubleshooting</CardTitle>
                  </div>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-slate-600 dark:text-slate-400 mb-4">
                    Having technical issues? We can help diagnose and fix problems with your build.
                  </p>
                  <ul className="text-xs text-slate-500 space-y-1">
                    <li>• PC won't boot</li>
                    <li>• Performance issues</li>
                    <li>• Hardware problems</li>
                    <li>• Software conflicts</li>
                  </ul>
                </CardContent>
              </Card>

              <Card className="border-slate-200 dark:border-slate-700">
                <CardHeader className="pb-3">
                  <div className="flex items-center gap-2">
                    <Settings className="h-5 w-5 text-green-600" />
                    <CardTitle className="text-lg">Build Problems</CardTitle>
                  </div>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-slate-600 dark:text-slate-400 mb-4">
                    Need help with assembly or compatibility issues? Our experts are here to help.
                  </p>
                  <ul className="text-xs text-slate-500 space-y-1">
                    <li>• Component compatibility</li>
                    <li>• Assembly guidance</li>
                    <li>• Cable management</li>
                    <li>• BIOS configuration</li>
                  </ul>
                </CardContent>
              </Card>

              <Card className="border-slate-200 dark:border-slate-700">
                <CardHeader className="pb-3">
                  <div className="flex items-center gap-2">
                    <Truck className="h-5 w-5 text-purple-600" />
                    <CardTitle className="text-lg">Delivery & Repair</CardTitle>
                  </div>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-slate-600 dark:text-slate-400 mb-4">
                    Need delivery services or repair work? We offer comprehensive support.
                  </p>
                  <ul className="text-xs text-slate-500 space-y-1">
                    <li>• Build delivery</li>
                    <li>• Component repair</li>
                    <li>• Warranty claims</li>
                    <li>• Return processing</li>
                  </ul>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          {/* Help Center Tab */}
          <TabsContent value="help" className="space-y-6">
            <div className="grid lg:grid-cols-3 gap-6">
              <div className="lg:col-span-2 space-y-6">
                <Card>
                  <CardHeader>
                    <CardTitle>Frequently Asked Questions</CardTitle>
                    <CardDescription>Quick answers to common questions</CardDescription>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="space-y-2">
                      <h4 className="font-medium text-slate-900 dark:text-white">How do I know if my components are compatible?</h4>
                      <p className="text-sm text-slate-600 dark:text-slate-400">
                        Use our compatibility checker in the PC builder. It automatically validates component compatibility and suggests alternatives if needed.
                      </p>
                    </div>
                    <div className="space-y-2">
                      <h4 className="font-medium text-slate-900 dark:text-white">What if my PC won't boot after assembly?</h4>
                      <p className="text-sm text-slate-600 dark:text-slate-400">
                        Check all connections, ensure RAM is properly seated, verify power supply connections, and check that the CPU is correctly installed.
                      </p>
                    </div>
                    <div className="space-y-2">
                      <h4 className="font-medium text-slate-900 dark:text-white">Do you offer build services?</h4>
                      <p className="text-sm text-slate-600 dark:text-slate-400">
                        Yes! We offer professional assembly services and can deliver your completed build. Contact support for more information.
                      </p>
                    </div>
                    <div className="space-y-2">
                      <h4 className="font-medium text-slate-900 dark:text-white">What's your return policy?</h4>
                      <p className="text-sm text-slate-600 dark:text-slate-400">
                        We offer 30-day returns on unopened components and 14-day returns on opened items. Contact support for return requests.
                      </p>
                    </div>
                  </CardContent>
                </Card>

                <Card>
                  <CardHeader>
                    <CardTitle>Contact Information</CardTitle>
                    <CardDescription>Get in touch with our support team</CardDescription>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="flex items-center gap-3">
                      <Phone className="h-5 w-5 text-blue-600" />
                      <div>
                        <p className="font-medium">Phone Support</p>
                        <p className="text-sm text-slate-600 dark:text-slate-400">1-800-BUILDMATE (Mon-Fri 9AM-6PM EST)</p>
                      </div>
                    </div>
                    <div className="flex items-center gap-3">
                      <Mail className="h-5 w-5 text-green-600" />
                      <div>
                        <p className="font-medium">Email Support</p>
                        <p className="text-sm text-slate-600 dark:text-slate-400">support@buildmate.com</p>
                      </div>
                    </div>
                    <div className="flex items-center gap-3">
                      <MessageSquare className="h-5 w-5 text-purple-600" />
                      <div>
                        <p className="font-medium">Live Chat</p>
                        <p className="text-sm text-slate-600 dark:text-slate-400">Available 24/7 on our website</p>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              </div>

              <div className="space-y-6">
                <Card>
                  <CardHeader>
                    <CardTitle>Quick Actions</CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-3">
                    <Button className="w-full justify-start" variant="outline">
                      <Wrench className="h-4 w-4 mr-2" />
                      Troubleshooting Guide
                    </Button>
                    <Button className="w-full justify-start" variant="outline">
                      <Settings className="h-4 w-4 mr-2" />
                      Build Checklist
                    </Button>
                    <Button className="w-full justify-start" variant="outline">
                      <FileText className="h-4 w-4 mr-2" />
                      User Manual
                    </Button>
                    <Button className="w-full justify-start" variant="outline">
                      <Star className="h-4 w-4 mr-2" />
                      Rate Our Service
                    </Button>
                  </CardContent>
                </Card>

                <Card>
                  <CardHeader>
                    <CardTitle>Support Stats</CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-3">
                    <div className="flex justify-between">
                      <span className="text-sm text-slate-600 dark:text-slate-400">Avg. Response Time</span>
                      <span className="font-medium">2 hours</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-sm text-slate-600 dark:text-slate-400">Resolution Rate</span>
                      <span className="font-medium">95%</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-sm text-slate-600 dark:text-slate-400">Customer Satisfaction</span>
                      <span className="font-medium">4.8/5</span>
                    </div>
                  </CardContent>
                </Card>
              </div>
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  )
}


