# PHASE 1 CHECKPOINT — Alumni Engagement Analytics

**Course:** Foundations of Data Science (CCSDS0301)  
**Project:** Alumni Engagement Analytics  
**Phase:** Phase 1 — Foundation and Data Preparation

## Work Completed
- Project setup
- Dataset creation
- Data import in R/RStudio
- Data understanding and inspection
- Data-quality analysis
- Data cleaning/preprocessing
- Descriptive statistics
- Initial visualization

## Dataset
- Raw records: 250
- Variables: 11
- Records after duplicate handling: 249

## Data-Quality Findings
- 1 missing Event_Attendance value
- 1 missing Email_Response value
- 1 missing Donations value
- 1 duplicate Alumni_ID (ALU1228)
- inconsistent Mentorship values (yes and Yes)
- whitespace inconsistencies in selected text fields

## Preprocessing
- standardized text whitespace
- standardized Mentorship values to Yes/No
- removed the duplicate Alumni_ID record
- replaced missing numeric values using column medians
- generated the processed dataset

Result: 249 records, 11 variables, 0 missing values after cleaning.

## Descriptive Results
- Average event attendance: 2.22 events
- Average email response: 55.95%
- Average networking events: 1.93
- Average alumni meetings: 1.44
- Event attendance range: 0–8
- Email response range: 2–100%
- Donation range: ₹0–₹15,000

Branch distribution: CSE 68; CSE(DS) 42; ME 39; ECE 37; IT 34; CE 29.

## Initial Visualizations
1. Alumni Distribution by Branch
2. Distribution of Event Attendance
3. Event Attendance vs Email Response

The third plot shows an upward fitted trend. At this stage it is treated as an observed association, not causation.

## Phase 1 Boundary
Phase 1 is complete. Phase 2 will continue from the cleaned dataset with deeper relationship, correlation, and comparative analysis.

Only work actually completed during the current implementation is recorded here. The previously submitted Report 1 is a requirement/reference document, not evidence for these results.
