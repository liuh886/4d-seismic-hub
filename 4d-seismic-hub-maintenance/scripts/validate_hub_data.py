import yaml
import os
import sys

def validate_papers(file_path):
    errors = []
    if not os.path.exists(file_path):
        return [f"File not found: {file_path}"]
    
    with open(file_path, 'r', encoding='utf-8') as f:
        data = yaml.safe_load(f)
    
    mandatory_fields = [
        'title', 'authors', 'year', 'description', 'link', 
        'bin_size', 'repeat_interval', 'sensor_type', 
        'nrms_median', 'main_driver', 'water_depth'
    ]
    
    for i, entry in enumerate(data):
        label = entry.get('title', f"Entry {i}")
        for field in mandatory_fields:
            if field not in entry or entry[field] is None:
                errors.append(f"[Papers] '{label}' is missing mandatory field: {field}")
        
        if not isinstance(entry.get('year'), int):
            errors.append(f"[Papers] '{label}' year must be an integer.")
            
    return errors

def validate_map(file_path):
    errors = []
    if not os.path.exists(file_path):
        return [f"File not found: {file_path}"]
    
    with open(file_path, 'r', encoding='utf-8') as f:
        data = yaml.safe_load(f)
    
    for i, entry in enumerate(data):
        name = entry.get('name', f"Entry {i}")
        
        # Check mandatory fields
        for field in ['name', 'location', 'latitude', 'longitude', 'summary']:
            if field not in entry:
                errors.append(f"[Map] '{name}' is missing mandatory field: {field}")
        
        # Validate coordinates
        lat = entry.get('latitude')
        lon = entry.get('longitude')
        if not isinstance(lat, (int, float)) or not (-90 <= lat <= 90):
            errors.append(f"[Map] '{name}' has invalid latitude: {lat}")
        if not isinstance(lon, (int, float)) or not (-180 <= lon <= 180):
            errors.append(f"[Map] '{name}' has invalid longitude: {lon}")
            
        # Summary length check
        summary = entry.get('summary', "")
        if len(summary) > 160:
            errors.append(f"[Map] '{name}' summary is too long ({len(summary)} chars). Max 160.")
            
    return errors

if __name__ == "__main__":
    # Base path is the project root (C:\Users\ZOZN109\Documents\GitHub\4d-seismic-hub)
    # We assume this script is run from the root or paths are relative to root.
    repo_root = os.getcwd()
    papers_path = os.path.join(repo_root, "_data", "papers.yml")
    map_path = os.path.join(repo_root, "_data", "case_studies_map.yml")
    
    all_errors = []
    all_errors.extend(validate_papers(papers_path))
    all_errors.extend(validate_map(map_path))
    
    if all_errors:
        print("鉂 Data Validation Failed:")
        for err in all_errors:
            print(f"  - {err}")
        sys.exit(1)
    else:
        print("鉁 Data Validation Passed! All technical parameters and map coordinates are valid.")
        sys.exit(0)
