import type React from "react"
import type { Metadata } from "next"
import { GeistSans } from "geist/font/sans"
import { GeistMono } from "geist/font/mono"
import { SupabaseAuthProvider } from "@/contexts/supabase-auth-context"
import { LoadingProvider } from "@/contexts/loading-context"
import { GlobalLoading } from "@/components/global-loading"
import { PageWrapper } from "@/components/page-wrapper"
import { Suspense } from "react"
import "./globals.css"

export const metadata: Metadata = {
  title: "BuildMate - PC Builder & Compatibility Checker",
  description: "Build your perfect PC with advanced compatibility checking and expert recommendations",
  generator: "v0.app",
  icons: {
    icon: [
      { url: '/buildmate-logo.svg', sizes: 'any', type: 'image/svg+xml' },
      { url: '/icon.png', sizes: 'any', type: 'image/png' },
      { url: '/favicon.ico', sizes: 'any', type: 'image/x-icon' },
    ],
    apple: [
      { url: '/icon.png', sizes: '180x180', type: 'image/png' },
    ],
    shortcut: '/buildmate-logo.svg',
  },
  openGraph: {
    title: "BuildMate - PC Builder & Compatibility Checker",
    description: "Build your perfect PC with advanced compatibility checking and expert recommendations",
    type: "website",
    images: [
      {
        url: '/buildmate-logo.svg',
        width: 512,
        height: 512,
        alt: 'BuildMate Logo',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    title: "BuildMate - PC Builder & Compatibility Checker",
    description: "Build your perfect PC with advanced compatibility checking and expert recommendations",
    images: ['/buildmate-logo.svg'],
  },
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en" className="h-full">
      <body className={`font-sans h-full ${GeistSans.variable} ${GeistMono.variable}`}>
        <Suspense fallback={null}>
          <SupabaseAuthProvider>
            <LoadingProvider>
              <GlobalLoading />
              <PageWrapper>
                {children}
              </PageWrapper>
            </LoadingProvider>
          </SupabaseAuthProvider>
        </Suspense>
      </body>
    </html>
  )
}
