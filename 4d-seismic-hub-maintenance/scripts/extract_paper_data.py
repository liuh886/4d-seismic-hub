import argparse
import sys
import os
import yaml
from pathlib import Path
from datetime import datetime

# This script is a template/harness for the 4D Seismic Agent to extract 
# standardized data from geophysical papers.
# It expects to be run in an environment with LLM access (e.g., Gemini CLI).

def extract_from_content(content):
    """
    This function defines the prompt for the LLM to extract data.
    In a real agentic workflow, the agent calls this script, 
    gets the content, and then uses its own LLM capabilities.
    """
    prompt = f"""
    You are a 4D Seismic Expert Agent. Analyze the following content and extract 
    standardized technical parameters for the 4D Seismic Hub.

    CONTENT:
    {content}

    EXTRACT THE FOLLOWING FIELDS (JSON FORMAT):
    - title: Full title of the paper.
    - authors: List of authors.
    - year: Publication year (integer).
    - description: A high-signal 2-3 sentence summary focused on project impact.
    - link: The source URL provided.
    - tags: 3-5 relevant tags (Region, Technology, Driver).
    - bin_size: e.g., "12.5m x 12.5m".
    - repeat_interval: e.g., "2 years" or "Permanent".
    - sensor_type: e.g., "Streamer", "PRM", "OBC".
    - nrms_median: Repeatability metric (be precise, include processing stage if known).
    - main_driver: e.g., "Water Saturation", "Pressure", "Compaction".
    - water_depth: e.g., "1300m".
    - map_id: A short, unique identifier for the map (e.g., "Jubarte PRM").
    - latitude/longitude: Search for approximate coordinates if possible.
    - analysis_post: A Markdown string with sections: ### Project Overview, ### 4D Seismic Contribution, ### Impact, ### Key Takeaway.

    STRICT REQUIREMENT: Return ONLY valid JSON.
    """
    return prompt

def save_output(data, repo_root):
    """
    Saves the extracted data to papers.yml, case_studies_map.yml, and a new post.
    """
    # 1. Update _data/papers.yml
    papers_path = Path(repo_root) / "_data" / "papers.yml"
    with open(papers_path, 'r', encoding='utf-8') as f:
        papers = yaml.safe_load(f) or []
    
    # Check for duplicates
    if any(p.get('title') == data['title'] for p in papers):
        print(f"Warning: Paper '{data['title']}' already exists in papers.yml.")
    else:
        # Filter for keys that belong in papers.yml
        paper_entry = {{k: data[k] for k in [
            'title', 'authors', 'year', 'description', 'link', 
            'tags', 'bin_size', 'repeat_interval', 'sensor_type', 
            'nrms_median', 'main_driver', 'water_depth', 'map_id'
        ] if k in data}}
        papers.append(paper_entry)
        with open(papers_path, 'w', encoding='utf-8') as f:
            yaml.dump(papers, f, sort_keys=False, allow_unicode=True)
        print(f"Successfully added '{data['title']}' to papers.yml")

    # 2. Update _data/case_studies_map.yml (if coordinates exist)
    if 'latitude' in data and 'longitude' in data:
        map_path = Path(repo_root) / "_data" / "case_studies_map.yml"
        with open(map_path, 'r', encoding='utf-8') as f:
            map_data = yaml.safe_load(f) or []
        
        if not any(m.get('name') == data['map_id'] for m in map_data):
            map_entry = {{
                'name': data['map_id'],
                'location': data.get('tags', ["Unknown"])[0],
                'latitude': data['latitude'],
                'longitude': data['longitude'],
                'summary': data['description'][:157] + "..." if len(data['description']) > 160 else data['description']
            }}
            map_data.append(map_entry)
            with open(map_path, 'w', encoding='utf-8') as f:
                yaml.dump(map_data, f, sort_keys=False, allow_unicode=True)
            print(f"Successfully added '{data['map_id']}' to case_studies_map.yml")

    # 3. Create _posts/YYYY-MM-DD-title.md
    date_str = datetime.now().strftime("%Y-%m-%d")
    slug = data['title'].lower().replace(" ", "-").replace(":", "").replace(",", "")[:50]
    post_filename = f"{{date_str}}-{{slug}}.md"
    post_path = Path(repo_root) / "_posts" / post_filename
    
    post_content = f"""---
layout: single
title: "{{data['title']}}"
date: {{date_str}}
categories: 4d-case-study
tags: {{data.get('tags', [])}}
---

{{data.get('analysis_post', "Analysis coming soon...")}}

[Read more on source]({{data['link']}})
"""
    with open(post_path, 'w', encoding='utf-8') as f:
        f.write(post_content)
    print(f"Successfully created post: {{post_filename}}")

if __name__ == "__main__":
    # In practice, the Agent will run this script to generate the prompt,
    # then call the LLM, then pass the result back to the script to save.
    print("4D Seismic Agent: Extraction logic ready.")
