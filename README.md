# Alumni Engagement Analytics

**Course:** Foundations of Data Science (CCSDS0301)  
**Domain:** Educational Analytics  
**SDG:** SDG 4 — Quality Education  
**Stack:** R, RStudio, Shiny, readr, dplyr, tidyr, ggplot2

## Objective

Explore alumni engagement patterns using data preparation, descriptive statistics, exploratory data analysis, relationship analysis, and visualizations. The repository includes a reproducible R workflow and an interactive Shiny analytics studio.

**Dataset limitation:** The project uses synthetic data because institutional alumni records were unavailable. Results must not be presented as actual institutional findings.

## Interactive application

The initial Shiny application is in `app.R`. It includes:
- Overview metrics and a batch-level engagement chart.
- Filterable data explorer with CSV export.
- Group comparisons by branch, batch, and mentorship.
- Selectable correlation/relationship analysis.
- A visualization lab for histograms, boxplots, and scatterplots.
- Descriptive findings and downloadable summary/correlation tables.

The app source has been committed, but it must be run and manually tested in R/RStudio before it is described as fully validated.

### Launch the app

Open the repository root as the working directory in RStudio, then install any missing packages:

```r
install.packages(c("shiny", "readr", "dplyr", "tidyr", "ggplot2"))
```

Run the app:

```r
shiny::runApp("app.R")
```

The app reads `data/processed/alumni_engagement_clean.csv`. If that file is missing, run the data workflow below first.

## Repository structure

- `app.R` — interactive Shiny analytics studio.
- `data/raw/` — original synthetic dataset with deliberate data-quality issues.
- `data/processed/` — cleaned dataset produced by the cleaning workflow.
- `R/01_data_import.R` through `R/05_basic_visualization.R` — Phase 1 workflow.
- `R/06_phase2_eda.R` — Module 3 EDA and six analysis tables.
- `R/07_phase2_visualization.R` — Module 4 visualizations.
- `R/08_validate_outputs.R` — checks dataset invariants and required generated outputs.
- `outputs/tables/` — generated CSV analysis tables.
- `outputs/plots/` — generated PNG visualizations.
- `docs/` — development log, phase documentation, research notes, and checkpoints.
- `PBL_CONTEXT.md` — technical handoff and verified project status.

## Run the analysis workflow

Open the repository folder as the RStudio working directory. Run scripts in order:

1. `R/01_data_import.R`
2. `R/02_data_quality.R`
3. `R/03_data_cleaning.R`
4. `R/04_data_exploration.R`
5. `R/05_basic_visualization.R`
6. `R/06_phase2_eda.R`
7. `R/07_phase2_visualization.R`
8. `R/08_validate_outputs.R` — run after scripts 01–07 to validate the cleaned data and generated files.

Run scripts from the repository root so relative paths resolve correctly. The cleaning step writes `data/processed/alumni_engagement_clean.csv`; the Phase 2 scripts use that processed dataset and write generated outputs under `outputs/`.

## Phase mapping

1. **Phase 1 — Modules 1–2:** import, quality inspection, cleaning, descriptive exploration, initial visualization.
2. **Phase 2 — Modules 3–4:** EDA, IQR outlier identification, correlation and comparison analysis, five additional visualizations.
3. **Phase 3 — Module 5 and final integration:** still pending syllabus confirmation and further implementation. The Shiny app is an initial product layer and has not yet been manually validated.

## Verified Phase 2 outputs

Analysis tables:
- `phase2_outlier_summary.csv`
- `phase2_branch_summary.csv`
- `phase2_mentorship_summary.csv`
- `phase2_batch_summary.csv`
- `phase2_relationship_summary.csv`
- `phase2_correlation_matrix.csv`

Phase 2 plots:
- `04_correlation_heatmap.png`
- `05_event_attendance_by_branch.png`
- `06_mentorship_vs_attendance.png`
- `07_batch_attendance_trend.png`
- `08_attendance_vs_email_response.png`

See `docs/PHASE_2_CHECKPOINT.md` for verified findings and limitations, and `docs/DEVELOPMENT_LOG.md` for the implementation history.

## Automated reproducibility check

GitHub Actions runs scripts 01–07 and then `R/08_validate_outputs.R` on pushes to `main`, pull requests, and manual workflow dispatches. The validation checks the expected raw/clean dataset dimensions, column schema, absence of missing values and duplicate IDs in the cleaned data, and presence of all six Phase 2 tables and eight plots. The workflow has been added; its first hosted run must pass before CI is described as verified.
