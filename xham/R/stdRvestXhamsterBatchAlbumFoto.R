# this must be added to setting chinese
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
# setwd("C:/Users/User/Pictures/sexpage")
#setwd("C:/Users/william/Desktop/scripts")
setwd("C:/Users/william/Desktop/scripts/xham/R")

#library(audio)
library(rvest)
library(crayon)
library(jsonlite)
 ligSilver <- make_style("#889988")

source("C://Users//william//Desktop//scripts//retrieveFile.R")

assembly = character()
historyFile = "xhamsterFotoHistory.txt"
batchFIleHistory = readLines(historyFile)

dhms <- function(t){
    paste(t %/% (60*60*24), "day" 
         ,paste(formatC(t %/% (60*60) %% 24, width = 2, format = "d", flag = "0")
               ,formatC(t %/% 60 %% 60, width = 2, format = "d", flag = "0")
               ,formatC(t %% 60, width = 2, format = "d", flag = "0")
               ,sep = ":"
               )
         )
}

chkRepeatUrl <- function(urls){
  rmIdx = numeric()
  for(i in length(urls)){
    url = urls[i]
    historyIdx = grep(url, batchFIleHistory)
    if(length(historyIdx) !=0){
        cat(red("\n", urls[i],"\nAlready Listed in xhamsterBatchProcessHistory.txt History!: ", historyIdx, "\n"))
        rmIdx = c(rmIdx, i)
    }
  }
  urls = urls[-rmIdx]
  cat(red("Total urls: "), length(urls), "\n")
}

  getlineFile <- function(urlAddr){
    retrytally = 1
    while(retrytally < 5) {
      cat("...retrytally try ",retrytally, "\n") 
      getFile <- tryCatch(
                        readLines(urlAddr, warn=F, encoding = "UTF-8"), 
                        warning = function(w){
                           cat(silver("code param error "))
                           retrytally = retrytally +1
                        }, 
                        error = function(e) {
                           cat(red(" unknown param error "))
                           retrytally = retrytally +1
                        }
      )
      if(length(grep("param error", getFile))==0 ){
         retrytally = 200
      }
    }
    return(getFile)
  }

collectImages <- function(url){
    cat(url, "\n")
    pagesource <- retrieveFile(url)

    lastPageclassName = ".test-pager li, .page-button-link"
    lastPageNum <- html_nodes(pagesource, lastPageclassName)

    if(length(lastPageNum)==0){
      lastPageNum = 1
    }else{
      lastPageIdx = length(lastPageNum)
      thelastLine = html_nodes(lastPageNum[lastPageIdx], "a")
      lastPageNum = as.numeric(html_text(lastPageNum[lastPageIdx]))
    }
    
    #if(length(lastPageNum)==0){
    #  lastPageNum = 1
    #}else{
    #  lastPageNum = as.numeric(html_text(lastPageNum))
    #}
    
    addr=1:lastPageNum
    lentocpage = lastPageNum
    cat(yellow("\ntotal pages: ",lentocpage,"\n"))

    for(i in 1:length(addr)){
     cat(i, "of", length(addr), " ")
    
     pageUrl = url
     if(i!=1){
        pageUrl = paste0(url, "/",i)
     }
    
     cat("url:",pageUrl, "\n")
    
     #pagesource <- getlineFile(pageUrl)
     #pagesource <- readLines(pageUrl, warn=F, encoding = "UTF-8")
     #fileIn=file(pageUrl,open="rb",encoding="UTF-8")
     pagesource = retrieveFile(pageUrl)
     #retrieveFile(pageUrl)
     pagesource = as.character(pagesource)
     targetLineIdx = grep("photoModel", pagesource)
     targetLine = pagesource[targetLineIdx]
     targetLine = gsub('^.*,"photos":', '', targetLine )
     targetLine = gsub(',"editable.*', '', targetLine)
     # writeClipboard(targetLine)
     targetLineDf = fromJSON(targetLine)
    
     imgSrc = unlist(targetLineDf["imageURL"])
    
     result = paste0('<div><img src="', imgSrc, '"></div>')
     cat(yellow("length(resut): ", length(result), " "))
     urlStr = paste0("<k>", url, "</k>")
     assembly <<- c(assembly, urlStr, result)
     cat(green("total length of assembly: ", length(assembly), "\n"))

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
}

# main
 urlSrc = readline("read urls from txt file or from collect from user name 0/1: ")
 titleName = "batch file"

 if(urlSrc=="0"){
  # read urls from file
  cat("read urls from txt file\n")
  batchFilename = readline("enter short file name, press enter for default, batchurl.txt: ")
    if(batchFilename==""){
      batchurl = "batchurl.txt"
    }else{
      batchurl = paste0(batchFilename, ".txt")
    }

  setwd("C:/Users/william/Desktop/scripts/xham")
  urls = readLines(batchurl)
  setwd("C:/Users/william/Desktop/scripts/xham/R")

  cat(red("total urls: ", length(urls), "\n\n"))
 }else{
  # read urls from user site
  source("stdRvestXhamsterUserGrpPhotos.R")
  urls = wholePage
  urls = gsub('^.*?href="','',urls)
  urls = gsub('">.*','',urls)
  titleName = paste0(userName, "Batch") # userName from stdRvestXhamsterUserGrpPhotos.R
  batchFilename = userName
 }

chkRepeatUrl(urls)

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")

# main loop here
urllen = length(urls)
for(k in 1:urllen){
  cat(pink("\n",k, " of total", urllen, "albums\n"))
  collectImages(urls[k])
}

#writeClipboard(assembly)
setwd("C:/Users/william/Desktop/scripts/xham/R")
templateHead = readLines("templateHeadArrayXhamFoto.txt")
templateTail = readLines("templateTailArrayXhamFoto.txt")
templateHead = gsub("penny-barber", paste0(titleName, ": ",length(assembly)), templateHead)
templateTail = gsub("penny-barber", paste0(titleName, ": ",length(assembly)), templateTail)
templateHead = gsub("img \\{width", "img {max-width", templateHead)

if(length(assembly)<60){
  showRangeIdx = grep("showRange", templateTail)
  templateTail[showRangeIdx] = paste0("showRange = ",length(assembly))
}

templateTail = gsub("penny-barber", paste0(titleName, ": ",length(assembly)), templateTail)

assembly = gsub('<img src="https://ic-ph-nss.xhcdn.com/a/', "", assembly)
assembly = gsub('_1000.jpg">', "", assembly)

assembly = gsub("'", ".", assembly)
assembly = gsub("<div>", "'", assembly)
assembly = gsub("</div>", "',", assembly)
assembly = gsub("<k>", "'<k>", assembly)
assembly = gsub("</k>", "</k>',", assembly)

asmFilename = paste0("xhamFoto ",batchFilename, length(assembly), ".html")

setwd("C:/Users/william/Desktop/scripts/xham")
  sink(asmFilename)
  cat(templateHead, sep="\n")
  cat(assembly, sep="\n")
  cat(templateTail, sep="\n")
  sink()

theFilename = asmFilename
ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ", dhms(LoopTime),"\n\n\n")
cat(theFilename, "created!", "Total links: ", length(assembly), "\n")
theFilename = paste0('"',theFilename,'"')

setwd("C:/Users/william/Desktop/scripts/xham/R")
      write(urls, file=historyFile, append=TRUE)
      cat(yellow("\n", historyFile, "updated!\n"))
