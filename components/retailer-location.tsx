"use client"

import { MapPin, Phone, Mail, Globe, User } from "lucide-react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"

interface RetailerInfo {
  id: number
  name: string
  address?: string | null
  phone?: string | null
  contactPerson?: string | null
  email?: string | null
  website?: string | null
}

interface RetailerLocationProps {
  retailer?: RetailerInfo
  className?: string
}

export function RetailerLocation({ retailer, className }: RetailerLocationProps) {
  if (!retailer) {
    return (
      <Card className={className}>
        <CardHeader>
          <CardTitle className="text-sm">Retailer Information</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-slate-500 dark:text-slate-400">No retailer information available</p>
        </CardContent>
      </Card>
    )
  }

  return (
    <Card className={className}>
      <CardHeader>
        <CardTitle className="text-sm flex items-center gap-2">
          <MapPin className="h-4 w-4" />
          Retailer: {retailer.name}
        </CardTitle>
        <CardDescription>Location and contact information</CardDescription>
      </CardHeader>
      <CardContent className="space-y-3">
        {retailer.address && (
          <div className="flex items-start gap-2 text-sm">
            <MapPin className="h-4 w-4 mt-0.5 text-slate-500 flex-shrink-0" />
            <div>
              <p className="font-medium text-slate-700 dark:text-slate-300">Address</p>
              <p className="text-slate-600 dark:text-slate-400">{retailer.address}</p>
            </div>
          </div>
        )}
        
        {retailer.phone && (
          <div className="flex items-center gap-2 text-sm">
            <Phone className="h-4 w-4 text-slate-500 flex-shrink-0" />
            <div>
              <p className="font-medium text-slate-700 dark:text-slate-300">Phone</p>
              <a 
                href={`tel:${retailer.phone}`}
                className="text-blue-600 dark:text-blue-400 hover:underline"
              >
                {retailer.phone}
              </a>
            </div>
          </div>
        )}

        {retailer.email && (
          <div className="flex items-center gap-2 text-sm">
            <Mail className="h-4 w-4 text-slate-500 flex-shrink-0" />
            <div>
              <p className="font-medium text-slate-700 dark:text-slate-300">Email</p>
              <a 
                href={`mailto:${retailer.email}`}
                className="text-blue-600 dark:text-blue-400 hover:underline"
              >
                {retailer.email}
              </a>
            </div>
          </div>
        )}

        {retailer.website && (
          <div className="flex items-center gap-2 text-sm">
            <Globe className="h-4 w-4 text-slate-500 flex-shrink-0" />
            <div>
              <p className="font-medium text-slate-700 dark:text-slate-300">Website</p>
              <a 
                href={retailer.website}
                target="_blank"
                rel="noopener noreferrer"
                className="text-blue-600 dark:text-blue-400 hover:underline"
              >
                {retailer.website}
              </a>
            </div>
          </div>
        )}

        {retailer.contactPerson && (
          <div className="flex items-center gap-2 text-sm">
            <User className="h-4 w-4 text-slate-500 flex-shrink-0" />
            <div>
              <p className="font-medium text-slate-700 dark:text-slate-300">Contact Person</p>
              <p className="text-slate-600 dark:text-slate-400">{retailer.contactPerson}</p>
            </div>
          </div>
        )}
      </CardContent>
    </Card>
  )
}
