# perform OCR (Optical Character Recognition) to detect the text "guideline"

library(httr)
library(tesseract)

# URL of the image
image_url <- "https://66.media.tumblr.com/tumblr_m40q65pLrN1r8xqlio1_1280.jpg"

# Fetch the image
response <- GET(image_url)

# Check if the request was successful
if (status_code(response) == 200) {
  # Save the image to a temporary file
  temp_file <- tempfile(fileext = ".png")
  writeBin(content(response, "raw"), temp_file)
  
  # Perform OCR on the image
  text <- ocr(temp_file)
  
  # Check if "guideline" is present in the text
  if (grepl("guideline", text, ignore.case = TRUE)) {
    print("The text 'guideline' was found!")
  } else {
    print("The text 'guideline' was not found.")
  }
  
  # Clean up by removing the temporary file
  unlink(temp_file)
} else {
  print("Failed to fetch the image.")
}
