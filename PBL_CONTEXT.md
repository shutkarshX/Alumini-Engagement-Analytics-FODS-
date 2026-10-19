# PBL Context — Alumni Engagement Analytics

## Project identity
- Repository: shutkarshX/Alumini-Engagement-Analytics-FODS-
- Project: Alumni Engagement Analytics
- Course: Foundations of Data Science (CCSDS0301)
- Assignment: Individual
- Student: Utkarsh Sharma
- Roll No.: 2501331540283
- Domain: Educational Analytics
- SDG: 4 — Quality Education
- Stack: R, RStudio, readr, dplyr, tidyr, ggplot2

## Reporting rules
- Report 1 was already submitted and is locked; do not recreate or backdate it.
- Use the latest NIET report instructions for required coverage, word/page limits, references, and final report structure.
- The user's submitted Report 1 is a formatting reference, not proof of the implementation it described.
- Never fabricate research, feedback, results, screenshots, validation, or progress.
- The dataset is synthetic because institutional alumni records were unavailable; never present it as real institutional data.
- College report PDFs and editable drafts belong in the private `shutkarshX/PBL-Reports` repository. Code, datasets, outputs, and technical docs belong here.
- Keep the preferred original report presentation where possible, but reconcile it with explicit requirements in the latest NIET guide.
- The user will upload the Report 2 PDF/DOCX into the private PBL-Reports repository using local Git commands; do not attempt binary upload through the connector. This does not prevent working on report content, compliance, or other project files.

## Verified Phase 1
- Created a synthetic dataset with 250 raw records and 11 variables.
- Verified R 4.6.1, RStudio 2026.09.0+174, and required packages.
- Inspected dimensions, data types, missing values, duplicate IDs, categories, and numeric summaries.
- Identified missing values in Event_Attendance, Email_Response, Donations; duplicate Alumni_ID ALU1228; and inconsistent text formatting.
- Cleaned data to 249 records and zero missing values.
- Performed descriptive exploration and generated three initial plots.
- Scripts: `R/01_data_import.R` through `R/05_basic_visualization.R`.
- Phase 1 coverage: Module 1 + Module 2.

## Verified Phase 2
### Module 3 — Exploratory Data Analysis
- Script: `R/06_phase2_eda.R`.
- Executed successfully in RStudio.
- Produced six CSV analysis tables: outlier summary, branch summary, mentorship summary, batch summary, relationship summary, correlation matrix.
- Verified correlations:
  - Event Attendance ↔ Email Response: 0.214
  - Event Attendance ↔ Alumni Meetings: 0.281
  - Event Attendance ↔ Donations: 0.064
  - Networking Events ↔ Email Response: -0.0215
- IQR outlier counts: Graduation Year 0, Event Attendance 2, Email Response 1, Donations 59, Networking Events 1, Alumni Meetings 21.
- These findings describe the synthetic dataset only; do not claim causation or real institutional trends.

### Module 4 — Data Visualization
- Script: `R/07_phase2_visualization.R`.
- Generated and manually checked five Phase 2 plots:
  - `04_correlation_heatmap.png`
  - `05_event_attendance_by_branch.png`
  - `06_mentorship_vs_attendance.png`
  - `07_batch_attendance_trend.png`
  - `08_attendance_vs_email_response.png`
- Eight plot files exist overall when Phase 1's three plots are included.
- Evidence commit: `1bb036a`.
- Phase 2 checkpoint: `docs/PHASE_2_CHECKPOINT.md`.
- Added `R/08_validate_outputs.R` and `.github/workflows/r-validation.yml` for reproducibility checks; hosted CI is pending its first completed run.

## Report 2 state
Local drafts created in the working session:
- `FODS_Report_2_FINAL_WITH_REPO_LINK.docx`
- `FODS_Report_2_FINAL_WITH_REPO_LINK.pdf` (latest PDF in local workspace at time of checkpoint; approx. 391 KB, four A4 pages total).
The report includes a recreated RStudio-style code visual, not a literal screenshot captured from the user's machine.

The report is not yet confirmed submission-ready against the latest NIET guide:
- Guide says Report II covers Sections 9–10: Module 3 and Module 4.
- Individual Assignment Report II body limit is one page.
- Current PDF is four pages total (title page plus three body pages) and uses the older numbered progress-report structure.
- Current PDF lacks a references section; guide specifies at least four references for Report II.
- Guide lists an appendix/source-code allowance for Report II; current preferred-style PDF has no formal appendix.
- The final PDF has not yet been archived in the private PBL-Reports repository.
Resolve these items against the applicable faculty instructions before calling the report final. Do not fabricate references or use a synthetic screenshot as if it were a genuine capture.

## Phase boundaries
- Phase 1 / Report 1: Module 1 + Module 2 — completed; Report 1 submitted/locked.
- Phase 2 / Report 2: Module 3 + Module 4 — implementation completed and verified; report compliance/archival remains.
- Phase 3 / Final Report: Module 5 onward plus final integration — not yet completed.

## Next actions
1. User reviews and uploads `FODS_Report_2_REVISED.pdf` to `PBL-Reports/Semester 3/FODS/` from their PC; optionally upload the DOCX too.
2. Confirm with faculty whether a separate source-code appendix is mandatory despite the user's preference not to add one.
3. After the user confirms archival, record the exact filenames/commit in the private archive.
4. Verify exact Module 5 syllabus topics before starting Phase 3.
