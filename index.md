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
  --hub-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

body {
  font-family: 'Inter', sans-serif;
  color: var(--hub-primary);
  font-size: 15px; /* Slightly smaller base font for a crisper look */
}

h1, h2, h3 {
  font-family: 'Merriweather', serif;
}

/* Rolling Map Hero - Scaled for better 100% zoom appearance */
.hero-banner {
  position: relative;
  height: 400px; /* Reduced from 500px */
  width: 100%;
  overflow: hidden;
  margin-bottom: 2.5rem;
  border-radius: 0 0 20px 20px;
  background: #000;
}

#hero-map {
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  z-index: 1;
  opacity: 0.65;
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
  width: 80px; /* Scaled down */
  margin-bottom: 1.25rem;
  filter: drop-shadow(0 0 10px rgba(181, 9, 172, 0.4));
}

.hero-overlay h1 {
  font-size: clamp(1.8rem, 4vw, 2.6rem); /* Scaled down */
  margin-bottom: 0.75rem;
  color: #fff;
  text-shadow: 0 2px 8px rgba(0,0,0,0.4);
}

.hero-overlay p {
  font-size: clamp(0.95rem, 1.5vw, 1.1rem); /* Scaled down */
  max-width: 650px;
  margin: 0 auto 2rem auto;
  text-shadow: 0 1px 4px rgba(0,0,0,0.4);
  opacity: 0.85;
}

.dashboard-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 2.5rem;
  margin-bottom: 3rem;
  max-width: 1100px;
  margin-left: auto;
  margin-right: auto;
}

.featured-list {
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
}

/* Compact Card Styling */
.content-card {
  padding: 1.4rem;
  border: 1px solid var(--hub-border);
  border-radius: 10px;
  transition: all 0.3s ease;
  background: #fff;
}

.content-card:hover {
  border-color: var(--hub-accent);
  transform: translateY(-2px);
  box-shadow: var(--hub-shadow);
}

.content-card h3 {
  margin-top: 0;
  font-size: 1.1rem;
  color: var(--hub-accent);
  margin-bottom: 0.5rem;
}

.btn-academic {
  display: inline-block;
  padding: 0.7rem 1.6rem;
  background: var(--hub-accent);
  color: #fff !important;
  border-radius: 6px;
  text-decoration: none !important;
  font-weight: 600;
  font-size: 0.9rem;
  transition: all 0.2s;
  box-shadow: 0 4px 12px rgba(181, 9, 172, 0.3);
}

.btn-academic:hover {
  background: var(--hub-accent-hover);
  transform: translateY(-1px);
}

.sidebar-box {
  background: #fff;
  padding: 1.4rem;
  border-radius: 10px;
  margin-bottom: 1.5rem;
  border: 1px solid var(--hub-border);
}

.sidebar-box h4 {
  margin-top: 0;
  text-transform: uppercase;
  font-size: 0.7rem;
  letter-spacing: 0.1em;
  color: var(--hub-secondary);
  margin-bottom: 1rem;
  border-bottom: 2px solid var(--hub-section-bg);
  padding-bottom: 0.4rem;
}

@media (max-width: 768px) {
  .dashboard-grid {
    grid-template-columns: 1fr;
  }
  .hero-banner { height: 350px; }
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