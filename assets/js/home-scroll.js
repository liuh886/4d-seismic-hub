(() => {
  const body = document.body;
  if (!body.classList.contains('layout--home')) return;

  const root = document.documentElement;
  const masthead = document.querySelector('.masthead');
  const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  function syncNavigation() {
    if (!masthead) return;
    masthead.classList.toggle('is-scrolled', window.scrollY > 24);
  }

  function revealContent() {
    const items = Array.from(document.querySelectorAll('.hub-readest-home [data-reveal]'));
    if (!items.length || reduceMotion) return;

    root.classList.add('has-home-motion');

    if (!('IntersectionObserver' in window)) {
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
      rootMargin: '0px 0px -6% 0px',
      threshold: 0.08
    });

    items.forEach((item) => observer.observe(item));
  }

  syncNavigation();
  revealContent();

  window.addEventListener('scroll', syncNavigation, { passive: true });
  window.addEventListener('pageshow', syncNavigation);
})();
