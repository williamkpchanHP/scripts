#dynamic menu functions 
# Enhanced main menu with error handling
main_menu <- function() {
 while(TRUE) {
  choice <- menu(
   title = "\nMAIN MENU\nWhat would you like to do?",
   choices = c(
    "Data Processing",
    "Analysis",
    "Visualization",
    "Exit"
   )
  )
  
  tryCatch({
   switch(choice,
    "1" = data_processing_menu(),
    "2" = analysis_menu(),
    "3" = visualization_menu(),
    "4" = return(invisible()),
    stop("Invalid choice")
   )
  }, error = function(e) {
   message("\nError: ", e$message)
   message("Please try again.")
  })
 }
}

# Enhanced submenu function template
create_submenu <- function(title, choices, scripts, parent_menu) {
 function() {
  while(TRUE) {
   choice <- menu(
    title = paste0("\n", toupper(title), " MENU"),
    choices = c(choices, "Back to Previous Menu")
   )
   
   if (choice == length(choices) + 1) {
    return(parent_menu())
   }
   
   tryCatch({
    if (choice > 0 && choice <= length(scripts)) {
     if (file.exists(scripts[choice])) {
      source(scripts[choice])
     } else {
      stop(paste("Script file not found:", scripts[choice]))
     }
    } else {
     stop("Invalid choice")
    }
   }, error = function(e) {
    message("\nError: ", e$message)
    message("Please try again.")
   })
  }
 }
}

# Define menu structure
menu_structure <- list(
 main = list(
  title = "Main Menu",
  choices = c("Data Processing", "Analysis", "Visualization", "Exit"),
  actions = c("data_processing", "analysis", "visualization", "exit")
 ),
 data_processing = list(
  title = "Data Processing",
  choices = c("Import Data", "Clean Data", "Transform Data"),
  scripts = c("scripts/import.R", "scripts/clean.R", "scripts/transform.R")
 ),
 analysis = list(
  title = "Analysis",
  choices = c("Descriptive Stats", "Regression", "Time Series"),
  scripts = c("scripts/descriptive.R", "scripts/regression.R", "scripts/timeseries.R")
 ),
 visualization = list(
  title = "Visualization",
  choices = c("Basic Plots", "Advanced Plots", "Interactive"),
  scripts = c("scripts/basic_plots.R", "scripts/advanced_plots.R", "scripts/interactive.R")
 )
)

# Create menu functions dynamically
data_processing_menu <- create_submenu(
 menu_structure$data_processing$title,
 menu_structure$data_processing$choices,
 menu_structure$data_processing$scripts,
 main_menu
)

analysis_menu <- create_submenu(
 menu_structure$analysis$title,
 menu_structure$analysis$choices,
 menu_structure$analysis$scripts,
 main_menu
)

visualization_menu <- create_submenu(
 menu_structure$visualization$title,
 menu_structure$visualization$choices,
 menu_structure$visualization$scripts,
 main_menu
)

# Start the application
main_menu()
