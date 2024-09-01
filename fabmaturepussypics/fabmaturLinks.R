# this must be added to setting chinese
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
setwd("C:/Users/william/Desktop/scripts/fabmaturepussypics")

library(rvest)

pageHeader = "http://www.fabmaturepussypics.com/"
pageTail=".html"

urlList = character()
theFilename = "fabmatureLinks.html"

className = ".item-section a"

#addr = readLines("sexhd.picsTOC.html")
addr = 1:11

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

 urlList = c(urlList, itemList)
}

sink(theFilename)
cat(urlList, sep="\n")
sink()

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ",LoopTime,"\n\n\n")

