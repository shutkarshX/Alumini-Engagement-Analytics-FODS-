# Alumni Engagement Analytics Studio
# Run from the repository root with: shiny::runApp("app.R")
# Dataset is synthetic; outputs are exploratory and not institutional findings.

library(shiny)
library(readr)
library(dplyr)
library(ggplot2)

clean_path <- file.path("data", "processed", "alumni_engagement_clean.csv")
raw_path <- file.path("data", "raw", "alumni_engagement_raw.csv")

if (!file.exists(clean_path)) {
  stop("Cleaned dataset not found. Run the existing R scripts from the repository root first.")
}

alumni <- read_csv(clean_path, show_col_types = FALSE)
raw_alumni <- if (file.exists(raw_path)) read_csv(raw_path, show_col_types = FALSE) else NULL

numeric_vars <- c(
  "Graduation_Year", "Event_Attendance", "Email_Response",
  "Donations", "Networking_Events", "Alumni_Meetings"
)

pretty_names <- c(
  Graduation_Year = "Graduation year",
  Event_Attendance = "Event attendance",
  Email_Response = "Email response (%)",
  Donations = "Donations",
  Networking_Events = "Networking events",
  Alumni_Meetings = "Alumni meetings"
)

ui <- fluidPage(
  tags$head(
    tags$title("Alumni Engagement Analytics Studio"),
    tags$style(HTML("
      body { background: #f5f7fb; color: #172033; font-family: Inter, system-ui, sans-serif; }
      .topbar { background: #101b35; color: white; padding: 24px 28px; margin: -15px -15px 22px; }
      .topbar h2 { margin: 0 0 7px; font-weight: 750; letter-spacing: -0.5px; }
      .topbar p { margin: 0; color: #cbd5e1; }
      .notice { background: #fff7df; border: 1px solid #f0d98b; border-radius: 10px; padding: 11px 14px; margin-bottom: 18px; color: #634c0b; }
      .metric { background: white; border: 1px solid #e3e8f2; border-radius: 13px; padding: 17px 18px; min-height: 104px; margin-bottom: 14px; }
      .metric-label { color: #64708a; font-size: 12px; text-transform: uppercase; letter-spacing: .7px; font-weight: 700; }
      .metric-value { font-size: 28px; font-weight: 750; color: #172033; margin-top: 8px; }
      .panel { background: white; border: 1px solid #e3e8f2; border-radius: 13px; padding: 18px; margin-bottom: 16px; }
      .panel h4 { margin-top: 0; font-weight: 700; }
      .small-note { color: #68748b; font-size: 12px; }
      .btn-primary { background: #334dc9; border-color: #334dc9; }
      .nav-tabs > li > a { font-weight: 650; }
      .form-control { border-radius: 8px; }
    "))
  ),
  div(class = "topbar",
      h2("Alumni Engagement Analytics Studio"),
      p("Explore engagement patterns. Inspect the data. Build evidence-backed insights.")
  ),
  tabsetPanel(
    id = "main_tabs",
    tabPanel("Overview",
      br(),
      fluidRow(
        column(3, div(class = "metric", div(class = "metric-label", "Clean records"),
                      div(class = "metric-value", textOutput("metric_records", inline = TRUE)))),
        column(3, div(class = "metric", div(class = "metric-label", "Variables"),
                      div(class = "metric-value", textOutput("metric_variables", inline = TRUE)))),
        column(3, div(class = "metric", div(class = "metric-label", "Missing values"),
                      div(class = "metric-value", textOutput("metric_missing", inline = TRUE)))),
        column(3, div(class = "metric", div(class = "metric-label", "Duplicate IDs"),
                      div(class = "metric-value", textOutput("metric_duplicates", inline = TRUE)))
        )
      ),
      fluidRow(
        column(8, div(class = "panel", h4("Engagement by graduation batch"),
                      plotOutput("overview_batch", height = 300))),
        column(4, div(class = "panel", h4("Dataset snapshot"),
                      tableOutput("overview_snapshot"),
                      p(class = "small-note", "Counts and averages are calculated from the cleaned synthetic dataset.")))
      ),
      fluidRow(
        column(12, div(class = "panel", h4("How to use this studio"),
          tags$ul(
            tags$li("Use Data Explorer to filter records and inspect the cleaned data."),
            tags$li("Use Analysis Studio to compare groups and explore correlations."),
            tags$li("Use Visualization Lab to choose variables and chart types."),
            tags$li("Export filtered data or chart-ready summaries for reproducible reporting.")
          )))
      )
    ),
    tabPanel("Data Explorer",
      br(),
      fluidRow(
        column(3, div(class = "panel",
          h4("Filter records"),
          textInput("search_id", "Search name or alumni ID", placeholder = "e.g. ALU10..."),
          selectInput("filter_branch", "Branch", choices = c("All")),
          selectInput("filter_batch", "Graduation batch", choices = c("All")),
          selectInput("filter_mentorship", "Mentorship", choices = c("All", "Yes", "No")),
          actionButton("reset_filters", "Reset filters", class = "btn-default")
        )),
        column(9, div(class = "panel",
          h4("Filtered records"),
          textOutput("filtered_count"),
          tableOutput("data_table"),
          br(),
          downloadButton("download_filtered", "Download filtered CSV", class = "btn-primary")
        ))
      ),
      fluidRow(
        column(12, div(class = "panel",
          h4("Variable dictionary"),
          tableOutput("dictionary")
        ))
      )
    ),
    tabPanel("Analysis Studio",
      br(),
      fluidRow(
        column(3, div(class = "panel",
          h4("Analysis controls"),
          p(class = "small-note", "Filter the cohort first; all comparisons and correlations below use these selections."),
          selectInput("analysis_branch", "Branch", choices = c("All")),
          selectInput("analysis_batch", "Graduation batch", choices = c("All")),
          selectInput("analysis_mentorship", "Mentorship", choices = c("All", "Yes", "No")),
          selectInput("group_by", "Compare groups by", choices = c("Branch", "Batch", "Mentorship")),
          selectInput("metric_by", "Measure", choices = setNames(names(pretty_names), unname(pretty_names)), selected = "Event_Attendance"),
          selectInput("cor_x", "Correlation: X variable", choices = setNames(names(pretty_names), unname(pretty_names)), selected = "Event_Attendance"),
          selectInput("cor_y", "Correlation: Y variable", choices = setNames(names(pretty_names), unname(pretty_names)), selected = "Email_Response")
        )),
        column(9,
          div(class = "panel", h4("Group comparison"), plotOutput("group_plot", height = 320), tableOutput("group_table")),
          div(class = "panel", h4("Relationship explorer"), plotOutput("correlation_plot", height = 320), textOutput("correlation_value"))
        )
      )
    ),
    tabPanel("Visualization Lab",
      br(),
      fluidRow(
        column(3, div(class = "panel",
          h4("Build a chart"),
          selectInput("chart_type", "Chart type",
            choices = c("Distribution (histogram)" = "hist",
                        "Group comparison (boxplot)" = "box",
                        "Relationship (scatterplot)" = "scatter")),
          selectInput("chart_x", "X variable", choices = setNames(names(pretty_names), unname(pretty_names)), selected = "Event_Attendance"),
          selectInput("chart_y", "Y variable (scatter only)", choices = setNames(names(pretty_names), unname(pretty_names)), selected = "Email_Response"),
          selectInput("chart_group", "Group by (optional)", choices = c("None", "Branch", "Batch", "Mentorship"))
        )),
        column(9, div(class = "panel", h4("Your visualization"), plotOutput("custom_plot", height = 420),
          downloadButton("download_plot", "Download chart (PNG)", class = "btn-primary")))
      )
    ),
    tabPanel("Data Quality & IG",
      br(),
      fluidRow(
        column(12, div(class = "panel",
          h4("Data quality overview"),
          p(class = "small-note", "Checks compare the repository's raw CSV with its cleaned CSV when the raw file is available."),
          tableOutput("quality_overview")
        ))
      ),
      fluidRow(
        column(5, div(class = "panel",
          h4("Column-level missing values"),
          tableOutput("quality_missing")
        )),
        column(7, div(class = "panel",
          h4("Information Gain explorer"),
          p("Information Gain estimates how much a predictor reduces uncertainty about a categorical target. Numeric predictors are split into quartile-based groups for this calculation."),
          selectInput("ig_target", "Target category", choices = c("Mentorship", "Branch"), selected = "Mentorship"),
          selectInput("ig_predictor", "Predictor variable", choices = setdiff(names(alumni), c("Alumni_ID", "Name", "Mentorship")), selected = "Branch"),
          plotOutput("ig_plot", height = 300),
          tableOutput("ig_table"),
          p(class = "small-note", "Information Gain is measured in bits. Results describe this synthetic demonstration dataset and do not imply causation.")
        ))
      )
    ),
    tabPanel("Insights & Exports",
      br(),
      fluidRow(
        column(7, div(class = "panel", h4("Descriptive findings"),
          uiOutput("insights_ui"),
          p(class = "small-note", "Findings are recalculated from the included synthetic data. Differences should not be interpreted as causal effects."))),
        column(5, div(class = "panel", h4("Export analysis"),
          p("Download a compact summary of group-level engagement metrics."),
          selectInput("export_group", "Summarize by", choices = c("Branch", "Batch", "Mentorship")),
          downloadButton("download_summary", "Download summary CSV", class = "btn-primary"),
          hr(),
          p("Export the numeric-variable correlation matrix."),
          downloadButton("download_cor", "Download correlation CSV", class = "btn-default")
        ))
      )
    )
  ),
  br(),
  p(class = "small-note", "Alumni Engagement Analytics • Foundations of Data Science • Reproducible R workflow")
)

server <- function(input, output, session) {
  updateSelectInput(session, "filter_branch", choices = c("All", sort(unique(alumni$Branch))))
  updateSelectInput(session, "filter_batch", choices = c("All", sort(unique(alumni$Batch))))
  updateSelectInput(session, "analysis_branch", choices = c("All", sort(unique(alumni$Branch))))
  updateSelectInput(session, "analysis_batch", choices = c("All", sort(unique(alumni$Batch))))
  updateSelectInput(session, "metric_by", choices = setNames(names(pretty_names), unname(pretty_names)), selected = "Event_Attendance")
  updateSelectInput(session, "cor_x", choices = setNames(names(pretty_names), unname(pretty_names)), selected = "Event_Attendance")
  updateSelectInput(session, "cor_y", choices = setNames(names(pretty_names), unname(pretty_names)), selected = "Email_Response")
  updateSelectInput(session, "chart_x", choices = setNames(names(pretty_names), unname(pretty_names)), selected = "Event_Attendance")
  updateSelectInput(session, "chart_y", choices = setNames(names(pretty_names), unname(pretty_names)), selected = "Email_Response")

  output$metric_records <- renderText(format(nrow(alumni), big.mark = ","))
  output$metric_variables <- renderText(ncol(alumni))
  output$metric_missing <- renderText(sum(is.na(alumni)))
  output$metric_duplicates <- renderText(sum(duplicated(alumni$Alumni_ID)))

  output$quality_overview <- renderTable({
    raw_n <- if (is.null(raw_alumni)) NA_integer_ else nrow(raw_alumni)
    raw_missing <- if (is.null(raw_alumni)) NA_integer_ else sum(is.na(raw_alumni))
    raw_dupes <- if (is.null(raw_alumni)) NA_integer_ else sum(duplicated(raw_alumni$Alumni_ID))
    data.frame(
      Check = c("Raw records", "Cleaned records", "Records removed during cleaning",
                "Raw missing values", "Cleaned missing values",
                "Raw duplicate alumni IDs", "Cleaned duplicate alumni IDs",
                "Cleaned columns"),
      Result = c(raw_n, nrow(alumni),
                 if (is.na(raw_n)) NA_integer_ else raw_n - nrow(alumni),
                 raw_missing, sum(is.na(alumni)), raw_dupes,
                 sum(duplicated(alumni$Alumni_ID)), ncol(alumni))
    )
  }, striped = TRUE, bordered = FALSE, spacing = "s")

  output$quality_missing <- renderTable({
    data.frame(
      Variable = names(alumni),
      Missing = vapply(alumni, function(x) sum(is.na(x)), integer(1)),
      Missing_Percent = round(vapply(alumni, function(x) mean(is.na(x)) * 100, numeric(1)), 2)
    ) %>% arrange(desc(Missing), desc(Missing_Percent))
  }, striped = TRUE, bordered = FALSE, spacing = "s")

  observe({
    predictors <- setdiff(names(alumni), c("Alumni_ID", "Name", input$ig_target))
    if (!length(predictors)) predictors <- setdiff(names(alumni), c("Alumni_ID", "Name"))
    updateSelectInput(session, "ig_predictor", choices = predictors,
                      selected = if (input$ig_predictor %in% predictors) input$ig_predictor else predictors[1])
  })

  information_gain <- reactive({
    req(input$ig_target, input$ig_predictor)
    validate(need(input$ig_target %in% names(alumni), "Choose a valid target."),
             need(input$ig_predictor %in% names(alumni), "Choose a valid predictor."),
             need(input$ig_target != input$ig_predictor, "Target and predictor must be different."))
    d <- alumni[, c(input$ig_target, input$ig_predictor), drop = FALSE]
    names(d) <- c("target", "predictor")
    d <- d[complete.cases(d), , drop = FALSE]
    validate(need(nrow(d) > 1, "Not enough complete records for this calculation."),
             need(length(unique(d$target)) > 1, "The target must contain at least two categories."))
    if (is.numeric(d$predictor)) {
      breaks <- unique(as.numeric(stats::quantile(d$predictor, probs = seq(0, 1, .25), na.rm = TRUE, type = 7)))
      if (length(breaks) >= 3) {
        d$predictor <- cut(d$predictor, breaks = breaks, include.lowest = TRUE, ordered_result = TRUE)
      } else {
        d$predictor <- factor(d$predictor)
      }
    } else {
      d$predictor <- as.factor(d$predictor)
    }
    d <- d[!is.na(d$predictor), , drop = FALSE]
    entropy <- function(x) {
      p <- as.numeric(table(x)) / length(x)
      p <- p[p > 0]
      -sum(p * log2(p))
    }
    base_entropy <- entropy(d$target)
    groups <- split(d$target, d$predictor, drop = TRUE)
    weighted_entropy <- sum(vapply(groups, function(x) length(x) / nrow(d) * entropy(x), numeric(1)))
    data.frame(
      Target = input$ig_target,
      Predictor = input$ig_predictor,
      Records_Used = nrow(d),
      Target_Entropy_Bits = round(base_entropy, 4),
      Conditional_Entropy_Bits = round(weighted_entropy, 4),
      Information_Gain_Bits = round(max(0, base_entropy - weighted_entropy), 4)
    )
  })

  output$ig_plot <- renderPlot({
    d <- information_gain()
    ggplot(d, aes(x = Predictor, y = Information_Gain_Bits)) +
      geom_col(fill = "#4058c8", width = .55) +
      geom_text(aes(label = round(Information_Gain_Bits, 4)), vjust = -0.5, size = 4) +
      scale_y_continuous(expand = expansion(mult = c(0, .2))) +
      labs(x = NULL, y = "Information Gain (bits)", title = "Information Gain for selected predictor") +
      theme_minimal(base_size = 12)
  })

  output$ig_table <- renderTable(information_gain(), digits = 4, striped = TRUE, bordered = FALSE, spacing = "s")

  output$overview_batch <- renderPlot({
    d <- alumni %>% group_by(Batch) %>% summarise(Mean = mean(Event_Attendance, na.rm = TRUE), .groups = "drop")
    ggplot(d, aes(x = factor(Batch), y = Mean)) +
      geom_col(fill = "#4058c8", width = .72) +
      geom_text(aes(label = round(Mean, 2)), vjust = -0.45, size = 3.5) +
      labs(x = "Graduation batch", y = "Mean event attendance", title = "Average event attendance by batch") +
      theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank())
  })

  output$overview_snapshot <- renderTable({
    data.frame(
      Measure = c("Mean event attendance", "Mean email response", "Alumni reporting mentorship"),
      Value = c(
        round(mean(alumni$Event_Attendance, na.rm = TRUE), 2),
        paste0(round(mean(alumni$Email_Response, na.rm = TRUE), 1), "%"),
        paste0(round(mean(alumni$Mentorship == "Yes", na.rm = TRUE) * 100, 1), "%")
      )
    )
  }, striped = TRUE, bordered = FALSE, spacing = "s")

  filtered <- reactive({
    d <- alumni
    if (!is.null(input$filter_branch) && input$filter_branch != "All") d <- d %>% filter(Branch == input$filter_branch)
    if (!is.null(input$filter_batch) && input$filter_batch != "All") d <- d %>% filter(Batch == as.numeric(input$filter_batch))
    if (!is.null(input$filter_mentorship) && input$filter_mentorship != "All") d <- d %>% filter(Mentorship == input$filter_mentorship)
    q <- trimws(input$search_id %||% "")
    if (nzchar(q)) d <- d %>% filter(grepl(q, Name, ignore.case = TRUE, fixed = TRUE) | grepl(q, Alumni_ID, ignore.case = TRUE, fixed = TRUE))
    d
  })

  observeEvent(input$reset_filters, {
    updateTextInput(session, "search_id", value = "")
    updateSelectInput(session, "filter_branch", selected = "All")
    updateSelectInput(session, "filter_batch", selected = "All")
    updateSelectInput(session, "filter_mentorship", selected = "All")
  })

  output$filtered_count <- renderText(paste(nrow(filtered()), "records match the current filters."))
  output$data_table <- renderTable(head(filtered(), 100), striped = TRUE, bordered = FALSE, spacing = "s")
  output$dictionary <- renderTable({
    data.frame(
      Variable = names(alumni),
      Meaning = c("Synthetic alumni identifier", "Synthetic display name", "Graduation batch",
                  "Academic branch", "Graduation year", "Event attendance count/score",
                  "Email response percentage", "Donation amount", "Mentorship participation",
                  "Networking event count", "Alumni meeting count")
    )
  }, striped = TRUE, bordered = FALSE, spacing = "s")

  output$download_filtered <- downloadHandler(
    filename = function() paste0("alumni_filtered_", Sys.Date(), ".csv"),
    content = function(file) write_csv(filtered(), file)
  )

  analysis_data <- reactive({
    d <- alumni
    if (!is.null(input$analysis_branch) && input$analysis_branch != "All") {
      d <- d %>% filter(Branch == input$analysis_branch)
    }
    if (!is.null(input$analysis_batch) && input$analysis_batch != "All") {
      d <- d %>% filter(Batch == as.numeric(input$analysis_batch))
    }
    if (!is.null(input$analysis_mentorship) && input$analysis_mentorship != "All") {
      d <- d %>% filter(Mentorship == input$analysis_mentorship)
    }
    d
  })

  group_data <- reactive({
    d <- analysis_data()
    validate(need(nrow(d) > 0, "No records match these cohort filters."))
    g <- input$group_by
    m <- input$metric_by
    d %>% mutate(Group = as.character(.data[[g]])) %>% group_by(Group) %>%
      summarise(Records = n(), Mean = mean(.data[[m]], na.rm = TRUE),
                Median = median(.data[[m]], na.rm = TRUE), .groups = "drop") %>%
      arrange(desc(Mean))
  })

  output$group_plot <- renderPlot({
    d <- group_data()
    ggplot(d, aes(x = reorder(Group, Mean), y = Mean)) +
      geom_col(fill = "#4058c8", width = .7) +
      coord_flip() +
      labs(x = NULL, y = paste("Mean", pretty_names[[input$metric_by]]),
           title = paste(pretty_names[[input$metric_by]], "by", input$group_by)) +
      theme_minimal(base_size = 12)
  })
  output$group_table <- renderTable(group_data(), digits = 2, striped = TRUE, spacing = "s")

  output$correlation_plot <- renderPlot({
    d <- analysis_data()
    validate(need(nrow(d) > 1, "Choose filters that leave at least two records."),
             need(input$cor_x != input$cor_y, "Choose two different variables to inspect a relationship."))
    ggplot(d, aes(x = .data[[input$cor_x]], y = .data[[input$cor_y]])) +
      geom_point(alpha = .65, color = "#4058c8") +
      geom_smooth(method = "lm", se = FALSE, color = "#d97745") +
      labs(x = pretty_names[[input$cor_x]], y = pretty_names[[input$cor_y]],
           title = "Relationship in the selected variables") +
      theme_minimal(base_size = 12)
  })
  output$correlation_value <- renderText({
    d <- analysis_data()
    if (nrow(d) < 2) return("Choose filters that leave at least two records.")
    if (input$cor_x == input$cor_y) return("Choose two different variables.")
    r <- cor(d[[input$cor_x]], d[[input$cor_y]], use = "complete.obs")
    paste0("Pearson correlation: ", round(r, 3),
           " (n = ", sum(complete.cases(d[, c(input$cor_x, input$cor_y)])),
           "). This describes linear association in the filtered synthetic sample; it does not establish causation.")
  })

  output$custom_plot <- renderPlot({
    x <- input$chart_x
    y <- input$chart_y
    g <- input$chart_group
    d <- alumni
    if (input$chart_type == "hist") {
      p <- ggplot(d, aes(x = .data[[x]])) + geom_histogram(bins = 18, fill = "#4058c8", color = "white") +
        labs(x = pretty_names[[x]], y = "Number of records")
    } else if (input$chart_type == "box") {
      if (g == "None") {
        p <- ggplot(d, aes(x = "All records", y = .data[[x]])) + geom_boxplot(fill = "#8c9cf0")
      } else {
        p <- ggplot(d, aes(x = .data[[g]], y = .data[[x]], fill = .data[[g]])) + geom_boxplot(show.legend = FALSE)
      }
      p <- p + labs(x = if (g == "None") NULL else g, y = pretty_names[[x]])
    } else {
      p <- ggplot(d, aes(x = .data[[x]], y = .data[[y]])) + geom_point(alpha = .65, color = "#4058c8") +
        geom_smooth(method = "lm", se = FALSE, color = "#d97745") +
        labs(x = pretty_names[[x]], y = pretty_names[[y]])
    }
    p + theme_minimal(base_size = 12) + theme(panel.grid.minor = element_blank())
  })

  output$download_plot <- downloadHandler(
    filename = function() paste0("alumni_visualization_", Sys.Date(), ".png"),
    content = function(file) ggsave(file, plot = {
      x <- input$chart_x; y <- input$chart_y; g <- input$chart_group
      if (input$chart_type == "hist") {
        ggplot(alumni, aes(x = .data[[x]])) + geom_histogram(bins = 18, fill = "#4058c8", color = "white") + theme_minimal()
      } else if (input$chart_type == "box") {
        if (g == "None") ggplot(alumni, aes(x = "All records", y = .data[[x]])) + geom_boxplot(fill = "#8c9cf0") + theme_minimal()
        else ggplot(alumni, aes(x = .data[[g]], y = .data[[x]], fill = .data[[g]])) + geom_boxplot() + theme_minimal()
      } else {
        ggplot(alumni, aes(x = .data[[x]], y = .data[[y]])) + geom_point(alpha = .65, color = "#4058c8") + geom_smooth(method = "lm", se = FALSE) + theme_minimal()
      }
    }, width = 9, height = 5, dpi = 180)
  )

  output$insights_ui <- renderUI({
    branch <- alumni %>% group_by(Branch) %>% summarise(avg = mean(Event_Attendance), .groups = "drop") %>% arrange(desc(avg))
    batch <- alumni %>% group_by(Batch) %>% summarise(avg = mean(Event_Attendance), .groups = "drop")
    ment <- alumni %>% group_by(Mentorship) %>% summarise(avg = mean(Event_Attendance), .groups = "drop")
    r <- cor(alumni$Event_Attendance, alumni$Email_Response, use = "complete.obs")
    tagList(
      tags$p(tags$strong("Branch comparison: "), paste0(branch$Branch[1], " has the highest mean event-attendance value in this sample (", round(branch$avg[1], 2), ").")),
      tags$p(tags$strong("Batch comparison: "), paste0(batch$Batch[which.max(batch$avg)], " has the highest mean event-attendance value across batches (", round(max(batch$avg), 2), ").")),
      tags$p(tags$strong("Mentorship comparison: "), paste0("Mean attendance is ", paste0(round(ment$avg[ment$Mentorship == "Yes"], 2)), " for mentorship participants and ", round(ment$avg[ment$Mentorship == "No"], 2), " for non-participants.")),
      tags$p(tags$strong("Relationship: "), paste0("Event attendance and email response have a Pearson correlation of ", round(r, 3), ".")),
      tags$p(tags$strong("Interpretation limit: "), "These are descriptive patterns in synthetic data. They cannot demonstrate what happens at a real institution or prove that one activity causes another.")
    )
  })

  summary_data <- reactive({
    g <- input$export_group
    alumni %>% group_by(.data[[g]]) %>%
      summarise(Records = n(),
                Mean_Event_Attendance = mean(Event_Attendance, na.rm = TRUE),
                Mean_Email_Response = mean(Email_Response, na.rm = TRUE),
                Mean_Donations = mean(Donations, na.rm = TRUE),
                Mean_Networking_Events = mean(Networking_Events, na.rm = TRUE),
                Mean_Alumni_Meetings = mean(Alumni_Meetings, na.rm = TRUE),
                .groups = "drop")
  })
  output$download_summary <- downloadHandler(
    filename = function() paste0("alumni_summary_by_", tolower(input$export_group), "_", Sys.Date(), ".csv"),
    content = function(file) write_csv(summary_data(), file)
  )
  output$download_cor <- downloadHandler(
    filename = function() paste0("alumni_correlation_matrix_", Sys.Date(), ".csv"),
    content = function(file) write.csv(cor(alumni[, numeric_vars], use = "complete.obs"), file, row.names = TRUE)
  )
}

shiny::shinyApp(ui = ui, server = server)
