library(readr)
library(dplyr)

# Phase 2: Exploratory Data Analysis
# Uses the cleaned dataset produced in Phase 1.

alumni <- read_csv(
  file.path("data", "processed", "alumni_engagement_clean.csv"),
  show_col_types = FALSE
)

numeric_vars <- alumni %>%
  select(
    Graduation_Year,
    Event_Attendance,
    Email_Response,
    Donations,
    Networking_Events,
    Alumni_Meetings
  )

cat("========================================\n")
cat("PHASE 2 - EXPLORATORY DATA ANALYSIS\n")
cat("========================================\n\n")

# 1. Univariate descriptive statistics
cat("--- UNIVARIATE STATISTICS ---\n")
print(summary(numeric_vars))

# 2. Outlier identification using the IQR rule
find_outliers <- function(x) {
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr_value <- q3 - q1
  lower <- q1 - 1.5 * iqr_value
  upper <- q3 + 1.5 * iqr_value

  sum(x < lower | x > upper, na.rm = TRUE)
}

outlier_summary <- data.frame(
  Variable = names(numeric_vars),
  Outlier_Count = sapply(numeric_vars, find_outliers)
)

cat("\n--- OUTLIER SUMMARY ---\n")
print(outlier_summary)

# 3. Correlation matrix
correlation_matrix <- cor(numeric_vars, use = "complete.obs")

cat("\n--- CORRELATION MATRIX ---\n")
print(round(correlation_matrix, 3))

# 4. Selected engagement relationships
relationship_summary <- alumni %>%
  summarise(
    Attendance_Email_Correlation =
      cor(Event_Attendance, Email_Response, use = "complete.obs"),
    Attendance_Donation_Correlation =
      cor(Event_Attendance, Donations, use = "complete.obs"),
    Networking_Email_Correlation =
      cor(Networking_Events, Email_Response, use = "complete.obs"),
    Meetings_Email_Correlation =
      cor(Alumni_Meetings, Email_Response, use = "complete.obs")
  )

cat("\n--- ENGAGEMENT RELATIONSHIPS ---\n")
print(relationship_summary)

# 5. Branch comparison
branch_summary <- alumni %>%
  group_by(Branch) %>%
  summarise(
    Alumni_Count = n(),
    Avg_Event_Attendance = mean(Event_Attendance),
    Avg_Email_Response = mean(Email_Response),
    Avg_Donations = mean(Donations),
    Avg_Networking_Events = mean(Networking_Events),
    Avg_Alumni_Meetings = mean(Alumni_Meetings),
    .groups = "drop"
  ) %>%
  arrange(desc(Avg_Event_Attendance))

cat("\n--- BRANCH-WISE ENGAGEMENT ---\n")
print(branch_summary)

# 6. Mentorship comparison
mentorship_summary <- alumni %>%
  group_by(Mentorship) %>%
  summarise(
    Alumni_Count = n(),
    Avg_Event_Attendance = mean(Event_Attendance),
    Avg_Email_Response = mean(Email_Response),
    Avg_Donations = mean(Donations),
    Avg_Networking_Events = mean(Networking_Events),
    Avg_Alumni_Meetings = mean(Alumni_Meetings),
    .groups = "drop"
  )

cat("\n--- MENTORSHIP COMPARISON ---\n")
print(mentorship_summary)

# 7. Batch comparison
batch_summary <- alumni %>%
  group_by(Batch) %>%
  summarise(
    Alumni_Count = n(),
    Avg_Event_Attendance = mean(Event_Attendance),
    Avg_Email_Response = mean(Email_Response),
    Avg_Donations = mean(Donations),
    Avg_Networking_Events = mean(Networking_Events),
    Avg_Alumni_Meetings = mean(Alumni_Meetings),
    .groups = "drop"
  ) %>%
  arrange(Batch)

cat("\n--- BATCH-WISE ENGAGEMENT ---\n")
print(batch_summary)

# Save Phase 2 analysis tables.
table_dir <- file.path("outputs", "tables")
dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)

write_csv(outlier_summary,
          file.path(table_dir, "phase2_outlier_summary.csv"))
write_csv(branch_summary,
          file.path(table_dir, "phase2_branch_summary.csv"))
write_csv(mentorship_summary,
          file.path(table_dir, "phase2_mentorship_summary.csv"))
write_csv(batch_summary,
          file.path(table_dir, "phase2_batch_summary.csv"))
write_csv(relationship_summary,
          file.path(table_dir, "phase2_relationship_summary.csv"))
write.csv(correlation_matrix,
          file.path(table_dir, "phase2_correlation_matrix.csv"))

cat("\nPhase 2 EDA script completed.\n")
cat("Analysis tables written to outputs/tables/.\n")
