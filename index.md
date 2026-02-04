---
title: "Dashboard"
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
  --hub-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
}

body {
  font-family: 'Inter', sans-serif;
  color: var(--hub-primary);
}

h1, h2, h3 {
  font-family: 'Merriweather', serif;
}

.hero {
  padding: 4rem 1rem;
  text-align: center;
  border-bottom: 1px solid var(--hub-border);
  margin-bottom: 2rem;
  background: linear-gradient(to bottom, #fff, var(--hub-section-bg));
}

.hero img.logo {
  width: 140px;
  margin-bottom: 1.5rem;
  filter: drop-shadow(0 4px 6px rgba(0,0,0,0.1));
}

/* Responsive Typography Fix */
.hero h1 {
  font-size: clamp(2rem, 5vw, 3rem);
  margin-bottom: 1rem;
  line-height: 1.2;
  font-weight: 700;
  color: var(--hub-primary);
}

.hero p {
  font-size: clamp(1.1rem, 2vw, 1.25rem);
  color: var(--hub-secondary);
  max-width: 800px;
  margin: 0 auto 2.5rem auto;
  line-height: 1.6;
}

.dashboard-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 3rem;
  margin-bottom: 4rem;
}

.featured-list {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.content-card {
  padding: 1.75rem;
  border: 1px solid var(--hub-border);
  border-radius: 12px;
  transition: all 0.3s ease;
  background: #fff;
}

.content-card:hover {
  border-color: var(--hub-accent);
  transform: translateY(-3px);
  box-shadow: var(--hub-shadow);
}

.content-card h3 {
  margin-top: 0;
  font-size: 1.25rem;
  color: var(--hub-accent);
}

.btn-academic {
  display: inline-block;
  padding: 0.8rem 1.8rem;
  background: var(--hub-accent);
  color: #fff !important;
  border-radius: 6px;
  text-decoration: none !important;
  font-weight: 600;
  transition: all 0.2s;
  box-shadow: 0 4px 14px 0 rgba(181, 9, 172, 0.39);
}

.btn-academic:hover {
  background: var(--hub-accent-hover);
  transform: scale(1.05);
}

.sidebar-box {
  background: #fff;
  padding: 1.75rem;
  border-radius: 12px;
  margin-bottom: 2rem;
  border: 1px solid var(--hub-border);
  box-shadow: 0 2px 4px rgba(0,0,0,0.02);
}

.sidebar-box h4 {
  margin-top: 0;
  text-transform: uppercase;
  font-size: 0.75rem;
  letter-spacing: 0.1em;
  color: var(--hub-secondary);
  margin-bottom: 1.25rem;
  border-bottom: 2px solid var(--hub-section-bg);
  padding-bottom: 0.5rem;
}

@media (max-width: 768px) {
  .dashboard-grid {
    grid-template-columns: 1fr;
  }
}
</style>

<style>
:root {
  --hub-primary: #1a202c;
  --hub-secondary: #4a5568;
  --hub-accent: #B509AC;
  --hub-accent-hover: #9d00e8;
  --hub-bg: #ffffff;
  --hub-section-bg: #f8fafc;
  --hub-border: #e2e8f0;
  --hub-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

body {
  font-family: 'Inter', sans-serif;
  color: var(--hub-primary);
}

h1, h2, h3 {
  font-family: 'Merriweather', serif;
}

/* Rolling Map Hero */
.hero-banner {
  position: relative;
  height: 500px;
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
  opacity: 0.7; /* Make it darker for text contrast */
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
  background: radial-gradient(circle, rgba(0,0,0,0.2) 0%, rgba(0,0,0,0.6) 100%);
  color: white;
  padding: 1rem;
}

.hero-overlay img.logo {
  width: 100px;
  margin-bottom: 1.5rem;
  filter: drop-shadow(0 0 12px rgba(181, 9, 172, 0.5));
}

.hero-overlay h1 {
  font-size: clamp(2.2rem, 6vw, 3.5rem);
  margin-bottom: 1rem;
  color: #fff;
  text-shadow: 0 2px 10px rgba(0,0,0,0.5);
}

.hero-overlay p {
  font-size: clamp(1.1rem, 2vw, 1.3rem);
  max-width: 800px;
  margin: 0 auto 2.5rem auto;
  text-shadow: 0 1px 5px rgba(0,0,0,0.5);
  opacity: 0.9;
}

.dashboard-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 3rem;
  margin-bottom: 4rem;
}

/* Card Styling */
.content-card {
  padding: 1.75rem;
  border: 1px solid var(--hub-border);
  border-radius: 12px;
  transition: all 0.3s ease;
  background: #fff;
}

.content-card:hover {
  border-color: var(--hub-accent);
  transform: translateY(-3px);
  box-shadow: var(--hub-shadow);
}

.btn-academic {
  display: inline-block;
  padding: 1rem 2.2rem;
  background: var(--hub-accent);
  color: #fff !important;
  border-radius: 8px;
  text-decoration: none !important;
  font-weight: 600;
  transition: all 0.2s;
  box-shadow: 0 4px 14px 0 rgba(181, 9, 172, 0.4);
}

.btn-academic:hover {
  background: var(--hub-accent-hover);
  transform: translateY(-2px);
  box-shadow: 0 6px 20px 0 rgba(181, 9, 172, 0.5);
}

@media (max-width: 768px) {
  .dashboard-grid {
    grid-template-columns: 1fr;
  }
  .hero-banner { height: 400px; }
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
  // Use a dark, professional tile set
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

  // Add subtle purple glowing markers
  locations.forEach(function(loc) {
    if (loc.latitude) {
      L.circleMarker([loc.latitude, loc.longitude], {
        radius: 6,
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
        duration: 12 // Even slower, more cinematic move
      });
    }
    currentIndex = (currentIndex + 1) % locations.length;
  }

  // Start rolling
  rollToNextLocation();
  setInterval(rollToNextLocation, 24000); // Change location every 24 seconds
});
</script>

<div class="dashboard-grid">
  <main class="featured-list">
    <h2 style="font-size: 1.5rem; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.5rem;">
      <span style="font-size: 1.2rem;">✨</span> Featured Insights
    </h2>

    {% for paper in site.data.papers limit:3 %}
    <article class="content-card">
      <h3 style="margin-bottom: 0.75rem; color: var(--hub-accent);">{{ paper.title }}</h3>
      <p style="color: var(--hub-secondary); line-height: 1.5; font-size: 0.95rem;">{{ paper.description | truncate: 160 }}</p>
      <a href="{{ paper.link }}" target="_blank" style="color: var(--hub-accent); font-weight: 600; text-decoration: none; font-size: 0.9rem;">Read Paper &rarr;</a>
    </article>
    {% endfor %}

    <a href="{{ '/pages/knowledge-base' | relative_url }}" style="text-align: center; margin-top: 1rem; color: var(--hub-secondary); text-decoration: none; font-size: 0.9rem; font-weight: 500;">View all resources...</a>
  </main>

  <aside>
    <div class="sidebar-box" style="background: #fff; padding: 1.75rem; border-radius: 12px; border: 1px solid var(--hub-border); margin-bottom: 2rem;">
      <h4 style="text-transform: uppercase; font-size: 0.75rem; letter-spacing: 0.1em; color: var(--hub-secondary); margin-bottom: 1rem; border-bottom: 2px solid var(--hub-section-bg); padding-bottom: 0.5rem;">Working Group</h4>
      <p style="font-size: 0.9rem; line-height: 1.6;">Maintainers of the 4D Seismic Hub. We rely on volunteers for peer-reviewed content curation.</p>
      <a href="{{ '/pages/contribute' | relative_url }}" style="font-weight: 600; color: var(--hub-accent); text-decoration: none; font-size: 0.9rem;">Join the Initiative &rarr;</a>
    </div>

    <div class="sidebar-box" style="background: #fff; padding: 1.75rem; border-radius: 12px; border: 1px solid var(--hub-border); border-left: 4px solid var(--hub-accent);">
      <h4 style="text-transform: uppercase; font-size: 0.75rem; letter-spacing: 0.1em; color: var(--hub-secondary); margin-bottom: 1rem; border-bottom: 2px solid var(--hub-section-bg); padding-bottom: 0.5rem;">Featured Case</h4>
      {% assign featured_case = site.data.case_studies_map | first %}
      <p style="margin-bottom: 0.5rem;"><strong>{{ featured_case.name }}</strong></p>
      <p style="font-size: 0.9rem; color: var(--hub-secondary); line-height: 1.5;">{{ featured_case.summary }}</p>
      <a href="{{ '/pages/knowledge-base' | relative_url }}" style="font-weight: 600; color: var(--hub-accent); text-decoration: none; font-size: 0.9rem;">Explore Full Map &rarr;</a>
    </div>
  </aside>
</div>
