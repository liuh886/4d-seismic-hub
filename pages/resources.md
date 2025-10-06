---
title: Resources
layout: default
---

## 4D Seismic Resources

Below is a list of open papers and presentations curated by the 4D Seismic Hub.  The entries are stored in `/_data/papers.yml` and automatically rendered here.  Contributions of additional open materials are welcome via pull request.

{% for paper in site.data.papers %}
### {{ paper.title }}

- **Authors:** {{ paper.authors | join: ", " }}
- **Year:** {{ paper.year }}
- **Description:** {{ paper.description }}
- **Link:** [Access]({{ paper.link }})
- **Tags:** {{ paper.tags | join: ", " }}

{% endfor %}

*Note:*  All links point to external sites (e.g. EarthDoc).  We only catalogue materials that are already publicly accessible and provide direct citations to the original hosting site.
