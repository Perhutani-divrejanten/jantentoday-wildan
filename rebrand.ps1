$directory = "d:\Magang\Perhutani\JantenToday"
$files = Get-ChildItem -Path $directory -Filter "*.html" -Recurse

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $content = $content -replace "Warta Jabar", "JantenToday"
    $content = $content -replace "warta jabar", "jantentoday"
    Set-Content $file.FullName $content
    Write-Host "Updated: $($file.Name)"
}

Write-Host "Rebranding completed!"
