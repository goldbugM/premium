# PowerShell script to fix navigation links in all blog guide pages

Write-Host "Fixing navigation links in blog guide pages..." -ForegroundColor Green

# Get all guide directories
$guideDirectories = Get-ChildItem -Path "blog\guides" -Directory

foreach ($guideDir in $guideDirectories) {
    $indexFile = Join-Path $guideDir.FullName "index.html"
    
    if (Test-Path $indexFile) {
        Write-Host "Processing: $($guideDir.Name)" -ForegroundColor Yellow
        
        # Read the file content
        $content = Get-Content $indexFile -Raw -Encoding UTF8
        
        # Replace the incorrect navigation links
        $content = $content -replace 'href="../../"', 'href="../../../index.html"'
        $content = $content -replace 'href="../../booking"', 'href="../../../booking-form.html"'
        
        # Write the updated content back
        Set-Content $indexFile -Value $content -Encoding UTF8
        
        Write-Host "  ✓ Updated navigation links" -ForegroundColor Green
    }
}

Write-Host "All blog guide navigation links have been fixed!" -ForegroundColor Green
