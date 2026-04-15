import os
import glob

def replace_in_file(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()

        original = content

        # Logo replacement
        content = content.replace('<img src="img/warta jabar.png" alt="Warta Jabar">', '<span class="brand-text">JantenToday</span>')

        # Title replacements
        content = content.replace(' - Warta Janten</title>', ' - JantenToday</title>')
        content = content.replace(' - Warta Jabar</title>', ' - JantenToday</title>')
        content = content.replace('Warta Janten</title>', 'JantenToday</title>')
        content = content.replace('Warta Jabar</title>', 'JantenToday</title>')

        # Footer replacements
        content = content.replace('<strong>Warta Janten</strong>', '<strong>JantenToday</strong>')
        content = content.replace('<strong>Warta Jabar</strong>', '<strong>JantenToday</strong>')

        # General text replacements
        content = content.replace('Warta Jabar', 'JantenToday')
        content = content.replace('Warta Janten', 'JantenToday')
        content = content.replace('warta jabar', 'jantentoday')
        content = content.replace('warta janten', 'jantentoday')

        if content != original:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
        return False

    except Exception as e:
        print(f"Error processing {filepath}: {e}")
        return False

# Process all HTML files
base_dir = r"d:\Magang\Perhutani\JantenToday"
html_files = glob.glob(os.path.join(base_dir, "*.html")) + glob.glob(os.path.join(base_dir, "**/*.html"), recursive=True)

updated = 0
for filepath in html_files:
    if replace_in_file(filepath):
        print(f"Updated: {os.path.basename(filepath)}")
        updated += 1

print(f"\nTotal files updated: {updated}")
print("Rebranding completed!")