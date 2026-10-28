# FODS Semester 3 Syllabus Alignment

Course: Foundations of Data Science Lab  
Course code: CCSDS0351  
Source: B.Tech CSE (Data Science), Second Year 2026–27 syllabus, Semester III.

This document maps the Alumni Engagement Analytics project to the practicals listed in the course syllabus. It is a planning aid, not a claim that every practical has already been completed.

## Existing project work

| Syllabus area | Current project evidence | Status |
|---|---|---|
| R programming and data frames (Practicals 1–3, 19) | The project uses R scripts and a Shiny app to load and inspect a cleaned data frame. | Partially demonstrated |
| Data formats (Practical 13) | The current app loads CSV files for raw and cleaned data. | Partial: other listed formats are not demonstrated by the app |
| Statistical summaries and EDA (Practical 14) | The app reports descriptive metrics and compares group means/medians. | Related skills demonstrated; the required Iris exercise is not part of this project |
| Distribution plots and outlier inspection (Practical 15) | The Visualization Lab supports histograms and boxplots; the app also supports scatterplots. | Partially demonstrated; explicit outlier identification/reporting should be documented |
| Regression (Practical 16) | Scatterplots can include a fitted linear trend line. | Basic visual demonstration; a clearly reported regression analysis is still a gap |
| Data cleaning (Practical 17) | The repository has a raw-to-cleaned data workflow and quality checks. | Existing workflow; confirm the cleaning steps and outputs are documented for the final report |
| 3D visualization (Practical 18) | The current app focuses on 2D plots. | Not demonstrated |
| Complete cleaning and Information Gain visualization (Practical 20) | Data-quality metrics are displayed, but a dedicated Information Gain calculation/visualization is not present in the current app. | **Highest-priority gap** |

## Recommended next implementation

Add a dedicated **Data Quality & Information Gain** section, keeping the existing working tabs intact.

1. Show data-quality checks for missing values, duplicate IDs, and relevant inconsistent values.
2. Show the cleaning workflow and before/after record counts using the repository's existing raw and cleaned CSV files.
3. Calculate and visualize Information Gain for appropriate predictors against a clearly defined categorical target. If a numeric engagement measure is used as the target, document how it is converted into categories; do not present the resulting values as institutional findings.
4. Add a short interpretation explaining that this project uses synthetic demonstration data.
5. Test the new section and existing tabs before considering the implementation complete.

## Other syllabus gaps to track

- Demonstrate reading additional formats listed in Practical 13 (such as XLSX, JSON, XML, TXT, and HTML) in a separate reproducible R script rather than forcing every format into the dashboard.
- Add a clearly labelled regression output (model, coefficient/fit summary, and interpretation) for Practical 16.
- Track the Iris-dataset exercise and 3D plot as separate syllabus exercises if the instructor expects each indicative practical to be submitted individually.

## Scope and evidence rules

- Do not claim the alumni records are real institutional data; the project dataset is synthetic.
- Do not claim that Information Gain, regression, or correlation proves causation.
- Do not mark a syllabus practical complete solely because the app has a superficially similar chart. Keep separate evidence for the actual required exercise.
- The syllabus describes its practical list as indicative and not limited to the listed items; confirm any instructor-specific submission requirements separately.
