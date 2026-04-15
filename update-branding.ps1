# Script untuk mengupdate semua referensi Warta Janten dan Warta Jabar ke JantenToday

$workspacePath = "d:\Magang\Perhutani\JantenToday"

# Daftar penggantian
$replacements = @(
    @{ old = '<img src="img/warta jabar.png" alt="Warta Jabar">'; new = '<span class="brand-text">JantenToday</span>' },
    @{ old = '- Warta Janten'; new = '- JantenToday' },
    @{ old = 'Copyright © 2026 Warta Janten'; new = 'Copyright © 2026 JantenToday' },
    @{ old = 'Copyright © 2026Warta Janten'; new = 'Copyright © 2026 JantenToday' },
    @{ old = '<strong>Warta Janten</strong>'; new = '<strong>JantenToday</strong>' },
    @{ old = 'Warta Janten'; new = 'JantenToday' },
    @{ old = 'Warta Jabar'; new = 'JantenToday' }
)

# Hitung total file yang akan diupdate
$htmlFiles = Get-ChildItem -Path $workspacePath -Filter "*.html" -Recurse | Where-Object { $_.PSIsContainer -eq $false }
Write-Host "Menemukan $($htmlFiles.Count) file HTML untuk diupdate"

$totalReplacements = 0
$filesModified = 0

# Proses setiap file HTML
foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Lakukan semua penggantian
    foreach ($replacement in $replacements) {
        $escapedOld = [regex]::Escape($replacement.old)
        if ($content -match $escapedOld) {
            $content = $content -replace $escapedOld, $replacement.new
        }
    }
    
    # Jika ada perubahan, simpan file
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        $filesModified++
        Write-Host "Updated: $($file.Name)"
    }
}

# Update file konfigurasi .vscode/launch.json
$launchJsonPath = Join-Path $workspacePath ".vscode\launch.json"
if (Test-Path $launchJsonPath) {
    $launchContent = Get-Content -Path $launchJsonPath -Raw -Encoding UTF8
    $launchContent = $launchContent.Replace('Warta Jabar', 'JantenToday')
    Set-Content -Path $launchJsonPath -Value $launchContent -Encoding UTF8
    Write-Host "✓ Updated: launch.json"
}

Write-Host ""
Write-Host "=== SUMMARY ==="
Write-Host "Total file yang dimodifikasi: $filesModified"
Write-Host "Branding berhasil diupdate ke JantenToday!"
