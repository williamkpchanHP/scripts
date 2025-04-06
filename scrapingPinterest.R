# scraping Pinterest

library(rvest)
library(httr)
library(dplyr)

search_term <- "cats"
url <- paste0("https://www.pinterest.com/search/pins/?q=", search_term)

# Send GET request
response <- GET(url, add_headers(
  "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
))

# Parse HTML
html <- read_html(response)

# Extract image URLs (Pinterest's structure may change)
image_urls <- html %>%
  html_nodes("[data-test-id='pin'] img") %>%
  html_attr("src") %>%
  na.omit() %>%
  unique()

head(image_urls)
