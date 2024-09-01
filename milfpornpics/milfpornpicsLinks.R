# this must be added to setting chinese
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
setwd("C:/Users/william/Desktop/scripts/milfpornpics")

library(rvest)

pageHeader = "http://www.milfpornpics.xxx/?pg="
pageTail=""

wholePage = character()
theFilename = "milfpornpics.html"

className = ".thumbs a"

#addr = readLines("sexhd.picsTOC.html")
addr = 1:39

lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")

for(i in 1:length(addr)){
 cat(i, "/", length(addr), " ")

 url = paste0(pageHeader,addr[i],pageTail)
 cat(url, "\n")
 pagesource <- read_html(url)

 itemList <- html_nodes(pagesource, className)

 itemList = html_attr(itemList, 'href')
 itemList = as.character(itemList)

 wholePage = c(wholePage, itemList)
}

sink(theFilename)
cat(wholePage, sep="\n")
sink()

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ",LoopTime,"\n\n\n")

