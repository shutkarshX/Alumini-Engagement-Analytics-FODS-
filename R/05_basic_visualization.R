library(readr)
library(ggplot2)

alumni <- read_csv(file.path("data","processed","alumni_engagement_clean.csv"), show_col_types=FALSE)
plot_dir <- file.path("outputs","plots")
dir.create(plot_dir, recursive=TRUE, showWarnings=FALSE)

p1 <- ggplot(alumni, aes(x=Branch)) + geom_bar() +
  labs(title="Alumni Distribution by Branch", x="Branch", y="Number of Alumni") + theme_minimal()
ggsave(file.path(plot_dir,"01_alumni_by_branch.png"), p1, width=8, height=5, dpi=150)

p2 <- ggplot(alumni, aes(x=Event_Attendance)) + geom_histogram(binwidth=1, boundary=-0.5) +
  labs(title="Distribution of Event Attendance", x="Events Attended", y="Number of Alumni") + theme_minimal()
ggsave(file.path(plot_dir,"02_event_attendance_distribution.png"), p2, width=8, height=5, dpi=150)

p3 <- ggplot(alumni, aes(x=Event_Attendance, y=Email_Response)) + geom_point(alpha=.65) +
  geom_smooth(method="lm", se=FALSE) +
  labs(title="Event Attendance vs Email Response", x="Event Attendance", y="Email Response (%)") + theme_minimal()
ggsave(file.path(plot_dir,"03_attendance_vs_email_response.png"), p3, width=8, height=5, dpi=150)
