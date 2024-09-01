# collect star pages
# this download cannot download full page and reason unknown

# this must be added to setting chinese
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
setwd("C:/Users/william/Desktop/scripts/")

#library(audio)
library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

starHeader="https://xhamster.com/pornstars/all/categories/"
starName = "big-tits"
#starName = readline(prompt="enter Keyword: ")
pageTail=""

theFilename = paste0("xhamsterStar", starName, ".html")
titleName = starName
pageHeader = paste0(starHeader, starName)

wholePage = character()
className = ".xh-paginator-button"
url = pageHeader
cat(url, "\n")
pagesource <- read_html(url)
lastPageNum <- html_nodes(pagesource, className)
lastPageNum = lastPageNum[length(lastPageNum)]
if(length(lastPageNum)==0){
  lastPageNum = 1
}else{
  lastPageNum = as.numeric(html_text(lastPageNum))
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

for(i in 1:length(addr)){
 cat(i, "/", length(addr), " ")

 url = paste0(pageHeader,'/',addr[i],pageTail)
 cat(url, "\n")
 pagesource <- read_html(url)
 className = ".pornstar-thumb-container"

 itemList <- html_nodes(pagesource, className)
 itemHref = html_nodes(itemList, "a.pornstar-thumb-container__image")
 itemRemain = grep("img", itemHref) # ignore imageless
 itemHref = itemHref[itemRemain]

 links = html_attr(itemHref, "href")

 images = html_nodes(itemHref, "img")
 imgSrc = html_attr(images, "src")
 linksTxt = html_attr(images, "alt")
 linksTxt = gsub("\\'", "\\\\'", linksTxt)

 countNum = html_nodes(itemList, ".videos")
 countNum = gsub("^.*?/i> |</div>", "", countNum)
 countNumIdx = grep("\\.", countNum)

 countNum = gsub("K|k", "000", countNum)
 countNum[countNumIdx] = gsub("000", "00", countNum[countNumIdx])
 countNum[countNumIdx] = gsub("\\.", "", countNum[countNumIdx])
 countNum =as.numeric(countNum)

 result = paste0('\'', countNum, ':',links, '"><img src="', imgSrc, '"><br>',countNum, ': ',linksTxt, '\',')

wholePage = c(wholePage, result)

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
templateHead = readLines("templateHead.txt")
templateTail = readLines("templateTail.txt")
templateHead = gsub("mom50", paste0(titleName, length(wholePage)), templateHead)
templateTail = gsub("mom50", paste0(titleName, length(wholePage)), templateTail)

sink(theFilename)
cat(templateHead, sep="\n")
cat(wholePage, sep="\n")
cat(templateTail, sep="\n")
sink()

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ", dhms(LoopTime),"\n\n\n")
cat(theFilename, "created\n", "links: ", length(wholePage), "\n")
theFilename = paste0('"',theFilename,'"')
shell(theFilename)
