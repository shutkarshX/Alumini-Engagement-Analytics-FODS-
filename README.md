# Alumni Engagement Analytics

**Course:** Foundations of Data Science (CCSDS0301)  
**Domain:** Educational Analytics  
**SDG:** SDG 4 — Quality Education  
**Stack:** R, RStudio, readr, dplyr, tidyr, ggplot2

## Objective

Explore alumni engagement patterns using data preparation, descriptive statistics, exploratory data analysis, relationship analysis, and visualizations.

**Dataset limitation:** The project uses synthetic data because institutional alumni records were unavailable. Results must not be presented as actual institutional findings.

## Repository structure

- `data/raw/` — original synthetic dataset with deliberate data-quality issues.
- `data/processed/` — cleaned dataset produced by the cleaning workflow.
- `R/01_data_import.R` through `R/05_basic_visualization.R` — Phase 1 workflow.
- `R/06_phase2_eda.R` — Module 3 EDA and six analysis tables.
- `R/07_phase2_visualization.R` — Module 4 visualizations.
- `outputs/tables/` — generated CSV analysis tables.
- `outputs/plots/` — generated PNG visualizations.
- `docs/` — development log, phase documentation, research notes, and checkpoints.
- `PBL_CONTEXT.md` — technical handoff and verified project status.

## Requirements

- R 4.6.1 or a compatible recent R version
- RStudio recommended
- R packages: `readr`, `dplyr`, `tidyr`, `ggplot2`

Install missing packages in the R console:

```r
install.packages(c("readr", "dplyr", "tidyr", "ggplot2"))
```

## Run the workflow

Open the repository folder as the RStudio working directory. Run scripts in order:

1. `R/01_data_import.R`
2. `R/02_data_quality.R`
3. `R/03_data_cleaning.R`
4. `R/04_data_exploration.R`
5. `R/05_basic_visualization.R`
6. `R/06_phase2_eda.R`
7. `R/07_phase2_visualization.R`

Run scripts from the repository root so relative paths resolve correctly. The cleaning step writes `data/processed/alumni_engagement_clean.csv`; the Phase 2 scripts use that processed dataset and write generated outputs under `outputs/`.

## Phase mapping

1. **Phase 1 — Modules 1–2:** import, quality inspection, cleaning, descriptive exploration, initial visualization.
2. **Phase 2 — Modules 3–4:** EDA, IQR outlier identification, correlation and comparison analysis, five additional visualizations.
3. **Phase 3 — Module 5 and final integration:** not yet completed; confirm the exact Module 5 syllabus topics before planning the implementation.

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
