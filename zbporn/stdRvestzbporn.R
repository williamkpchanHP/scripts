# must load page before run script
rm(list = ls())
Sys.setlocale(category = 'LC_ALL', 'Chinese')
setwd("C:/Users/william/Desktop/scripts/zbporn")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

source("../retrieveFile.R")
#extract href addr
className = "a.item"

url = readline("enter url: ")
#url = "https://zbporn.com/albums/326031/ebony-and-latino-and-mulatto-piercing/"
outFilename = readline("enter outFilename without extension: ")

pagesource <- retrieveFile(url)
imgLinks <- html_nodes(pagesource, className)
imgLinks = html_attr(imgLinks, "href")
imgLinks = paste0('<img loading="lazy" src="', imgLinks, '">')

cat("\ntotal: ",length(imgLinks), "\n")

outFilename = paste0(outFilename, ".html")

sink(outFilename)
  cat(imgLinks, sep="\n")
sink()
cat(red(outFilename, " created!\n"))
shell(outFilename)
