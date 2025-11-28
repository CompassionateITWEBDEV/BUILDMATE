const fs = require('fs');
const path = require('path');

const sqlFile = path.join(__dirname, 'import-20-components-per-category.sql');
const content = fs.readFileSync(sqlFile, 'utf8');

const categories = {
  1: 'CPU',
  2: 'Motherboard',
  3: 'RAM',
  4: 'Storage',
  5: 'GPU',
  6: 'PSU',
  7: 'Case',
  8: 'Cooling'
};

const counts = {};

for (let i = 1; i <= 8; i++) {
  const regex = new RegExp(`,\\s+${i},\\s+NULL`, 'g');
  const matches = content.match(regex);
  counts[i] = matches ? matches.length : 0;
}

console.log('📊 Category Distribution in SQL File:\n');
Object.entries(categories).forEach(([id, name]) => {
  console.log(`  ${name} (category_id ${id}): ${counts[id]} components`);
});

const total = Object.values(counts).reduce((sum, count) => sum + count, 0);
console.log(`\n  Total: ${total} components`);

// Verify each category has exactly 20
const allHave20 = Object.values(counts).every(count => count === 20);
if (allHave20) {
  console.log('\n✅ All categories have exactly 20 components!');
} else {
  console.log('\n⚠️  Some categories do not have 20 components:');
  Object.entries(categories).forEach(([id, name]) => {
    if (counts[id] !== 20) {
      console.log(`  ❌ ${name}: ${counts[id]} (expected 20)`);
    }
  });
}



