# FODS — Alumni Engagement Analytics
## Project Context / Handoff Memory

### Project
- Course: Foundations of Data Science (FODS)
- Course Code: CCSDS0301
- Project: Alumni Engagement Analytics
- Student: Utkarsh Sharma
- Roll: 2501331540283
- Program: BTech CSE (Data Science)
- Semester: 3rd
- Section/Batch: D
- Academic Year: 2026–2027
- Assignment: Individual
- Domain: Educational Analytics
- SDG: 4 — Quality Education

### Phase Structure
- Phase 1 → Module 1 + Module 2
- Phase 2 → Module 3 + Module 4
- Phase 3 → Final integration/refinement

### Project Rules
1. Work is completed phase-by-phase.
2. Only actual completed work may be reported.
3. The previously submitted FODS Report 1 is a locked submission/reference and is not evidence of actual implementation.
4. Do not backdate Phase 2 or Phase 3 work into Phase 1.
5. Do not fabricate datasets, findings, screenshots, tests, or results.
6. Later phases build on the cleaned Phase 1 dataset.

### Phase 1 Status
Phase 1 is complete and pushed to GitHub.

Completed:
- Synthetic alumni dataset created and documented as synthetic.
- RStudio environment verified.
- Data import implemented.
- Data quality inspection implemented.
- Data cleaning/preprocessing implemented.
- Basic descriptive exploration implemented.
- Three initial ggplot2 visualizations implemented.
- Phase 1 checkpoint documented.
- Git history merged and pushed successfully.

### Actual Phase 1 Dataset
250 raw records, 11 columns:
- Alumni_ID
- Name
- Batch
- Branch
- Graduation_Year
- Event_Attendance
- Email_Response
- Donations
- Mentorship
- Networking_Events
- Alumni_Meetings

Quality issues:
- 1 missing Event_Attendance
- 1 missing Email_Response
- 1 missing Donations
- whitespace/inconsistent text formatting
- inconsistent Mentorship capitalization/spacing
- duplicate Alumni_ID ALU1228

Cleaning result:
- 250 raw rows → 249 cleaned rows
- Missing values after cleaning: 0

Exploration:
- Average Event_Attendance: 2.22
- Average Email_Response: 55.95%
- Average Networking_Events: 1.93
- Average Alumni_Meetings: 1.44
- Branch counts: CSE 68, CSE(DS) 42, ME 39, ECE 37, IT 34, CE 29
- Event_Attendance range: 0–8
- Email_Response range: 2–100
- Donations range: ₹0–₹15,000

Initial visualizations:
- Alumni count by branch
- Event attendance distribution
- Event attendance vs email response

### Phase 1 Boundary
Initial descriptive analysis and plots support Phase 1 validation. Deeper EDA, outlier analysis, relationships/correlation, comparative analysis, and advanced visualization belong to Phase 2.

### Git
Repository: https://github.com/shutkarshX/Alumini-Engagement-Analytics-FODS-
Planned Phase 1 tag: FODS-PHASE-1-MODULE-1-2

### Next Phase
Phase 2 continues from the cleaned dataset with deeper EDA, outliers, relationships/correlation, comparative analysis, stronger visualizations, meaningful findings, and a Phase 2 checkpoint.
