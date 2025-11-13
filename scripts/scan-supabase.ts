import { supabase } from '../lib/supabase'

async function scanSupabase() {
  console.log('🔍 Scanning Supabase Database...\n')
  console.log('=' .repeat(60))

  try {
    // Scan Users
    console.log('\n📊 USERS TABLE:')
    const { data: users, error: usersError } = await supabase
      .from('users')
      .select('user_id, user_name, email, user_type, created_at')
      .order('created_at', { ascending: false })
      .limit(10)

    if (usersError) {
      console.log('❌ Error:', usersError.message)
    } else {
      console.log(`✅ Found ${users?.length || 0} users`)
      if (users && users.length > 0) {
        users.forEach((user, index) => {
          console.log(`   ${index + 1}. ${user.user_name} (${user.email}) - ${user.user_type}`)
        })
      }
    }

    // Scan Component Categories
    console.log('\n📊 COMPONENT CATEGORIES:')
    const { data: categories, error: categoriesError } = await supabase
      .from('component_categories')
      .select('category_id, category_name, description')
      .order('category_name')

    if (categoriesError) {
      console.log('❌ Error:', categoriesError.message)
    } else {
      console.log(`✅ Found ${categories?.length || 0} categories`)
      if (categories && categories.length > 0) {
        categories.forEach((cat) => {
          console.log(`   - ${cat.category_name} (ID: ${cat.category_id})`)
        })
      }
    }

    // Scan Build Types
    console.log('\n📊 BUILD TYPES:')
    const { data: buildTypes, error: buildTypesError } = await supabase
      .from('build_types')
      .select('build_type_id, type_name, description')
      .order('type_name')

    if (buildTypesError) {
      console.log('❌ Error:', buildTypesError.message)
    } else {
      console.log(`✅ Found ${buildTypes?.length || 0} build types`)
      if (buildTypes && buildTypes.length > 0) {
        buildTypes.forEach((type) => {
          console.log(`   - ${type.type_name} (ID: ${type.build_type_id})`)
        })
      }
    }

    // Scan Retailers
    console.log('\n📊 RETAILERS:')
    const { data: retailers, error: retailersError } = await supabase
      .from('retailers')
      .select('retailer_id, retailer_name, website')
      .order('retailer_name')

    if (retailersError) {
      console.log('❌ Error:', retailersError.message)
    } else {
      console.log(`✅ Found ${retailers?.length || 0} retailers`)
      if (retailers && retailers.length > 0) {
        retailers.forEach((retailer) => {
          console.log(`   - ${retailer.retailer_name} (ID: ${retailer.retailer_id})`)
        })
      }
    }

    // Scan Components
    console.log('\n📊 COMPONENTS:')
    const { data: components, error: componentsError } = await supabase
      .from('components')
      .select(`
        component_id,
        component_name,
        component_price,
        category_id,
        retailer_id,
        component_categories(category_name),
        retailers(retailer_name)
      `)
      .order('component_name')
      .limit(20)

    if (componentsError) {
      console.log('❌ Error:', componentsError.message)
    } else {
      console.log(`✅ Found ${components?.length || 0} components (showing first 20)`)
      if (components && components.length > 0) {
        components.forEach((comp, index) => {
          const category = comp.component_categories as any
          const retailer = comp.retailers as any
          console.log(`   ${index + 1}. ${comp.component_name}`)
          console.log(`      Price: $${comp.component_price || 0}`)
          console.log(`      Category: ${category?.category_name || 'N/A'}`)
          console.log(`      Retailer: ${retailer?.retailer_name || 'N/A'}`)
        })
      }
    }

    // Scan Builds
    console.log('\n📊 BUILDS:')
    const { data: builds, error: buildsError } = await supabase
      .from('builds')
      .select(`
        build_id,
        build_name,
        date_created,
        user_id,
        build_type_id,
        users(user_name, email),
        build_types(type_name)
      `)
      .order('date_created', { ascending: false })
      .limit(10)

    if (buildsError) {
      console.log('❌ Error:', buildsError.message)
    } else {
      console.log(`✅ Found ${builds?.length || 0} builds (showing first 10)`)
      if (builds && builds.length > 0) {
        builds.forEach((build, index) => {
          const user = build.users as any
          const buildType = build.build_types as any
          console.log(`   ${index + 1}. ${build.build_name}`)
          console.log(`      User: ${user?.user_name || 'N/A'} (${user?.email || 'N/A'})`)
          console.log(`      Type: ${buildType?.type_name || 'N/A'}`)
          console.log(`      Created: ${new Date(build.date_created).toLocaleDateString()}`)
        })
      }
    }

    // Scan Build Components (relationships)
    console.log('\n📊 BUILD COMPONENTS (Relationships):')
    const { data: buildComponents, error: buildComponentsError } = await supabase
      .from('build_components')
      .select('build_component_id, build_id, component_id')
      .limit(10)

    if (buildComponentsError) {
      console.log('❌ Error:', buildComponentsError.message)
    } else {
      console.log(`✅ Found ${buildComponents?.length || 0} build-component relationships (showing first 10)`)
    }

    // Scan Build History
    console.log('\n📊 BUILD HISTORY:')
    const { data: history, error: historyError } = await supabase
      .from('build_history')
      .select('bhistory_id, build_id, change_description, changed_at')
      .order('changed_at', { ascending: false })
      .limit(10)

    if (historyError) {
      console.log('❌ Error:', historyError.message)
    } else {
      console.log(`✅ Found ${history?.length || 0} history entries (showing first 10)`)
      if (history && history.length > 0) {
        history.forEach((entry, index) => {
          console.log(`   ${index + 1}. Build ID: ${entry.build_id} - ${entry.change_description || 'No description'}`)
        })
      }
    }

    // Scan Comments
    console.log('\n📊 COMMENTS:')
    const { data: comments, error: commentsError } = await supabase
      .from('comments')
      .select('comment_id, bhistory_id, user_id, comment_text, commented_at')
      .order('commented_at', { ascending: false })
      .limit(10)

    if (commentsError) {
      console.log('❌ Error:', commentsError.message)
    } else {
      console.log(`✅ Found ${comments?.length || 0} comments (showing first 10)`)
    }

    // Summary
    console.log('\n' + '='.repeat(60))
    console.log('📈 SUMMARY:')
    console.log(`   Users: ${users?.length || 0}`)
    console.log(`   Categories: ${categories?.length || 0}`)
    console.log(`   Build Types: ${buildTypes?.length || 0}`)
    console.log(`   Retailers: ${retailers?.length || 0}`)
    console.log(`   Components: ${components?.length || 0}`)
    console.log(`   Builds: ${builds?.length || 0}`)
    console.log(`   Build Components: ${buildComponents?.length || 0}`)
    console.log(`   History Entries: ${history?.length || 0}`)
    console.log(`   Comments: ${comments?.length || 0}`)
    console.log('='.repeat(60))
    console.log('\n✅ Scan completed!')

  } catch (error: any) {
    console.error('❌ Fatal error scanning database:', error.message)
    console.error(error)
  }
}

// Run the scan
if (require.main === module) {
  scanSupabase()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error)
      process.exit(1)
    })
}

export { scanSupabase }









