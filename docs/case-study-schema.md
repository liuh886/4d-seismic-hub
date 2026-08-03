# Case-study content and evidence contract

The case-study template separates shared technical data, editorial synthesis, and community review so that readers can see what each layer can support.

## Three evidence layers

1. **Technical source record** — the paper or project source referenced by `_data/papers.yml`.
2. **Editorial synthesis** — the decision-oriented interpretation stored in the post and displayed in the structured case brief.
3. **Community review** — issue-backed observations, counterexamples, and maintainer synthesis. This layer can challenge or improve an article, but it is not a primary technical source.

## Source of truth

Each case post stores the fields that belong to editorial interpretation:

```yaml
classes: case-study
case_study:
  map_id: Project name used by shared datasets
  monitoring_objective: The uncertainty or operational question being monitored
  decision_outcome: What the evidence changed or supported
  transferable_lesson: What another project team can reuse
  evidence_status: A short maturity label
  evidence_scope: What the cited source and article can reasonably support
  limitations:
    - A known interpretation, transfer, or method limitation
    - A second material limitation
```

Technical benchmark values and the source citation are not duplicated in post front matter. The case overview resolves the same `map_id` against:

- `_data/case_studies_map.yml` for location and case-library routing;
- `_data/papers.yml` for source title, authors, year, URL, sensor type, repeat interval, NRMS, main signal driver, and water depth.

Update the shared dataset once when a benchmark or source record changes. Do not patch the visible case page separately.

## Required article structure

Case posts use the following sequence:

1. **Decision context** — the uncertainty, risk, or development decision.
2. **Monitoring approach** — the acquisition or surveillance response.
3. **Evidence** — the observed signal and relevant repeatability evidence.
4. **Operational outcome** — the action, assurance, or decision supported.
5. **Transferable lesson** — what can and cannot be reused elsewhere.

These headings are part of the current validation contract because they keep the decision chain visible across all case pages.

## Community synthesis

`community_summary` remains optional. When present, it must contain:

```yaml
community_summary:
  updated_at: YYYY-MM-DD
  pro:
    - Evidence or field experience supporting the article interpretation
  con:
    - Limitation, counterexample, or transfer condition
```

The internal `pro` and `con` keys are retained for compatibility. The site presents them as **Supporting signals** and **Limits and counterexamples**. Summary items should identify the claim being addressed and must not silently replace the source record or article evidence scope.

## Validation

`tests/validate_case_studies.rb` checks that:

- every post in the `4d-case-study` or `ccs-monitoring` category has structured metadata;
- required editorial fields, evidence scope, and at least two limitations are present;
- the five standard article headings are present;
- each case uses the `case-study` page class;
- `map_id` exists exactly once in the technical dataset and exists in the map dataset;
- technical source records include title, authors, year, and a valid HTTPS URL;
- each documented case has a map `post_url`;
- no two posts claim the same `map_id`;
- optional community summaries contain an update date and non-empty supporting and skeptical items.

`tests/community_debate_check.sh` checks that the issue-backed forum, evidence-boundary statement, labels, and edit path remain wired into the site.

Both validations run in the pull-request workflow before the Jekyll build.

## Editorial rules

- Do not copy benchmark parameters or source citations into post front matter or add a second hand-written source link at the end of the article.
- State what the evidence supports and what it does not support.
- Keep missing or partial evidence explicit; do not infer a value merely to complete the case card.
- Treat community discussion as a review channel. Promote a correction into the article only by updating the source record, editorial synthesis, or limitations field through a reviewed change.
