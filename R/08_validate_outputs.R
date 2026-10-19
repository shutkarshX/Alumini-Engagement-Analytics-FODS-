# Validate the reproducibility outputs for the FODS project.
# Run from the repository root after scripts 01-07.

required_packages <- c("readr", "dplyr", "tidyr", "ggplot2")
missing_packages <- required_packages[
  !vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)
]
if (length(missing_packages) > 0) {
  stop("Missing required packages: ", paste(missing_packages, collapse = ", "))
}

raw_path <- file.path("data", "raw", "alumni_engagement_raw.csv")
clean_path <- file.path("data", "processed", "alumni_engagement_clean.csv")
stopifnot(file.exists(raw_path), file.exists(clean_path))

raw <- readr::read_csv(raw_path, show_col_types = FALSE)
clean <- readr::read_csv(clean_path, show_col_types = FALSE)

expected_columns <- c(
  "Alumni_ID", "Name", "Batch", "Branch", "Graduation_Year",
  "Event_Attendance", "Email_Response", "Donations", "Mentorship",
  "Networking_Events", "Alumni_Meetings"
)

if (nrow(raw) != 250L) stop("Expected 250 raw records; found ", nrow(raw), ".")
if (ncol(raw) != 11L) stop("Expected 11 raw columns; found ", ncol(raw), ".")
if (!identical(names(raw), expected_columns)) {
  stop("Raw dataset columns do not match the expected schema/order.")
}
if (nrow(clean) != 249L) stop("Expected 249 cleaned records; found ", nrow(clean), ".")
if (!identical(names(clean), expected_columns)) {
  stop("Cleaned dataset columns do not match the expected schema/order.")
}
if (anyNA(clean)) stop("Cleaned dataset still contains missing values.")
if (anyDuplicated(clean$Alumni_ID) > 0L) stop("Cleaned dataset contains duplicate Alumni_ID values.")

expected_tables <- c(
  "phase2_outlier_summary.csv",
  "phase2_branch_summary.csv",
  "phase2_mentorship_summary.csv",
  "phase2_batch_summary.csv",
  "phase2_relationship_summary.csv",
  "phase2_correlation_matrix.csv"
)
expected_plots <- c(
  "01_alumni_by_branch.png",
  "02_event_attendance_distribution.png",
  "03_attendance_vs_email_response.png",
  "04_correlation_heatmap.png",
  "05_event_attendance_by_branch.png",
  "06_mentorship_vs_attendance.png",
  "07_batch_attendance_trend.png",
  "08_attendance_vs_email_response.png"
)

missing_tables <- expected_tables[
  !file.exists(file.path("outputs", "tables", expected_tables))
]
missing_plots <- expected_plots[
  !file.exists(file.path("outputs", "plots", expected_plots))
]
if (length(missing_tables)) {
  stop("Missing generated tables: ", paste(missing_tables, collapse = ", "))
}
if (length(missing_plots)) {
  stop("Missing generated plots: ", paste(missing_plots, collapse = ", "))
}

empty_plots <- expected_plots[
  file.info(file.path("outputs", "plots", expected_plots))$size <= 0
]
if (length(empty_plots)) {
  stop("Generated plot files are empty: ", paste(empty_plots, collapse = ", "))
}

cat("FODS validation passed.\n")
cat("Raw dataset: ", nrow(raw), " rows x ", ncol(raw), " columns.\n", sep = "")
cat("Clean dataset: ", nrow(clean), " rows; zero missing values; unique Alumni_ID values.\n", sep = "")
cat("Verified generated outputs: ", length(expected_tables), " tables and ",
    length(expected_plots), " plots.\n", sep = "")
