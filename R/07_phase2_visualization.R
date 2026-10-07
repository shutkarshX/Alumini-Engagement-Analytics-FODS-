library(readr)
library(dplyr)
library(ggplot2)

# Phase 2: Data Visualization
# Uses the cleaned dataset produced in Phase 1.

alumni <- read_csv(
  file.path("data", "processed", "alumni_engagement_clean.csv"),
  show_col_types = FALSE
)

plot_dir <- file.path("outputs", "plots")
dir.create(plot_dir, recursive = TRUE, showWarnings = FALSE)

# 1. Correlation heatmap
numeric_vars <- alumni %>%
  select(
    Graduation_Year,
    Event_Attendance,
    Email_Response,
    Donations,
    Networking_Events,
    Alumni_Meetings
  )

correlation_matrix <- cor(numeric_vars, use = "complete.obs")

correlation_data <- as.data.frame(as.table(correlation_matrix)) %>%
  rename(Variable_X = Var1, Variable_Y = Var2, Correlation = Freq)

p1 <- ggplot(correlation_data,
             aes(x = Variable_X, y = Variable_Y, fill = Correlation)) +
  geom_tile() +
  geom_text(aes(label = sprintf("%.2f", Correlation)), size = 3) +
  scale_fill_gradient2(
    low = "steelblue",
    mid = "white",
    high = "firebrick",
    midpoint = 0,
    limits = c(-1, 1)
  ) +
  labs(
    title = "Correlation Heatmap of Alumni Engagement Variables",
    x = NULL,
    y = NULL,
    fill = "Correlation"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(
  file.path(plot_dir, "04_correlation_heatmap.png"),
  p1, width = 9, height = 7, dpi = 300
)

# 2. Event attendance distribution by branch
p2 <- ggplot(alumni, aes(x = Branch, y = Event_Attendance)) +
  geom_boxplot() +
  labs(
    title = "Event Attendance by Branch",
    x = "Branch",
    y = "Event Attendance"
  ) +
  theme_minimal()

ggsave(
  file.path(plot_dir, "05_event_attendance_by_branch.png"),
  p2, width = 9, height = 6, dpi = 300
)

# 3. Mentorship vs event attendance
p3 <- ggplot(alumni, aes(x = Mentorship, y = Event_Attendance)) +
  geom_boxplot() +
  labs(
    title = "Event Attendance by Mentorship Participation",
    x = "Mentorship Participation",
    y = "Event Attendance"
  ) +
  theme_minimal()

ggsave(
  file.path(plot_dir, "06_mentorship_vs_attendance.png"),
  p3, width = 8, height = 6, dpi = 300
)

# 4. Batch-wise average event attendance
batch_summary <- alumni %>%
  group_by(Batch) %>%
  summarise(
    Avg_Event_Attendance = mean(Event_Attendance),
    .groups = "drop"
  )

p4 <- ggplot(
  batch_summary,
  aes(x = factor(Batch), y = Avg_Event_Attendance, group = 1)
) +
  geom_line() +
  geom_point(size = 3) +
  labs(
    title = "Average Event Attendance by Graduation Batch",
    x = "Graduation Batch",
    y = "Average Event Attendance"
  ) +
  theme_minimal()

ggsave(
  file.path(plot_dir, "07_batch_attendance_trend.png"),
  p4, width = 9, height = 6, dpi = 300
)

# 5. Event attendance vs email response
p5 <- ggplot(
  alumni,
  aes(x = Event_Attendance, y = Email_Response)
) +
  geom_point(alpha = 0.65) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Event Attendance vs Email Response",
    x = "Event Attendance",
    y = "Email Response (%)"
  ) +
  theme_minimal()

ggsave(
  file.path(plot_dir, "08_attendance_vs_email_response.png"),
  p5, width = 9, height = 6, dpi = 300
)

cat("========================================\n")
cat("PHASE 2 - DATA VISUALIZATION\n")
cat("========================================\n")
cat("Five Module 4 visualizations generated successfully.\n")
cat("Plots written to outputs/plots/.\n")
