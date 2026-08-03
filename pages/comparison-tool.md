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
    <span class="hub-inline-stat">Explicit metric handling</span>
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

<div id="benchmark-summary" class="hub-benchmark-summary" aria-live="polite"></div>

<div class="hub-chart-grid">
  <section class="hub-chart-card" aria-labelledby="scatter-title">
    <h3 id="scatter-title">NRMS vs. water depth</h3>
    <div class="hub-chart-frame"><canvas id="scatterChart" role="img" aria-label="Scatter plot of NRMS against water depth for plottable projects"></canvas></div>
    <p class="hub-chart-note">Ranges are plotted at their midpoint. Approximate and estimated values retain their original labels in the tooltip. Censored values such as “&lt;10%” and non-applicable values are not plotted as exact points.</p>
  </section>
  <section class="hub-chart-card" aria-labelledby="coverage-title">
    <h3 id="coverage-title">Data completeness for current filter</h3>
    <div class="hub-chart-frame"><canvas id="coverageChart" role="img" aria-label="Percentage of filtered projects with reported benchmark values"></canvas></div>
    <p class="hub-chart-note">Coverage is a percentage of filtered records with a reported value. It does not compare the magnitude or quality of unlike engineering metrics.</p>
  </section>
</div>

<details class="hub-methodology">
  <summary>How the benchmark metrics are handled</summary>
  <div class="hub-methodology__body">
    <ul>
      <li>Each median is calculated in its own unit; unlike metrics are never combined into one score.</li>
      <li>Numeric ranges use the midpoint only for plotting and summary calculations, while the original range remains visible in tooltips and the table.</li>
      <li>Censored values using “&lt;” or “&gt;” are counted as reported for data coverage but excluded from point estimates.</li>
      <li>Repeat intervals are converted to years before calculating the median; months and weeks are converted proportionally.</li>
      <li>Land projects and fields marked N/A are excluded from water-depth calculations rather than assigned a zero.</li>
    </ul>
  </div>
</details>

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
  const summaryNode = document.getElementById('benchmark-summary');
  const mapNode = document.getElementById('tool-map');
  const map = window.L ? L.map(mapNode, { scrollWheelZoom: false }).setView([20, 0], 2) : null;

  if (map) {
    L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
      attribution: '&copy; OpenStreetMap contributors &copy; CARTO'
    }).addTo(map);
  }

  let markers = [];
  let scatterChart;
  let coverageChart;

  function hasReportedValue(value) {
    const text = value === null || value === undefined ? '' : String(value).trim();
    return Boolean(text) && !/\bN\/A\b/i.test(text) && !/not (stated|recorded)/i.test(text);
  }

  function parseMetric(value) {
    const raw = value === null || value === undefined ? '' : String(value).trim();
    if (!hasReportedValue(raw)) return { value: null, raw: raw, method: 'missing' };
    if (/^[<>≤≥]/.test(raw)) return { value: null, raw: raw, method: 'censored' };

    const range = raw.match(/(\d+(?:\.\d+)?)\s*(?:-|–|—|to)\s*(\d+(?:\.\d+)?)/i);
    if (range) {
      const lower = parseFloat(range[1]);
      const upper = parseFloat(range[2]);
      return { value: (lower + upper) / 2, raw: raw, method: 'range midpoint' };
    }

    const number = raw.match(/\d+(?:\.\d+)?/);
    if (!number) return { value: null, raw: raw, method: 'unparsed' };
    const method = /~|approx|estimated|variable/i.test(raw) ? 'approximate' : 'reported';
    return { value: parseFloat(number[0]), raw: raw, method: method };
  }

  function parseDurationYears(value) {
    const parsed = parseMetric(value);
    if (parsed.value === null) return parsed;
    const raw = parsed.raw.toLowerCase();
    let years = parsed.value;
    if (/month/.test(raw)) years = years / 12;
    if (/week/.test(raw)) years = years / 52;
    return { value: years, raw: parsed.raw, method: parsed.method };
  }

  function projectName(project) {
    return project.map_id || project.title || 'Unnamed project';
  }

  function rowId(project) {
    return 'row-' + projectName(project).replace(/[^a-zA-Z0-9]+/g, '-').toLowerCase();
  }

  function parsedValues(data, field, parser) {
    return data.map(function (item) { return parser(item[field]); })
      .filter(function (item) { return item.value !== null && Number.isFinite(item.value); });
  }

  function median(items) {
    if (!items.length) return null;
    const sorted = items.map(function (item) { return item.value; }).sort(function (a, b) { return a - b; });
    const middle = Math.floor(sorted.length / 2);
    return sorted.length % 2 ? sorted[middle] : (sorted[middle - 1] + sorted[middle]) / 2;
  }

  function coverage(data, field) {
    if (!data.length) return 0;
    const reported = data.filter(function (item) { return hasReportedValue(item[field]); }).length;
    return Math.round((reported / data.length) * 100);
  }

  function formatNumber(value, digits) {
    if (value === null) return '—';
    return value.toLocaleString(undefined, { maximumFractionDigits: digits });
  }

  function formatYears(value) {
    if (value === null) return '—';
    if (value < 1) return formatNumber(value * 12, 1) + ' mo';
    return formatNumber(value, 2) + ' yr';
  }

  function summaryCard(label, value, detail) {
    return '<article class="hub-benchmark-stat"><span>' + label + '</span><strong>' + value + '</strong><small>' + detail + '</small></article>';
  }

  function updateSummary(data) {
    const total = data.length;
    const nrms = parsedValues(data, 'nrms_median', parseMetric);
    const repeat = parsedValues(data, 'repeat_interval', parseDurationYears);
    const bin = parsedValues(data, 'bin_size', parseMetric);
    const depth = parsedValues(data, 'water_depth', parseMetric);

    summaryNode.innerHTML =
      summaryCard('Median plottable NRMS', median(nrms) === null ? '—' : formatNumber(median(nrms), 1) + '%', nrms.length + ' of ' + total + ' records used') +
      summaryCard('Median repeat interval', formatYears(median(repeat)), repeat.length + ' of ' + total + ' records used') +
      summaryCard('Median first bin dimension', median(bin) === null ? '—' : formatNumber(median(bin), 2) + ' m', bin.length + ' of ' + total + ' records used') +
      summaryCard('Median water depth', median(depth) === null ? '—' : formatNumber(median(depth), 0) + ' m', depth.length + ' of ' + total + ' records used');
  }

  function updateCharts(data) {
    const scatterData = data.map(function (project) {
      const depth = parseMetric(project.water_depth);
      const nrms = parseMetric(project.nrms_median);
      if (depth.value === null || nrms.value === null) return null;
      return {
        x: depth.value,
        y: nrms.value,
        label: projectName(project),
        depthRaw: depth.raw,
        nrmsRaw: nrms.raw,
        depthMethod: depth.method,
        nrmsMethod: nrms.method
      };
    }).filter(Boolean);

    if (!window.Chart) return scatterData.length;

    if (scatterChart) scatterChart.destroy();
    scatterChart = new Chart(document.getElementById('scatterChart'), {
      type: 'scatter',
      data: { datasets: [{ label: 'Projects', data: scatterData, backgroundColor: '#0b7f82', borderColor: '#06666a', pointRadius: 5, pointHoverRadius: 7 }] },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        parsing: false,
        scales: {
          x: { title: { display: true, text: 'Water depth plot estimate (m)' }, grid: { color: '#e4ecee' } },
          y: { title: { display: true, text: 'NRMS plot estimate (%)' }, grid: { color: '#e4ecee' } }
        },
        plugins: {
          legend: { display: false },
          tooltip: {
            callbacks: {
              title: function (items) { return items.length ? items[0].raw.label : ''; },
              label: function (context) {
                return [
                  'Water depth: ' + context.raw.depthRaw + ' (' + context.raw.depthMethod + ')',
                  'NRMS: ' + context.raw.nrmsRaw + ' (' + context.raw.nrmsMethod + ')'
                ];
              }
            }
          }
        }
      }
    });

    const coverageData = [
      coverage(data, 'nrms_median'),
      coverage(data, 'repeat_interval'),
      coverage(data, 'bin_size'),
      coverage(data, 'water_depth')
    ];

    if (coverageChart) coverageChart.destroy();
    coverageChart = new Chart(document.getElementById('coverageChart'), {
      type: 'bar',
      data: {
        labels: ['NRMS', 'Repeat interval', 'Bin size', 'Water depth'],
        datasets: [{ label: 'Reported records', data: coverageData, backgroundColor: 'rgba(11, 127, 130, 0.72)', borderColor: '#06666a', borderWidth: 1 }]
      },
      options: {
        indexAxis: 'y',
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          x: { beginAtZero: true, max: 100, title: { display: true, text: 'Reported records (%)' }, grid: { color: '#e4ecee' } },
          y: { grid: { display: false } }
        },
        plugins: {
          legend: { display: false },
          tooltip: { callbacks: { label: function (context) { return context.raw + '% of filtered projects'; } } }
        }
      }
    });

    return scatterData.length;
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

    updateSummary(filtered);
    const plottedCount = updateCharts(filtered);
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
        if (!location || location.latitude === null || location.latitude === undefined || location.longitude === null || location.longitude === undefined) return;
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

    statsText.innerHTML = '<strong>' + filtered.length + '</strong> projects in the current comparison; <strong>' + plottedCount + '</strong> have plottable NRMS and water-depth values';
  }

  ['filter-sensor', 'filter-driver', 'filter-region'].forEach(function (id) {
    document.getElementById(id).addEventListener('change', updateDisplay);
  });

  updateDisplay();
});
</script>
