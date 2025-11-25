"use client"

import { Badge } from "@/components/ui/badge"
import { CheckCircle2, XCircle, AlertTriangle, Ban } from "lucide-react"

type AvailabilityStatus = 'in_stock' | 'out_of_stock' | 'low_stock' | 'discontinued'

interface AvailabilityBadgeProps {
  status?: AvailabilityStatus | null
  className?: string
}

export function AvailabilityBadge({ status, className }: AvailabilityBadgeProps) {
  if (!status || status === 'in_stock') {
    return (
      <Badge variant="default" className={`bg-green-500 hover:bg-green-600 ${className}`}>
        <CheckCircle2 className="h-3 w-3 mr-1" />
        In Stock
      </Badge>
    )
  }

  switch (status) {
    case 'low_stock':
      return (
        <Badge variant="secondary" className={`bg-yellow-500 hover:bg-yellow-600 text-white ${className}`}>
          <AlertTriangle className="h-3 w-3 mr-1" />
          Low Stock
        </Badge>
      )
    case 'out_of_stock':
      return (
        <Badge variant="destructive" className={className}>
          <XCircle className="h-3 w-3 mr-1" />
          Out of Stock
        </Badge>
      )
    case 'discontinued':
      return (
        <Badge variant="outline" className={`border-slate-400 text-slate-500 ${className}`}>
          <Ban className="h-3 w-3 mr-1" />
          Discontinued
        </Badge>
      )
    default:
      return (
        <Badge variant="default" className={`bg-green-500 hover:bg-green-600 ${className}`}>
          <CheckCircle2 className="h-3 w-3 mr-1" />
          In Stock
        </Badge>
      )
  }
}

