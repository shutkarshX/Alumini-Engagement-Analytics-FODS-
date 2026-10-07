library(readr)
library(dplyr)

alumni <- read_csv(file.path("data","processed","alumni_engagement_clean.csv"), show_col_types=FALSE)
cat("\n--- Structure ---\n")
glimpse(alumni)
cat("\n--- Summary Statistics ---\n")
print(summary(alumni))
cat("\n--- Average Engagement Measures ---\n")
print(alumni %>% summarise(
  Avg_Event_Attendance=mean(Event_Attendance),
  Avg_Email_Response=mean(Email_Response),
  Avg_Networking_Events=mean(Networking_Events),
  Avg_Alumni_Meetings=mean(Alumni_Meetings),
  Total_Donations=sum(Donations)
))
cat("\n--- Branch Counts ---\n")
print(count(alumni, Branch, sort=TRUE))
