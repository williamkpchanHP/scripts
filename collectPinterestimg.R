# collect Pinterest images with keyword
keyword <- readline(prompt="enter keyword:")

url <- paste0("https://www.pinterest.com/search/pins/?q=", URLencode(keyword))

# Send a GET request
page <- read_html(url)
# Extract the image URLs using CSS selectors or XPath:
image_urls <- page %>%
  html_nodes("img") %>%
  html_attr("src")

# Subset the image URLs to get the 10 images
image_urls <- head(image_urls, 10)
# Print the image URLs:
print(image_urls)

