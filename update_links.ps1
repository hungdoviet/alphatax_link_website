$files = Get-ChildItem -Path "e:\MelLink\AlphaTaxLink\Web" -Filter "*.html"
$files += Get-ChildItem -Path "e:\MelLink\AlphaTaxLink\Web\sitemap.xml"

foreach ($file in $files) {
    $content = Get-Content -Raw -Path $file.FullName
    
    # Absolute URLs
    $content = $content -replace 'https://alphataxlink\.com\.au/index\.html', 'https://alphataxlink.com.au/'
    $content = $content -replace 'https://alphataxlink\.com\.au/([a-zA-Z0-9-]+)\.html', 'https://alphataxlink.com.au/$1'
    
    # Relative hrefs
    $content = $content -replace 'href="index\.html"', 'href="/"'
    $content = $content -replace 'href="([a-zA-Z0-9-]+)\.html"', 'href="/$1"'

    Set-Content -Path $file.FullName -Value $content -NoNewline
}
