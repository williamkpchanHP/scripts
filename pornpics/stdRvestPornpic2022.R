# this download cannot download full page and reason unknown

# this must be added to setting chinese
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
setwd("C:/Users/william/Desktop/scripts")
library(rvest)
library(crayon)

#pageTail="/"
pageTail=""
pageHeader = readline(prompt="enter pageHeader if not default, else press enter: ")
if(pageHeader == ""){
  pageHeader = "https://www.pornpics.com/galleries/"
}

wholePage = character()
titleName = ""

while(titleName == ""){
  titleName = readline(prompt="enter titleName: ")
}
theFilename = paste0("pornpics", titleName, ".html")

# remember to remove &#9;
addr = readLines(paste0(titleName, ".txt"))

className = ".thumbwook a" # pornpic
lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")

finishBeep <- function(rptCnt){ # beep count
    while(rptCnt>0){
        play(sin(1:6000/10))
        Sys.sleep(0.2)
     rptCnt = rptCnt-1
    }
}

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

 url = paste0(pageHeader,addr[i],pageTail)
 cat(url, "\n")
 pagesource <- read_html(url)

 itemList <- html_nodes(pagesource, className)

 itemList = html_attr(itemList, 'href')
 itemList = as.character(itemList)
 itemList = gsub('https.*?1280/', '\'', itemList)
 itemList = gsub('\\.jpg', '\',', itemList)

 wholePage = c(wholePage, itemList)

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
templateHead = gsub("mom50", titleName, templateHead)

sink(theFilename)
cat(templateHead, sep="\n")
cat(wholePage, sep="\n")
cat(templateTail, sep="\n")
sink()

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ", dhms(LoopTime),"\n\n\n")
cat(theFilename, "created\n")
#finishBeep(1)
