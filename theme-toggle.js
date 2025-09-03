/**
 * Theme Toggle Functionality for Premium Chauffeur
 * Provides light/dark mode switching with localStorage persistence
 * Prevents FOUC (Flash of Unstyled Content) by applying theme immediately
 */

// Apply theme immediately to prevent FOUC
(function() {
    const savedTheme = 'light'; // Always start in light mode
    document.documentElement.setAttribute('data-theme', savedTheme);
})();

class ThemeManager {
    constructor() {
        // Always start in light mode
        this.currentTheme = 'light';
        this.themeToggleButton = null;
        this.init();
    }

    init() {
        // Wait for DOM to be ready
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => this.setup());
        } else {
            this.setup();
        }
    }

    setup() {
        this.applyTheme();
        this.createThemeToggleButton();
        this.bindEvents();
    }

    createThemeToggleButton() {
        // Find all theme toggle buttons
        this.themeToggleButtons = [
            document.getElementById('theme-toggle'),
            document.getElementById('theme-toggle-tablet'),
            document.getElementById('theme-toggle-mobile')
        ].filter(btn => btn !== null);

        // If no buttons exist, don't create a fallback - buttons should be in HTML
        if (this.themeToggleButtons.length === 0) {
            console.warn('No theme toggle buttons found. Make sure to include theme toggle buttons in your HTML.');
            return;
        }

        if (this.themeToggleButtons.length > 0) {
            this.updateThemeIcon();
        }
    }

    bindEvents() {
        if (this.themeToggleButtons && this.themeToggleButtons.length > 0) {
            this.themeToggleButtons.forEach(button => {
                if (button) {
                    button.addEventListener('click', () => this.toggleTheme());
                }
            });
        }
    }

    applyTheme() {
        document.documentElement.setAttribute('data-theme', this.currentTheme);
    }

    toggleTheme() {
        this.currentTheme = this.currentTheme === 'dark' ? 'light' : 'dark';
        localStorage.setItem('theme', this.currentTheme);
        this.applyTheme();
        this.updateThemeIcon();
        
        // Dispatch custom event for other components to listen to
        window.dispatchEvent(new CustomEvent('themeChanged', { 
            detail: { theme: this.currentTheme } 
        }));
    }

    updateThemeIcon() {
        if (!this.themeToggleButtons || this.themeToggleButtons.length === 0) return;

        this.themeToggleButtons.forEach(button => {
            if (!button) return;

            const icon = button.querySelector('i');
            if (!icon) return;

            if (this.currentTheme === 'light') {
                icon.setAttribute('data-lucide', 'moon');
                button.title = 'Switch to Dark Mode';
            } else {
                icon.setAttribute('data-lucide', 'sun');
                button.title = 'Switch to Light Mode';
            }
        });

        // Recreate lucide icons if available
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
    }

    getCurrentTheme() {
        return this.currentTheme;
    }

    setTheme(theme) {
        if (theme === 'light' || theme === 'dark') {
            this.currentTheme = theme;
            localStorage.setItem('theme', this.currentTheme);
            this.applyTheme();
            this.updateThemeIcon();
        }
    }
}

// Initialize theme manager
window.themeManager = new ThemeManager();

// Export for module systems
if (typeof module !== 'undefined' && module.exports) {
    module.exports = ThemeManager;
}
