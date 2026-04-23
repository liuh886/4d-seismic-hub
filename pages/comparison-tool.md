---
title: Interactive Comparison Tool
layout: default
permalink: /pages/comparison-tool/
---

<style>
/* Engineering Table Style */
.comparison-container {
  max-width: 100%;
  margin: 1rem 0;
  font-family: 'Segoe UI', system-ui, sans-serif;
}

#tool-map {
  height: 400px;
  width: 100%;
  border-radius: 12px;
  border: 1px solid #e2e8f0;
  margin-bottom: 2rem;
  z-index: 1;
}

.filter-bar {
  background: #f8fafc;
  padding: 1.5rem;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
  display: flex;
  flex-wrap: wrap;
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.filter-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.filter-group label {
  font-size: 0.75rem;
  font-weight: 700;
  text-transform: uppercase;
  color: #64748b;
  letter-spacing: 0.05em;
}

.filter-group select {
  padding: 0.5rem;
  border-radius: 6px;
  border: 1px solid #cbd5e1;
  background: white;
  min-width: 160px;
  font-size: 0.9rem;
}

.comparison-table-wrapper {
  overflow-x: auto;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
}

.comparison-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.85rem;
  background: white;
}

.comparison-table th {
  background: #f1f5f9;
  text-align: left;
  padding: 1rem;
  border-bottom: 2px solid #e2e8f0;
  white-space: nowrap;
  color: #475569;
  font-weight: 600;
}

.comparison-table td {
  padding: 0.85rem 1rem;
  border-bottom: 1px solid #f1f5f9;
  color: #1e293b;
}

.comparison-table tr:hover {
  background: #f8fafc;
}

.comparison-table tr.highlighted {
  background: rgba(181, 9, 172, 0.05) !important;
  border-left: 4px solid var(--hub-accent, #B509AC);
}

.tag-sensor {
  background: #eff6ff;
  color: #1d4ed8;
  padding: 2px 6px;
  border-radius: 4px;
  font-size: 0.7rem;
  font-weight: 600;
}

.nrms-badge {
  font-weight: 700;
  color: #059669;
}

.stats-counter {
  font-size: 0.9rem;
  color: #64748b;
  margin-bottom: 1rem;
}
</style>

# 4D Technical Benchmarking

Use this interactive tool to compare technical parameters across global 4D monitoring projects. Select filters to narrow down by technology or objective.

<div class="comparison-container">
  
  <!-- Map Integration -->
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
  <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <div id="tool-map"></div>

  <!-- Filters -->
  <div class="filter-bar">
    <div class="filter-group">
      <label>Sensor Technology</label>
      <select id="filter-sensor">
        <option value="all">All Sensors</option>
        <option value="OBN">OBN / Nodes</option>
        <option value="Streamer">Streamer</option>
        <option value="PRM">Permanent (PRM)</option>
        <option value="Surface">Land / Surface</option>
      </select>
    </div>

    <div class="filter-group">
      <label>Main Driver</label>
      <select id="filter-driver">
        <option value="all">All Drivers</option>
        <option value="Saturation">Saturation</option>
        <option value="Pressure">Pressure</option>
        <option value="Compaction">Compaction / Geomechanics</option>
        <option value="CO2">CO2 / Storage</option>
      </select>
    </div>

    <div class="filter-group">
      <label>Region</label>
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

  <div class="stats-counter" id="stats-text">Showing 20 projects</div>

  <!-- Visualization Charts -->
  <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 2rem;">
    <div style="background: #fff; border: 1px solid #e2e8f0; border-radius: 8px; padding: 1rem;">
      <h4 style="margin-top:0; font-size: 0.9rem; color: #475569;">NRMS vs. Water Depth</h4>
      <canvas id="scatterChart" height="250"></canvas>
    </div>
    <div style="background: #fff; border: 1px solid #e2e8f0; border-radius: 8px; padding: 1rem;">
      <h4 style="margin-top:0; font-size: 0.9rem; color: #475569;">Technical Benchmarking (Avg)</h4>
      <canvas id="radarChart" height="250"></canvas>
    </div>
  </div>

  <!-- Table -->
  <div class="comparison-table-wrapper">
    <table class="comparison-table">
      <thead>
        <tr>
          <th>Project / Field</th>
          <th>Sensor</th>
          <th>Bin Size</th>
          <th>Repeat</th>
          <th>NRMS (Median)</th>
          <th>Main Driver</th>
          <th>Water Depth</th>
        </tr>
      </thead>
      <tbody id="comparison-body">
        <!-- JS populated -->
      </tbody>
    </table>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
  const papers = {{ site.data.papers | jsonify }};
  const mapData = {{ site.data.case_studies_map | jsonify }};
  const tableBody = document.getElementById('comparison-body');
  const statsText = document.getElementById('stats-text');
  
  // Initialize Map
  const map = L.map('tool-map').setView([20, 0], 2);
  L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png').addTo(map);
  
  let markers = [];
  let scatterChart, radarChart;

  const parseNum = (str) => {
    if (!str || String(str).includes('N/A')) return null;
    const m = String(str).match(/[\d\.]+/);
    return m ? parseFloat(m[0]) : null;
  };

  function updateCharts(data) {
    const scatterData = data.map(p => ({
      x: parseNum(p.water_depth),
      y: parseNum(p.nrms_median),
      label: p.map_id
    })).filter(d => d.x !== null && d.y !== null);

    const avgNRMS = data.reduce((acc, p) => acc + (parseNum(p.nrms_median) || 0), 0) / data.length || 0;
    const avgRepeat = data.reduce((acc, p) => acc + (parseNum(p.repeat_interval) || 0), 0) / data.length || 0;
    const avgBin = data.reduce((acc, p) => acc + (parseNum(p.bin_size) || 0), 0) / data.length || 0;
    const avgDepth = data.reduce((acc, p) => acc + (parseNum(p.water_depth) || 0), 0) / data.length || 0;

    if (scatterChart) scatterChart.destroy();
    scatterChart = new Chart(document.getElementById('scatterChart'), {
      type: 'scatter',
      data: {
        datasets: [{
          label: 'Projects',
          data: scatterData,
          backgroundColor: '#B509AC'
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          x: { title: { display: true, text: 'Water Depth (m)' } },
          y: { title: { display: true, text: 'NRMS (%)' } }
        },
        plugins: {
          tooltip: {
            callbacks: {
              label: (ctx) => ctx.raw.label + ': (' + ctx.raw.x + 'm, ' + ctx.raw.y + '%)'
            }
          }
        }
      }
    });

    if (radarChart) radarChart.destroy();
    radarChart = new Chart(document.getElementById('radarChart'), {
      type: 'radar',
      data: {
        labels: ['NRMS', 'Repeat Interval', 'Bin Size', 'Water Depth (scaled)'],
        datasets: [{
          label: 'Filtered Avg',
          data: [avgNRMS, avgRepeat * 10, avgBin, avgDepth / 20],
          fill: true,
          backgroundColor: 'rgba(181, 9, 172, 0.2)',
          borderColor: '#B509AC',
          pointBackgroundColor: '#B509AC'
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          r: { beginAtZero: true, max: 50 }
        }
      }
    });
  }

  function updateDisplay() {
    const sensorFilter = document.getElementById('filter-sensor').value;
    const driverFilter = document.getElementById('filter-driver').value;
    const regionFilter = document.getElementById('filter-region').value;

    const filtered = papers.filter(p => {
      const matchSensor = sensorFilter === 'all' || p.sensor_type.includes(sensorFilter);
      const matchDriver = driverFilter === 'all' || p.main_driver.includes(driverFilter);
      const matchRegion = regionFilter === 'all' || p.tags.some(t => t.includes(regionFilter));
      return matchSensor && matchDriver && matchRegion;
    });

    // Update Charts
    updateCharts(filtered);

    // Update Table
    tableBody.innerHTML = '';
    filtered.forEach(p => {
      const row = document.createElement('tr');
      row.id = `row-${p.map_id.replace(/\s+/g, '-').toLowerCase()}`;
      row.innerHTML = `
        <td><strong>${p.map_id || p.title}</strong><br><small style="color:#64748b">${p.year}</small></td>
        <td><span class="tag-sensor">${p.sensor_type}</span></td>
        <td>${p.bin_size}</td>
        <td>${p.repeat_interval}</td>
        <td><span class="nrms-badge">${p.nrms_median}</span></td>
        <td>${p.main_driver}</td>
        <td>${p.water_depth}</td>
      `;
      row.addEventListener('click', () => {
        document.querySelectorAll('.comparison-table tr').forEach(r => r.classList.remove('highlighted'));
        row.classList.add('highlighted');
        const m = markers.find(m => m.options.id === p.map_id);
        if (m) {
          map.flyTo(m.getLatLng(), 5);
          m.openPopup();
        }
      });
      tableBody.appendChild(row);
    });

    // Update Map Markers
    markers.forEach(m => map.removeLayer(m));
    markers = [];
    
    filtered.forEach(p => {
      const loc = mapData.find(m => m.name === p.map_id);
      if (loc) {
        const marker = L.circleMarker([loc.latitude, loc.longitude], {
          radius: 8,
          fillColor: "#B509AC",
          color: "#fff",
          weight: 2,
          opacity: 1,
          fillOpacity: 0.8,
          id: p.map_id
        }).addTo(map);
        
        marker.bindPopup(`<strong>${loc.name}</strong><br>${loc.summary}`);
        marker.on('click', () => {
          const row = document.getElementById(`row-${p.map_id.replace(/\s+/g, '-').toLowerCase()}`);
          if (row) {
            document.querySelectorAll('.comparison-table tr').forEach(r => r.classList.remove('highlighted'));
            row.classList.add('highlighted');
            row.scrollIntoView({ behavior: 'smooth', block: 'center' });
          }
        });
        markers.push(marker);
      }
    });

    statsText.innerText = `Showing ${filtered.length} projects`;
  }

  // Event Listeners
  document.getElementById('filter-sensor').addEventListener('change', updateDisplay);
  document.getElementById('filter-driver').addEventListener('change', updateDisplay);
  document.getElementById('filter-region').addEventListener('change', updateDisplay);

  updateDisplay();
});
</script>
