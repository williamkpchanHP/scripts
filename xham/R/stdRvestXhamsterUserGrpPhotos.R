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
batchFIleHistory = readLines("xhamFotoBatHist.txt")
ProcessStartTime = Sys.time()

dhms <- function(t){
    paste(t %/% (60*60*24), "day" 
         ,paste(formatC(t %/% (60*60) %% 24, width = 2, format = "d", flag = "0")
               ,formatC(t %/% 60 %% 60, width = 2, format = "d", flag = "0")
               ,formatC(t %% 60, width = 2, format = "d", flag = "0")
               ,sep = ":"
               )
         )
}

fetchUserFotos = function(userName){
  url = paste0(userHeader, userName, "/photos/")
  historyIdx = grep(userName, batchFIleHistory)
  if(length(historyIdx) !=0){
     stop(red("\nAlready Listed in xhamFotoBatHist.txt History!: ", historyIdx, "\n"))
  }

  cat(red("url: ",url, "\n"))
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
  cat("\nAlbum container pages: ",lentocpage,"\n")
  cat(format(Sys.time(), "%H:%M:%OS"),"\n")


  for(i in addr){
   cat("\n",i, "of", length(addr), " ")
   if(i==1){
     url = paste0(userHeader, userName, "/photos/")
   }else{
     url = paste0(userHeader, userName, "/photos/", i)
   }

   cat("url: ",url, "\n")
   pagesource <- readLines(url)
   targetLineIdx = grep(lineSignature, pagesource)
   targetLine = pagesource[targetLineIdx]
   targetLine = gsub('^.*userGalleriesCollection":', '', targetLine )
   targetLine = gsub(',"maxPhotoPages.*', '', targetLine)

   targetLineDf = fromJSON(targetLine)
cat("\nlength targetLineDf: ", length(targetLineDf))

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

   cat("\n\nlength(resut): ", length(result), "\n")
   wholePage <<- c(wholePage, result)
   allLinks <<- c(allLinks, links)
   cat("\nlength allLinks: ", length(allLinks))
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
  #saveFile(userName)
  cat("\n\nfetchUserFotos complete! ", length(allLinks))
}

saveFile = function(userName){
  theFilename = paste0("xhamFoto ", userName, " List.html")
  #writeClipboard(wholePage)
  setwd("C:/Users/william/Desktop/scripts/xham/R")
  templateHead = readLines("templateHeadXham.txt")
  templateTail = readLines("templateTailXham.txt")
  templateHead = gsub("mom50", userName, templateHead)
  templateTail = gsub("mom50", userName, templateTail)

  templateTail = gsub("lineHeader = '<div>'", "lineHeader = ''", templateTail)
  templateTail = gsub("lineTail = '</div>'", "lineTail = ''", templateTail)

  showRangeIdx = grep("showRange", templateTail)
  if(length(wholePage)<=60){
    templateTail[showRangeIdx] = paste0("showRange = ", length(wholePage))
  }
  wholePage <<- gsub("'", ".", wholePage)
  wholePage <<- gsub("</div>", "<br>',", wholePage)
  wholePage <<- sort(wholePage, decreasing=TRUE)
  wholePage <<- gsub("^.*?<div>", "'", wholePage)

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
  cat(yellow("Total links: ", length(allLinks), " save in file: ", paste0(userName, "allLinks.txt\n")))
  cat(red("Please fetch all images using the allLinks.txt"))
}

# main loop
# ==========
wholePage = character()
allLinks = character()
userHeader = character()

modetype = readline("batch mode or single user? 0/1 ")
if(modetype=="1"){
  userName = "nenagamer"
  userName = readline(prompt="enter userName: ")
  userOrCreat = readline(prompt="pornstars, user or creator? 0/1/2: ")

  if(userOrCreat==0){
    userHeader="https://xhamster.com/pornstars/"
  }else if(userOrCreat==1){
    userHeader="https://xhamster.com/users/"
  }else if(userOrCreat==2){
    userHeader="https://xhamster.com/creators/"
  }
  ProcessStartTime <<- Sys.time()
  wholePage = character()
  cat(yellow("\n\nuserHeader: ", userHeader, "\n\n\n"))
  fetchUserFotos(userName)
}else{
  batchFilename = readline("enter short file name, press enter for default, batchurl.txt: ")
    if(batchFilename==""){
      batchurl = "batchurl.txt"
    }else{
      batchurl = paste0(batchFilename, ".txt")
    }

  setwd("C:/Users/william/Desktop/scripts/xham")
  batchuserName = readLines(batchurl)
  batchUNlen = length(batchuserName)
  cat("Total userNamea: ", batchUNlen, "\n")

  userOrCreat = readline(prompt="user or creator? 0/1: ")
  if(userOrCreat==0){
    userHeader="https://xhamster.com/users/"
  }else{
    userHeader="https://xhamster.com/creators/"
  }

  ProcessStartTime <<- Sys.time()
  counter = 0
  for(i in batchuserName){
    counter = counter + 1
    cat(counter, "of", batchUNlen,"\n")
    wholePage = character()
    fetchUserFotos(i)
  }
  userName = paste0("collectedimgs", length(allLinks))
}

saveFile(userName)
