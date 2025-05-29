#This script will:
#1. Ask for a URL and number of loops (page interactions)
#2. Use RSelenium to extract dynamically loaded content
#3. Save all images and iframes to an HTML file
#4. Name the file with today's date in yymmdd_hhmm format

# Load required libraries
if (!require("RSelenium")) install.packages("RSelenium")
if (!require("xml2")) install.packages("xml2")
if (!require("rvest")) install.packages("rvest")
if (!require("dplyr")) install.packages("dplyr")

library(RSelenium)
library(xml2)
library(rvest)
library(dplyr)

# Function to get user input
get_user_input <- function() {
  cat("Enter the URL to scrape: ")
  url <- readline()
  
  cat("Enter number of interactions/loops (to load dynamic content): ")
  loops <- as.integer(readline())
  
  return(list(url = url, loops = loops))
}

# Function to initialize Selenium
init_selenium <- function() {
  # Check if a Selenium server is already running
  tryCatch({
    remDr <- remoteDriver(port = 4567L)
    remDr$open()
    return(remDr)
  }, error = function(e) {
    # If not, start a new server
    rD <- rsDriver(browser = "chrome", port = 4567L, chromever = "latest")
    return(rD$client)
  })
}

# Function to interact with page (scroll, wait, etc.)
interact_with_page <- function(remDr, loops) {
  for (i in 1:loops) {
    # Scroll to bottom of page
    remDr$executeScript("window.scrollTo(0, document.body.scrollHeight);")
    
    # Wait for dynamic content to load (adjust time as needed)
    Sys.sleep(2)
    
    # Print progress
    cat(paste0("Interaction ", i, " of ", loops, " completed\n"))
  }
}

# Function to extract images and iframes
extract_content <- function(remDr) {
  # Get page source
  page_source <- remDr$getPageSource()[[1]]
  
  # Parse HTML
  html <- read_html(page_source)
  
  # Extract all images
  images <- html %>% 
    html_nodes("img") %>% 
    sapply(function(x) {
      src <- html_attr(x, "src")
      alt <- html_attr(x, "alt") %||% "No alt text"
      data_src <- html_attr(x, "data-src") %||% "No data-src"
      paste0('<img src="', src, '" alt="', alt, '" data-src="', data_src, '">')
    })
  
  # Extract all iframes
  iframes <- html %>% 
    html_nodes("iframe") %>% 
    sapply(function(x) {
      src <- html_attr(x, "src")
      paste0('<iframe src="', src, '"></iframe>')
    })
  
  return(list(images = images, iframes = iframes))
}

# Function to save content to HTML
save_to_html <- function(content) {
  # Generate filename with current date/time
  filename <- format(Sys.time(), "%y%m%d_%H%M.html")
  
  # Create HTML structure
  html_content <- paste0(
    '<!DOCTYPE html>
    <html>
    <head>
      <title>Extracted Content - ', filename, '</title>
      <meta charset="UTF-8">
    </head>
    <body>
      <h1>Extracted Images</h1>
      ', paste(content$images, collapse = "<br>"), '
      
      <h1>Extracted Iframes</h1>
      ', paste(content$iframes, collapse = "<br>"), '
    </body>
    </html>'
  )
  
  # Write to file
  writeLines(html_content, filename)
  cat(paste0("Content saved to: ", filename, "\n"))
}

# Main function
main <- function() {
  # Get user input
  inputs <- get_user_input()
  
  # Initialize Selenium
  remDr <- init_selenium()
  on.exit(remDr$close())
  
  # Navigate to URL
  remDr$navigate(inputs$url)
  Sys.sleep(3) # Initial page load
  
  # Interact with page to load dynamic content
  interact_with_page(remDr, inputs$loops)
  
  # Extract content
  content <- extract_content(remDr)
  
  # Save to HTML
  save_to_html(content)
}

# Run the script
main()

## Instructions for Use:
#1. Make sure you have Chrome installed on your system
#2. Install the required R packages if you haven't already
#3. Run the script - it will prompt you for:
#   - The URL to scrape
#   - Number of interactions/loops (how many times to scroll/wait for dynamic content)
#4. The script will save an HTML file with all images and iframes in your working directory

## Notes:

#- The script attempts to connect to an existing Selenium server or starts a new one
#- You may need to adjust the chromever parameter based on your Chrome version
#- The wait times (Sys.sleep) may need adjustment based on the website's loading speed
#- The script captures both src and data-src attributes for images, as many lazy-loaded images use data-src
