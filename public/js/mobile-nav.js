document.addEventListener('DOMContentLoaded', () => {
    // --- Elements ---
    const fabButton = document.createElement('button');
    fabButton.className = 'fab-button';
    fabButton.innerHTML = '<i class="fas fa-bars"></i>';

    const backdrop = document.createElement('div');
    backdrop.className = 'nav-backdrop';

    const mobileNav = document.createElement('div');
    mobileNav.className = 'mobile-nav';

    const navMenu = document.createElement('div');
    navMenu.className = 'nav-menu';

    // Navigation items
    const navigationItems = [
        { path: '/', icon: 'fa-home', text: 'Home' },
        { path: '/books', icon: 'fa-book', text: 'Books' },
        { path: '/docs', icon: 'fa-file-alt', text: 'Docs' },
        { path: '/music', icon: 'fa-music', text: 'Music' },
        { path: '/movies', icon: 'fa-film', text: 'Movies' },
        { path: '/faq', icon: 'fa-question-circle', text: 'FAQ' }
    ];
    const currentPath = window.location.pathname;

    // Build nav links
    navigationItems.forEach(item => {
        const link = document.createElement('a');
        link.href = item.path;
        link.className = 'nav-link' + (currentPath === item.path ? ' active' : '');
        link.innerHTML = `<i class="fas ${item.icon}"></i> ${item.text}`;
        navMenu.appendChild(link);

        // Close menu when clicking a link
        link.addEventListener('click', closeMenu);
    });

    mobileNav.appendChild(navMenu);
    document.body.appendChild(fabButton);
    document.body.appendChild(backdrop);
    document.body.appendChild(mobileNav);

    // --- Functions ---
    function openMenu() {
        fabButton.classList.add('active');
        backdrop.classList.add('active');
        mobileNav.classList.add('active');

        const icon = fabButton.querySelector('i');
        if (icon) {
            icon.classList.remove('fa-bars');
            icon.classList.add('fa-times');
        }
    }

    function closeMenu() {
        fabButton.classList.remove('active');
        backdrop.classList.remove('active');
        mobileNav.classList.remove('active');

        const icon = fabButton.querySelector('i');
        if (icon) {
            icon.classList.remove('fa-times');
            icon.classList.add('fa-bars');
        }
    }

    function toggleMenu(e) {
        e.stopPropagation();
        if (mobileNav.classList.contains('active')) {
            closeMenu();
        } else {
            openMenu();
        }
    }

    // --- Event Listeners ---
    fabButton.addEventListener('click', toggleMenu);
    backdrop.addEventListener('click', closeMenu);

    // Close when clicking outside
    document.addEventListener('click', (e) => {
        if (!mobileNav.contains(e.target) && !fabButton.contains(e.target)) {
            closeMenu();
        }
    });

    // FAB animation on scroll
    let scrollTimeout;
    let isVisible = true;
    window.addEventListener('scroll', () => {
        if (scrollTimeout) clearTimeout(scrollTimeout);

        if (isVisible) {
            fabButton.style.transform = 'scale(0.8)';
            fabButton.style.opacity = '0.5';
            isVisible = false;
        }

        scrollTimeout = setTimeout(() => {
            fabButton.style.transform = 'scale(1)';
            fabButton.style.opacity = '1';
            isVisible = true;
        }, 150);
    });

    fabButton.style.transition = 'all 0.3s ease';
});
