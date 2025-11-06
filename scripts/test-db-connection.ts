import { supabase } from '../lib/supabase'

async function testDatabaseConnection() {
  console.log('🔍 Testing Supabase Database Connection...\n')

  // Test 1: Check if we can connect
  console.log('1. Testing basic connection...')
  try {
    const { data, error } = await supabase.from('users').select('count').limit(1)
    if (error) throw error
    console.log('   ✅ Connection successful!\n')
  } catch (error: any) {
    console.log('   ❌ Connection failed:', error.message)
    return
  }

  // Test 2: Check all tables exist
  console.log('2. Checking if all tables exist...')
  const tables = [
    'users',
    'builds',
    'components',
    'component_categories',
    'build_types',
    'retailers',
    'build_components',
    'build_history',
    'comments'
  ]

  const tableResults: { [key: string]: boolean } = {}

  for (const table of tables) {
    try {
      const { error } = await supabase.from(table).select('*').limit(1)
      if (error) {
        if (error.code === 'PGRST116') {
          // Table exists but is empty - that's okay
          tableResults[table] = true
        } else {
          tableResults[table] = false
          console.log(`   ❌ ${table}: ${error.message}`)
        }
      } else {
        tableResults[table] = true
        console.log(`   ✅ ${table}`)
      }
    } catch (error: any) {
      tableResults[table] = false
      console.log(`   ❌ ${table}: ${error.message}`)
    }
  }

  // Test 3: Check table structures match schema
  console.log('\n3. Verifying table structures...')
  
  // Check users table
  try {
    const { data, error } = await supabase
      .from('users')
      .select('user_id, user_name, email, password, user_type, created_at')
      .limit(1)
    
    if (error && error.code !== 'PGRST116') {
      console.log('   ⚠️  users table structure may not match schema')
    } else {
      console.log('   ✅ users table structure matches')
    }
  } catch (error) {
    console.log('   ⚠️  Could not verify users table structure')
  }

  // Check components table
  try {
    const { data, error } = await supabase
      .from('components')
      .select('component_id, component_name, component_price, compatibility_information, category_id, retailer_id')
      .limit(1)
    
    if (error && error.code !== 'PGRST116') {
      console.log('   ⚠️  components table structure may not match schema')
    } else {
      console.log('   ✅ components table structure matches')
    }
  } catch (error) {
    console.log('   ⚠️  Could not verify components table structure')
  }

  // Test 4: Count records in each table
  console.log('\n4. Counting records in each table...')
  for (const table of tables) {
    try {
      const { count, error } = await supabase
        .from(table)
        .select('*', { count: 'exact', head: true })
      
      if (error && error.code !== 'PGRST116') {
        console.log(`   ⚠️  ${table}: Could not count (${error.message})`)
      } else {
        console.log(`   📊 ${table}: ${count || 0} records`)
      }
    } catch (error: any) {
      console.log(`   ⚠️  ${table}: Error counting (${error.message})`)
    }
  }

  // Summary
  console.log('\n📋 Summary:')
  const allTablesExist = Object.values(tableResults).every(exists => exists)
  if (allTablesExist) {
    console.log('   ✅ All tables exist and are accessible!')
    console.log('   ✅ Database connection is working properly!')
  } else {
    console.log('   ⚠️  Some tables may be missing or inaccessible')
    console.log('   Please check your Supabase migration script')
  }
}

// Run the test
testDatabaseConnection()
  .then(() => {
    console.log('\n✨ Database connection test completed!')
    process.exit(0)
  })
  .catch((error) => {
    console.error('\n❌ Test failed:', error)
    process.exit(1)
  })


