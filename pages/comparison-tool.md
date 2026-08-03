---
title: Interactive Comparison Tool
layout: default
permalink: /pages/comparison-tool/
classes: wide
---

<div class="hub-page-hero">
  <p class="hub-kicker">Technical benchmarking</p>
  <h1>Compare the choices behind 4D performance.</h1>
  <p>Filter global projects by sensor technology, monitoring driver, and region, then inspect how acquisition parameters and repeatability metrics vary across field settings.</p>
  <div class="hub-inline-stats">
    <span class="hub-inline-stat">Interactive map</span>
    <span class="hub-inline-stat">Linked charts and table</span>
    <span class="hub-inline-stat">Decision-oriented parameters</span>
  </div>
</div>

<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div id="tool-map" class="hub-map" role="region" aria-label="Map of projects currently included in the comparison"></div>

<div class="hub-tool-panel" aria-label="Comparison filters">
  <p class="hub-kicker">Filter projects</p>
  <div class="hub-filter-grid">
    <div class="hub-filter-group">
      <label for="filter-sensor">Sensor technology</label>
      <select id="filter-sensor">
        <option value="all">All sensors</option>
        <option value="OBN">OBN / nodes</option>
        <option value="Streamer">Streamer</option>
        <option value="PRM">Permanent / PRM</option>
        <option value="Surface">Land / surface</option>
      </select>
    </div>
    <div class="hub-filter-group">
      <label for="filter-driver">Main monitoring driver</label>
      <select id="filter-driver">
        <option value="all">All drivers</option>
        <option value="Saturation">Saturation</option>
        <option value="Pressure">Pressure</option>
        <option value="Compaction">Compaction / geomechanics</option>
        <option value="CO2">CO₂ / storage</option>
      </select>
    </div>
    <div class="hub-filter-group">
      <label for="filter-region">Region</label>
      <select id="filter-region">
        <option value="all">Global</option>
        <option value="North Sea">North Sea</option>
        <option value="West Africa">West Africa</option>
        <option value="GoM">Gulf of Mexico</option>
        <option value="China">China</option>
        <option value="Brazil">Brazil</option>
      </select>
    </div>
  </div>
</div>

<div class="hub-results-bar">
  <span id="stats-text" aria-live="polite">Loading projects…</span>
  <span>Select a row or map marker to connect the project context.</span>
</div>

<div class="hub-chart-grid">
  <section class="hub-chart-card" aria-labelledby="scatter-title">
    <h3 id="scatter-title">NRMS vs. water depth</h3>
    <div class="hub-chart-frame"><canvas id="scatterChart"></canvas></div>
  </section>
  <section class="hub-chart-card" aria-labelledby="radar-title">
    <h3 id="radar-title">Filtered technical profile</h3>
    <div class="hub-chart-frame"><canvas id="radarChart"></canvas></div>
  </section>
</div>

<div class="hub-table-wrap" role="region" aria-label="Project comparison table" tabindex="0">
  <table class="hub-table">
    <thead>
      <tr>
        <th>Project / field</th>
        <th>Sensor</th>
        <th>Bin size</th>
        <th>Repeat</th>
        <th>NRMS median</th>
        <th>Main driver</th>
        <th>Water depth</th>
      </tr>
    </thead>
    <tbody id="comparison-body"></tbody>
  </table>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
  const papers = {{ site.data.papers | jsonify }};
  const mapData = {{ site.data.case_studies_map | jsonify }};
  const tableBody = document.getElementById('comparison-body');
  const statsText = document.getElementById('stats-text');
  const mapNode = document.getElementById('tool-map');
  const map = window.L ? L.map(mapNode, { scrollWheelZoom: false }).setView([20, 0], 2) : null;

  if (map) {
    L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
      attribution: '&copy; OpenStreetMap contributors &copy; CARTO'
    }).addTo(map);
  }

  let markers = [];
  let scatterChart;
  let radarChart;

  function parseNum(value) {
    if (value === null || value === undefined || String(value).includes('N/A')) return null;
    const match = String(value).match(/[\d.]+/);
    return match ? parseFloat(match[0]) : null;
  }

  function projectName(project) {
    return project.map_id || project.title || 'Unnamed project';
  }

  function rowId(project) {
    return 'row-' + projectName(project).replace(/[^a-zA-Z0-9]+/g, '-').toLowerCase();
  }

  function average(data, field) {
    const values = data.map(function (item) { return parseNum(item[field]); }).filter(function (value) { return value !== null; });
    if (!values.length) return 0;
    return values.reduce(function (sum, value) { return sum + value; }, 0) / values.length;
  }

  function updateCharts(data) {
    if (!window.Chart) return;

    const scatterData = data.map(function (project) {
      return { x: parseNum(project.water_depth), y: parseNum(project.nrms_median), label: projectName(project) };
    }).filter(function (point) { return point.x !== null && point.y !== null; });

    if (scatterChart) scatterChart.destroy();
    scatterChart = new Chart(document.getElementById('scatterChart'), {
      type: 'scatter',
      data: { datasets: [{ label: 'Projects', data: scatterData, backgroundColor: '#0b7f82', borderColor: '#06666a', pointRadius: 5, pointHoverRadius: 7 }] },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          x: { title: { display: true, text: 'Water depth (m)' }, grid: { color: '#e4ecee' } },
          y: { title: { display: true, text: 'NRMS (%)' }, grid: { color: '#e4ecee' } }
        },
        plugins: { tooltip: { callbacks: { label: function (context) { return context.raw.label + ': ' + context.raw.x + ' m, ' + context.raw.y + '%'; } } } }
      }
    });

    if (radarChart) radarChart.destroy();
    radarChart = new Chart(document.getElementById('radarChart'), {
      type: 'radar',
      data: {
        labels: ['NRMS', 'Repeat interval', 'Bin size', 'Water depth / 20'],
        datasets: [{
          label: 'Filtered average',
          data: [average(data, 'nrms_median'), average(data, 'repeat_interval') * 10, average(data, 'bin_size'), average(data, 'water_depth') / 20],
          fill: true,
          backgroundColor: 'rgba(11, 127, 130, 0.16)',
          borderColor: '#0b7f82',
          pointBackgroundColor: '#f2a33a',
          pointBorderColor: '#ffffff'
        }]
      },
      options: { responsive: true, maintainAspectRatio: false, scales: { r: { beginAtZero: true, grid: { color: '#dfe8ea' }, angleLines: { color: '#dfe8ea' }, pointLabels: { color: '#38515d' } } } }
    });
  }

  function activateProject(project, shouldScroll) {
    document.querySelectorAll('.hub-table tbody tr').forEach(function (row) { row.classList.remove('is-active'); });
    const row = document.getElementById(rowId(project));
    if (row) {
      row.classList.add('is-active');
      if (shouldScroll) row.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }

    const marker = markers.find(function (item) { return item.options.projectId === projectName(project); });
    if (marker && map) {
      map.flyTo(marker.getLatLng(), 5, { duration: 0.8 });
      marker.openPopup();
    }
  }

  function updateDisplay() {
    const sensorFilter = document.getElementById('filter-sensor').value;
    const driverFilter = document.getElementById('filter-driver').value;
    const regionFilter = document.getElementById('filter-region').value;

    const filtered = papers.filter(function (project) {
      const sensor = String(project.sensor_type || '');
      const driver = String(project.main_driver || '');
      const tags = Array.isArray(project.tags) ? project.tags : [];
      return (sensorFilter === 'all' || sensor.includes(sensorFilter)) &&
        (driverFilter === 'all' || driver.includes(driverFilter)) &&
        (regionFilter === 'all' || tags.some(function (tag) { return String(tag).includes(regionFilter); }));
    });

    updateCharts(filtered);
    tableBody.innerHTML = '';

    if (!filtered.length) {
      tableBody.innerHTML = '<tr><td colspan="7" class="hub-empty">No projects match this filter combination.</td></tr>';
    } else {
      filtered.forEach(function (project) {
        const row = document.createElement('tr');
        row.id = rowId(project);
        row.tabIndex = 0;
        row.innerHTML =
          '<td><strong>' + projectName(project) + '</strong><br><small>' + (project.year || 'Year not stated') + '</small></td>' +
          '<td><span class="hub-sensor-badge">' + (project.sensor_type || 'N/A') + '</span></td>' +
          '<td>' + (project.bin_size || 'N/A') + '</td>' +
          '<td>' + (project.repeat_interval || 'N/A') + '</td>' +
          '<td><span class="hub-nrms-badge">' + (project.nrms_median || 'N/A') + '</span></td>' +
          '<td>' + (project.main_driver || 'N/A') + '</td>' +
          '<td>' + (project.water_depth || 'N/A') + '</td>';
        row.addEventListener('click', function () { activateProject(project, false); });
        row.addEventListener('keydown', function (event) { if (event.key === 'Enter' || event.key === ' ') { event.preventDefault(); activateProject(project, false); } });
        tableBody.appendChild(row);
      });
    }

    if (map) {
      markers.forEach(function (marker) { map.removeLayer(marker); });
      markers = [];
      filtered.forEach(function (project) {
        const location = mapData.find(function (item) { return item.name === project.map_id; });
        if (!location || !location.latitude || !location.longitude) return;
        const marker = L.circleMarker([location.latitude, location.longitude], {
          radius: 7,
          fillColor: '#0b7f82',
          color: '#ffffff',
          weight: 2,
          opacity: 1,
          fillOpacity: 0.9,
          projectId: projectName(project)
        }).addTo(map);
        marker.bindPopup('<strong>' + location.name + '</strong><br><span style="color:#536975">' + location.summary + '</span>');
        marker.on('click', function () { activateProject(project, true); });
        markers.push(marker);
      });
      if (markers.length) map.fitBounds(L.featureGroup(markers).getBounds().pad(0.12));
    }

    statsText.innerHTML = '<strong>' + filtered.length + '</strong> projects in the current comparison';
  }

  ['filter-sensor', 'filter-driver', 'filter-region'].forEach(function (id) {
    document.getElementById(id).addEventListener('change', updateDisplay);
  });

  updateDisplay();
});
</script>
