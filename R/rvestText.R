#Sys.setlocale(category = 'LC_ALL', 'Chinese')	# this must be added to script to show chinese

options("encoding" = "native.enc")
Sys.setlocale(category = 'LC_ALL', 'Chinese')	# this must be added to script to show chinese
setwd("C:/Users/william/Desktop/scripts")

library(rvest)
library(crayon)

pageHeader="https://www.yuedu88.com/chunyouchun/"
pageTail=".html"

wholepage = character()
theFilename = "cunyoucun.html"
className = ".article"

addr = 13162:13181

lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")


for(i in 1:length(addr)){
 Sys.sleep(sample(1:20,1))
 url = paste0(pageHeader,addr[i],pageTail)
 cat(i, " ", yellow(url), "\n")
 pagesource <- read_html(url, encoding="utf-8")
 keywordList <- html_nodes(pagesource, className)
 keywordList = as.character(keywordList)
 #keywordList = gsub(' src=".*?_images', ' src="https://docs.blender.org/manual/en/latest/_images', keywordList)

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

