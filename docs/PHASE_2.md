# FODS Phase 2

## Scope

Phase 2 covers the Foundations of Data Science syllabus areas for:

- Module 3: Exploratory Data Analysis
- Module 4: Data Visualization

## Module 3 implementation

The first Phase 2 implementation step is deeper EDA on the cleaned Phase 1 dataset.

Implemented in:
- `R/06_phase2_eda.R`

The script is designed to produce, when executed:

- univariate descriptive statistics
- IQR-based outlier counts
- a correlation matrix
- selected engagement relationship measures
- branch-wise comparison
- mentorship comparison
- batch-wise comparison

Analysis tables are written to `outputs/tables/`.

## Verified Results

The Phase 2 EDA script was executed in RStudio and its generated analysis tables were verified.

Key verified relationships:
- Event Attendance ↔ Email Response: 0.214
- Event Attendance ↔ Donations: 0.064
- Networking Events ↔ Email Response: -0.0215
- Alumni Meetings ↔ Email Response: 0.0101

The Module 4 visualization script was also executed successfully. Five visualization outputs were generated and visually inspected.

See `docs/PHASE_2_CHECKPOINT.md` for the verified Phase 2 record and evidence list.

## Status

Phase 2 — Module 3 and Module 4 implementation and verification complete.

Next step: prepare Report 2 from the verified Phase 2 evidence.
