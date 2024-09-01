#Sys.setlocale(category = 'LC_ALL', 'Chinese')	# this must be added to script to show chinese

options("encoding" = "native.enc")
Sys.setlocale(category = 'LC_ALL', 'Chinese')	# this must be added to script to show chinese
setwd("C:/R programs/Extracts by R")
setwd("C:/Users/william/Desktop/scripts/rgsex")

library(rvest)
library(crayon)
cat(red("scrape pink-sluts gallery\nNote imgs protected!!!\n"))
scrapeUrl = readline("enter url: ")

wholepage = character()
theFilename = "scrapeUrl.html"
className = ".gall-pst-img"

 pagesource <- read_html(scrapeUrl)
 keywordList <- html_nodes(pagesource, className)
 keywordList = as.character(keywordList)
 keywordList = gsub("/p-", "/", keywordList)
 keywordList = gsub('name=".*?"', "", keywordList)
 keywordList = gsub(' alt=".*?"', "", keywordList)
 keywordList = gsub('class="gall-pst-img"', "", keywordList)

options("encoding" = "UTF-8")
sink(theFilename)
 cat(keywordList, sep="\n")
sink()

cat(red("Job complete!\n"))

