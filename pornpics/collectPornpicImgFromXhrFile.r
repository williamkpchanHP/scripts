# collect Pornpic Img From Xhr File
rm(list = ls())
Sys.setlocale(category = 'LC_ALL', 'Chinese')
setwd("C:/Users/william/Desktop/scripts/pornpics")
library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

cat(red("\n\nxhr file must exclude header: https://www.pornpics.com/galleries/\n\n"))
source("../retrieveFile.R")

pageHeader="https://www.pornpics.com/galleries/"
pageTail=""
className = ".thumbwook a" # pornpic
#schkeyHistory = readLines("pornpicHistory.txt")
#xhrFileName = "Bikini.txt"
xhrFileName = readline(prompt="Enter xhr file name without .txt: ")
titleName = xhrFileName
 
xhrFileName = paste0(xhrFileName, ".txt")
xhr = readLines(xhrFileName)

dhms <- function(t){
    paste(t %/% (60*60*24), "day" 
         ,paste(formatC(t %/% (60*60) %% 24, width = 2, format = "d", flag = "0")
               ,formatC(t %/% 60 %% 60, width = 2, format = "d", flag = "0")
               ,formatC(t %% 60, width = 2, format = "d", flag = "0")
               ,sep = ":"
               )
         )
}


# main loop
  wholePage = character()
  xhrlen = length(xhr)
  ProcessStartTime = Sys.time()
#  if(xhrlen>3000){
#    cat(red("\nlist too long! chop into sections!\n"))
#    longxhr = xhr

#    for
#  }

  for(i in 1:xhrlen){
    url = paste0(pageHeader,xhr[i],pageTail)
    cat(red(i, "of",xhrlen), url,"\n")
    pagesource <- retrieveFile(url)
  
    itemList <- html_nodes(pagesource, className)
  
    itemList = html_attr(itemList, 'href')
    itemList = as.character(itemList)
    itemList = gsub('https://cdni.pornpics.com/1280/', '\'', itemList)
    itemList = gsub('\\.jpg', '\',', itemList)
  
    wholePage = c(wholePage, itemList)
  
    if(i == 10){
      ProcessEndTime = Sys.time()
      LoopTime = as.numeric(ProcessEndTime - ProcessStartTime, units="secs")
      ecTime = xhrlen*LoopTime/10
  
      cat(red(
          "\n\n Expect to complete at: ", as.character(ProcessStartTime + ecTime),"\n",
          "per cycle time: ", dhms(LoopTime/10),"\n",
          "Expected total time: ", dhms(ecTime),"\n\n"
         ))
    }
  }


  templateHead = readLines("templateHead.txt")
  templateTail = readLines("templateTail.txt")
  templateHead = gsub("mom50", titleName, templateHead)
  templateTail = gsub("mom50", titleName, templateTail)

  rmidx = grep("^/$", wholePage) 
  if(length(rmidx)>0){
    wholePage = wholePage[-rmidx]
  }

  theFilename = paste0("pornpics", titleName, ".html")
  sink(theFilename)
  cat(templateHead, sep="\n")
  cat(wholePage, sep="\n")
  cat(templateTail, sep="\n")
  sink()

cat(red("task complete!\n"))
  fileName = paste0("pornpics", schkey)
  source("C:/Users/william/Desktop/scripts/updateoptionsArray.R")
