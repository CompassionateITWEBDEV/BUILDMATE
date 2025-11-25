"use client"

import { useState, useEffect } from "react"
import { useAuth } from "@/contexts/supabase-auth-context"
import { useRouter } from "next/navigation"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Badge } from "@/components/ui/badge"
import { Input } from "@/components/ui/input"
import { 
  Users, 
  Package, 
  Wrench, 
  Shield, 
  Trash2, 
  Edit, 
  Search,
  BarChart3,
  Activity,
  AlertCircle,
  ShoppingCart,
  Mail,
  CheckCircle,
  Clock,
  XCircle,
  Eye
} from "lucide-react"
import Link from "next/link"
import { adminService, buildService, componentService, userService } from "@/lib/database"
import { formatCurrency } from "@/lib/currency"
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog"

interface User {
  user_id: number
  user_name: string
  email: string
  user_type: 'admin' | 'user' | 'moderator'
  created_at: string
}

interface Build {
  build_id: number
  build_name: string
  user_id: number
  total_price: number
  date_created: string
  users?: User
  build_types?: { type_name: string }
}

interface Component {
  component_id: number
  component_name: string
  component_brand: string | null
  component_price: number | null
  component_description: string | null
  component_categories?: { category_name: string }
  retailers?: { retailer_name: string }
}

export default function AdminPage() {
  const { user } = useAuth()
  const router = useRouter()
  const [activeTab, setActiveTab] = useState("overview")
  const [users, setUsers] = useState<User[]>([])
  const [builds, setBuilds] = useState<Build[]>([])
  const [components, setComponents] = useState<Component[]>([])
  const [purchases, setPurchases] = useState<any[]>([])
  const [loading, setLoading] = useState(true)
  const [searchTerm, setSearchTerm] = useState("")
  const [selectedStatus, setSelectedStatus] = useState<string>("all")
  const [deleteDialog, setDeleteDialog] = useState<{
    open: boolean
    type: 'user' | 'build' | 'component' | null
    id: number | null
    name: string
  }>({ open: false, type: null, id: null, name: "" })

  // Check if user is admin
  useEffect(() => {
    if (user && user.user_type !== 'admin') {
      router.push('/dashboard')
    }
  }, [user, router])

  // Load data
  useEffect(() => {
    if (user?.user_type === 'admin') {
      loadData()
    }
  }, [user])

  const loadData = async () => {
    try {
      setLoading(true)
      const [usersData, buildsData, componentsData, purchasesData] = await Promise.all([
        adminService.getAllUsers(),
        adminService.getAllBuilds(),
        adminService.getAllComponents(),
        adminService.getAllPurchases()
      ])
      setUsers(usersData as User[])
      setBuilds(buildsData as Build[])
      setComponents(componentsData as Component[])
      setPurchases(purchasesData || [])
    } catch (error) {
      console.error("Error loading admin data:", error)
    } finally {
      setLoading(false)
    }
  }


  const handleDelete = async () => {
    if (!deleteDialog.id || !deleteDialog.type) return

    try {
      switch (deleteDialog.type) {
        case 'user':
          await adminService.deleteUser(deleteDialog.id)
          break
        case 'build':
          await adminService.deleteBuild(deleteDialog.id)
          break
        case 'component':
          await adminService.deleteComponent(deleteDialog.id)
          break
      }
      setDeleteDialog({ open: false, type: null, id: null, name: "" })
      loadData()
    } catch (error) {
      console.error("Error deleting:", error)
    }
  }

  const filteredUsers = users.filter(u =>
    u.user_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    u.email.toLowerCase().includes(searchTerm.toLowerCase())
  )

  const filteredBuilds = builds.filter(b =>
    b.build_name.toLowerCase().includes(searchTerm.toLowerCase())
  )

  const filteredComponents = components.filter(c =>
    c.component_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    (c.component_brand && c.component_brand.toLowerCase().includes(searchTerm.toLowerCase()))
  )

  const filteredPurchases = purchases.filter((p: any) => {
    const buildName = p.build_name || ''
    const userName = p.user_name || p.users?.user_name || ''
    const userEmail = p.user_email || p.users?.email || ''
    const matchesSearch = 
      buildName.toLowerCase().includes(searchTerm.toLowerCase()) ||
      userName.toLowerCase().includes(searchTerm.toLowerCase()) ||
      userEmail.toLowerCase().includes(searchTerm.toLowerCase())
    // Since we're using builds table, all are considered purchases
    return matchesSearch
  })

  if (!user || user.user_type !== 'admin') {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <AlertCircle className="h-5 w-5 text-red-500" />
              Access Denied
            </CardTitle>
            <CardDescription>
              You must be an administrator to access this page.
            </CardDescription>
          </CardHeader>
        </Card>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800 p-6">
      <div className="max-w-7xl mx-auto">
        <div className="mb-6">
          <h1 className="text-3xl font-bold flex items-center gap-2">
            <Shield className="h-8 w-8" />
            Admin Dashboard
          </h1>
          <p className="text-muted-foreground mt-2">
            Manage users, builds, and components
          </p>
        </div>

        <Tabs value={activeTab} onValueChange={setActiveTab}>
          <TabsList className="grid w-full grid-cols-5">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="users">Users</TabsTrigger>
            <TabsTrigger value="builds">Builds</TabsTrigger>
            <TabsTrigger value="components">Components</TabsTrigger>
            <TabsTrigger value="purchases">Purchases</TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-4">
            <div className="grid gap-4 md:grid-cols-3">
              <Card>
                <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                  <CardTitle className="text-sm font-medium">Total Users</CardTitle>
                  <Users className="h-4 w-4 text-muted-foreground" />
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold">{users.length}</div>
                  <p className="text-xs text-muted-foreground">
                    {users.filter(u => u.user_type === 'admin').length} admins
                  </p>
                </CardContent>
              </Card>

              <Card>
                <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                  <CardTitle className="text-sm font-medium">Total Builds</CardTitle>
                  <Wrench className="h-4 w-4 text-muted-foreground" />
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold">{builds.length}</div>
                  <p className="text-xs text-muted-foreground">
                    {formatCurrency(builds.reduce((sum, b) => sum + (b.total_price || 0), 0))} total value
                  </p>
                </CardContent>
              </Card>

              <Card>
                <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                  <CardTitle className="text-sm font-medium">Total Components</CardTitle>
                  <Package className="h-4 w-4 text-muted-foreground" />
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold">{components.length}</div>
                  <p className="text-xs text-muted-foreground">
                    Across all categories
                  </p>
                </CardContent>
              </Card>

              <Card>
                <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                  <CardTitle className="text-sm font-medium">Total Purchases</CardTitle>
                  <ShoppingCart className="h-4 w-4 text-muted-foreground" />
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold">{purchases.length}</div>
                  <p className="text-xs text-muted-foreground">
                    {purchases.filter(p => p.status === 'pending').length} pending
                  </p>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          <TabsContent value="users" className="space-y-4">
            <div className="flex gap-4">
              <div className="relative flex-1">
                <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
                <Input
                  placeholder="Search users..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="pl-8"
                />
              </div>
            </div>

            <Card>
              <CardHeader>
                <CardTitle>All Users</CardTitle>
                <CardDescription>Manage user accounts and permissions</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-2">
                  {loading ? (
                    <div className="text-center py-8">Loading...</div>
                  ) : filteredUsers.length === 0 ? (
                    <div className="text-center py-8 text-muted-foreground">No users found</div>
                  ) : (
                    filteredUsers.map((user) => (
                      <div
                        key={user.user_id}
                        className="flex items-center justify-between p-4 border rounded-lg"
                      >
                        <div>
                          <div className="font-medium">{user.user_name}</div>
                          <div className="text-sm text-muted-foreground">{user.email}</div>
                          <Badge variant={user.user_type === 'admin' ? 'default' : 'secondary'} className="mt-1">
                            {user.user_type}
                          </Badge>
                        </div>
                        <div className="flex gap-2">
                          <Button
                            variant="destructive"
                            size="sm"
                            onClick={() =>
                              setDeleteDialog({
                                open: true,
                                type: 'user',
                                id: user.user_id,
                                name: user.user_name
                              })
                            }
                          >
                            <Trash2 className="h-4 w-4" />
                          </Button>
                        </div>
                      </div>
                    ))
                  )}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="builds" className="space-y-4">
            <div className="flex gap-4">
              <div className="relative flex-1">
                <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
                <Input
                  placeholder="Search builds..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="pl-8"
                />
              </div>
            </div>

            <Card>
              <CardHeader>
                <CardTitle>All Builds</CardTitle>
                <CardDescription>View and manage all PC builds</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-2">
                  {loading ? (
                    <div className="text-center py-8">Loading...</div>
                  ) : filteredBuilds.length === 0 ? (
                    <div className="text-center py-8 text-muted-foreground">No builds found</div>
                  ) : (
                    filteredBuilds.map((build) => (
                      <div
                        key={build.build_id}
                        className="flex items-center justify-between p-4 border rounded-lg"
                      >
                        <div>
                          <div className="font-medium">{build.build_name}</div>
                          <div className="text-sm text-muted-foreground">
                            By: {build.users?.user_name || 'Unknown'} • {formatCurrency(build.total_price || 0)}
                          </div>
                          {build.build_types && (
                            <Badge variant="outline" className="mt-1">
                              {build.build_types.type_name}
                            </Badge>
                          )}
                        </div>
                        <Button
                          variant="destructive"
                          size="sm"
                          onClick={() =>
                            setDeleteDialog({
                              open: true,
                              type: 'build',
                              id: build.build_id,
                              name: build.build_name
                            })
                          }
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    ))
                  )}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="components" className="space-y-4">
            <div className="flex gap-4">
              <div className="relative flex-1">
                <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
                <Input
                  placeholder="Search components..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="pl-8"
                />
              </div>
            </div>

            <Card>
              <CardHeader>
                <CardTitle>All Components</CardTitle>
                <CardDescription>Manage PC components in the database</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-2">
                  {loading ? (
                    <div className="text-center py-8">Loading...</div>
                  ) : filteredComponents.length === 0 ? (
                    <div className="text-center py-8 text-muted-foreground">No components found</div>
                  ) : (
                    filteredComponents.map((component) => (
                      <div
                        key={component.component_id}
                        className="flex items-center justify-between p-4 border rounded-lg"
                      >
                        <div>
                          <div className="font-medium">{component.component_name}</div>
                          {component.component_brand && (
                            <div className="text-sm text-muted-foreground">Brand: {component.component_brand}</div>
                          )}
                          <div className="text-sm text-muted-foreground">
                            {formatCurrency(component.component_price || 0)} • {component.component_categories?.category_name}
                          </div>
                        </div>
                        <Button
                          variant="destructive"
                          size="sm"
                          onClick={() =>
                            setDeleteDialog({
                              open: true,
                              type: 'component',
                              id: component.component_id,
                              name: component.component_name
                            })
                          }
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    ))
                  )}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="purchases" className="space-y-4">
            <div className="flex gap-4">
              <div className="relative flex-1">
                <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
                <Input
                  placeholder="Search purchases by build name, user..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="pl-8"
                />
              </div>
              <Select value={selectedStatus} onValueChange={setSelectedStatus}>
                <SelectTrigger className="w-[180px]">
                  <SelectValue placeholder="Filter by status" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Purchases</SelectItem>
                  <SelectItem value="pending">Pending</SelectItem>
                  <SelectItem value="processing">Processing</SelectItem>
                  <SelectItem value="completed">Completed</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <Card>
              <CardHeader>
                <CardTitle>Purchase Details</CardTitle>
                <CardDescription>
                  All builds that have been purchased - emails sent to sales.centraljuan.net@gmail.com
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-2">
                  {loading ? (
                    <div className="text-center py-8">Loading...</div>
                  ) : filteredPurchases.length === 0 ? (
                    <div className="text-center py-8 text-muted-foreground">No purchases found</div>
                  ) : (
                    filteredPurchases.map((purchase: any) => (
                      <div
                        key={purchase.build_id || purchase.purchase_id}
                        className="flex items-center justify-between p-4 border rounded-lg"
                      >
                        <div className="flex-1">
                          <div className="font-medium">{purchase.build_name}</div>
                          <div className="text-sm text-muted-foreground mt-1">
                            Customer: {purchase.user_name || purchase.users?.user_name || 'Unknown'} ({purchase.user_email || purchase.users?.email || 'N/A'})
                          </div>
                          <div className="text-sm text-muted-foreground">
                            Build Type: {purchase.build_types?.type_name || purchase.build_type || 'Custom'} • 
                            Total: {formatCurrency(purchase.total_price || 0)}
                          </div>
                          <div className="text-xs text-muted-foreground mt-1">
                            Date: {new Date(purchase.date_created || purchase.purchase_date).toLocaleString()}
                          </div>
                          <div className="flex items-center gap-2 mt-2">
                            {purchase.email_sent_to_retailer !== false && (
                              <Badge variant="outline" className="text-xs">
                                <Mail className="h-3 w-3 mr-1" />
                                Sent to retailer
                              </Badge>
                            )}
                            <Badge variant="outline" className="text-xs">
                              sales.centraljuan.net@gmail.com
                            </Badge>
                          </div>
                        </div>
                        <div className="flex items-center gap-2">
                          <Button
                            variant="outline"
                            size="sm"
                            asChild
                          >
                            <Link href={`/builds/${purchase.build_id}`}>
                              <Eye className="h-4 w-4 mr-2" />
                              View Build
                            </Link>
                          </Button>
                        </div>
                      </div>
                    ))
                  )}
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>

        <AlertDialog open={deleteDialog.open} onOpenChange={(open) => 
          setDeleteDialog({ ...deleteDialog, open })
        }>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>Are you sure?</AlertDialogTitle>
              <AlertDialogDescription>
                This will permanently delete {deleteDialog.type} "{deleteDialog.name}". This action cannot be undone.
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogCancel>Cancel</AlertDialogCancel>
              <AlertDialogAction onClick={handleDelete} className="bg-red-600 hover:bg-red-700">
                Delete
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </div>
  )
}

