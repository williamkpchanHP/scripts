options("encoding" = "native.enc")
Sys.setlocale(category = 'LC_ALL', 'Chinese')	# this must be added to script to show chinese

setwd("C:/Users/william/Desktop/scripts")

library(rvest)
library(crayon)
pageHeader= "https://www.pornpics.com/"

theFilename = "testpp.html"
wholepage = character()
className = 'img[data-src]'

 url = pageHeader
 pagesource <- read_html(url, encoding = "UTF-8")
  keywordList <- pagesource %>% html_nodes(className) %>% html_attr("data-src")
  wholepage = c(wholepage, keywordList)

sink(theFilename)
  cat(wholepage, sep = "\n")
sink()
