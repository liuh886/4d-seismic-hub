# Benchmark metric methodology

The comparison tool is designed to support technical orientation, not to rank projects with a synthetic score.

## No mixed-unit composite score

NRMS, repeat interval, bin size, and water depth describe different engineering dimensions. They are not normalized into a radar score or combined average. Each metric is summarized in its own unit.

## Filtered summary statistics

For the active filter set, the tool reports:

- median plottable NRMS in percent;
- median repeat interval after converting weeks and months to years;
- median first bin dimension in metres;
- median water depth in metres;
- the number of records used for each median.

The median is used instead of the mean because the dataset contains heterogeneous project settings, ranges, approximate values, and material outliers.

## Parsing rules

### Ranges

A range such as `10-15%` or `400-1000m` is represented by its midpoint for the scatter plot and median calculation. The original string remains visible in the table and chart tooltip. The midpoint is a plotting convention, not a new source value.

### Approximate and estimated values

Values marked with `~`, `approx`, `estimated`, or `variable` may be included in the plot or median when a numeric estimate can be parsed. The tooltip identifies the parsing method and preserves the original text.

### Censored values

Values using `<`, `>`, `≤`, or `≥` are reported observations but are not treated as exact point estimates. They count toward data-completeness coverage but are excluded from the scatter plot and medians.

### Not applicable and missing values

`N/A`, land water depth, empty fields, and unparseable values are excluded from metric calculations. They are never replaced by zero.

### Repeat interval conversion

- weeks are divided by 52;
- months are divided by 12;
- years remain in years;
- ranges use their midpoint before unit conversion.

## Data completeness chart

The second chart shows the percentage of filtered project records with a reported value for each benchmark field. All bars use the same percentage unit. Coverage does not imply that the reported values have equal quality, precision, or comparability.

## Scatter plot eligibility

A project appears in the NRMS-versus-water-depth scatter plot only when both fields produce a non-censored numeric estimate. The result count explicitly states how many filtered projects are plottable.

## Validation

`tests/validate_benchmark_contract.rb` checks that:

- the mixed-unit radar implementation does not return;
- the documented parsing and median functions remain present;
- the data-completeness view remains present;
- benchmarking CSS is loaded;
- the embedded JavaScript passes `node --check` after Jekyll data placeholders are replaced with test arrays.

The shared repository CI automatically discovers and runs this validator before building the production site.
