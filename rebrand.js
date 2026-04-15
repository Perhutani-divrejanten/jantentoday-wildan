const fs = require('fs');
const path = require('path');

const directory = 'd:\\Magang\\Perhutani\\JantenToday';

function walkDir(dir) {
  const files = fs.readdirSync(dir);
  files.forEach(file => {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);
    if (stat.isDirectory() && !filePath.includes('node_modules')) {
      walkDir(filePath);
    } else if (file.endsWith('.html')) {
      try {
        let content = fs.readFileSync(filePath, 'utf-8');
        let original = content;
        
        content = content.replace(/<img src="img\/warta jabar\.png" alt="Warta Jabar">/g, 'JantenToday');
        content = content.replace(/Warta Jabar/g, 'JantenToday');
        content = content.replace(/Warta Janten/g, 'JantenToday');
        
        if (content !== original) {
          fs.writeFileSync(filePath, content, 'utf-8');
          console.log('Updated: ' + file);
        }
      } catch (e) {
        console.log('Error: ' + file);
      }
    }
  });
}

walkDir(directory);
console.log('Rebranding completed!');
