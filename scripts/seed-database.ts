import { componentService, categoryService, retailerService } from '../lib/database'

// Sample component data based on your mock data
const sampleComponents = [
  // CPUs
  {
    component_name: 'AMD Ryzen 7 7800X3D',
    component_price: 449.99,
    compatibility_information: 'AM5 socket, DDR5 memory support',
    category_name: 'CPU'
  },
  {
    component_name: 'Intel Core i7-13700K',
    component_price: 399.99,
    compatibility_information: 'LGA1700 socket, DDR4/DDR5 memory support',
    category_name: 'CPU'
  },
  {
    component_name: 'AMD Ryzen 5 5600G',
    component_price: 159.99,
    compatibility_information: 'AM4 socket, integrated graphics',
    category_name: 'CPU'
  },
  
  // GPUs
  {
    component_name: 'NVIDIA GeForce RTX 4080 SUPER',
    component_price: 999.99,
    compatibility_information: 'PCIe 4.0, 16GB GDDR6X',
    category_name: 'GPU'
  },
  {
    component_name: 'AMD Radeon RX 7800 XT',
    component_price: 499.99,
    compatibility_information: 'PCIe 4.0, 16GB GDDR6',
    category_name: 'GPU'
  },
  
  // Motherboards
  {
    component_name: 'ASUS ROG Strix X670E-E Gaming WiFi',
    component_price: 449.99,
    compatibility_information: 'AM5 socket, DDR5, WiFi 6E',
    category_name: 'Motherboard'
  },
  {
    component_name: 'MSI MAG B550 Tomahawk',
    component_price: 149.99,
    compatibility_information: 'AM4 socket, DDR4, PCIe 4.0',
    category_name: 'Motherboard'
  },
  
  // Memory
  {
    component_name: 'Corsair Vengeance LPX 32GB (2x16GB) DDR4-3200',
    component_price: 89.99,
    compatibility_information: 'DDR4-3200, CL16, 1.35V',
    category_name: 'Memory'
  },
  {
    component_name: 'G.Skill Trident Z5 RGB 32GB (2x16GB) DDR5-6000',
    component_price: 149.99,
    compatibility_information: 'DDR5-6000, CL30, 1.35V',
    category_name: 'Memory'
  },
  
  // Storage
  {
    component_name: 'Samsung 980 PRO 1TB NVMe SSD',
    component_price: 99.99,
    compatibility_information: 'PCIe 4.0, 7000MB/s read, 5000MB/s write',
    category_name: 'Storage'
  },
  {
    component_name: 'Crucial MX500 500GB SATA SSD',
    component_price: 49.99,
    compatibility_information: 'SATA III, 560MB/s read, 510MB/s write',
    category_name: 'Storage'
  },
  
  // Power Supplies
  {
    component_name: 'Corsair RM850x 850W 80+ Gold',
    component_price: 149.99,
    compatibility_information: '850W, 80+ Gold, Fully Modular',
    category_name: 'PSU'
  },
  {
    component_name: 'EVGA 500W 80+ Bronze',
    component_price: 39.99,
    compatibility_information: '500W, 80+ Bronze, Non-Modular',
    category_name: 'PSU'
  },
  
  // Cases
  {
    component_name: 'Fractal Design Define 7',
    component_price: 149.99,
    compatibility_information: 'ATX Mid Tower, Sound Dampening',
    category_name: 'Case'
  },
  {
    component_name: 'NZXT H510',
    component_price: 69.99,
    compatibility_information: 'ATX Mid Tower, Tempered Glass',
    category_name: 'Case'
  },
  
  // Cooling
  {
    component_name: 'Noctua NH-D15',
    component_price: 99.99,
    compatibility_information: 'Dual Tower Air Cooler, 140mm fans',
    category_name: 'Cooling'
  },
  {
    component_name: 'Corsair H100i RGB Pro XT',
    component_price: 119.99,
    compatibility_information: '240mm AIO Liquid Cooler, RGB',
    category_name: 'Cooling'
  }
]

// Sample retailers
const sampleRetailers = [
  {
    retailer_name: 'Newegg',
    email: 'support@newegg.com',
    website: 'https://newegg.com',
    retailer_address: '17560 Rowland St, City of Industry, CA 91748',
    retailer_phone: '1-800-390-1119'
  },
  {
    retailer_name: 'Amazon',
    email: 'support@amazon.com',
    website: 'https://amazon.com',
    retailer_address: '410 Terry Ave N, Seattle, WA 98109',
    retailer_phone: '1-888-280-4331'
  },
  {
    retailer_name: 'Best Buy',
    email: 'support@bestbuy.com',
    website: 'https://bestbuy.com',
    retailer_address: '7601 Penn Ave S, Richfield, MN 55423',
    retailer_phone: '1-888-237-8289'
  },
  {
    retailer_name: 'Micro Center',
    email: 'support@microcenter.com',
    website: 'https://microcenter.com',
    retailer_address: '7500 Tuckerman Ln, Rockville, MD 20855',
    retailer_phone: '1-301-984-1540'
  }
]

async function seedDatabase() {
  try {
    console.log('Starting database seeding...')

    // Create retailers first
    console.log('Creating retailers...')
    const retailers = []
    for (const retailerData of sampleRetailers) {
      try {
        const retailer = await retailerService.create(retailerData)
        retailers.push(retailer)
        console.log(`Created retailer: ${retailer.retailer_name}`)
      } catch (error) {
        console.log(`Retailer ${retailerData.retailer_name} might already exist`)
      }
    }

    // Get categories
    console.log('Getting categories...')
    const categories = await categoryService.getAll()
    const categoryMap = new Map(categories.map(c => [c.category_name.toLowerCase(), c.category_id]))

    // Create components
    console.log('Creating components...')
    for (const componentData of sampleComponents) {
      try {
        const categoryId = categoryMap.get(componentData.category_name.toLowerCase())
        if (!categoryId) {
          console.log(`Category ${componentData.category_name} not found, skipping component ${componentData.component_name}`)
          continue
        }

        // Randomly assign a retailer
        const randomRetailer = retailers[Math.floor(Math.random() * retailers.length)]

        await componentService.create({
          component_name: componentData.component_name,
          component_price: componentData.component_price,
          compatibility_information: componentData.compatibility_information,
          category_id: categoryId,
          retailer_id: randomRetailer.retailer_id
        })

        console.log(`Created component: ${componentData.component_name}`)
      } catch (error) {
        console.log(`Component ${componentData.component_name} might already exist or error occurred:`, error)
      }
    }

    console.log('Database seeding completed!')
  } catch (error) {
    console.error('Error seeding database:', error)
  }
}

// Run the seeder if this file is executed directly
if (require.main === module) {
  seedDatabase()
}

export { seedDatabase }




























