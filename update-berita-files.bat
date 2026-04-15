@echo off
REM Batch script to update all remaining berita HTML files
REM This script replaces "Warta Jabar" and "Warta Janten" with "JantenToday"
REM And updates the logo from img tag to text

setlocal enabledelayedexpansion

echo Updating all berita HTML files...
echo:

for %%F in (berita*.html) do (
    echo Processing: %%F
    
    REM Use FART (Find And Replace Text) if available, otherwise use PowerShell
    REM You can download FART from: http://fart.sourceforge.net/
    REM Or use the PowerShell alternative below
    
    powershell -NoProfile -Command ^
        "$content = Get-Content '%%F' -Raw; " ^
        "$content = $content -replace 'Warta Janten', 'JantenToday'; " ^
        "$content = $content -replace 'Warta Jabar', 'JantenToday'; " ^
        "$content = $content -replace '<img src=\"img/warta jabar\.png\" alt=\"Warta Jabar\">', 'JantenToday'; " ^
        "Set-Content '%%F' $content -Encoding UTF8"
)

echo:
echo All files processed!
echo:
pause
