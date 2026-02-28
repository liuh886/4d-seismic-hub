# YAML Schema for 4D Seismic Hub

## `_data/papers.yml` Entry Template

```yaml
- title: "Full Title of the Paper"
  authors: ["Last Name, F.", "Last Name, F."]
  year: YYYY
  description: "1-2 sentence focus on the DECISION made based on 4D."
  link: "URL"
  tags: ["Region", "Sensor Type", "Reservoir Type"]
  bin_size: "XXm x XXm"
  repeat_interval: "X years"
  sensor_type: "OBN / Streamer / PRM / etc."
  nrms_median: "XX% (Context)"
  main_driver: "Saturation / Pressure / Compaction"
  water_depth: "XXm / N/A (Land)"
```

## `_data/case_studies_map.yml` Entry Template

```yaml
- name: "Field/Project Name"
  location: "Country/Region"
  latitude: 0.000
  longitude: 0.000
  summary: "Key decision summary (max 160 chars)."
```
