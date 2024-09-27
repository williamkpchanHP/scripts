# this download cannot download full page and reason unknown

# this must be added to setting chinese
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
#setwd("C:/Users/william/Desktop/scripts")
setwd("C:/Users/william/Desktop/scripts/xham/R")

#library(audio)
library(rvest)
library(crayon)
library(jsonlite)
 ligSilver <- make_style("#889988")

titleName = readline("enter titleName: ")
url = readline("enter url: ")

wholePage = character()
historyFile = "xhamsterFotoHistory.txt"
batchFIleHistory = readLines(historyFile)

historyIdx = grep(url, batchFIleHistory)
if(length(historyIdx) !=0){
    repeatAgain = readline("Already Listed in xhamsterFotoHistory.txt History! repat job? 0/1(y): ")
    if(repeatAgain == "0"){
      stop(red("\nStop! ", historyIdx, "\n"))
    }
}
cat(url, "\n")
pagesource <- read_html(url)
lastPageclassName = ".test-pager li, .page-button-link"
lastPageNum <- html_nodes(pagesource, lastPageclassName)

if(length(lastPageNum)==0){
  lastPageNum = 1
}else{
  lastPageIdx = length(lastPageNum)
  thelastLine = lastPageNum[lastPageIdx]
  lastPageNum = as.numeric(html_text(thelastLine))
}

addr=1:lastPageNum
lentocpage = lastPageNum
cat("\ntotal pages: ",lentocpage,"\n")

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")

dhms <- function(t){
    paste(t %/% (60*60*24), "day" 
         ,paste(formatC(t %/% (60*60) %% 24, width = 2, format = "d", flag = "0")
               ,formatC(t %/% 60 %% 60, width = 2, format = "d", flag = "0")
               ,formatC(t %% 60, width = 2, format = "d", flag = "0")
               ,sep = ":"
               )
         )
}

albumurl = url
for(i in 1:length(addr)){
 cat(i, "of", length(addr), " ")
 if(i!=1){
    albumurl = paste0(url, "/",i)
 }

 cat("url:",albumurl, "\n\n")

 pagesource <- readLines(albumurl)
 targetLineIdx = grep("window.initials", pagesource)
 targetLine = pagesource[targetLineIdx]
 targetLine = unlist(strsplit(targetLine, '"spriteURL":'))
 targetLine = targetLine[-(1:3)]
 targetLine = gsub('\\\\/', '/', targetLine)
cat("targetLine", targetLine,"\n")
 title = gsub('^.*?title":"', '', targetLine)
 title = gsub('","thumbId.*', '', title)
cat("title", length(title),"\n")

 pageURL = gsub('^.*?"pageURL":"', '', targetLine)
 pageURL = gsub('","thumbURL.*', '', pageURL)
 pageURL = gsub('<a href="https://xhamster.com/videos/', "'", pageURL)
cat("pageURL", length(pageURL),"\n")


#cat(pageURL, sep="\n")
 thumbURL = gsub('^.*?"thumbURL":"', '', targetLine)
 thumbURL = gsub('","previewThumbURL.*', '', thumbURL)
cat("thumbURL", length(thumbURL),"\n")
 video = gsub('^.*?"trailerURL":"', '', targetLine)
 video = gsub('","isHD.*', '', video)
cat("video", length(video),"\n")

 result = paste0('<a href="', pageURL, '"><img src="', thumbURL, '"><br>',
   title,'</a><br><video controls preload="none" preload="none" loop autoplay><source src="', video, "',")
 cat("\n\nlength(resut): ", length(result), "\n\n")
 wholePage = c(wholePage, result)
cat("wholePage", length(wholePage),"\n")

 if(i == 10){
   ProcessEndTime = Sys.time()
   LoopTime = as.numeric(ProcessEndTime - ProcessStartTime, units="secs")
   ecTime = length(addr)*LoopTime/10

   cat(red(
        "\n\n Expect to complete at: ", as.character(ProcessStartTime + ecTime),"\n",
        "per cycle time: ", dhms(LoopTime/10),"\n",
        "total time: ", dhms(ecTime),"\n\n"
      ))
 }
}

templateHead = readLines("templateHeadArrayXhamFoto.txt")
templateTail = readLines("templateTailArrayXhamFoto.txt")
templateHead = gsub("penny-barber", paste0(titleName, ": ",length(wholePage)), templateHead)
templateTail = gsub("penny-barber", paste0(titleName, ": ",length(wholePage)), templateTail)
if(length(wholePage)<60){
  templateTail = gsub("showRange = 60", paste0("showRange = ",length(wholePage)), templateTail)
}
templateTail = gsub("lineHeader = .*", 'lineHeader = \'<a href="https://xhamster.com/videos/', templateTail)
templateTail = gsub("lineTail = .*", 'lineTail = "></video><br>"', templateTail)

wholePage = gsub("'", ".", wholePage)

rmidx = grep('<a href="https://xhamster.com/users/', wholePage)
if(length(rmidx)>0){ wholePage = wholePage[-rmidx] }


theFilename = paste0("xhamVideo ",titleName, ".html")
setwd("C:/Users/william/Desktop/scripts/xham/")
  sink(theFilename)
  cat(templateHead, sep="\n")
  cat(wholePage, sep="\n")
  cat(templateTail, sep="\n")
  sink()


ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ", dhms(LoopTime),"\n\n\n")
cat(theFilename, "created!", "Total links: ", length(wholePage), "\n")
theFilename = paste0('"',theFilename,'"')

      write(url, file=historyFile, append=TRUE)
      cat(yellow("\n", historyFile, "updated!\n"))
