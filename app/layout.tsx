import type React from "react"
import type { Metadata } from "next"
import { GeistSans } from "geist/font/sans"
import { GeistMono } from "geist/font/mono"
import { SupabaseAuthProvider } from "@/contexts/supabase-auth-context"
import { LoadingProvider } from "@/contexts/loading-context"
import { GlobalLoading } from "@/components/global-loading"
import { Suspense } from "react"
import "./globals.css"

export const metadata: Metadata = {
  title: "BuildMate - PC Builder & Compatibility Checker",
  description: "Build your perfect PC with advanced compatibility checking and expert recommendations",
  generator: "v0.app",
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en">
      <body className={`font-sans ${GeistSans.variable} ${GeistMono.variable}`}>
        <Suspense fallback={null}>
          <SupabaseAuthProvider>
            <LoadingProvider>
              <GlobalLoading />
              {children}
            </LoadingProvider>
          </SupabaseAuthProvider>
        </Suspense>
      </body>
    </html>
  )
}
