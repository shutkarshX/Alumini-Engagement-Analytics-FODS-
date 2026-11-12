# Alumni Engagement Analytics — FODS Studio

[![R](https://img.shields.io/badge/R-4.2%2B-276DC3.svg)](https://www.r-project.org/)
[![Shiny](https://img.shields.io/badge/Shiny-Interactive%20App-blue.svg)](https://shiny.rstudio.com/)
[![ggplot2](https://img.shields.io/badge/ggplot2-Visualization-orange.svg)](https://ggplot2.tidyverse.org/)
[![dplyr](https://img.shields.io/badge/dplyr-Data%20Transformation-brightgreen.svg)](https://dplyr.tidyverse.org/)
[![SDG 4](https://img.shields.io/badge/SDG%204-Quality%20Education-C5192D.svg)](https://sdgs.un.org/goals/goal4)
[![GitHub Actions](https://img.shields.io/badge/CI-Automated%20Validation-success.svg)](.github/workflows/r-validation.yml)

An analytical data science studio and reproducible R workflow developed for the **Foundations of Data Science (CCSDS0301)** Project-Based Learning (PBL) curriculum. It provides data cleaning, statistical correlation, IQR outlier detection, exploratory visualization, and an interactive **R Shiny** analytical dashboard for educational institutions.

---

## 🔬 Data Pipeline Architecture

```mermaid
flowchart TD
    Raw["Raw Dataset (data/raw/alumni_engagement_raw.csv)"]
    
    subgraph DataPrep["Phase 1: Ingestion & Quality Control"]
        S1["01_data_import.R<br/>Schema & Structure"]
        S2["02_data_quality.R<br/>Missing & Inconsistency Audit"]
        S3["03_data_cleaning.R<br/>Deduplication & Imputation"]
    end
    
    Clean[("Clean Data (alumni_engagement_clean.csv)")]
    
    subgraph Analytics["Phase 2: Statistical Modeling & EDA"]
        S4["04_data_exploration.R<br/>Descriptive Statistics"]
        S6["06_phase2_eda.R<br/>IQR Outliers & Correlations"]
        S7["07_phase2_visualization.R<br/>ggplot2 Visual Engine"]
    end

    subgraph Deliverables["Outputs & Interactive Layer"]
        Plots["8 Visual Plots (outputs/plots/)"]
        Tables["6 Summary Tables (outputs/tables/)"]
        Shiny["Interactive R Shiny Studio (app.R)"]
        CI["08_validate_outputs.R (CI Invariant Checks)"]
    end

    Raw --> S1 --> S2 --> S3 --> Clean
    Clean --> S4 --> S6 --> S7
    Clean --> Shiny
    S7 --> Plots
    S6 --> Tables
    Plots & Tables --> CI
```

---

## 📊 Visual Analytics Gallery

Here are highlights from the 8 generated exploratory data visualizations:

| Correlation Heatmap | Batch Attendance Trends |
| :---: | :---: |
| ![Correlation Heatmap](outputs/plots/04_correlation_heatmap.png) | ![Batch Attendance Trend](outputs/plots/07_batch_attendance_trend.png) |

| Event Attendance by Department | Alumni Count by Branch |
| :---: | :---: |
| ![Event Attendance by Branch](outputs/plots/05_event_attendance_by_branch.png) | ![Alumni Count by Branch](outputs/plots/01_alumni_by_branch.png) |

---

## 💻 Interactive Shiny Analytics Studio

The repository includes a full interactive Shiny web application in `app.R`:
* **Overview KPI Metrics**: Total alumni, active participation rate, and batch-level engagement breakdown.
* **Filterable Data Explorer**: Searchable records with CSV export capabilities.
* **Cohort Comparisons**: Group-level comparisons across branch, graduation batch, and mentorship enrollment.
* **Correlation Lab**: Interactive scatterplots and relationship matrices.
* **Visualization Lab**: On-the-fly customizable histograms, boxplots, and violin distributions.

### Launch the App Locally

Open RStudio or an R terminal in the repository root directory:

```r
# 1. Install dependencies
install.packages(c("shiny", "readr", "dplyr", "tidyr", "ggplot2"))

# 2. Launch the Shiny Studio
shiny::runApp("app.R")
```

---

## ⚡ Reproducible Analysis Pipeline

To execute the entire analytical pipeline from scratch, run the scripts in sequence:

```r
source("R/01_data_import.R")       # Step 1: Validate raw schema
source("R/02_data_quality.R")      # Step 2: Run missingness audit
source("R/03_data_cleaning.R")     # Step 3: Produce clean dataset
source("R/04_data_exploration.R")  # Step 4: Compute summary stats
source("R/05_basic_visualization.R")# Step 5: Generate initial plots
source("R/06_phase2_eda.R")        # Step 6: IQR outlier detection & matrix
source("R/07_phase2_visualization.R")# Step 7: Export high-res plots
source("R/08_validate_outputs.R")  # Step 8: Assert output integrity
```

---

## 📁 Repository Structure

```text
Alumini-Engagement-Analytics-FODS-/
├── app.R                          # Interactive Shiny analytics application
├── R/                             # Sequential 8-stage data pipeline scripts
│   ├── 01_data_import.R
│   ├── 02_data_quality.R
│   ├── 03_data_cleaning.R
│   ├── 04_data_exploration.R
│   ├── 05_basic_visualization.R
│   ├── 06_phase2_eda.R
│   ├── 07_phase2_visualization.R
│   └── 08_validate_outputs.R
├── data/
│   ├── raw/alumni_engagement_raw.csv
│   └── processed/alumni_engagement_clean.csv
├── outputs/
│   ├── plots/                     # 8 high-resolution PNG charts
│   └── tables/                    # 6 statistical summary CSV tables
├── docs/                          # Course documentation & phase checkpoints
│   ├── FODS_SYLLABUS_ALIGNMENT.md
│   ├── PHASE_2.md
│   ├── PHASE_2_CHECKPOINT.md
│   └── RESEARCH_NOTES.md
├── .github/workflows/
│   └── r-validation.yml           # Automated CI verification workflow
└── README.md
```

---

## 📜 Dataset & Academic Note
* **Course:** Foundations of Data Science (`CCSDS0301`).
* **Ethical Disclosure:** The project uses synthetic data to illustrate educational analytics techniques while strictly maintaining privacy. Results represent simulated exploratory analysis.
