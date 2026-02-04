---
layout: home
author_profile: false
---

<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&family=Merriweather:ital,wght@0,300;0,700;1,300&display=swap');

:root {
  --hub-primary: #1a202c;
  --hub-secondary: #4a5568;
  --hub-accent: #B509AC;
  --hub-accent-hover: #9d00e8;
  --hub-bg: #ffffff;
  --hub-section-bg: #f8fafc;
  --hub-border: #e2e8f0;
  --hub-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

body {
  font-family: 'Inter', sans-serif;
  color: var(--hub-primary);
  font-size: 14px; /* Very crisp base font */
  line-height: 1.45; /* Tighter line height */
}

h1, h2, h3 {
  font-family: 'Merriweather', serif;
  margin-top: 0;
}

/* Rolling Map Hero - Original Height, Compact Content */
.hero-banner {
  position: relative;
  height: 500px; /* Restored to original */
  width: 100%;
  overflow: hidden;
  margin-bottom: 3rem;
  border-radius: 0 0 24px 24px;
  background: #000;
}

#hero-map {
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  z-index: 1;
  opacity: 0.6;
}

.hero-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 2;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  background: radial-gradient(circle, rgba(0,0,0,0.1) 0%, rgba(0,0,0,0.5) 100%);
  color: white;
  padding: 1rem;
}

.hero-overlay img.logo {
  width: 80px; 
  margin-bottom: 1.5rem;
  filter: drop-shadow(0 0 10px rgba(181, 9, 172, 0.4));
}

.hero-overlay h1 {
  font-size: clamp(2rem, 5vw, 3rem); /* Slightly larger for the big banner but still crisp */
  margin-bottom: 0.75rem;
  font-weight: 700;
  text-shadow: 0 2px 8px rgba(0,0,0,0.5);
}

.hero-overlay p {
  font-size: 1.1rem;
  max-width: 700px;
  margin: 0 auto 2.5rem auto;
  opacity: 0.9;
  line-height: 1.5;
}

.dashboard-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 3rem; 
  margin-bottom: 4rem;
  max-width: 1200px; /* Restored to original expansive width */
  margin-left: auto;
  margin-right: auto;
}

.featured-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

/* Compact Card Styling */
.content-card {
  padding: 1.25rem;
  border: 1px solid var(--hub-border);
  border-radius: 8px;
  transition: all 0.2s ease;
  background: #fff;
}

.content-card:hover {
  border-color: var(--hub-accent);
  transform: translateY(-1px);
  box-shadow: var(--hub-shadow);
}

.content-card h3 {
  font-size: 1.05rem; /* Much smaller titles */
  color: var(--hub-accent);
  margin-bottom: 0.4rem;
}

.content-card p {
  font-size: 0.85rem;
  color: var(--hub-secondary);
}

.btn-academic {
  display: inline-block;
  padding: 0.6rem 1.4rem;
  background: var(--hub-accent);
  color: #fff !important;
  border-radius: 4px;
  text-decoration: none !important;
  font-weight: 600;
  font-size: 0.85rem;
  box-shadow: 0 2px 8px rgba(181, 9, 172, 0.2);
}

.sidebar-box {
  padding: 1.25rem;
  border-radius: 8px;
  margin-bottom: 1.25rem;
  border: 1px solid var(--hub-border);
}

.sidebar-box h4 {
  font-size: 0.65rem; /* Tiny headers for professional look */
  letter-spacing: 0.12em;
  margin-bottom: 0.75rem;
}

.sidebar-box p {
  font-size: 0.8rem;
  line-height: 1.5;
}

@media (max-width: 768px) {
  .dashboard-grid {
    grid-template-columns: 1fr;
  }
}
</style>

<!-- Leaflet for Hero -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

<section class="hero-banner">
  <div id="hero-map"></div>
  <div class="hero-overlay">
    <img src="{{ '/assets/images/logo.svg' | relative_url }}" alt="4D Seismic Hub Logo" class="logo">
    <h1>4D Seismic Knowledge Hub</h1>
    <p>Discover the pulse of time-lapse monitoring across the world's most complex reservoirs.</p>
    <a href="{{ '/pages/knowledge-base' | relative_url }}" class="btn-academic">Explore Knowledge Base</a>
  </div>
</section>

<script>
document.addEventListener('DOMContentLoaded', function() {
  var heroMap = L.map('hero-map', {
    zoomControl: false,
    attributionControl: false,
    scrollWheelZoom: false,
    dragging: false,
    touchZoom: false
  }).setView([20, 0], 3);

  L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
    attribution: '&copy; CartoDB'
  }).addTo(heroMap);

  var locations = {{ site.data.case_studies_map | jsonify }};
  var currentIndex = 0;

  locations.forEach(function(loc) {
    if (loc.latitude) {
      L.circleMarker([loc.latitude, loc.longitude], {
        radius: 5,
        fillColor: "#B509AC",
        color: "#fff",
        weight: 1,
        opacity: 0.8,
        fillOpacity: 0.6
      }).addTo(heroMap);
    }
  });

  function rollToNextLocation() {
    var loc = locations[currentIndex];
    if (loc.latitude) {
      heroMap.flyTo([loc.latitude, loc.longitude], 4, {
        animate: true,
        duration: 12
      });
    }
    currentIndex = (currentIndex + 1) % locations.length;
  }

  rollToNextLocation();
  setInterval(rollToNextLocation, 24000);
});
</script>

<div class="dashboard-grid">
  <main class="featured-list">
    <h2 style="font-size: 1.35rem; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.5rem;">
      <span style="font-size: 1.1rem;">✨</span> Featured Insights
    </h2>

    {% for paper in site.data.papers limit:3 %}
    <article class="content-card">
      <h3 style="margin-bottom: 0.5rem; color: var(--hub-accent);">{{ paper.title }}</h3>
      <p style="color: var(--hub-secondary); line-height: 1.5; font-size: 0.9rem;">{{ paper.description | truncate: 160 }}</p>
      <a href="{{ paper.link }}" target="_blank" style="color: var(--hub-accent); font-weight: 600; text-decoration: none; font-size: 0.85rem;">Read Paper &rarr;</a>
    </article>
    {% endfor %}

    <a href="{{ '/pages/knowledge-base' | relative_url }}" style="text-align: center; margin-top: 1rem; color: var(--hub-secondary); text-decoration: none; font-size: 0.85rem; font-weight: 500;">View all resources...</a>
  </main>

  <aside>
    <div class="sidebar-box">
      <h4>Working Group</h4>
      <p style="font-size: 0.85rem; line-height: 1.6;">Maintainers of the 4D Seismic Hub. We rely on volunteers for peer-reviewed content curation.</p>
      <a href="{{ '/pages/contribute' | relative_url }}" style="font-weight: 600; color: var(--hub-accent); text-decoration: none; font-size: 0.85rem;">Join the Initiative &rarr;</a>
    </div>

    <div class="sidebar-box" style="border-left: 4px solid var(--hub-accent);">
      <h4>Featured Case</h4>
      {% assign featured_case = site.data.case_studies_map | first %}
      <p style="margin-bottom: 0.4rem; font-size: 0.95rem;"><strong>{{ featured_case.name }}</strong></p>
      <p style="font-size: 0.85rem; color: var(--hub-secondary); line-height: 1.5;">{{ featured_case.summary }}</p>
      <a href="{{ '/pages/knowledge-base' | relative_url }}" style="font-weight: 600; color: var(--hub-accent); text-decoration: none; font-size: 0.85rem;">Explore Full Map &rarr;</a>
    </div>
  </aside>
</div>