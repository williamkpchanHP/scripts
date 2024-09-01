
#Sys.setlocale(category = 'LC_ALL', 'Chinese')	# this must be added to script to show chinese

setwd("C:/Users/william/Desktop/scripts/R")

library(rvest)
library(crayon)
pageHeader="https://www.tomorrowporn.com/st/archives/archive"
pageTail = ".html"

wholepage = character()
theFilename = "tomorrowporn.html"

addr = 1:32
className = '.thumbs'

lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")

for(i in 1:length(addr)){
#for(i in 1:2){
 cat("remaining Pages: ", length(addr) - i, " ")
 url = paste0(pageHeader, addr[i], pageTail)
 cat("\n",i, blue(url), "\n")
 # Sys.sleep(sample(2:6, 1))
 pagesource <- read_html(url)
  keywordList <- html_nodes(pagesource, className)
  keywordList = as.character(keywordList)
  cat(
     red("keywordList length: ", length(keywordList)),
     yellow("str1 len: ", nchar(keywordList[1]), " str2 len: ", nchar(keywordList[2]),"\n")
  )

  maxPageNum = as.character(html_nodes(pagesource, ".pppagination a"))
  maxPageNum = maxPageNum[length(maxPageNum)-1]
  maxPageNum = as.numeric(gsub('^.*?</span> |</a>',"",maxPageNum))
  cat(" maxPageNum: ", maxPageNum)
  wholepage = c(wholepage, keywordList)
  if(length(maxPageNum)>0){
    cat(" subPage\n")
    for(j in 2:maxPageNum){
      cat(j,".")
      url = paste0(pageHeader, addr[i], pageTail, "page/", j,"/")
      cat(url, "\n")
      pagesource <- read_html(url)
      keywordList <- html_nodes(pagesource, className)
      keywordList = as.character(keywordList)
      wholepage = c(wholepage, keywordList)
    }
  }
}

sink(theFilename)
  cat(wholepage, sep = "\n")
sink()

cat(yellow("\nJob completed!\n\n"))
ProcessEndTime = Sys.time()
cat("\n", format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("loop time: ",LoopTime,"\n")
