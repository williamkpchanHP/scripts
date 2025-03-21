# rvest Tumbler Archive from tumblrAddr.txt

workpath = "C:/Users/william/Desktop/scripts/tumbler"
setwd(workpath)

library(rvest)
#https://www.99csw.com/book/3783/129158.htm
pageHeader = ""
pageTail = ""
className = "video, img.RoN4R, .tmblr-full, RoN4R, tPU70, xhGbM, img"

source("../retrieveFile.R")

addr = readLines("tumblrAddr.txt")
theFilename = "rvestTumblerArchive.html"

wholePage = character()
lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")

counter = 0
wholeList = character()

for(i in 1:lentocpage){
  counter = counter +1
  url = paste0(pageHeader, addr[i], pageTail)
  cat(counter, "of",lentocpage, url, "\n\n")
  
  pagesource <- retrieveFile(url)
  if(!is.character(pagesource)){
    itemList <- html_nodes(pagesource, className)
    itemList = as.character(itemList)
    itemList = gsub("^.*?poster","'<video controls loop poster",itemList)
    itemList = gsub("</video>","</video>',",itemList)
    itemList = gsub(' controlslist="nodownload"',"",itemList)
    wholeList = c(wholeList, itemList)
    cat(yellow("item numbers: ", length(itemList), " wholeList number: ", length(wholeList), "\n"))
  }
}

sink(theFilename)
  cat(wholeList, sep="\n")
sink()

cat(red("\n",workpath, "/",theFilename, "created!\n"))

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("loop time: ",LoopTime,"\n")

