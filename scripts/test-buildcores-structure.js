const https = require('https');

function githubRequest(url) {
  return new Promise((resolve, reject) => {
    https.get(url, {
      headers: {
        'User-Agent': 'BuildMate-Component-Importer',
        'Accept': 'application/vnd.github.v3+json'
      }
    }, (res) => {
      let data = '';
      res.on('data', (chunk) => data += chunk);
      res.on('end', () => {
        try {
          resolve(JSON.parse(data));
        } catch (e) {
          reject(e);
        }
      });
    }).on('error', reject);
  });
}

async function test() {
  try {
    console.log('Testing BuildCores OpenDB structure...\n');
    
    // Test root open-db directory
    const rootUrl = 'https://api.github.com/repos/buildcores/buildcores-open-db/contents/open-db';
    console.log('Fetching root directory...');
    const root = await githubRequest(rootUrl);
    console.log('Root response:', JSON.stringify(root, null, 2));
    
    if (Array.isArray(root)) {
      console.log('\nFound directories/files:');
      root.forEach(item => {
        console.log(`  - ${item.name} (${item.type})`);
      });
    } else {
      console.log('\nResponse is not an array:', typeof root);
      console.log('Response:', root);
    }
  } catch (error) {
    console.error('Error:', error.message);
  }
}

test();



