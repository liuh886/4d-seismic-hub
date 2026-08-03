(() => {
  const root = document.documentElement;
  const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  root.classList.add('has-home-motion');

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
      rootMargin: '0px 0px -10% 0px',
      threshold: 0.12
    });

    items.forEach((item) => observer.observe(item));
  }

  function activateStory() {
    const visual = document.querySelector('[data-story-visual]');
    const steps = Array.from(document.querySelectorAll('[data-story-step]'));
    if (!visual || !steps.length) return;

    const setActive = (step) => {
      const state = step.dataset.storyStep;
      if (!state) return;
      visual.dataset.active = state;
      steps.forEach((item) => item.setAttribute('aria-current', item === step ? 'true' : 'false'));
    };

    setActive(steps[0]);

    if (reduceMotion || !('IntersectionObserver' in window)) return;

    const observer = new IntersectionObserver((entries) => {
      const visible = entries
        .filter((entry) => entry.isIntersecting)
        .sort((a, b) => b.intersectionRatio - a.intersectionRatio);
      if (visible.length) setActive(visible[0].target);
    }, {
      rootMargin: '-32% 0px -42% 0px',
      threshold: [0.15, 0.35, 0.6]
    });

    steps.forEach((step) => observer.observe(step));
  }

  function addHeroParallax() {
    if (reduceMotion) return;
    const hero = document.querySelector('[data-home-hero]');
    const stage = document.querySelector('[data-hero-stage]');
    if (!hero || !stage) return;

    let ticking = false;

    const update = () => {
      const rect = hero.getBoundingClientRect();
      const distance = Math.max(0, Math.min(rect.height, -rect.top));
      const progress = rect.height ? distance / rect.height : 0;
      stage.style.setProperty('--hero-shift', `${Math.round(progress * 16)}px`);
      ticking = false;
    };

    const requestUpdate = () => {
      if (ticking) return;
      ticking = true;
      window.requestAnimationFrame(update);
    };

    update();
    window.addEventListener('scroll', requestUpdate, { passive: true });
    window.addEventListener('resize', requestUpdate);
  }

  function init() {
    revealContent();
    activateStory();
    addHeroParallax();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init, { once: true });
  } else {
    init();
  }
})();
