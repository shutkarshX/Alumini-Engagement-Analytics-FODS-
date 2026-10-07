# FODS Phase 2 Checkpoint

## Status
**Phase 2 — Completed and verified**

Coverage:
- Module 3 — Exploratory Data Analysis
- Module 4 — Data Visualization

## Module 3 — Verified Work

Executed locally in RStudio using the cleaned Phase 1 dataset.

Implemented:
- univariate descriptive statistics;
- IQR-based outlier identification;
- correlation matrix;
- selected engagement relationship analysis;
- branch-wise comparison;
- mentorship comparison;
- batch-wise comparison.

### Verified findings

Correlation results:
- Event Attendance ↔ Email Response: **0.214**
- Event Attendance ↔ Donations: **0.064**
- Networking Events ↔ Email Response: **-0.0215**
- Alumni Meetings ↔ Email Response: **0.0101**
- Event Attendance ↔ Alumni Meetings: **0.281** (largest positive pair in the correlation matrix)

IQR outlier counts:
- Graduation Year: 0
- Event Attendance: 2
- Email Response: 1
- Donations: 59
- Networking Events: 1
- Alumni Meetings: 21

Branch comparison:
- ECE had the highest average event attendance: **2.62**
- IT: 2.29
- ME: 2.21
- CSE: 2.13
- CSE(DS): 2.10
- CE: 2.03

Mentorship comparison:
- Mentorship = Yes: average event attendance **2.57**
- Mentorship = No: average event attendance **2.04**
- Email response averages were 56.5% and 55.7% respectively.

Batch comparison:
- Highest average event attendance: **2019 = 2.75**
- Lowest: **2023 = 1.77**
- 2024 = 2.55
- 2025 = 2.48

These are descriptive findings from the synthetic dataset. They are not causal claims.

## Module 4 — Verified Work

Executed locally in RStudio and visually inspected.

Generated:
- correlation heatmap;
- event attendance by branch boxplot;
- mentorship vs event attendance boxplot;
- batch-wise average attendance trend;
- event attendance vs email response scatter plot with linear trend.

Evidence files:
- `outputs/tables/phase2_outlier_summary.csv`
- `outputs/tables/phase2_branch_summary.csv`
- `outputs/tables/phase2_mentorship_summary.csv`
- `outputs/tables/phase2_batch_summary.csv`
- `outputs/tables/phase2_relationship_summary.csv`
- `outputs/tables/phase2_correlation_matrix.csv`
- `outputs/plots/04_correlation_heatmap.png`
- `outputs/plots/05_event_attendance_by_branch.png`
- `outputs/plots/06_mentorship_vs_attendance.png`
- `outputs/plots/07_batch_attendance_trend.png`
- `outputs/plots/08_attendance_vs_email_response.png`

## Verification

- Module 3 script completed without execution errors.
- Module 4 visualization script completed without execution errors.
- Generated visualizations were manually inspected and confirmed correct.
- Phase 2 evidence was committed and pushed to `main`.
- Phase 2 evidence commit: `1bb036a`.

## Boundary

Phase 2 is now locked for reporting.

Report 2 will document this verified work under the official Review 2 structure. No later-phase work should be backdated into Phase 2.

Next project stage: prepare Report 2, then begin Phase 3 only after the report checkpoint is established.
