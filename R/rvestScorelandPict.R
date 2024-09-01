#rvest scoreland page addr
options("encoding" = "native.enc")
setwd("C:/Users/william/Desktop/scripts/R")

library(rvest)
library(crayon)

wholepage = character()
theFilename = "scoreland-big-boob-Allphotos.txt"
className = '.lazyload-wrap img w-100, .tn a '

addr = readLines("scoreland-big-boob-photos.txt")

lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")


for(i in 1:length(addr)){
 #Sys.sleep(sample(1:20,1))
 url = addr[i]
 cat(i, " ", yellow(url), "\n")
 pagesource <- readLines(url)
 pagesource <- paste(pagesource, collapse = '')

 pagesource <- read_html(pagesource)

 keywordList <- html_nodes(pagesource, className)
 keywordList = as.character(keywordList)
 keywordList = gsub('<a href=.*?src="', 'https', keywordList)
 keywordList = gsub('_tn.jpg.*', '.jpg', keywordList)
 keywordList = keywordList[1] # total 16 picts, use first pict as index, te rest add nums

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

