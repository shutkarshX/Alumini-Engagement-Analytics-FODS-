library(readr)
library(dplyr)
library(tidyr)
alumni_raw <- read_csv(file.path("data","raw","alumni_engagement_raw.csv"), show_col_types=FALSE)
alumni_clean <- alumni_raw %>%
  mutate(
    Alumni_ID=trimws(Alumni_ID), Name=trimws(Name), Batch=trimws(Batch),
    Branch=trimws(Branch), Mentorship=trimws(Mentorship),
    Mentorship=case_when(
      tolower(Mentorship)=="yes" ~ "Yes",
      tolower(Mentorship)=="no" ~ "No",
      TRUE ~ Mentorship
    )
  ) %>%
  distinct(Alumni_ID, .keep_all=TRUE) %>%
  mutate(
    Email_Response=replace_na(Email_Response, median(Email_Response, na.rm=TRUE)),
    Donations=replace_na(Donations, median(Donations, na.rm=TRUE)),
    Event_Attendance=replace_na(Event_Attendance, median(Event_Attendance, na.rm=TRUE))
  )
write_csv(alumni_clean, file.path("data","processed","alumni_engagement_clean.csv"))
cat("Clean rows:", nrow(alumni_clean), "\n")
cat("Missing values after cleaning:", sum(is.na(alumni_clean)), "\n")
