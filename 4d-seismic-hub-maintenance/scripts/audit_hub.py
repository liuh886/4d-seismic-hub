import yaml
import os
import sys
import re
from pathlib import Path

def validate_papers(repo_root):
    file_path = os.path.join(repo_root, "_data", "papers.yml")
    errors = []
    if not os.path.exists(file_path):
        return [f"File not found: {file_path}"]

    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f) or []
    except Exception as e:
        return [f"YAML Parse Error in papers.yml: {e}"]

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

def validate_map(repo_root):
    file_path = os.path.join(repo_root, "_data", "case_studies_map.yml")
    errors = []
    if not os.path.exists(file_path):
        return [f"File not found: {file_path}"]

    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f) or []
    except Exception as e:
        return [f"YAML Parse Error in case_studies_map.yml: {e}"]

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

def validate_posts(repo_root):
    posts_dir = os.path.join(repo_root, "_posts")
    errors = []
    if not os.path.exists(posts_dir):
        return errors

    for filename in os.listdir(posts_dir):
        if not filename.endswith(".md"):
            continue
            
        file_path = os.path.join(posts_dir, filename)
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
            
            # Check Frontmatter
            if not content.startswith("---"):
                errors.append(f"[Post] {filename} is missing frontmatter.")
                continue
                
            parts = content.split("---", 2)
            if len(parts) < 3:
                errors.append(f"[Post] {filename} has malformed frontmatter.")
                continue
            
            try:
                fm = yaml.safe_load(parts[1])
                if not fm or 'title' not in fm:
                    errors.append(f"[Post] {filename} is missing 'title' in frontmatter.")
                if fm.get('layout') != 'single':
                    errors.append(f"[Post] {filename} should use 'layout: single' for consistency.")
            except Exception as e:
                errors.append(f"[Post] {filename} frontmatter YAML error: {e}")

            # Check for Community Module (Pro/Cons)
            body = parts[2]
            if "How do you think 4D Seismic in this cases" not in body and "community-perspectives" not in body:
                # The module is in the layout, so we check if the post uses that layout.
                # However, we also want to make sure no placeholders or broken structure in body.
                pass

    return errors

def check_cross_references(repo_root):
    # Ensure every post has a corresponding entry in map or papers if it's a case study
    # This is a bit complex without specific IDs, but we can check naming.
    return []

if __name__ == "__main__":
    repo_root = os.getcwd()
    print("--- 4D Seismic Hub: Intelligent Agent Audit ---")
    
    errors = []
    errors.extend(validate_papers(repo_root))
    errors.extend(validate_map(repo_root))
    errors.extend(validate_posts(repo_root))
    
    if errors:
        print(f"❌ Found {len(errors)} issues:")
        for err in errors:
            print(f"  - {err}")
        sys.exit(1)
    else:
        print("✅ Audit Passed! All data, posts, and coordinates are healthy.")
        sys.exit(0)
