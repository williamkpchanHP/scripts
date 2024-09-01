#rvest scoreland page addr
options("encoding" = "native.enc")
setwd("C:/Users/william/Desktop/scripts/R")

library(rvest)
library(crayon)

pageHeader="https://www.scoreland.com/big-boob-photos/?page="
pageTail=""

wholepage = character()
theFilename = "scoreland-big-boob-photos.txt"
className = '.item-img a'

addr = 1:333

lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")


for(i in 1:length(addr)){
 #Sys.sleep(sample(1:20,1))
 url = paste0(pageHeader,addr[i],pageTail)
 cat(i, " ", yellow(url), "\n")
 pagesource <- readLines(url)
 pagesource <- paste(pagesource, collapse = '')

 pagesource <- read_html(pagesource)

 keywordList <- html_nodes(pagesource, className)
 keywordList = as.character(keywordList)
 keywordList = gsub('<a href="', '', keywordList)
 keywordList = gsub('\\?nats.*', '', keywordList)

 wholepage = c(wholepage, keywordList)
}

options("encoding" = "UTF-8")

sink(theFilename)
 cat(paste(wholepage), sep="\n")
sink()

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat(red("loop time: ",LoopTime,"\n"))

