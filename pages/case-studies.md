---
title: Case Studies
layout: default
---

## Case Studies

Case studies illustrate how 4D seismic data were used to answer specific reservoir questions.  Each case follows a simple template—**Problem**, **Approach** and **Outcome**—to make it easy to understand the context and relevance.  When summarised into a **case card**, these elements become a concise abstract that can be reused in conference submissions or project documents.  Additional case studies and cards can be added as new monitor surveys are acquired or as participants share their experiences.

### Global case study map

Explore the locations of each case study on the interactive map below.  Hover or tap on a marker to see a short description, or zoom the map to focus on a specific region.  Markers are data-driven—just add additional entries to `_data/case_studies_map.yml` (each with a `name`, `location`, `latitude`, `longitude`, and `summary`) to display as many pinpoints as you need.

<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-o9N1j7kG8GkZsG32MRuX3HyCu+a0LYX1fV9XYbO9w5w=" crossorigin="" />
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-VuZ0p71g+p8vLw+sE7cQ8ZkH7CjQwlWvnkpIBu0zYJ0=" crossorigin=""></script>

<div id="case-studies-map" class="case-studies-map"></div>

<script>
  function initializeCaseStudiesMap() {
    var mapContainer = document.getElementById('case-studies-map');
    if (!mapContainer || !window.L) {
      return;
    }

    var studies = {{ site.data.case_studies_map | jsonify }};
    if (!studies || !studies.length) {
      return;
    }

    var map = L.map('case-studies-map', {
      scrollWheelZoom: false
    }).setView([10, 0], 2);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 18,
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    var bounds = [];

    studies.forEach(function (study) {
      if (!study.latitude || !study.longitude) {
        return;
      }

      var marker = L.marker([study.latitude, study.longitude]).addTo(map);
      var popupContent = '<strong>' + study.name + '</strong><br />' +
        '<span>' + study.location + '</span>' +
        '<p style="margin: 0.25rem 0 0; font-size: 0.9rem;">' + study.summary + '</p>';

      marker.bindPopup(popupContent);
      bounds.push([study.latitude, study.longitude]);
    });

    if (bounds.length) {
      map.fitBounds(bounds, { padding: [40, 40] });
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initializeCaseStudiesMap);
  } else {
    initializeCaseStudiesMap();
  }
</script>

### Case Study 1: Middle East Carbonate OBN Monitor

**Problem:**  To understand water and gas movement in a mature carbonate field that had reached its production plateau, the operator commissioned an ocean‑bottom node (OBN) baseline survey with the intention of repeating it several years later.  The objective was to detect subtle pressure depletion and saturation changes around injection wells and faults.

**Approach:**  Repeatable node deployment was combined with iterative 4D inversion to enhance the signal‑to‑noise ratio.  Particular attention was paid to matching geometry, timing and processing parameters between the baseline and monitor surveys.  Processing included careful positioning, source and receiver matching, wavelet shaping and high‑resolution 4D inversion to extract impedance changes.

**Outcome:**  The 4D difference volumes highlighted pressure depletion near injection wells and unexpected saturation changes along a fault corridor.  These insights allowed the asset team to reprioritise workovers, delay an expensive sidetrack and reconfigure the water‑flood strategy.  The case demonstrates that high‑fidelity OBN data, when combined with inversion and production information, can deliver actionable insights even in complex carbonate settings.

### Case Study 2: Hybrid OBN/Streamer Concept in Carbonates

**Problem:**  Deploying a dense OBN grid over a carbonate field can be cost‑prohibitive.  A hybrid concept was proposed in which sparse nodes would be used to fill gaps in a conventional towed‑streamer monitor, thereby improving illumination without requiring a full node footprint.

**Approach:**  A feasibility study tested different node spacings and streamer geometries.  Crossline interference and 4D repeatability metrics were evaluated through synthetic modelling and field trials.  The study also examined how the node data could be integrated into a primarily towed acquisition and processing workflow.

**Outcome:**  The study showed that a judicious combination of nodes and streamers could yield reliable 4D signals in the target interval while reducing acquisition time and cost.  The operator ultimately adopted the hybrid layout for its first monitor survey, demonstrating that alternative acquisition concepts can unlock 4D projects that might otherwise be uneconomic.

*Do you have a case to share?*  Please follow the [contribution guidelines](/pages/contribute) and submit a pull request.
