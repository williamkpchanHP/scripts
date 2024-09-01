# https://forum.xnxx.com/forums/pic-movie-post.8/
library(rvest)
library(crayon)
library(jsonlite)
 ligSilver <- make_style("#889988")
setwd("C:/Users/william/Desktop/scripts/xnxx")

source("../retrieveFile.R")
allpages = character()
imgClassName = "h3 a"
lastpage = 2395
urlHeader = "https://forum.xnxx.com/forums/pic-movie-post.8/page-"
for(i in 83:lastpage){
  cat(i,".")
  url = paste0(urlHeader, i)
  pagesource <- retrieveFile(url)
    allimgs <- html_nodes(pagesource, imgClassName)
    allimgs = html_attr(allimgs, "href")
    allimgs = gsub('threads/', 'https://forum.xnxx.com/threads/',allimgs)
    allpages = c(allpages, allimgs)
}

sink("xnxxallforumlinks.txt")
  cat(allpages, sep="\n")
sink()
