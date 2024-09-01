# to extract user group photos

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

userHeader="https://xhamster.com/users/"
lineSignature = "window.initials="

userName = "olderwomanfun"
userName = readline(prompt="enter userName: ")
userOrCreat = readline(prompt="user or creator? 0/1: ")
if(userOrCreat==0){
  userHeader="https://xhamster.com/users/"
}else{
  userHeader="https://xhamster.com/creators/"
}

wholePage = character()
allLinks = character()

theFilename = paste0("xhamFoto ", userName, " List.html")
url = paste0(userHeader, userName, "/photos/")

batchFIleHistory = readLines("xhamFotoBatHist.txt")
historyIdx = grep(userName, batchFIleHistory)
if(length(historyIdx) !=0){
    stop(red("\nAlready Listed in xhamFotoBatHist.txt History!: ", historyIdx, "\n"))
}

cat(url, "\n")
pagesource <- read_html(url)
lastPageclassName = ".xh-paginator-button, .page-button-link"
lastPageNum <- html_nodes(pagesource, lastPageclassName)
lastPageNum = lastPageNum[length(lastPageNum)]
if(length(lastPageNum)==0){
  lastPageNum = 1
}else{
  lastPageNum = as.numeric(html_text(lastPageNum))
}

addr=1:lastPageNum
lentocpage = lastPageNum
cat("\nalbum total pages: ",lentocpage,"\n")

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

for(i in addr){
 cat(i, "of", length(addr), " ")
 if(i==1){
   url = paste0(userHeader, userName, "/photos/")
 }else{
   url = paste0(userHeader, userName, "/photos/", i)
 }

 cat("url:",url, "\n")
 pagesource <- readLines(url)
 targetLineIdx = grep(lineSignature, pagesource)
 targetLine = pagesource[targetLineIdx]
 targetLine = gsub('^.*userGalleriesCollection":', '', targetLine )
 targetLine = gsub(',"favoritesGalleryCollection.*', '', targetLine)
 targetLine = gsub(',"pagination".*', '', targetLine)
 
# writeClipboard(targetLine)
 targetLineDf = fromJSON(targetLine)

 # "icon":"friends", "privacy":1,
 # "icon":"lock",
 if("icon" %in% colnames(targetLineDf)){
    privacy = unlist(targetLineDf["icon"])
    rmIdx = grep("friends|lock", privacy)
    if(length(rmIdx)>0){
      targetLineDf =  targetLineDf[-rmIdx, ]
    }
 }

 links = unlist(targetLineDf["pageURL"])
 imgSrc = unlist(targetLineDf["thumbURL"])
 linksTxt = unlist(targetLineDf["title"])
 linksTxt = gsub("'", "\'", linksTxt)
 linksTxt = gsub(" from OlderWomanFun", "", linksTxt)

 if("imgCount" %in% colnames(targetLineDf)){
    imgCount = unlist(targetLineDf["imgCount"])
    result = paste0('000',imgCount,'<div><a href="', links, '"><img src="', imgSrc, '"><br>', linksTxt, '</a> ', imgCount, '</div>')
 }else{
    result = paste0('<div><a href="', links, '"><img src="', imgSrc, '"><br>', linksTxt, '</a></div>')
 }

 cat("length(resut): ", length(result), "\n")
 wholePage = c(wholePage, result)
 allLinks = c(allLinks, links)

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


#writeClipboard(wholePage)
templateHead = readLines("templateHeadXham.txt")
templateTail = readLines("templateTailXham.txt")
templateHead = gsub("mom50", userName, templateHead)
templateTail = gsub("mom50", userName, templateTail)

wholePage = gsub("'", ".", wholePage)
wholePage = gsub("</div>", "',", wholePage)
wholePage = sort(wholePage, decreasing=TRUE)
wholePage = gsub("^.*?<div>", "'", wholePage)


setwd("C:/Users/william/Desktop/scripts/xham")
  sink(theFilename)
  cat(templateHead, sep="\n")
  cat(wholePage, sep="\n")
  cat(templateTail, sep="\n")
  sink()

  sink(paste0(userName, "allLinks.txt"))
  cat(allLinks, sep="\n")
  sink()

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ", dhms(LoopTime),"\n\n\n")
cat(red(theFilename, "created!", "Total links: ", length(wholePage), "\n"))
cat(yellow("Total links: ", length(allLinks), " in file: ", paste0(userName, "allLinks.txt")))