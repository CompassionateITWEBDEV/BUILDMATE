"use client"

import { useState, useEffect } from "react"
import { useAuth } from "@/contexts/supabase-auth-context"
import { useRouter } from "next/navigation"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { 
  BarChart3, 
  Download, 
  FileText, 
  TrendingUp, 
  Package,
  DollarSign,
  Calendar,
  ArrowLeft
} from "lucide-react"
import Link from "next/link"
import { retailerService, componentService } from "@/lib/database"
import { formatCurrency } from "@/lib/currency"
import { supabase } from "@/lib/supabase"

interface ComponentReport {
  component_id: number
  component_name: string
  component_price: number | null
  availability_status: string | null
  component_categories: { category_name: string }
  retailers: { retailer_name: string } | null
}

export default function RetailerReportsPage() {
  const { user } = useAuth()
  const router = useRouter()
  const [components, setComponents] = useState<ComponentReport[]>([])
  const [loading, setLoading] = useState(true)
  const [selectedRetailer, setSelectedRetailer] = useState<string>("all")
  const [reportType, setReportType] = useState<"inventory" | "sales" | "performance">("inventory")

  useEffect(() => {
    if (user && user.user_type !== 'retailer' && user.user_type !== 'admin') {
      router.push('/dashboard')
    }
  }, [user, router])

  useEffect(() => {
    if (user?.user_type === 'retailer' || user?.user_type === 'admin') {
      loadComponents()
    }
  }, [user, selectedRetailer])

  const loadComponents = async () => {
    try {
      setLoading(true)
      const { data, error } = await supabase
        .from('components')
        .select(`
          component_id,
          component_name,
          component_price,
          availability_status,
          component_categories(category_name),
          retailers(retailer_name, retailer_id)
        `)
        .order('component_name')

      if (error) throw error

      let filteredData = data
      if (selectedRetailer !== 'all') {
        filteredData = data.filter((comp: any) => 
          comp.retailers?.retailer_id?.toString() === selectedRetailer
        )
      }

      setComponents(filteredData as ComponentReport[])
    } catch (error) {
      console.error("Error loading components:", error)
    } finally {
      setLoading(false)
    }
  }

  const generateReport = () => {
    const reportData = {
      type: reportType,
      date: new Date().toISOString(),
      components: components.map(comp => ({
        name: comp.component_name,
        price: comp.component_price,
        status: comp.availability_status,
        category: comp.component_categories?.category_name,
        retailer: comp.retailers?.retailer_name
      }))
    }

    const blob = new Blob([JSON.stringify(reportData, null, 2)], { type: 'application/json' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `retailer-report-${reportType}-${new Date().toISOString().split('T')[0]}.json`
    document.body.appendChild(a)
    a.click()
    document.body.removeChild(a)
    URL.revokeObjectURL(url)
  }

  const totalValue = components.reduce((sum, comp) => sum + (comp.component_price || 0), 0)
  const inStockCount = components.filter(comp => comp.availability_status === 'in_stock').length
  const outOfStockCount = components.filter(comp => comp.availability_status === 'out_of_stock').length

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      <div className="container mx-auto px-4 py-8">
        <div className="mb-6">
          <Link href="/dashboard">
            <Button variant="ghost" size="sm" className="mb-4">
              <ArrowLeft className="h-4 w-4 mr-2" />
              Back to Dashboard
            </Button>
          </Link>
          <h1 className="text-3xl font-bold text-slate-900 dark:text-white mb-2">
            Retailer Reports
          </h1>
          <p className="text-slate-600 dark:text-slate-400">
            View and generate reports on components
          </p>
        </div>

        <div className="grid gap-6 mb-6">
          <div className="grid gap-4 md:grid-cols-3">
            <Card>
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">Total Components</CardTitle>
                <Package className="h-4 w-4 text-muted-foreground" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">{components.length}</div>
                <p className="text-xs text-muted-foreground">
                  {formatCurrency(totalValue)} total value
                </p>
              </CardContent>
            </Card>

            <Card>
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">In Stock</CardTitle>
                <TrendingUp className="h-4 w-4 text-green-600" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-green-600">{inStockCount}</div>
                <p className="text-xs text-muted-foreground">
                  {components.length > 0 ? Math.round((inStockCount / components.length) * 100) : 0}% of total
                </p>
              </CardContent>
            </Card>

            <Card>
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">Out of Stock</CardTitle>
                <TrendingUp className="h-4 w-4 text-red-600" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-red-600">{outOfStockCount}</div>
                <p className="text-xs text-muted-foreground">
                  {components.length > 0 ? Math.round((outOfStockCount / components.length) * 100) : 0}% of total
                </p>
              </CardContent>
            </Card>
          </div>

          <Card>
            <CardHeader>
              <div className="flex items-center justify-between">
                <div>
                  <CardTitle>Generate Report</CardTitle>
                  <CardDescription>Select report type and generate</CardDescription>
                </div>
                <Button onClick={generateReport}>
                  <Download className="h-4 w-4 mr-2" />
                  Generate & Download
                </Button>
              </div>
            </CardHeader>
            <CardContent>
              <div className="flex gap-4">
                <Select value={reportType} onValueChange={(value: any) => setReportType(value)}>
                  <SelectTrigger className="w-48">
                    <SelectValue placeholder="Report Type" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="inventory">Inventory Report</SelectItem>
                    <SelectItem value="sales">Sales Report</SelectItem>
                    <SelectItem value="performance">Performance Report</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </CardContent>
          </Card>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>Component Inventory</CardTitle>
            <CardDescription>View all components with details</CardDescription>
          </CardHeader>
          <CardContent>
            {loading ? (
              <div className="text-center py-8">Loading components...</div>
            ) : (
              <div className="space-y-2">
                {components.map((component) => (
                  <div
                    key={component.component_id}
                    className="border rounded-lg p-4 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors"
                  >
                    <div className="flex items-start justify-between">
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-1">
                          <h3 className="font-semibold">{component.component_name}</h3>
                          <Badge variant="outline">
                            {component.component_categories?.category_name || 'Unknown'}
                          </Badge>
                          {component.availability_status && (
                            <Badge
                              variant={
                                component.availability_status === 'in_stock'
                                  ? 'default'
                                  : component.availability_status === 'low_stock'
                                    ? 'secondary'
                                    : 'destructive'
                              }
                            >
                              {component.availability_status.replace('_', ' ')}
                            </Badge>
                          )}
                        </div>
                        <div className="flex items-center gap-4 text-sm text-slate-600 dark:text-slate-400">
                          <span>Price: {formatCurrency(component.component_price || 0)}</span>
                          {component.retailers && (
                            <span>Retailer: {component.retailers.retailer_name}</span>
                          )}
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
                {components.length === 0 && (
                  <div className="text-center py-8 text-slate-500">
                    No components found
                  </div>
                )}
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  )
}

