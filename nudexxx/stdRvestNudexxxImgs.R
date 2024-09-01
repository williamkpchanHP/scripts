#
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
#setwd("C:/Users/User/Pictures/sexpage")
#setwd("C:/Users/william/Desktop/scripts")
setwd("C:/Users/william/Desktop/scripts/nudexxx")

#library(audio)
library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

cat("\n")
titleName = readline(prompt="enter title name: ")
titleName = gsub(" |\\+", "-", titleName)

typeName = ""
while(typeName == ""){
  typeName = readline(prompt="1 categories, 2 star, 3 search, 4 channel (1,2,3,4):")
}

if(typeName=="1"){
  pageHeader="https://www.nudexxx.pics/categories/"
  pageTail="/"
}else if(typeName=="2"){
  pageHeader="https://www.nudexxx.pics/pornstars/"
  pageTail="/"
}else if(typeName=="3"){
  pageHeader="https://www.nudexxx.pics/load.php?scroll=1&opc=&search="
  pageTail="&p="
}else if(typeName=="4"){
  pageHeader="https://www.nudexxx.pics/channels/"
  pageTail="/"
}

className = ".item a"

theFilename = paste0('nudexxx ',titleName, ".html")
allLinks = character()
wholePage = character()

totalResults = 0
totalPages = 1000

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

for(i in 1:totalPages){
 cat(i, "")
 if(typeName==3){
   url = paste0(pageHeader, titleName, pageTail, i )
 }else{
   url = paste0(pageHeader, titleName, pageTail )
 }

 #url = paste0(pageHeader, i,pageTail)
 cat(url, "\n")
url ="https://www.nudexxx.pics/gallery/mature-ivana-slew-can-nurse-you-or-be-your-hot-granny-75427.html"
 pagesource = readLines(url)
 targetID = grep("gallery.php", pagesource)
 galleryId = pagesource[targetID]
 galleryId = gsub("^.*?=", "", galleryId)
 galleryId = gsub("'.*", "", galleryId)
url =paste0("https://www.nudexxx.pics/gallery.php?id=", galleryId)

 pagesource <- read_html(url)
 itemList <- html_nodes(pagesource, className)
 itemHref = html_attr(itemList, "href")
 itemHrefID = grep("cdn.nudexxx", itemHref)
 itemHref = itemHref[itemHrefID]

 result = paste0('\'', itemHref, '\',')
 cat(yellow("length(result): ",length(result), "  "))
 totalResults = totalResults + length(result)
 cat(blue("totalResults: ", totalResults, "  "))

 allLinks = c(allLinks, result)
 allLinks = unique(allLinks)
 cat(white("allLinks: ", length(allLinks), "\n"))
 
# if(length(allLinks)>=totalVideos){break}

 if(length(result)<36){break}
 if(i == 10){
   ProcessEndTime = Sys.time()
   LoopTime = as.numeric(ProcessEndTime - ProcessStartTime, units="secs")
   ecTime = totalPages*LoopTime/10

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
privateIdx = grep("private-video",allLinks)
if(length(privateIdx)!=0){
  allLinks = allLinks[-privateIdx]
  cat(red("removed privateIdx: ", length(privateIdx), "\n"))
}

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
