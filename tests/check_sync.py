import yaml
import os
import sys

def check_sync():
    repo_root = os.getcwd()
    papers_path = os.path.join(repo_root, "_data", "papers.yml")
    map_path = os.path.join(repo_root, "_data", "case_studies_map.yml")
    
    if not os.path.exists(papers_path) or not os.path.exists(map_path):
        print("Error: Data files missing.")
        return False

    with open(papers_path, 'r', encoding='utf-8') as f:
        papers = yaml.safe_load(f)
    with open(map_path, 'r', encoding='utf-8') as f:
        map_entries = yaml.safe_load(f)

    map_names = {entry['name'] for entry in map_entries}
    
    errors = []
    
    # 1. Check if every paper's map_id exists in case_studies_map.yml
    for i, paper in enumerate(papers):
        title = paper.get('title', f"Entry {i}")
        map_id = paper.get('map_id')
        if not map_id:
            errors.append(f"Paper '{title}' is missing 'map_id'.")
        elif map_id not in map_names:
            errors.append(f"Paper '{title}' has map_id '{map_id}' which does not exist in case_studies_map.yml.")

    # 2. Check for orphaned map entries (optional but good for clean data)
    referenced_map_ids = {paper.get('map_id') for paper in papers if paper.get('map_id')}
    for entry in map_entries:
        if entry['name'] not in referenced_map_ids:
            # Not necessarily an error, but worth noting
            print(f"Note: Map entry '{entry['name']}' is not referenced by any paper.")

    if errors:
        print("Sync Validation Failed:")
        for err in errors:
            print(f"  - {err}")
        return False
    else:
        print("Sync Validation Passed! All papers are correctly mapped to map entries.")
        return True

if __name__ == "__main__":
    if check_sync():
        sys.exit(0)
    else:
        sys.exit(1)
