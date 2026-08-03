# Benchmark metric and source methodology

The comparison tool is designed to support technical orientation, not to rank projects with a synthetic score or imply that every record has the same evidentiary strength.

## Source eligibility

Every `_data/papers.yml` record has a one-to-one entry in `_data/source_registry.yml`.

- **Grade A — canonical technical publication:** a direct publication or DOI landing page suitable for item-level review.
- **Grade B — project publication:** a direct operator, project, or technology-provider publication with operational relevance but without the same independence as a technical publication.
- **Grade C — discovery record:** a search or discovery URL that can help locate the source but does not yet prove the exact item-level metadata and benchmark fields.
- **Grade D — provisional record:** a record with unresolved bibliographic identity, explicitly estimated fields, or another material provenance limitation.

The default comparison includes Grades A–C. Grade D records remain inspectable through the source filter but are excluded from medians, data-completeness percentages, and scatter-plot calculations.

A source grade describes provenance maturity, not whether a project succeeded or whether its technical conclusions are correct.

## No mixed-unit composite score

NRMS, repeat interval, bin size, and water depth describe different engineering dimensions. They are not normalized into a radar score or combined average. Each metric is summarized in its own unit.

## Filtered summary statistics

For the source-eligible records in the active filter set, the tool reports:

- median plottable NRMS in percent;
- median repeat interval after converting weeks and months to years;
- median first bin dimension in metres;
- median water depth in metres;
- the number of records used for each median.

The median is used instead of the mean because the dataset contains heterogeneous project settings, ranges, approximate values, and material outliers.

## Parsing rules

### Ranges

A range such as `10-15%` or `400-1000m` is represented by its midpoint for the scatter plot and median calculation. The original string remains visible in the table and chart tooltip. The midpoint is a plotting convention, not a new source value.

### Approximate values

Values marked with `~`, `approx`, or `variable` may be included when a numeric estimate can be parsed and the record is source-eligible. The tooltip identifies the parsing method and preserves the original text.

Values explicitly marked `Estimated` should be registered as Grade D until the field is tied to a canonical or direct project source. Grade D values are not used in aggregate calculations.

### Censored values

Values using `<`, `>`, `≤`, or `≥` are reported observations but are not treated as exact point estimates. They count toward data-completeness coverage for source-eligible records but are excluded from the scatter plot and medians.

### Not applicable and missing values

`N/A`, land water depth, empty fields, and unparseable values are excluded from metric calculations. They are never replaced by zero.

### Repeat interval conversion

- weeks are divided by 52;
- months are divided by 12;
- years remain in years;
- ranges use their midpoint before unit conversion.

## Data completeness chart

The second chart shows the percentage of source-eligible filtered records with a reported value for each benchmark field. All bars use the same percentage unit. Coverage does not imply that the reported values have equal quality, precision, or comparability.

## Scatter plot eligibility

A project appears in the NRMS-versus-water-depth scatter plot only when:

1. its provenance grade is A, B, or C; and
2. both fields produce a non-censored numeric estimate.

The result count separately states visible records, source-eligible records, and plottable records.

## Validation

`tests/validate_benchmark_contract.rb` checks that:

- the mixed-unit radar implementation does not return;
- Grade D records are separated from the analytical dataset;
- the source filter and registry data are wired into the page;
- the documented parsing and median functions remain present;
- the data-completeness view remains present;
- benchmarking CSS is loaded;
- the embedded JavaScript passes `node --check` after Jekyll data placeholders are replaced with test arrays.

`tests/validate_source_registry.rb` checks complete one-to-one registry coverage, valid grades, direct-versus-discovery URL rules, provisional-field declarations, and review metadata.

The shared repository CI automatically discovers and runs both validators before building the production site.
