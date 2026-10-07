library(readr)
library(dplyr)

alumni_raw <- read_csv(file.path("data","raw","alumni_engagement_raw.csv"), show_col_types=FALSE)
cat("Rows:", nrow(alumni_raw), "\n")
cat("Columns:", ncol(alumni_raw), "\n")
print(names(alumni_raw))
print(head(alumni_raw))
