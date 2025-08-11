# perform OCR (Optical Character Recognition) to detect the text "guideline"
# .webp will cause error, remove .webp before ocr
rm(list = ls())

library(crayon)
library(httr)
library(tesseract)

# URL of the image
image_url <- "https://66.media.tumblr.com/tumblr_m40q65pLrN1r8xqlio1_1280.jpg"

chkEmptyImg <- function(image_url){
  # Fetch the image
  response <- GET(image_url)

  # Check if the request was successful
  if (status_code(response) == 200) {
    # Save the image to a temporary file
    temp_file <- tempfile(fileext = ".png")
    writeBin(content(response, "raw"), temp_file)

    # Perform OCR on the image
    tryCatch({
      text <- ocr(temp_file)
    }, error = function(e) {
      text ="n"
    })

    # Check if "guideline" is present in the text
    if (grepl("guideline", text, ignore.case = TRUE)) {
      result = "y"
      cat(red(" y"))
    }else{
      result = "n"
      cat(green(" n"))
    }

    # Clean up by removing the temporary file
    unlink(temp_file)
  } else {
    print("Failed to fetch the image.")
    result = "y"
  }

  return(result)
}


workpath = "C:/Users/william/Desktop/scripts/tumbler"
setwd(workpath)
cat("\n\n\n")
cat("\nperform OCR to detect the text 'guideline'\n")

inputFile = "tumblrList.js"
txtfile <- readLines(inputFile)

# clean file
imgLines = grep("'<img src=", txtfile)
txtfile = txtfile[imgLines]

txtfile = sub(".*?(http.*)", "\\1", txtfile)
txtfile = gsub('">.*', "", txtfile)

# begin exam
rmIdx = numeric(0)

for(linNo in 1:length(txtfile)){
  url = txtfile[linNo]
  cat("\n", linNo, url)

  chkresult = chkEmptyImg(url)
  if(chkresult == "y"){
    rmIdx = c(rmIdx, linNo)
  }
}

cat(yellow("\nJob complete! Total empty images: ", length(rmIdx), "\n"))

txtfile = txtfile[-rmIdx]

outputfile = "tumblrListBackup.js"
sink(outputfile)
 cat(txtfile, sep="\n")
sink()

cat(red(outputfile, " is saved!"))
