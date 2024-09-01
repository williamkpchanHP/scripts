# to collect other pinkfinart pages, change allAlbumHeader and output
setwd("C:/Users/william/Desktop/scripts")
library(rvest)
library(crayon)

# note must end with /
titlename = readline(prompt=("enter title name: "))
siteheader = "https://www.pinkfineart.com/"
allAlbumHeader = paste0(siteheader, titlename)
# output file name
theFilename = paste0("pinkFA",titlename, ".html")

cat(green("\n\nStart time:",format(Sys.time(), "%H:%M:%OS"), "\n"))
now_time <- unclass(as.POSIXlt(Sys.time()))
startTime <- now_time[3]$hour*60 + now_time[2]$min

dhms <- function(t){
    paste(t %/% (60*60*24), "day" 
         ,paste(formatC(t %/% (60*60) %% 24, width = 2, format = "d", flag = "0")
               ,formatC(t %/% 60 %% 60, width = 2, format = "d", flag = "0")
               ,formatC(t %% 60, width = 2, format = "d", flag = "0")
               ,sep = ":"
               )
         )
}

allAlbumList = character()
allLinkList = character()
allPhotoList = character()

  url = allAlbumHeader
  cat("\n",url, " ")
  pagesource <- read_html(url, warn=FALSE)
  pageination = "div.my-0 small"
  totalPages <- html_nodes(pagesource, pageination)
  totalPages = totalPages[length(totalPages)]
  totalPages = as.numeric(gsub('^.*? |<.*?$', '', totalPages))
  cat(green("\ntotalPages ",totalPages, "\n"))
 # get all albums links
for(page in 1:totalPages){
  url = paste0(allAlbumHeader, "/page/", page)
  cat("\n",page, " of ", totalPages,url, " ")
  pagesource <- read_html(url, warn=FALSE)
  linkClassName = "a.card-link"
  albumLinks <- html_nodes(pagesource, linkClassName)
  albumLinks = gsub('^.*?href="', siteheader, albumLinks)
  albumLinks = gsub('" title.*', '', albumLinks)
  allLinkList = c(allLinkList, albumLinks)
}
cat(red("\nalbum List complete!\n"))
cat(green("\nlength of allLinkList: ", length(allLinkList), "\n"))

linkAddrname = paste0("pinkFA",titlename, ".txt")
sink(linkAddrname)
  cat(allLinkList, sep="\n")
sink()
cat(green(linkAddrname, "created!\n"))

#grep("samantha-rae-kitchen", allLinkList)
#allLinkList = allLinkList[-(1:145)]
ProcessStartTime = Sys.time()
for(i in 1:length(allLinkList)){
  cat("\n",i, " of ", length(allLinkList), allLinkList[i])
  pagesource <- read_html(allLinkList[i], warn=FALSE)
  linkClassName = ".card a"
  imgLinks <- html_nodes(pagesource, linkClassName)
  imgLinks = html_attr(imgLinks, 'href')
  allPhotoList = c(allPhotoList, imgLinks)

 if(i == 10){
   ProcessEndTime = Sys.time()
   LoopTime = as.numeric(ProcessEndTime - ProcessStartTime, units="secs")
   ecTime = length(allLinkList)*LoopTime/10

   cat(red(
        "\n\n Expect to complete at: ", as.character(ProcessStartTime + ecTime),"\n",
        "per cycle time: ", dhms(LoopTime/10),"\n",
        "total time: ", dhms(ecTime),"\n\n"
      ))
 }
}

templateHead = readLines("templateHead.txt")
templateTail = readLines("templateTail.txt")
templateHead = gsub("mom50", titlename, templateHead)
templateTail = gsub("mom50", titlename, templateTail)

sink(theFilename)
cat(templateHead, sep="\n")
cat(allPhotoList, sep="\n")
cat(templateTail, sep="\n")
sink()

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ", dhms(LoopTime),"\n\n\n")
cat(theFilename, "created\n")
#finishBeep(1)

cat(red("Job completed!\n"))

cat(green("end time:",format(Sys.time(), "%H:%M:%OS"), "\n"))
now_time <- unclass(as.POSIXlt(Sys.time()))
endTime <- now_time[3]$hour*60 + now_time[2]$min
timdDiff = endTime - startTime
cat(yellow("time lapse:",timdDiff, "minutes\n"))
