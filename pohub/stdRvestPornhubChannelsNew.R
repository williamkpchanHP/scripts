# this must be added to setting chinese
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
#setwd("C:/Users/User/Pictures/sexpage")
setwd("C:/Users/william/Desktop/scripts/pohub")

#library(audio)
library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")
# https://www.pornhub.com/channels/dreamgirlsmembers/videos?page=1
# 2269

#titleName = "dreamgirlsmembers"
cat("\n")
titleName = readline(prompt="enter title name: ")
titleName = gsub(" |\\+", "-", titleName)

typeName = ""
while(typeName == ""){
  typeName = readline(prompt="1 channel, 2 star, 3 model, 4 search:")
}

if(typeName=="1"){
  pageHeader="https://www.pornhub.com/channels/"
  pageTail="/videos?page="
}else if(typeName=="2"){
  pageHeader="https://www.pornhub.com/pornstar/"
  pageTail="/videos?page="
}else if(typeName=="3"){
  pageHeader="https://www.pornhub.com/model/"
  pageTail="/videos?page="
}else if(typeName=="4"){
  #https://www.pornhub.com/video/search?search=ashlyn+peaks&page=2
  pageHeader="https://www.pornhub.com/video/search?search="
  pageTail="&page="
  titleName = gsub(" |\\-", "+", titleName)
}

  tailType = readline(prompt="1 ?page=, 2 &page=, 3 /videos/upload?page=")
  if(tailType=="1"){
    pageTail="?page="
  }else if(tailType=="2"){
    pageTail="&page="
  }else if(tailType=="1"){
    pageTail="/videos/upload?page="
  }

className = ".phimage"

#totalVideos = 2269
totalVideos = as.numeric(readline(prompt="enter totalVideos: "))
if(typeName=="1"){
  totalPages = ceiling(totalVideos/36)
}else{
  totalPages = ceiling(totalVideos/40)
}
theFilename = paste0('pornhub_',titleName, ".html")
allLinks = character()
wholePage = character()

addr = 1:totalPages

lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

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
#https://www.pornhub.com/pornstar/mz-berlin/videos?
for(i in 1:length(addr)){
 cat(i, "/", length(addr), " ")
 #guess_encoding(pagesource)
 #pagesource <- read_html(paste0(pageHeader,addr[i],pageTail), encoding = "UTF-8")
 #url = paste0(pageHeader,addr[i],pageTail)

 if(i ==1){
   url = paste0(pageHeader, titleName )
}else{
   url = paste0(pageHeader, titleName, pageTail,addr[i] )
   #url = paste0(pageHeader,addr[i],pageTail)
}
 cat(url, "\n")
 pagesource <- read_html(url)
#sink("text.txt")
#cat(as.character(pagesource))
#sink()

 itemList <- html_nodes(pagesource, className)
 itemList <- html_nodes(itemList, "a")
 itemHref = html_attr(itemList, "href")
 linksTxt = html_attr(itemList, "title")
 linksTxt = gsub("\'", "", linksTxt)

 images = html_nodes(itemList, "img")
 imgSrc = html_attr(images, "src")

 result = paste0('\'', itemHref, '"><img src="', imgSrc, '"><br>', linksTxt, '\',')
 cat(yellow("length(result): ",length(result), "\n"))

 allLinks = c(allLinks, result)

 if(i == 10){
   ProcessEndTime = Sys.time()
   LoopTime = as.numeric(ProcessEndTime - ProcessStartTime, units="secs")
   ecTime = length(addr)*LoopTime/10

   cat(red(
        "\n\n Expect to complete at: ", as.character(ProcessStartTime + ecTime),"\n",
        "per cycle time: ", dhms(LoopTime/10),"\n",
        "Expected total time: ", dhms(ecTime),"\n\n"
      ))
 }
}

templateHead = readLines("templateHeadPohub.txt")
templateTail = readLines("templateTailPohub.txt")
templateHead = gsub("dreamgirlsmembers", titleName, templateHead)
templateTail = gsub("dreamgirlsmembers", titleName, templateTail)
allLinks = gsub("/view_video.php\\?viewkey=", "", allLinks)
cat(red("length(allLinks) before unique: ",length(allLinks), "\n"))
allLinks = unique(allLinks)
cat(green("length(allLinks) after unique: ",length(allLinks), "\n"))
allLinks = sort(allLinks)

sink(theFilename)
cat(templateHead, sep="\n")
cat(allLinks, sep="\n")
cat(templateTail, sep="\n")
sink()

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ", dhms(LoopTime),"\n\n\n")
cat(theFilename, "created\n")
