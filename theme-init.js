/**
 * Immediate Theme Initialization
 * This script must be loaded synchronously in the <head> to prevent FOUC
 * Place this BEFORE any CSS files that use theme variables
 */

(function() {
    'use strict';
    
    // Always start in light mode
    const savedTheme = 'light';
    
    // Apply theme to document root immediately
    document.documentElement.setAttribute('data-theme', savedTheme);
    
    // Also set a class for additional CSS targeting if needed
    document.documentElement.classList.add('theme-' + savedTheme);
    
    // Store theme for other scripts
    window.initialTheme = savedTheme;
    
})();
