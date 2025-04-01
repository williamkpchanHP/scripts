library(shiny)
ui <- navbarPage(
 "My R Application",
 tabPanel("Data Processing",
   sidebarLayout(
    sidebarPanel(
     actionButton("import", "Import Data"),
     actionButton("clean", "Clean Data"),
     actionButton("transform", "Transform Data")
    ),
    mainPanel(
     verbatimTextOutput("data_output")
    )
   )),
 tabPanel("Analysis",
   sidebarLayout(
    sidebarPanel(
     selectInput("analysis_type", "Analysis Type",
        choices = c("Descriptive", "Regression", "Time Series")),
     actionButton("run_analysis", "Run Analysis")
    ),
    mainPanel(
     verbatimTextOutput("analysis_output")
    )
   )),
 tabPanel("Visualization",
   sidebarLayout(
    sidebarPanel(
     selectInput("plot_type", "Plot Type",
        choices = c("Histogram", "Scatter", "Boxplot")),
     actionButton("generate_plot", "Generate Plot")
    ),
    mainPanel(
     plotOutput("visualization_output")
    )
   ))
)

server <- function(input, output) {
 # Data Processing
 observeEvent(input$import, {
  source("scripts/import_data.R")
  output$data_output <- renderPrint({"Data imported successfully!"})
 })
 
 observeEvent(input$clean, {
  source("scripts/clean_data.R")
  output$data_output <- renderPrint({"Data cleaned successfully!"})
 })
 
 # Analysis
 observeEvent(input$run_analysis, {
  switch(input$analysis_type,
   "Descriptive" = source("scripts/descriptive_stats.R"),
   "Regression" = source("scripts/regression.R"),
   "Time Series" = source("scripts/time_series.R"))
  output$analysis_output <- renderPrint({"Analysis completed!"})
 })
 
 # Visualization
 observeEvent(input$generate_plot, {
  switch(input$plot_type,
   "Histogram" = source("scripts/histogram.R"),
   "Scatter" = source("scripts/scatter.R"),
   "Boxplot" = source("scripts/boxplot.R"))
 })
}

shinyApp(ui = ui, server = server)
