---
title: Knowledge Base
layout: default
permalink: /pages/knowledge-base/
classes: wide
---

{% assign case_count = site.data.case_studies_map | size %}
{% assign paper_count = site.data.papers | size %}

<div class="hub-page-hero">
  <p class="hub-kicker">Case library</p>
  <h1>4D seismic evidence, organized for project work.</h1>
  <p>Browse documented monitoring projects, locate comparable reservoir settings, and move from a project name to the technical choices and field evidence behind it.</p>
  <div class="hub-inline-stats">
    <span class="hub-inline-stat"><strong>{{ case_count }}</strong> monitoring projects</span>
    <span class="hub-inline-stat"><strong>{{ paper_count }}</strong> technical resources</span>
    <span class="hub-inline-stat">Map + searchable library</span>
  </div>
</div>

<div class="hub-tool-panel">
  <label for="kb-search" class="hub-kicker">Search the collection</label>
  <div class="hub-search-wrap">
    <input class="hub-search" type="search" id="kb-search" placeholder="Search title, location, author, summary, or tag" autocomplete="off">
  </div>
  <div class="hub-results-bar"><span id="kb-results" aria-live="polite">Showing the full collection</span><a href="{{ '/pages/comparison-tool/' | relative_url }}">Need a parameter comparison? →</a></div>
</div>

<section class="hub-block" aria-labelledby="atlas-heading">
  <div class="hub-block-heading"><h2 id="atlas-heading">Global monitoring atlas</h2></div>
  <p>Use the map to understand geographic coverage and open a concise project summary. The library cards below contain the reusable technical context.</p>
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">
  <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
  <div id="case-studies-map" class="hub-map" role="region" aria-label="Map of documented 4D seismic case studies"></div>
</section>

<section class="hub-block" aria-labelledby="cases-heading">
  <div class="hub-block-heading"><h2 id="cases-heading">Practical case summaries</h2></div>
  <div class="hub-library-grid" id="case-library">
    {% for case in site.data.case_studies_map %}
      {% if case.post_url %}
      <a class="hub-library-card kb-search-item" href="{{ case.post_url | relative_url }}" data-kind="case">
        <span class="hub-library-card__meta">{{ case.location }}</span>
        <h3>{{ case.name }}</h3>
        <p>{{ case.summary }}</p>
        <div class="hub-library-card__footer"><span class="hub-tag">Case study</span><span class="hub-tag">Analysis available</span></div>
      </a>
      {% else %}
      <article class="hub-library-card kb-search-item" data-kind="case">
        <span class="hub-library-card__meta">{{ case.location }}</span>
        <h3>{{ case.name }}</h3>
        <p>{{ case.summary }}</p>
        <div class="hub-library-card__footer"><span class="hub-tag">Case study</span></div>
      </article>
      {% endif %}
    {% endfor %}
  </div>
</section>

<section class="hub-block" aria-labelledby="papers-heading">
  <div class="hub-block-heading"><h2 id="papers-heading">Technical papers and reports</h2></div>
  <div class="hub-library-grid" id="paper-library">
    {% for paper in site.data.papers %}
    <a class="hub-library-card kb-search-item" data-kind="paper" href="{{ paper.link }}" target="_blank" rel="noopener">
      <span class="hub-library-card__meta">{{ paper.year }} · {{ paper.authors | first }}{% if paper.authors.size > 1 %} et al.{% endif %}</span>
      <h3>{{ paper.title }}</h3>
      <p>{{ paper.description }}</p>
      <div class="hub-library-card__footer">
        {% for tag in paper.tags limit:4 %}<span class="hub-tag">{{ tag }}</span>{% endfor %}
      </div>
    </a>
    {% endfor %}
  </div>
</section>

<script>
document.addEventListener('DOMContentLoaded', function () {
  const mapNode = document.getElementById('case-studies-map');
  const studies = {{ site.data.case_studies_map | jsonify }};

  if (mapNode && window.L) {
    const map = L.map(mapNode, { scrollWheelZoom: false }).setView([20, 0], 2);
    L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
      attribution: '&copy; OpenStreetMap contributors &copy; CARTO'
    }).addTo(map);

    const markers = [];
    studies.forEach(function (study) {
      if (study.latitude && study.longitude) {
        const marker = L.circleMarker([study.latitude, study.longitude], {
          radius: 7,
          fillColor: '#0b7f82',
          color: '#ffffff',
          weight: 2,
          opacity: 1,
          fillOpacity: 0.88
        }).addTo(map);
        marker.bindPopup(
          '<div style="min-width:210px">' +
          '<strong style="color:#071923;font-size:1rem">' + study.name + '</strong>' +
          '<div style="margin:.25rem 0 .6rem;color:#0b7f82;font-size:.72rem;font-weight:700;text-transform:uppercase;letter-spacing:.05em">' + study.location + '</div>' +
          '<div style="color:#536975;font-size:.84rem;line-height:1.45">' + study.summary + '</div>' +
          '</div>'
        );
        markers.push(marker);
      }
    });

    if (markers.length) {
      map.fitBounds(L.featureGroup(markers).getBounds().pad(0.08));
    }
  }

  const input = document.getElementById('kb-search');
  const resultText = document.getElementById('kb-results');
  const items = Array.from(document.querySelectorAll('.kb-search-item'));

  function filterLibrary() {
    const query = input.value.trim().toLowerCase();
    let visible = 0;
    items.forEach(function (item) {
      const matches = !query || item.textContent.toLowerCase().includes(query);
      item.hidden = !matches;
      if (matches) visible += 1;
    });
    resultText.textContent = query ? 'Showing ' + visible + ' matching resources' : 'Showing the full collection';
  }

  input.addEventListener('input', filterLibrary);
});
</script>
