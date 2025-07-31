# PowerShell script to update all blog guide pages with Premium Chauffeur header and theme system

Write-Host "Updating all blog guide pages with Premium Chauffeur system..." -ForegroundColor Green

# Get all guide directories
$guideDirectories = Get-ChildItem -Path "blog\guides" -Directory

$totalGuides = $guideDirectories.Count
$currentGuide = 0

foreach ($guideDir in $guideDirectories) {
    $currentGuide++
    $indexFile = Join-Path $guideDir.FullName "index.html"
    
    if (Test-Path $indexFile) {
        Write-Host "[$currentGuide/$totalGuides] Processing: $($guideDir.Name)" -ForegroundColor Yellow
        
        # Read the file content
        $content = Get-Content $indexFile -Raw -Encoding UTF8
        
        # 1. Update the head section - replace old CSS/JS with Premium Chauffeur system
        $oldHead = @'
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="../../public/css/main.css">
'@

        $newHead = @'
    <!-- Premium Chauffeur Theme Init -->
    <script src="../../../theme-init.js"></script>
    <script src="https://cdn.tailwindcss.com?plugins=typography"></script>
    
    <!-- Premium Chauffeur Styles -->
    <link rel="stylesheet" href="../../../style.css">
    <link rel="stylesheet" href="../../../social-bubble.css">
    <link rel="stylesheet" href="../../../language.css">
    <link rel="stylesheet" href="../../../business-card.css">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;500;600;700&family=Amiri:wght@400;700&family=Noto+Sans+Arabic:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icons and Libraries -->
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="../../../theme-toggle.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Blog Custom CSS -->
    <link rel="stylesheet" href="../../public/css/main.css">
'@

        $content = $content -replace [regex]::Escape($oldHead), $newHead
        
        # 2. Update body tag
        $content = $content -replace '<body>', '<body class="bg-brand-dark text-brand-light font-sans antialiased" data-page="blog">'
        
        Write-Host "  ✓ Updated head section and body tag" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ index.html not found in $($guideDir.Name)" -ForegroundColor Red
    }
}

        # 3. Update the old header with Premium Chauffeur header
        $oldHeaderPattern = '(?s)<header class="header">.*?</header>'

        $newHeader = @'
    <!-- Header -->
    <header id="main-header" class="fixed top-0 left-0 right-0 z-50 navbar-transparent transition-all duration-300">
        <nav class="container mx-auto px-6 py-4">
            <div class="flex items-center justify-between">
                <!-- Logo -->
                <a href="../../../index.html" class="flex items-center space-x-3 hover:opacity-80 transition-opacity">
                    <div class="w-10 h-10 flex items-center justify-center">
                        <img src="../../../assets/logo.svg" alt="Premium Chauffeur Logo" class="w-8 h-8 rotating-logo">
                    </div>
                    <div class="text-xl font-bold text-brand-gold">
                        PREMIUM CHAUFFEUR
                    </div>
                </a>

                <!-- Desktop Navigation -->
                <div class="hidden lg:flex items-center space-x-6 xl:space-x-8">
                    <a href="../../../services.html" class="nav-link" data-page="services" data-translate="nav.services">
                        Services
                    </a>
                    <a href="../../../fleet.html" class="nav-link" data-page="fleet" data-translate="nav.fleet">
                        Fleet
                    </a>
                    <a href="../../index.html" class="nav-link active" data-page="blog" data-translate="nav.blog">
                        Blog
                    </a>
                    <a href="../../../destinations.html" class="nav-link" data-page="destinations" data-translate="nav.destinations">
                        Destinations
                    </a>
                    <a href="../../../Tourism_Packages.html" class="nav-link" data-page="Tourism_Packages" data-translate="nav.tourism_packages">
                        Tourism
                    </a>
                    <a href="../../../contact.html" class="nav-link" data-page="contact" data-translate="nav.contact">
                        Contact
                    </a>
                    <a href="../../../booking-form.html" class="btn btn-primary text-sm px-6 py-2" data-translate="nav.book_now">
                        Book Now
                    </a>
                </div>

                <!-- Mobile Menu Button -->
                <button id="mobile-menu-btn" class="md:hidden text-brand-light hover:text-brand-gold transition-colors">
                    <i data-lucide="menu" class="w-6 h-6"></i>
                </button>
            </div>

            <!-- Mobile Navigation -->
            <div id="mobile-menu" class="md:hidden mt-4 pb-4 border-t border-gray-800/50 hidden">
                <div class="flex flex-col space-y-4 pt-4">
                    <a href="../../../services.html" class="mobile-nav-link" data-page="services" data-translate="nav.services">
                        Services
                    </a>
                    <a href="../../../fleet.html" class="mobile-nav-link" data-page="fleet" data-translate="nav.fleet">
                        Fleet
                    </a>
                    <a href="../../index.html" class="mobile-nav-link active" data-page="blog" data-translate="nav.blog">
                        Blog
                    </a>
                    <a href="../../../destinations.html" class="mobile-nav-link" data-page="destinations" data-translate="nav.destinations">
                        Destinations
                    </a>
                    <a href="../../../Tourism_Packages.html" class="mobile-nav-link" data-page="Tourism_Packages" data-translate="nav.tourism_packages">
                        Tourism
                    </a>
                    <a href="../../../contact.html" class="mobile-nav-link" data-page="contact" data-translate="nav.contact">
                        Contact
                    </a>
                    <a href="../../../booking-form.html" class="btn btn-primary text-sm px-6 py-2 mt-4 inline-block text-center" data-translate="nav.book_now">
                        Book Now
                    </a>
                </div>
            </div>
        </nav>
    </header>

    <!-- Theme Toggle Button -->
    <button id="theme-toggle" class="theme-toggle" title="Toggle Light/Dark Mode">
        <i data-lucide="sun" class="w-5 h-5"></i>
    </button>

    <!-- Floating Language Selector -->
    <div id="floating-language-selector" class="fixed bottom-6 right-6 z-50" style="transition: opacity 0.3s ease, transform 0.3s ease;">
        <div class="language-selector-container relative">
            <button id="lang-toggle-btn" class="flex items-center justify-center w-9 h-9 rounded-full shadow-lg transition-all duration-300 transform hover:scale-110" style="background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 50%, #1a1a1a 100%); border: 2px solid #D4AF37; color: #D4AF37; font-size: 0.75rem; font-weight: 600;">
                <span id="current-lang">EN</span>
            </button>
        </div>
    </div>
'@

        if ($content -match $oldHeaderPattern) {
            $content = $content -replace $oldHeaderPattern, $newHeader
            Write-Host "  ✓ Updated header" -ForegroundColor Green
        } else {
            Write-Host "  ⚠ Header pattern not found in $($guideDir.Name)" -ForegroundColor Yellow
        }

        # 4. Update JavaScript section
        $oldJSPattern = '(?s)    <!-- JavaScript -->.*?</body>'

        $newJS = @'
    <!-- Premium Chauffeur JavaScript -->
    <script type="module" src="https://esm.run/framer-motion"></script>
    <script src="../../../translations-simple.js"></script>
    <script src="../../../mobile-menu.js"></script>
    <script src="../../../script.js"></script>
    <script src="../../../chatbot.js"></script>
    <script src="../../../social-bubble.js"></script>
    <script src="../../../business-card.js"></script>

    <!-- Blog JavaScript -->
    <script src="../../public/js/LightRays.js"></script>
    <script src="../../public/js/main.js"></script>

</body>
'@

        if ($content -match $oldJSPattern) {
            $content = $content -replace $oldJSPattern, $newJS
            Write-Host "  ✓ Updated JavaScript section" -ForegroundColor Green
        }

        # Write the updated content back
        Set-Content $indexFile -Value $content -Encoding UTF8

        Write-Host "  ✅ Successfully updated $($guideDir.Name)" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ index.html not found in $($guideDir.Name)" -ForegroundColor Red
    }
}

Write-Host "`n🎉 All guide pages have been updated with Premium Chauffeur system!" -ForegroundColor Green
Write-Host "✨ Features added to all guides:" -ForegroundColor Cyan
Write-Host "  • Premium Chauffeur header with full navigation" -ForegroundColor White
Write-Host "  • Theme toggle (light/dark mode)" -ForegroundColor White
Write-Host "  • Language selector" -ForegroundColor White
Write-Host "  • Mobile responsive design" -ForegroundColor White
Write-Host "  • Gold titles and white text in dark mode" -ForegroundColor White
Write-Host "  • Unified branding across all pages" -ForegroundColor White
