# this rvest video links and save as js file
# and update eoptionsArray by sourcing updateoptionsArray.R
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
#setwd("C:/Users/User/Pictures/sexpage")
setwd("C:/Users/william/Desktop/scripts/pohub")
#setwd("C:/Users/User/Pictures/sexpage")

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
while(typeName==""){
  typeName = readline(prompt="1 channel, 2 pornstar, 3 model, 4 users (1,2,3,4):")
}

if(typeName=="1"){
  pageHeader="https://www.pornhub.com/channels/"
  pageTail="/videos?page="
}else if(typeName=="2"){
  pageHeader="https://www.pornhub.com/pornstar/"
}else if(typeName=="3"){
  pageHeader="https://www.pornhub.com/model/"
}else if(typeName=="4"){
  pageHeader="https://www.pornhub.com/users/"
}

tailType = readline(prompt="1 ?page=, 2 /videos?page=, 3 /videos/upload?page=, 4 num, 5 /videos/public?page= (1,2,3,4,5):")
  if(tailType=="1"){
    pageTail="?page="
  }else if(tailType=="2"){
    pageTail="/videos?page="
  }else if(tailType=="3"){
    pageTail="/videos/upload?page="
  }else if(tailType=="4"){
    pageTail="/"
  }else if(tailType=="5"){
    pageTail="/videos/public?page="
  }


className = ".phimage"

#totalVideos = 2269
totalVideos = as.numeric(readline(prompt="enter totalVideos: "))
totalPages = ceiling(totalVideos/38)
totalResults = 0

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
 
if(i=="1"){
 url = paste0(pageHeader, titleName )
}else{
 url = paste0(pageHeader, titleName, pageTail,addr[i] )
}
 #url = paste0(pageHeader,addr[i],pageTail)
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
 cat(yellow("length(result): ",length(result), " "))
 totalResults = totalResults + length(result)
 cat(red("totalResults: ", totalResults, "\n"))
 allLinks = c(allLinks, result)

 if(length(allLinks)> totalVideos){break}

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

fileName = gsub(" |\\+|\\-", "", titleName)
fileName = paste0('pornhub',fileName)
#theFilename = paste0('pohub ',titleName, ".html")
theFilename = paste0(fileName, ".js")

#templateHead = readLines("C:/Users/william/Desktop/scripts/pohub/R/templateHeadPohub.txt")
#templateTail = readLines("C:/Users/william/Desktop/scripts/pohub/R/templateTailPohub.txt")
templateHead = paste0("var ", fileName , "=[")
templateTail = paste0("];\n", "lineHeader = '<div><a href=\"https://www.pornhub.com/embed/'\n","lineTail = '</a></div>'")

#templateHead = gsub("dreamgirlsmembers", titleName, templateHead)
#templateTail = gsub("dreamgirlsmembers", titleName, templateTail)
allLinks = gsub("/view_video.php\\?viewkey=", "", allLinks)

cat(red("length(allLinks) before unique: ",length(allLinks), "\n"))
cat(pink("duplicated links:\n"))
cat(green(allLinks[duplicated(allLinks)]), sep="\n\n")

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
cat(theFilename, "created\n\n")

source("C:/Users/william/Desktop/scripts/updateoptionsArray.R")
