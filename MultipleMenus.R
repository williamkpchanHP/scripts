# Creating Multiple Menus and Submenus in R to Source Scripts
# Main menu function
main_menu <- function() {
 choice <- menu(
  title = "MAIN MENU\nWhat would you like to do?",
  choices = c(
   "Data Processing",
   "Analysis",
   "Visualization",
   "Exit"
  )
 )
 
 switch(choice,
  "1" = data_processing_menu(),
  "2" = analysis_menu(),
  "3" = visualization_menu(),
  "4" = {cat("Goodbye!\n"); invisible()}
 )
}

# Data Processing Submenu
data_processing_menu <- function() {
 choice <- menu(
  title = "DATA PROCESSING MENU",
  choices = c(
   "Import Data",
   "Clean Data",
   "Transform Data",
   "Back to Main Menu"
  )
 )
 
 switch(choice,
  "1" = {source("scripts/import_data.R"); data_processing_menu()},
  "2" = {source("scripts/clean_data.R"); data_processing_menu()},
  "3" = {source("scripts/transform_data.R"); data_processing_menu()},
  "4" = main_menu()
 )
}

# Analysis Submenu
analysis_menu <- function() {
 choice <- menu(
  title = "ANALYSIS MENU",
  choices = c(
   "Descriptive Statistics",
   "Regression Analysis",
   "Time Series Analysis",
   "Back to Main Menu"
  )
 )
 
 switch(choice,
  "1" = {source("scripts/descriptive_stats.R"); analysis_menu()},
  "2" = {source("scripts/regression.R"); analysis_menu()},
  "3" = {source("scripts/time_series.R"); analysis_menu()},
  "4" = main_menu()
 )
}

# Visualization Submenu
visualization_menu <- function() {
 choice <- menu(
  title = "VISUALIZATION MENU",
  choices = c(
   "Basic Plots",
   "Advanced Plots",
   "Interactive Visuals",
   "Back to Main Menu"
  )
 )
 
 switch(choice,
  "1" = {source("scripts/basic_plots.R"); visualization_menu()},
  "2" = {source("scripts/advanced_plots.R"); visualization_menu()},
  "3" = {source("scripts/interactive_visuals.R"); visualization_menu()},
  "4" = main_menu()
 )
}

# Start the application
main_menu()
