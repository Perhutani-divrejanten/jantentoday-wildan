$workspacePath = "d:\Magang\Perhutani\JantenToday"

$htmlFiles = Get-ChildItem -Path $workspacePath -Filter "*.html" -Recurse
Write-Host "Found $($htmlFiles.Count) HTML files"

$filesModified = 0

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    $content = $content -replace 'img src="img/warta jabar.png" alt="Warta Jabar"', 'span class="brand-text">JantenToday</span'
    $content = $content -replace 'Warta Janten', 'JantenToday'
    $content = $content -replace 'Warta Jabar', 'JantenToday'
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        $filesModified++
        Write-Host "Updated: $($file.Name)"
    }
}

$launchJsonPath = Join-Path $workspacePath ".vscode\launch.json"
if (Test-Path $launchJsonPath) {
    $content = Get-Content -Path $launchJsonPath -Raw -Encoding UTF8
    $content = $content -replace 'Warta Jabar', 'JantenToday'
    $content = $content -replace 'Warta Jabar', 'JantenToday'
    Set-Content -Path $launchJsonPath -Value $content -Encoding UTF8
    Write-Host "Updated: launch.json"
}

Write-Host "Updated $filesModified files"
