// Mock data for PC components and builds
export interface Component {
  id: string
  name: string
  category: ComponentCategory
  brand: string
  price: number
  image: string
  specifications: Record<string, any>
  compatibility: {
    socket?: string
    formFactor?: string
    memoryType?: string
    powerRequirement?: number
    dimensions?: {
      length?: number
      width?: number
      height?: number
    }
    memorySupport?: string
    m2Slots?: string
    sataPorts?: string
  }
  rating: number
  reviews: number
  performanceTags: PerformanceCategory[]
}

export type ComponentCategory = "cpu" | "motherboard" | "memory" | "storage" | "gpu" | "psu" | "case" | "cooling"

export type PerformanceCategory = "gaming" | "office" | "academic" | "all"

export interface PerformanceRequirements {
  minCpuCores?: number
  maxCpuCores?: number
  minMemoryGB?: number
  maxMemoryGB?: number
  minGpuMemory?: number
  maxGpuMemory?: number
  minStorageGB?: number
  maxStorageGB?: number
  minPsuWattage?: number
  maxPsuWattage?: number
  requiresGpu?: boolean
  maxPrice?: number
  minPrice?: number
}

// Performance category definitions
export const performanceCategories: Record<PerformanceCategory, { name: string; description: string; requirements: PerformanceRequirements }> = {
  gaming: {
    name: "Gaming",
    description: "High-performance components for gaming and entertainment",
    requirements: {
      minCpuCores: 6,
      minMemoryGB: 16,
      minGpuMemory: 8,
      minStorageGB: 500,
      minPsuWattage: 650,
      requiresGpu: true,
      minPrice: 800,
    }
  },
  office: {
    name: "Office",
    description: "Efficient components for productivity and business tasks",
    requirements: {
      minCpuCores: 4,
      maxCpuCores: 8,
      minMemoryGB: 8,
      maxMemoryGB: 32,
      maxGpuMemory: 4,
      minStorageGB: 250,
      maxStorageGB: 1000,
      minPsuWattage: 400,
      maxPsuWattage: 650,
      requiresGpu: false,
      maxPrice: 1200,
    }
  },
  academic: {
    name: "Academic",
    description: "Balanced components for research, coding, and educational work",
    requirements: {
      minCpuCores: 6,
      maxCpuCores: 16,
      minMemoryGB: 16,
      maxMemoryGB: 64,
      minGpuMemory: 4,
      maxGpuMemory: 12,
      minStorageGB: 500,
      maxStorageGB: 2000,
      minPsuWattage: 550,
      maxPsuWattage: 850,
      requiresGpu: true,
      minPrice: 600,
      maxPrice: 2000,
    }
  },
  all: {
    name: "All Components",
    description: "Show all available components",
    requirements: {}
  }
}

export interface Build {
  id: string
  name: string
  description: string
  components: Record<ComponentCategory, Component | null>
  totalPrice: number
  createdBy: string
  createdAt: Date
  likes: number
  isPublic: boolean
  tags: string[]
}

export interface User {
  id: string
  username: string
  email: string
  avatar?: string
  builds: string[]
  likedBuilds: string[]
  createdAt: Date
}

// Mock component data
export const mockComponents: Component[] = [
  // CPUs
  {
    id: "cpu-1",
    name: "AMD Ryzen 7 7800X3D",
    category: "cpu",
    brand: "AMD",
    price: 449,
    image: "/amd-ryzen-cpu.jpg",
    specifications: {
      cores: 8,
      threads: 16,
      baseClock: "4.2 GHz",
      boostClock: "5.0 GHz",
      cache: "96MB L3",
      tdp: "120W",
      memorySupport: "DDR5",
    },
    compatibility: {
      socket: "AM5",
      powerRequirement: 120,
    },
    rating: 4.8,
    reviews: 1247,
    performanceTags: ["gaming", "academic"],
  },
  {
    id: "cpu-2",
    name: "Intel Core i7-14700K",
    category: "cpu",
    brand: "Intel",
    price: 409,
    image: "/intel-core-i7-cpu.png",
    specifications: {
      cores: 20,
      threads: 28,
      baseClock: "3.4 GHz",
      boostClock: "5.6 GHz",
      cache: "33MB L3",
      tdp: "125W",
      memorySupport: "DDR5",
    },
    compatibility: {
      socket: "LGA1700",
      powerRequirement: 125,
    },
    rating: 4.6,
    reviews: 892,
    performanceTags: ["gaming", "academic", "office"],
  },
  // GPUs
  {
    id: "gpu-1",
    name: "NVIDIA RTX 4080 SUPER",
    category: "gpu",
    brand: "NVIDIA",
    price: 999,
    image: "/nvidia-rtx-4080-graphics-card.jpg",
    specifications: {
      memory: "16GB GDDR6X",
      baseClock: "2295 MHz",
      boostClock: "2550 MHz",
      memorySpeed: "23 Gbps",
      busWidth: "256-bit",
    },
    compatibility: {
      powerRequirement: 320,
      dimensions: { length: 304, width: 137, height: 61 },
    },
    rating: 4.7,
    reviews: 634,
    performanceTags: ["gaming", "academic"],
  },
  // Motherboards
  {
    id: "mb-1",
    name: "ASUS ROG STRIX X670E-E",
    category: "motherboard",
    brand: "ASUS",
    price: 499,
    image: "/asus-motherboard.jpg",
    specifications: {
      chipset: "X670E",
      memorySlots: 4,
      maxMemory: "128GB",
      expansion: "4x PCIe 5.0, 2x PCIe 4.0",
      networking: "WiFi 6E, 2.5Gb Ethernet",
      m2Slots: "4",
      sataPorts: "8",
    },
    compatibility: {
      socket: "AM5",
      formFactor: "ATX",
      memoryType: "DDR5",
    },
    rating: 4.5,
    reviews: 423,
    performanceTags: ["gaming", "academic", "office"],
  },
  // Memory
  {
    id: "mem-1",
    name: "Corsair Vengeance DDR5-5600",
    category: "memory",
    brand: "Corsair",
    price: 179,
    image: "/corsair-ddr5-memory.jpg",
    specifications: {
      capacity: "32GB",
      speed: "5600 MHz",
      type: "DDR5",
      modules: "2x16GB",
      latency: "CL36",
    },
    compatibility: {
      memoryType: "DDR5",
      powerRequirement: 5,
    },
    rating: 4.6,
    reviews: 892,
    performanceTags: ["gaming", "academic", "office"],
  },
  // Power Supply
  {
    id: "psu-1",
    name: "Corsair RM850x",
    category: "psu",
    brand: "Corsair",
    price: 149,
    image: "/corsair-psu-850w.jpg",
    specifications: {
      wattage: "850W",
      efficiency: "80+ Gold",
      modular: "Fully Modular",
      warranty: "10 Years",
    },
    compatibility: {
      powerRequirement: 0, // PSU doesn't consume power
    },
    rating: 4.8,
    reviews: 1456,
    performanceTags: ["gaming", "academic", "office"],
  },
  // Case
  {
    id: "case-1",
    name: "Fractal Design Define 7",
    category: "case",
    brand: "Fractal Design",
    price: 169,
    image: "/fractal-design-case.jpg",
    specifications: {
      formFactor: "ATX",
      maxGpuLength: "440mm",
      maxGpuHeight: "180mm",
      maxCoolerHeight: "185mm",
      frontPorts: "2x USB 3.0, 1x USB-C",
    },
    compatibility: {
      formFactor: "ATX",
      powerRequirement: 0,
    },
    rating: 4.7,
    reviews: 634,
    performanceTags: ["gaming", "academic", "office"],
  },
  // Cooling
  {
    id: "cool-1",
    name: "Noctua NH-D15",
    category: "cooling",
    brand: "Noctua",
    price: 109,
    image: "/noctua-cpu-cooler.jpg",
    specifications: {
      type: "Air Cooler",
      height: "165mm",
      tdpRating: "220W",
      fans: "2x 140mm",
      noise: "24.6 dB(A)",
    },
    compatibility: {
      socket: "AM5,LGA1700",
      powerRequirement: 2,
    },
    rating: 4.9,
    reviews: 2341,
    performanceTags: ["gaming", "academic", "office"],
  },
  // Storage
  {
    id: "ssd-1",
    name: "Samsung 980 PRO 1TB",
    category: "storage",
    brand: "Samsung",
    price: 89,
    image: "/samsung-nvme-ssd.jpg",
    specifications: {
      capacity: "1TB",
      interface: "M.2",
      type: "NVMe PCIe 4.0",
      readSpeed: "7,000 MB/s",
      writeSpeed: "5,000 MB/s",
    },
    compatibility: {
      powerRequirement: 8,
    },
    rating: 4.8,
    reviews: 3421,
    performanceTags: ["gaming", "academic", "office"],
  },
  // Additional components for better filtering
  {
    id: "cpu-3",
    name: "AMD Ryzen 5 5600G",
    category: "cpu",
    brand: "AMD",
    price: 159,
    image: "/amd-ryzen-cpu.jpg",
    specifications: {
      cores: 6,
      threads: 12,
      baseClock: "3.9 GHz",
      boostClock: "4.4 GHz",
      cache: "16MB L3",
      tdp: "65W",
      memorySupport: "DDR4",
    },
    compatibility: {
      socket: "AM4",
      powerRequirement: 65,
    },
    rating: 4.4,
    reviews: 567,
    performanceTags: ["office"],
  },
  {
    id: "cpu-4",
    name: "Intel Core i5-13400",
    category: "cpu",
    brand: "Intel",
    price: 199,
    image: "/intel-core-i7-cpu.png",
    specifications: {
      cores: 10,
      threads: 16,
      baseClock: "2.5 GHz",
      boostClock: "4.6 GHz",
      cache: "20MB L3",
      tdp: "65W",
      memorySupport: "DDR5",
    },
    compatibility: {
      socket: "LGA1700",
      powerRequirement: 65,
    },
    rating: 4.3,
    reviews: 423,
    performanceTags: ["office", "academic"],
  },
  {
    id: "gpu-2",
    name: "NVIDIA GTX 1660 SUPER",
    category: "gpu",
    brand: "NVIDIA",
    price: 249,
    image: "/nvidia-rtx-4080-graphics-card.jpg",
    specifications: {
      memory: "6GB GDDR6",
      baseClock: "1530 MHz",
      boostClock: "1785 MHz",
      memorySpeed: "14 Gbps",
      busWidth: "192-bit",
    },
    compatibility: {
      powerRequirement: 125,
      dimensions: { length: 229, width: 111, height: 40 },
    },
    rating: 4.2,
    reviews: 892,
    performanceTags: ["office", "academic"],
  },
  {
    id: "gpu-3",
    name: "NVIDIA RTX 3060",
    category: "gpu",
    brand: "NVIDIA",
    price: 329,
    image: "/nvidia-rtx-4080-graphics-card.jpg",
    specifications: {
      memory: "12GB GDDR6",
      baseClock: "1320 MHz",
      boostClock: "1777 MHz",
      memorySpeed: "15 Gbps",
      busWidth: "192-bit",
    },
    compatibility: {
      powerRequirement: 170,
      dimensions: { length: 242, width: 112, height: 40 },
    },
    rating: 4.5,
    reviews: 1234,
    performanceTags: ["gaming", "academic"],
  },
  {
    id: "mem-2",
    name: "Corsair Vengeance LPX DDR4-3200",
    category: "memory",
    brand: "Corsair",
    price: 89,
    image: "/corsair-ddr5-memory.jpg",
    specifications: {
      capacity: "16GB",
      speed: "3200 MHz",
      type: "DDR4",
      modules: "2x8GB",
      latency: "CL16",
    },
    compatibility: {
      memoryType: "DDR4",
      powerRequirement: 3,
    },
    rating: 4.4,
    reviews: 567,
    performanceTags: ["office"],
  },
  {
    id: "mem-3",
    name: "G.Skill Trident Z5 DDR5-6000",
    category: "memory",
    brand: "G.Skill",
    price: 249,
    image: "/corsair-ddr5-memory.jpg",
    specifications: {
      capacity: "64GB",
      speed: "6000 MHz",
      type: "DDR5",
      modules: "2x32GB",
      latency: "CL30",
    },
    compatibility: {
      memoryType: "DDR5",
      powerRequirement: 8,
    },
    rating: 4.7,
    reviews: 234,
    performanceTags: ["academic"],
  },
  {
    id: "psu-2",
    name: "EVGA 500W 80+ Bronze",
    category: "psu",
    brand: "EVGA",
    price: 59,
    image: "/corsair-psu-850w.jpg",
    specifications: {
      wattage: "500W",
      efficiency: "80+ Bronze",
      modular: "Non-Modular",
      warranty: "3 Years",
    },
    compatibility: {
      powerRequirement: 0,
    },
    rating: 4.1,
    reviews: 1234,
    performanceTags: ["office"],
  },
  {
    id: "psu-3",
    name: "Seasonic Focus GX-750",
    category: "psu",
    brand: "Seasonic",
    price: 119,
    image: "/corsair-psu-850w.jpg",
    specifications: {
      wattage: "750W",
      efficiency: "80+ Gold",
      modular: "Fully Modular",
      warranty: "10 Years",
    },
    compatibility: {
      powerRequirement: 0,
    },
    rating: 4.6,
    reviews: 789,
    performanceTags: ["gaming", "academic"],
  },
  {
    id: "storage-2",
    name: "Samsung 870 EVO 500GB",
    category: "storage",
    brand: "Samsung",
    price: 49,
    image: "/samsung-nvme-ssd.jpg",
    specifications: {
      capacity: "500GB",
      interface: "SATA",
      type: "SATA III",
      readSpeed: "560 MB/s",
      writeSpeed: "530 MB/s",
    },
    compatibility: {
      powerRequirement: 3,
    },
    rating: 4.5,
    reviews: 2341,
    performanceTags: ["office"],
  },
  {
    id: "storage-3",
    name: "WD Black SN850X 2TB",
    category: "storage",
    brand: "Western Digital",
    price: 199,
    image: "/samsung-nvme-ssd.jpg",
    specifications: {
      capacity: "2TB",
      interface: "M.2",
      type: "NVMe PCIe 4.0",
      readSpeed: "7,300 MB/s",
      writeSpeed: "6,300 MB/s",
    },
    compatibility: {
      powerRequirement: 10,
    },
    rating: 4.8,
    reviews: 567,
    performanceTags: ["gaming", "academic"],
  },
  // Additional components for better filtering demonstration
  {
    id: "cpu-5",
    name: "AMD Ryzen 9 7950X",
    category: "cpu",
    brand: "AMD",
    price: 699,
    image: "/amd-ryzen-cpu.jpg",
    specifications: {
      cores: 16,
      threads: 32,
      baseClock: "4.5 GHz",
      boostClock: "5.7 GHz",
      cache: "64MB L3",
      tdp: "170W",
      memorySupport: "DDR5",
    },
    compatibility: {
      socket: "AM5",
      powerRequirement: 170,
    },
    rating: 4.9,
    reviews: 234,
    performanceTags: ["academic"],
  },
  {
    id: "gpu-4",
    name: "NVIDIA RTX 4090",
    category: "gpu",
    brand: "NVIDIA",
    price: 1599,
    image: "/nvidia-rtx-4080-graphics-card.jpg",
    specifications: {
      memory: "24GB GDDR6X",
      baseClock: "2230 MHz",
      boostClock: "2520 MHz",
      memorySpeed: "21 Gbps",
      busWidth: "384-bit",
    },
    compatibility: {
      powerRequirement: 450,
      dimensions: { length: 304, width: 137, height: 61 },
    },
    rating: 4.8,
    reviews: 456,
    performanceTags: ["gaming", "academic"],
  },
  {
    id: "mem-4",
    name: "Corsair Dominator Platinum DDR5-6400",
    category: "memory",
    brand: "Corsair",
    price: 399,
    image: "/corsair-ddr5-memory.jpg",
    specifications: {
      capacity: "32GB",
      speed: "6400 MHz",
      type: "DDR5",
      modules: "2x16GB",
      latency: "CL32",
    },
    compatibility: {
      memoryType: "DDR5",
      powerRequirement: 6,
    },
    rating: 4.7,
    reviews: 123,
    performanceTags: ["gaming", "academic"],
  },
  {
    id: "case-2",
    name: "NZXT H510 Compact",
    category: "case",
    brand: "NZXT",
    price: 79,
    image: "/fractal-design-case.jpg",
    specifications: {
      formFactor: "ATX",
      maxGpuLength: "381mm",
      maxGpuHeight: "165mm",
      maxCoolerHeight: "165mm",
      frontPorts: "1x USB 3.1, 1x USB-C",
    },
    compatibility: {
      formFactor: "ATX",
      powerRequirement: 0,
    },
    rating: 4.3,
    reviews: 2341,
    performanceTags: ["office", "academic"],
  },
  {
    id: "cool-2",
    name: "Cooler Master Hyper 212",
    category: "cooling",
    brand: "Cooler Master",
    price: 39,
    image: "/noctua-cpu-cooler.jpg",
    specifications: {
      type: "Air Cooler",
      height: "158mm",
      tdpRating: "150W",
      fans: "1x 120mm",
      noise: "26 dB(A)",
    },
    compatibility: {
      socket: "AM4,AM5,LGA1700",
      powerRequirement: 1,
    },
    rating: 4.2,
    reviews: 4567,
    performanceTags: ["office"],
  },
]

export const mockBuilds: Build[] = [
  {
    id: "build-1",
    name: "Ultimate Gaming Beast",
    description: "High-end gaming build for 4K gaming at max settings with ray tracing enabled",
    components: {
      cpu: mockComponents[0], // AMD Ryzen 7 7800X3D
      gpu: mockComponents[2], // RTX 4080 SUPER
      motherboard: mockComponents[3], // ASUS ROG STRIX X670E-E
      memory: mockComponents[4], // Corsair DDR5-5600 32GB
      storage: mockComponents[7], // Samsung 980 PRO 1TB
      psu: mockComponents[5], // Corsair RM850x
      case: mockComponents[6], // Fractal Design Define 7
      cooling: mockComponents[8], // Noctua NH-D15
    },
    totalPrice: 2463,
    createdBy: "user-1",
    createdAt: new Date("2024-01-15"),
    likes: 156,
    isPublic: true,
    tags: ["gaming", "high-end", "4k", "ray-tracing"],
  },
  {
    id: "build-2",
    name: "Budget Gaming Starter",
    description: "Affordable 1080p gaming build perfect for esports and indie games",
    components: {
      cpu: mockComponents[1], // Intel i7-14700K
      gpu: mockComponents[2], // RTX 4080 SUPER (placeholder)
      motherboard: mockComponents[3],
      memory: mockComponents[4],
      storage: mockComponents[7],
      psu: mockComponents[5],
      case: null,
      cooling: null,
    },
    totalPrice: 899,
    createdBy: "user-2",
    createdAt: new Date("2024-01-20"),
    likes: 89,
    isPublic: true,
    tags: ["budget", "gaming", "1080p", "starter"],
  },
  {
    id: "build-3",
    name: "Content Creator Workstation",
    description: "Powerful workstation optimized for video editing, streaming, and content creation",
    components: {
      cpu: mockComponents[0],
      gpu: mockComponents[2],
      motherboard: mockComponents[3],
      memory: mockComponents[4],
      storage: mockComponents[7],
      psu: mockComponents[5],
      case: mockComponents[6],
      cooling: mockComponents[8],
    },
    totalPrice: 3299,
    createdBy: "user-3",
    createdAt: new Date("2024-01-18"),
    likes: 203,
    isPublic: true,
    tags: ["workstation", "content-creation", "streaming", "professional"],
  },
  {
    id: "build-4",
    name: "Silent Office Build",
    description: "Whisper-quiet build for office work and productivity tasks",
    components: {
      cpu: mockComponents[1],
      gpu: null,
      motherboard: mockComponents[3],
      memory: mockComponents[4],
      storage: mockComponents[7],
      psu: mockComponents[5],
      case: mockComponents[6],
      cooling: mockComponents[8],
    },
    totalPrice: 1299,
    createdBy: "user-1",
    createdAt: new Date("2024-01-22"),
    likes: 67,
    isPublic: true,
    tags: ["office", "quiet", "productivity", "business"],
  },
]

// Mock user data
export const mockUsers: User[] = [
  {
    id: "user-1",
    username: "PCMaster2024",
    email: "pcmaster@example.com",
    avatar: "/diverse-user-avatars.png",
    builds: ["build-1", "build-4"],
    likedBuilds: ["build-2", "build-3"],
    createdAt: new Date("2024-01-01"),
  },
  {
    id: "user-2",
    username: "BudgetBuilder",
    email: "budget@example.com",
    avatar: "/diverse-user-avatars.png",
    builds: ["build-2"],
    likedBuilds: ["build-1"],
    createdAt: new Date("2024-01-10"),
  },
  {
    id: "user-3",
    username: "ContentCreatorPro",
    email: "creator@example.com",
    avatar: "/diverse-user-avatars.png",
    builds: ["build-3"],
    likedBuilds: ["build-1", "build-4"],
    createdAt: new Date("2024-01-05"),
  },
]
