# R Script to Extract Dynamically Loaded Content using WebDriver (Improved Version)

# Function to check and install packages
install_if_missing <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}

# Install and load required packages
required_packages <- c("RSelenium", "xml2", "rvest", "dplyr", "wdman", "netstat")
sapply(required_packages, install_if_missing)

# Function to get user input
get_user_input <- function() {
  cat("Enter the URL to scrape: ")
  url <- readline()
  
  cat("Enter number of interactions/loops (to load dynamic content): ")
  loops <- as.integer(readline())
  
  return(list(url = url, loops = loops))
}

# Function to initialize Selenium with better error handling
init_selenium <- function() {
  tryCatch({
    # Try to connect to existing server first
    remDr <- remoteDriver(
      browserName = "chrome",
      port = 4567L
    )
    remDr$open(silent = TRUE)
    return(remDr)
  }, error = function(e) {
    cat("Starting new Selenium server...\n")
    
    # Find an available port
    free_port <- netstat::free_port()
    
    # Start Selenium server
    selenium(
      port = free_port,
      version = "latest",
      chromever = "latest",
      check = FALSE
    )
    
    # Give it time to start
    Sys.sleep(5)
    
    # Connect to the new server
    remDr <- remoteDriver(
      browserName = "chrome",
      port = free_port
    )
    remDr$open(silent = TRUE)
    return(remDr)
  })
}

# Function to interact with page
interact_with_page <- function(remDr, loops) {
  for (i in 1:loops) {
    tryCatch({
      # Scroll to bottom of page
      remDr$executeScript("window.scrollTo(0, document.body.scrollHeight);")
      
      # Wait for dynamic content to load
      Sys.sleep(2)
      
      cat(paste0("Interaction ", i, " of ", loops, " completed\n"))
    }, error = function(e) {
      cat(paste0("Error during interaction ", i, ": ", e$message, "\n"))
    })
  }
}

# Function to extract images and iframes
extract_content <- function(remDr) {
  tryCatch({
    # Get page source
    page_source <- remDr$getPageSource()[[1]]
    
    # Parse HTML
    html <- read_html(page_source)
    
    # Extract all images (including those in data-src)
    images <- html %>% 
      html_nodes("img") %>% 
      sapply(function(x) {
        src <- html_attr(x, "src") %||% html_attr(x, "data-src") %||% "No source"
        alt <- html_attr(x, "alt") %||% "No alt text"
        paste0('<img src="', src, '" alt="', alt, '">')
      })
    
    # Extract all iframes
    iframes <- html %>% 
      html_nodes("iframe") %>% 
      sapply(function(x) {
        src <- html_attr(x, "src") %||% "No source"
        paste0('<iframe src="', src, '"></iframe>')
      })
    
    return(list(images = images, iframes = iframes))
  }, error = function(e) {
    cat(paste0("Error extracting content: ", e$message, "\n"))
    return(list(images = character(0), iframes = character(0)))
  })
}

# Function to save content to HTML
save_to_html <- function(content) {
  filename <- format(Sys.time(), "%y%m%d_%H%M.html")
  
  html_content <- paste0(
    '<!DOCTYPE html>
    <html>
    <head>
      <title>Extracted Content - ', filename, '</title>
      <meta charset="UTF-8">
      <style>
        img { max-width: 300px; display: block; margin: 10px; border: 1px solid #ccc; }
        iframe { width: 400px; height: 300px; margin: 10px; border: 1px solid #ccc; }
      </style>
    </head>
    <body>
      <h1>Extracted Images (', length(content$images), ')</h1>
      ', paste(content$images, collapse = ""), '
      
      <h1>Extracted Iframes (', length(content$iframes), ')</h1>
      ', paste(content$iframes, collapse = ""), '
    </body>
    </html>'
  )
  
  writeLines(html_content, filename)
  cat(paste0("Content saved to: ", filename, "\n"))
}

# Main function
main <- function() {
  # Get user input
  inputs <- get_user_input()
  
  # Initialize Selenium
  remDr <- init_selenium()
  on.exit({
    try(remDr$close(), silent = TRUE)
    try(remDr$closeServer(), silent = TRUE)
  })
  
  # Navigate to URL
  tryCatch({
    remDr$navigate(inputs$url)
    Sys.sleep(3) # Initial page load
    
    # Interact with page to load dynamic content
    interact_with_page(remDr, inputs$loops)
    
    # Extract content
    content <- extract_content(remDr)
    
    # Save to HTML
    save_to_html(content)
  }, error = function(e) {
    cat(paste0("Error in main process: ", e$message, "\n"))
  })
}

# Run the script
main()
