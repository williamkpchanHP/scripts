# https://forum.xnxx.com/forums/pic-movie-post.8/
library(rvest)
library(crayon)
library(jsonlite)
 ligSilver <- make_style("#889988")
setwd("C:/Users/william/Desktop/scripts/xnxx")

allpages = character()
urlHeader = "https://forum.xnxx.com/threads/mature.391738/page-"
for(i in 1:253){
  cat(".")
  url = paste0(urlHeader, i)
  pagesource <- read_html(url)
    imgClassName = ".messageText .bbCodeImage"
    allimgs <- html_nodes(pagesource, imgClassName)
    allimgs = html_attr(allimgs, "src")
    allimgs = paste0('<img src="', allimgs, '">')
    rmidx = grep("data/attachments", allimgs)
    allimgs = allimgs[-rmidx]
    allpages = c(allpages, allimgs)
}

sink("testimg.html")
  cat(allpages, sep="\n")
sink()
