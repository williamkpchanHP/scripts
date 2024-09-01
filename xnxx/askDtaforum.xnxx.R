# https://forum.xnxx.com/forums/pic-movie-post.8/
library(rvest)
library(crayon)
library(jsonlite)
 ligSilver <- make_style("#889988")
setwd("C:/Users/william/Desktop/scripts/xnxx")

allpages = character()
cat("\n\n\n")
urlHeader = "https://forum.xnxx.com/threads/mature.391738/page-"

urlHeader = readline("enter url header:")
lastpageNum = as.numeric(readline("enter url lastpage Num:"))
outputName = paste0(readline("enter outputName:"),".html")
cat(yellow("working!\n"))
for(i in 1:lastpageNum){
  cat(".")
  url = paste0(urlHeader, i)
  pagesource <- read_html(url)
    imgClassName = ".messageText .bbCodeImage, .messageText img"
    allimgs <- html_nodes(pagesource, imgClassName)
    allimgs = html_attr(allimgs, "src")
    allimgs = paste0("'", allimgs, "',")
    rmidx = grep("data/attachments", allimgs)
    allimgs = allimgs[-rmidx]
    allpages = c(allpages, allimgs)
}

templateHead = readLines("../templateHead.txt")
templateTail = readLines("../templateTail.txt")
templateHead = gsub("mom50", outputName, templateHead)
templateTail = gsub("mom50", outputName, templateTail)
templateTail = gsub("cdni.pornpics.com/1280/", "", templateTail)
templateTail = gsub(".jpg", "", templateTail)
templateTail = gsub("showLongTips", "../showLongTips", templateTail)
if(length(allpages)<60){
  templateTail = gsub("showRange = 21", paste0("showRange = ", length(allpages)), templateTail)
}
sink(outputName)
  cat(templateHead, sep="\n")
  cat(allpages, sep="\n")
  cat(templateTail, sep="\n")
sink()
cat(red("\nJob completed!\n\n\n"))