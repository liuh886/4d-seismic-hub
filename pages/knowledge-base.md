---
title: Knowledge Base
layout: default
permalink: /pages/knowledge-base/
---

<style>
.kb-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 1.5rem;
  margin-top: 1.5rem;
}
.kb-card {
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  padding: 1.5rem;
  background: #fff;
  transition: all 0.2s ease;
  display: flex;
  flex-direction: column;
}
.kb-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  border-color: var(--hub-accent, #B509AC);
}
.kb-card h3 {
  margin-top: 0;
  color: var(--hub-accent, #B509AC);
  font-size: 1.15rem;
  margin-bottom: 0.5rem;
}
.kb-card .meta {
  font-size: 0.8rem;
  color: #64748b;
  margin-bottom: 1rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}
.kb-card .summary {
  font-size: 0.95rem;
  line-height: 1.6;
  color: #334155;
  flex-grow: 1;
}
.tag-container {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin-top: 1rem;
}
.tag {
  font-size: 0.7rem;
  background: #f1f5f9;
  padding: 0.2rem 0.5rem;
  border-radius: 4px;
  color: #475569;
}
.section-header {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  border-bottom: 2px solid #f1f5f9;
  padding-bottom: 0.5rem;
  margin-top: 3rem;
  margin-bottom: 1.5rem;
}
.section-header h2 {
  margin: 0;
  font-size: 1.75rem;
}
</style>

# 4D Seismic Knowledge Base

A unified collection of case studies, research papers, and technical reports. Use this repository to benchmark workflows and discover operational insights.

<div style="margin: 2rem 0; padding: 1rem; background: #f8fafc; border-radius: 8px; border: 1px solid #e2e8f0;">
  <input type="text" id="kb-search" placeholder="🔍 Search by title, author, or tags..." 
    style="width: 100%; padding: 0.75rem; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 1rem;">
</div>

---

<div class="section-header">
  <h2>🌍 Global Case Study Map</h2>
</div>

Explore the locations of the 4D monitoring projects documented in this hub. Click markers for a quick summary.

<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<div id="case-studies-map" style="height: 450px; width: 100%; border-radius: 12px; margin: 1.5rem 0; border: 1px solid #e2e8f0; z-index: 1;"></div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    var map = L.map('case-studies-map', { scrollWheelZoom: false }).setView([20, 0], 2);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);
    var studies = {{ site.data.case_studies_map | jsonify }};
    var markers = [];
    studies.forEach(function (study) {
      if (study.latitude && study.longitude) {
        var marker = L.marker([study.latitude, study.longitude]).addTo(map);
        marker.bindPopup('<strong>' + study.name + '</strong><br>' + study.location + '<p style="font-size:0.8rem; margin-top:0.5rem;">' + study.summary + '</p>');
        markers.push(marker);
      }
    });
    
    // Auto-fit bounds if markers exist
    if (markers.length > 0) {
      var group = new L.featureGroup(markers);
      map.fitBounds(group.getBounds().pad(0.1));
    }

    // Live Search Logic
    const searchInput = document.getElementById('kb-search');
    const cards = document.querySelectorAll('.kb-card');

    searchInput.addEventListener('input', function() {
      const query = this.value.toLowerCase();
      cards.forEach(card => {
        const text = card.innerText.toLowerCase();
        card.style.display = text.includes(query) ? 'flex' : 'none';
      });
      
      // Hide headers if no cards visible in a section
      document.querySelectorAll('.section-header').forEach(header => {
        let next = header.nextElementSibling;
        let hasVisible = false;
        while(next && !next.classList.contains('section-header')) {
          if(next.classList.contains('kb-grid')) {
             if([...next.children].some(c => c.style.display !== 'none')) hasVisible = true;
          }
          next = next.nextElementSibling;
        }
        header.style.display = hasVisible ? 'flex' : 'none';
      });
    });
  });
</script>

<div class="section-header">
  <h2>💡 Practical Case Summaries</h2>
</div>

<div class="kb-grid">
{% for case in site.data.case_studies_map %}
  <article class="kb-card">
    <h3>{{ case.name }}</h3>
    <div class="meta">{{ case.location }}</div>
    <div class="summary">{{ case.summary }}</div>
  </article>
{% endfor %}
</div>

<div class="section-header">
  <h2>📑 Technical Papers & Reports</h2>
</div>

<div class="kb-grid">
{% for paper in site.data.papers %}
  <article class="kb-card">
    <h3>{{ paper.title }}</h3>
    <div class="meta">{{ paper.year }} | {{ paper.authors | first }} et al.</div>
    <div class="summary">{{ paper.description }}</div>
    <div style="margin-top: 1rem;">
      <a href="{{ paper.link }}" target="_blank" style="color: var(--hub-accent, #B509AC); font-weight: 600; text-decoration: none; font-size: 0.9rem;">Access Resource &rarr;</a>
    </div>
    <div class="tag-container">
      {% for tag in paper.tags %}<span class="tag">#{{ tag }}</span>{% endfor %}
    </div>
  </article>
{% endfor %}
</div>
