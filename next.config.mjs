/** @type {import('next').NextConfig} */
const nextConfig = {
  // Use 'standalone' for Docker deployment, remove for Vercel (Vercel handles this automatically)
  // output: 'standalone', // Comment out for Vercel, uncomment for Docker/Render
  eslint: {
    ignoreDuringBuilds: true,
  },
  typescript: {
    ignoreBuildErrors: true,
  },
  images: {
    unoptimized: true, // Required for Supabase storage URLs
    remotePatterns: [
      {
        protocol: 'https',
        hostname: '**.supabase.co',
        pathname: '/storage/v1/object/public/**',
      },
    ],
  },
  webpack: (config, { isServer }) => {
    if (!isServer) {
      // Ensure React Three Fiber is treated as a client-only module
      config.resolve.fallback = {
        ...config.resolve.fallback,
        fs: false,
      }
    }
    return config
  },
}

export default nextConfig