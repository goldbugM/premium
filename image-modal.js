/**
 * Image Modal Functionality
 * Adds click-to-expand functionality for images across the website
 */

document.addEventListener('DOMContentLoaded', function() {
    // Create modal HTML if it doesn't exist
    if (!document.getElementById('imageModal')) {
        const modalHTML = `
            <div id="imageModal" class="image-modal">
                <div class="image-modal-content">
                    <span class="image-modal-close">&times;</span>
                    <img id="modalImage" src="" alt="Expanded Image">
                </div>
            </div>
        `;
        document.body.insertAdjacentHTML('beforeend', modalHTML);
    }

    const modal = document.getElementById('imageModal');
    const modalImg = document.getElementById('modalImage');
    const closeBtn = document.querySelector('.image-modal-close');
    
    // Add click event to all images
    function initializeImageModal() {
        const images = document.querySelectorAll('img, .service-image, .premium-card img, .vehicle-card img, .booking-vehicle-image, .slideshow img, #slideshow-container img, .hero-image, .card img, .gallery img, .fleet-card img, .main-car-image');
        
        images.forEach(img => {
            // Skip logo and small icons
            if (img.classList.contains('rotating-logo') || 
                img.closest('.logo') || 
                img.classList.contains('modal-skip') ||
                img.width < 100 || 
                img.height < 100) {
                return;
            }
            
            // Add visual indicator that image is clickable
            img.style.cursor = 'pointer';
            
            // Remove any existing click listeners to prevent duplicates
            img.removeEventListener('click', handleImageClick);
            img.addEventListener('click', handleImageClick);
        });
    }
    
    function handleImageClick(e) {
        e.preventDefault();
        e.stopPropagation();
        
        modal.classList.add('active');
        modalImg.src = this.src;
        modalImg.alt = this.alt || 'Expanded Image';
        
        // Prevent body scroll when modal is open
        document.body.style.overflow = 'hidden';
    }
    
    // Close modal when clicking the X
    closeBtn.addEventListener('click', function() {
        closeModal();
    });
    
    // Close modal when clicking outside the image
    modal.addEventListener('click', function(e) {
        if (e.target === modal) {
            closeModal();
        }
    });
    
    // Close modal with Escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && modal.classList.contains('active')) {
            closeModal();
        }
    });
    
    function closeModal() {
        modal.classList.remove('active');
        document.body.style.overflow = '';
    }
    
    // Initialize on page load
    initializeImageModal();
    
    // Re-initialize when new content is loaded (for dynamic content)
    const observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
                // Check if any new images were added
                const hasNewImages = Array.from(mutation.addedNodes).some(node => 
                    node.nodeType === 1 && (node.tagName === 'IMG' || node.querySelector('img'))
                );
                if (hasNewImages) {
                    setTimeout(initializeImageModal, 100); // Small delay to ensure images are loaded
                }
            }
        });
    });
    
    observer.observe(document.body, {
        childList: true,
        subtree: true
    });
});
