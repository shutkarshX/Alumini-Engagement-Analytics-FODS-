# Phase 2 — Data Visualization

## Module 4 Scope

The visualization stage turns selected Phase 2 EDA results into graphical analysis.

Script:
- `R/07_phase2_visualization.R`

The script generates five visualizations:

1. Correlation heatmap of numeric engagement variables.
2. Event attendance by branch using boxplots.
3. Event attendance comparison by mentorship participation.
4. Average event attendance across graduation batches.
5. Event attendance versus email response with a fitted linear trend.

Generated PNG files are written to `outputs/plots/`.

## Verification

The script was executed successfully in RStudio. All five generated PNGs were manually inspected and confirmed correct.

Verified output files:
- `outputs/plots/04_correlation_heatmap.png`
- `outputs/plots/05_event_attendance_by_branch.png`
- `outputs/plots/06_mentorship_vs_attendance.png`
- `outputs/plots/07_batch_attendance_trend.png`
- `outputs/plots/08_attendance_vs_email_response.png`

The plots are based on the project's synthetic dataset. Interpretations are descriptive and must not be presented as causal findings or as verified patterns in actual institutional alumni records.

For the full list of Phase 2 analysis tables, findings, and verification details, see `docs/PHASE_2_CHECKPOINT.md`.
