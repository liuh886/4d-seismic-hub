---
title: Knowledge Base
layout: default
permalink: /pages/knowledge-base/
---

<style>
.kb-section {
  margin-bottom: 3rem;
}
.kb-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 1.5rem;
}
.kb-card {
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  padding: 1.5rem;
  background: #fff;
}
.kb-card h3 {
  margin-top: 0;
  color: var(--hub-accent, #B509AC);
}
.kb-card .tags {
  display: flex;
  gap: 0.5rem;
  margin-top: 1rem;
}
.tag {
  font-size: 0.75rem;
  background: #f1f5f9;
  padding: 0.2rem 0.5rem;
  border-radius: 4px;
}
.case-studies-map {
  height: 400px;
  width: 100%;
  border-radius: 8px;
  margin: 1.5rem 0;
}
</style>

# 4D Seismic Knowledge Base

A unified collection of case studies, research papers, and technical reports. Use this repository to benchmark workflows and discover operational insights.

---

## 🌍 Global Case Study Map
Explore the locations of the 4D monitoring projects documented in this hub.

<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<div id="case-studies-map" class="case-studies-map"></div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    var map = L.map('case-studies-map', { scrollWheelZoom: false }).setView([10, 0], 2);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
    var studies = {{ site.data.case_studies_map | jsonify }};
    var bounds = [];
    studies.forEach(function (study) {
      if (study.latitude && study.longitude) {
        L.marker([study.latitude, study.longitude]).addTo(map)
          .bindPopup('<strong>' + study.name + '</strong><br>' + study.location);
        bounds.push([study.latitude, study.longitude]);
      }
    });
    if (bounds.length) map.fitBounds(bounds, { padding: [40, 40] });
  });
</script>

---

## 📑 Technical Papers & Reports

{% for paper in site.data.papers %}
<article class="kb-card">
  <h3>{{ paper.title }}</h3>
  <p><strong>{{ paper.year }}</strong> | {{ paper.authors | join: ", " }}</p>
  <p>{{ paper.description }}</p>
  <a href="{{ paper.link }}" target="_blank">Access Resource &rarr;</a>
  <div class="tags">
    {% for tag in paper.tags %}<span class="tag">#{{ tag }}</span>{% endfor %}
  </div>
</article>
{% endfor %}

---

## 💡 Practical Case Studies

### 1. Middle East Carbonate OBN Monitor
**Problem:** To understand water and gas movement in a mature carbonate field. Detected subtle pressure depletion and saturation changes.
**Approach:** Repeatable node deployment combined with iterative 4D inversion. 
**Outcome:** Difference volumes highlighted pressure depletion near injection wells, allowing for reprioritization of workovers.

### 2. Hybrid OBN/Streamer Concept
**Problem:** Dense OBN grid costs vs. resolution requirements.
**Approach:** Tested sparse nodes to fill gaps in conventional towed-streamer monitor.
**Outcome:** Adopting the hybrid layout for the first monitor survey proved alternative acquisition concepts can unlock uneconomic projects.
