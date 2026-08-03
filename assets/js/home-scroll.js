(() => {
  const root = document.documentElement;
  const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  root.classList.add('has-home-motion');

  function updateNavigation() {
    const masthead = document.querySelector('.masthead');
    if (!masthead) return;

    const syncState = () => {
      masthead.classList.toggle('is-scrolled', window.scrollY > 24);
    };

    syncState();
    window.addEventListener('scroll', syncState, { passive: true });
  }

  function revealContent() {
    const items = Array.from(document.querySelectorAll('.hub-readest-home [data-reveal]'));
    if (!items.length) return;

    if (reduceMotion || !('IntersectionObserver' in window)) {
      items.forEach((item) => item.classList.add('is-visible'));
      return;
    }

    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (!entry.isIntersecting) return;
        entry.target.classList.add('is-visible');
        observer.unobserve(entry.target);
      });
    }, {
      rootMargin: '0px 0px -8% 0px',
      threshold: 0.1
    });

    items.forEach((item) => observer.observe(item));
  }

  function init() {
    updateNavigation();
    revealContent();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init, { once: true });
  } else {
    init();
  }
})();
