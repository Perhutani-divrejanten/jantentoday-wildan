import os
import re

directory = r"d:\Magang\Perhutani\JantenToday"

# Replacements patterns
replacements = [
    (r'<img src="img/warta jabar\.png" alt="Warta Jabar">', 'JantenToday'),
    (r'<img src="img/jantentoday\.png" alt="JantenToday">', 'JantenToday'),
    ('Warta Jabar', 'JantenToday'),
    ('Warta Janten', 'JantenToday'),
]

# Process all HTML files
for root, dirs, files in os.walk(directory):
    for file in files:
        if file.endswith('.html'):
            file_path = os.path.join(root, file)
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                original_content = content
                
                # Apply replacements
                content = content.replace('<img src="img/warta jabar.png" alt="Warta Jabar">', 'JantenToday')
                content = content.replace('<img src="img/jantentoday.png" alt="JantenToday">', 'JantenToday')
                content = content.replace('Warta Jabar', 'JantenToday')
                content = content.replace('Warta Janten', 'JantenToday')
                content = content.replace('warta jabar', 'jantentoday')
                
                if content != original_content:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        f.write(content)
                    print(f"Updated: {file}")
                else:
                    print(f"No changes needed: {file}")
            except Exception as e:
                print(f"Error processing {file}: {e}")

print("Rebranding completed!")
