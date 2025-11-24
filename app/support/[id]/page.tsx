"use client"

import { useState, useEffect } from "react"
import { useParams, useRouter } from "next/navigation"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Separator } from "@/components/ui/separator"
import { Textarea } from "@/components/ui/textarea"
import { useLoading } from "@/contexts/loading-context"
import {
  ArrowLeft,
  Clock,
  CheckCircle,
  FileText,
  Settings,
  User,
  Calendar,
  Tag,
  MessageSquare,
  Send,
  AlertTriangle,
  Wrench,
  Truck,
  HelpCircle,
  Cpu,
} from "lucide-react"

// Mock ticket data - in production, this would come from an API
const mockTickets: Record<string, any> = {
  "TKT-001": {
    id: "TKT-001",
    title: "PC won't boot after assembly",
    type: "troubleshooting",
    priority: "high",
    status: "open",
    createdAt: "2024-01-15",
    updatedAt: "2024-01-16",
    description: "My PC won't turn on after I assembled all the components. No lights or fans spinning.",
    assignedTo: "Tech Support",
    replies: [
      {
        id: 1,
        author: "Tech Support",
        message: "Thank you for contacting us. Let's troubleshoot this step by step. First, please check if the power supply switch is turned on.",
        createdAt: "2024-01-15T10:30:00",
      },
      {
        id: 2,
        author: "You",
        message: "I've checked the power supply switch and it's on. Still no response.",
        createdAt: "2024-01-15T14:20:00",
      },
      {
        id: 3,
        author: "Tech Support",
        message: "Please verify all power connections, especially the 24-pin ATX and CPU power connectors. Also check if the RAM is properly seated.",
        createdAt: "2024-01-16T09:15:00",
      },
    ],
  },
  "TKT-002": {
    id: "TKT-002",
    title: "Request for delivery service",
    type: "delivery",
    priority: "medium",
    status: "in_progress",
    createdAt: "2024-01-14",
    updatedAt: "2024-01-15",
    description: "I need help with delivery options for my completed build.",
    assignedTo: "Delivery Team",
    replies: [
      {
        id: 1,
        author: "Delivery Team",
        message: "We offer several delivery options. Please let us know your location and preferred delivery date.",
        createdAt: "2024-01-14T11:00:00",
      },
    ],
  },
  "TKT-003": {
    id: "TKT-003",
    title: "Component compatibility issue",
    type: "build_problem",
    priority: "low",
    status: "resolved",
    createdAt: "2024-01-10",
    updatedAt: "2024-01-12",
    description: "RAM not fitting properly in motherboard slots.",
    assignedTo: "Build Support",
    replies: [
      {
        id: 1,
        author: "Build Support",
        message: "This is usually a RAM compatibility issue. Please verify the RAM type matches your motherboard specifications.",
        createdAt: "2024-01-10T15:30:00",
      },
      {
        id: 2,
        author: "You",
        message: "I've checked and the RAM type is correct. Still having issues.",
        createdAt: "2024-01-11T10:00:00",
      },
      {
        id: 3,
        author: "Build Support",
        message: "Try inserting the RAM at a slight angle and applying even pressure. Make sure the clips click into place.",
        createdAt: "2024-01-11T16:45:00",
      },
      {
        id: 4,
        author: "You",
        message: "That worked! Thank you for the help.",
        createdAt: "2024-01-12T09:20:00",
      },
    ],
  },
}

const supportTypes = [
  { value: "troubleshooting", label: "Troubleshooting", icon: Wrench },
  { value: "build_problem", label: "Build Problem", icon: Settings },
  { value: "delivery", label: "Delivery/Repair", icon: Truck },
  { value: "general", label: "General Inquiry", icon: HelpCircle },
]

const priorityLevels = [
  { value: "low", label: "Low", color: "bg-green-100 text-green-800 dark:bg-green-900/20 dark:text-green-300" },
  { value: "medium", label: "Medium", color: "bg-yellow-100 text-yellow-800 dark:bg-yellow-900/20 dark:text-yellow-300" },
  { value: "high", label: "High", color: "bg-orange-100 text-orange-800 dark:bg-orange-900/20 dark:text-orange-300" },
  { value: "urgent", label: "Urgent", color: "bg-red-100 text-red-800 dark:bg-red-900/20 dark:text-red-300" },
]

const statusOptions = [
  { value: "open", label: "Open", color: "bg-blue-100 text-blue-800 dark:bg-blue-900/20 dark:text-blue-300", icon: Clock },
  { value: "in_progress", label: "In Progress", color: "bg-yellow-100 text-yellow-800 dark:bg-yellow-900/20 dark:text-yellow-300", icon: Settings },
  { value: "resolved", label: "Resolved", color: "bg-green-100 text-green-800 dark:bg-green-900/20 dark:text-green-300", icon: CheckCircle },
  { value: "closed", label: "Closed", color: "bg-gray-100 text-gray-800 dark:bg-gray-900/20 dark:text-gray-300", icon: FileText },
]

export default function TicketDetailPage() {
  const params = useParams()
  const router = useRouter()
  const { startLoading, stopLoading } = useLoading()
  const ticketId = params.id as string

  const [ticket, setTicket] = useState<any>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [newReply, setNewReply] = useState("")
  const [isSubmitting, setIsSubmitting] = useState(false)

  useEffect(() => {
    const fetchTicket = async () => {
      startLoading("Loading ticket details...")
      setIsLoading(true)

      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 500))

      // Try to load from localStorage first (user-created tickets)
      let ticketData = null
      if (typeof window !== 'undefined') {
        const savedTickets = localStorage.getItem('buildmate-support-tickets')
        if (savedTickets) {
          try {
            const tickets = JSON.parse(savedTickets)
            ticketData = tickets.find((t: any) => t.id === ticketId) || null
          } catch (e) {
            console.error('Error loading tickets from localStorage:', e)
          }
        }
      }

      // If not found in localStorage, check mock tickets
      if (!ticketData) {
        ticketData = mockTickets[ticketId] || null
      }

      // If ticket found, add empty replies array if it doesn't exist
      if (ticketData && !ticketData.replies) {
        ticketData.replies = []
      }

      setTicket(ticketData)
      setIsLoading(false)
      stopLoading()
    }

    if (ticketId) {
      fetchTicket()
    }
  }, [ticketId, startLoading, stopLoading])

  const handleSubmitReply = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!newReply.trim()) return

    setIsSubmitting(true)
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 500))

    // Add new reply (in production, this would be an API call)
    const newReplyObj = {
      id: (ticket.replies?.length || 0) + 1,
      author: "You",
      message: newReply,
      createdAt: new Date().toISOString(),
    }

    const updatedTicket = {
      ...ticket,
      replies: [...(ticket.replies || []), newReplyObj],
      updatedAt: new Date().toISOString().split('T')[0],
    }

    setTicket(updatedTicket)

    // Update ticket in localStorage
    if (typeof window !== 'undefined') {
      const savedTickets = localStorage.getItem('buildmate-support-tickets')
      if (savedTickets) {
        try {
          const tickets = JSON.parse(savedTickets)
          const ticketIndex = tickets.findIndex((t: any) => t.id === ticket.id)
          if (ticketIndex !== -1) {
            tickets[ticketIndex] = updatedTicket
            localStorage.setItem('buildmate-support-tickets', JSON.stringify(tickets))
          }
        } catch (e) {
          console.error('Error updating ticket in localStorage:', e)
        }
      }
    }

    setNewReply("")
    setIsSubmitting(false)
  }

  const getStatusIcon = (status: string) => {
    const statusOption = statusOptions.find(s => s.value === status)
    const Icon = statusOption?.icon || Clock
    return <Icon className="h-4 w-4" />
  }

  const getPriorityColor = (priority: string) => {
    const level = priorityLevels.find(p => p.value === priority)
    return level?.color || "bg-gray-100 text-gray-800"
  }

  const getStatusColor = (status: string) => {
    const option = statusOptions.find(s => s.value === status)
    return option?.color || "bg-gray-100 text-gray-800"
  }

  const getTypeIcon = (type: string) => {
    const typeOption = supportTypes.find(t => t.value === type)
    const Icon = typeOption?.icon || HelpCircle
    return <Icon className="h-4 w-4" />
  }

  if (isLoading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
        <div className="container mx-auto px-4 py-8">
          <div className="flex items-center justify-center min-h-[60vh]">
            <div className="text-center">
              <Cpu className="h-16 w-16 text-blue-600 dark:text-blue-400 mx-auto mb-6 animate-pulse" />
              <p className="text-lg font-medium text-slate-700 dark:text-slate-300">
                Loading ticket details...
              </p>
            </div>
          </div>
        </div>
      </div>
    )
  }

  if (!ticket) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
        <div className="container mx-auto px-4 py-8">
          <Card>
            <CardContent className="p-12 text-center">
              <AlertTriangle className="h-12 w-12 text-slate-400 mx-auto mb-4" />
              <h3 className="text-lg font-medium text-slate-900 dark:text-white mb-2">Ticket not found</h3>
              <p className="text-slate-600 dark:text-slate-400 mb-4">
                The ticket you're looking for doesn't exist or has been removed.
              </p>
              <Button onClick={() => router.push("/support")} variant="outline">
                <ArrowLeft className="h-4 w-4 mr-2" />
                Back to Support
              </Button>
            </CardContent>
          </Card>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      
      {/* Page Header */}
      <div className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <Link href="/support">
                <Button variant="ghost" size="sm">
                  <ArrowLeft className="h-4 w-4 mr-2" />
                  Back to Tickets
                </Button>
              </Link>
              <div>
                <h2 className="text-xl font-semibold text-slate-900 dark:text-white">Ticket Details</h2>
                <p className="text-sm text-slate-600 dark:text-slate-400">Ticket ID: {ticket.id}</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="container mx-auto px-4 py-8">
        <div className="grid lg:grid-cols-3 gap-6">
          {/* Main Content */}
          <div className="lg:col-span-2 space-y-6">
            {/* Ticket Header */}
            <Card>
              <CardHeader>
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <div className="flex items-center gap-3 mb-3">
                      <h3 className="text-2xl font-bold text-slate-900 dark:text-white">{ticket.title}</h3>
                      <Badge className={getPriorityColor(ticket.priority)}>
                        {priorityLevels.find(p => p.value === ticket.priority)?.label}
                      </Badge>
                      <Badge className={getStatusColor(ticket.status)}>
                        {getStatusIcon(ticket.status)}
                        <span className="ml-1">{statusOptions.find(s => s.value === ticket.status)?.label}</span>
                      </Badge>
                    </div>
                    <div className="flex items-center gap-4 text-sm text-slate-600 dark:text-slate-400">
                      <div className="flex items-center gap-1">
                        <Tag className="h-4 w-4" />
                        {supportTypes.find(t => t.value === ticket.type)?.label}
                      </div>
                      <div className="flex items-center gap-1">
                        <User className="h-4 w-4" />
                        {ticket.assignedTo}
                      </div>
                      <div className="flex items-center gap-1">
                        <Calendar className="h-4 w-4" />
                        Created: {ticket.createdAt}
                      </div>
                      <div className="flex items-center gap-1">
                        <Calendar className="h-4 w-4" />
                        Updated: {ticket.updatedAt}
                      </div>
                    </div>
                  </div>
                </div>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  <div>
                    <h4 className="font-semibold text-slate-900 dark:text-white mb-2">Description</h4>
                    <p className="text-slate-600 dark:text-slate-400 whitespace-pre-wrap">{ticket.description}</p>
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* Replies Section */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <MessageSquare className="h-5 w-5" />
                  Conversation ({ticket.replies?.length || 0} replies)
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {ticket.replies && ticket.replies.length > 0 ? (
                    ticket.replies.map((reply: any, index: number) => (
                      <div key={reply.id || index} className="space-y-2">
                        <div className="flex items-start gap-3 p-4 rounded-lg bg-slate-50 dark:bg-slate-800/50">
                          <div className="flex-1">
                            <div className="flex items-center gap-2 mb-2">
                              <span className="font-semibold text-slate-900 dark:text-white">{reply.author}</span>
                              <span className="text-xs text-slate-500">
                                {new Date(reply.createdAt).toLocaleString()}
                              </span>
                            </div>
                            <p className="text-slate-700 dark:text-slate-300 whitespace-pre-wrap">{reply.message}</p>
                          </div>
                        </div>
                        {index < ticket.replies.length - 1 && <Separator />}
                      </div>
                    ))
                  ) : (
                    <div className="text-center py-8 text-slate-500">
                      <MessageSquare className="h-12 w-12 mx-auto mb-4 text-slate-400" />
                      <p>No replies yet. Start the conversation!</p>
                    </div>
                  )}
                </div>
              </CardContent>
            </Card>

            {/* Reply Form */}
            <Card>
              <CardHeader>
                <CardTitle>Add Reply</CardTitle>
                <CardDescription>Respond to this ticket</CardDescription>
              </CardHeader>
              <CardContent>
                <form onSubmit={handleSubmitReply} className="space-y-4">
                  <Textarea
                    value={newReply}
                    onChange={(e) => setNewReply(e.target.value)}
                    placeholder="Type your reply here..."
                    rows={4}
                    required
                  />
                  <div className="flex justify-end">
                    <Button type="submit" disabled={isSubmitting || !newReply.trim()}>
                      {isSubmitting ? (
                        <>
                          <Clock className="h-4 w-4 mr-2 animate-spin" />
                          Sending...
                        </>
                      ) : (
                        <>
                          <Send className="h-4 w-4 mr-2" />
                          Send Reply
                        </>
                      )}
                    </Button>
                  </div>
                </form>
              </CardContent>
            </Card>
          </div>

          {/* Sidebar */}
          <div className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Ticket Information</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div>
                  <p className="text-sm text-slate-600 dark:text-slate-400 mb-1">Ticket ID</p>
                  <p className="font-medium text-slate-900 dark:text-white">{ticket.id}</p>
                </div>
                <Separator />
                <div>
                  <p className="text-sm text-slate-600 dark:text-slate-400 mb-1">Type</p>
                  <div className="flex items-center gap-2">
                    {getTypeIcon(ticket.type)}
                    <p className="font-medium text-slate-900 dark:text-white">
                      {supportTypes.find(t => t.value === ticket.type)?.label}
                    </p>
                  </div>
                </div>
                <Separator />
                <div>
                  <p className="text-sm text-slate-600 dark:text-slate-400 mb-1">Priority</p>
                  <Badge className={getPriorityColor(ticket.priority)}>
                    {priorityLevels.find(p => p.value === ticket.priority)?.label}
                  </Badge>
                </div>
                <Separator />
                <div>
                  <p className="text-sm text-slate-600 dark:text-slate-400 mb-1">Status</p>
                  <Badge className={getStatusColor(ticket.status)}>
                    {getStatusIcon(ticket.status)}
                    <span className="ml-1">{statusOptions.find(s => s.value === ticket.status)?.label}</span>
                  </Badge>
                </div>
                <Separator />
                <div>
                  <p className="text-sm text-slate-600 dark:text-slate-400 mb-1">Assigned To</p>
                  <p className="font-medium text-slate-900 dark:text-white">{ticket.assignedTo}</p>
                </div>
                <Separator />
                <div>
                  <p className="text-sm text-slate-600 dark:text-slate-400 mb-1">Created</p>
                  <p className="font-medium text-slate-900 dark:text-white">{ticket.createdAt}</p>
                </div>
                <Separator />
                <div>
                  <p className="text-sm text-slate-600 dark:text-slate-400 mb-1">Last Updated</p>
                  <p className="font-medium text-slate-900 dark:text-white">{ticket.updatedAt}</p>
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  )
}

