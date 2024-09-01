# Note, to process long list, break the job into sub jobs to avoid lost of all data
# to break into sub jobs, change the for loop counter in every operation

rm(list = ls())
Sys.setlocale(category = 'LC_ALL', 'Chinese')	# this must be added to script to show chinese
library(crayon)

setwd("C:/Users/william/Desktop/scripts/R")
pageHeader="https://www.pichunter.com/gallery/"
pageTail = ""

theFilename = "pichunterDance.html"
addr = readLines("pichunterDance.txt")
targetSig = 'class="item pop-execute'

theWholepage = character()
errorList = character()

lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

# retrieveFile
  retrieveFile <- function(urlAddr){
    retryCounter = 1
    while(retryCounter < 15) {
      cat("...try ",retryCounter) 
      #retriveFile <- tryCatch(readLines(urlAddr, warn=F, encoding = "UTF-8"), 
      retriveFile <- tryCatch(readLines(urlAddr, warn=F), 
                        warning = function(w){
                         cat(silver("code param error "));
                         return(" code param error ")
                        }, 
                        error = function(e) {
                          if(grepl("Error in open.connection", e)){
                            cat(silver(" Error in open.connection "))
                            return("Error in open.connection")
                          }else if(grepl("Error in doc_parse_raw", e)){
                            cat(silver(" Error in doc_parse_raw, "))
                            return(read_html(urlAddr, warn=F))
                          }else{
                            cat(red(" unknown error "))
                            return("unknown error")
                          }
                        }
                     )
      if (grepl("code param error", retriveFile)) {
        cat(red(" Error in connection, try 5 secs later!\n"))
        retryCounter <- retryCounter + 1
        retriveFile = "<html></html>"  # if end of loop this will be returned
      }else if(grepl("Error in open.connection", retriveFile)){
        cat(red("unable to connect! \n"), urlAddr,"\n")
        retryCounter <- retryCounter + 1
        retriveFile = "<html></html>"  # if end of loop this will be returned
        cat(retriveFile)
        retryCounter = 200  # to jump out of loop
      }else if(grepl("unknown error", retriveFile)){
        retriveFile = "<html></html>"  # if end of loop this will be returned
        retryCounter = 200  # to jump out of loop
      }else{
        cat(green(" \tseems OK! "))
        retryCounter = 200  # to jump out of loop
      }
    }
    cat(green(" loop end retry counts: ", retryCounter, "\n"))
    closeAllConnections()
    return(retriveFile)
  }

# processOnePage
  processOnePage <- function(page){
     if ((page %% 100) == 0 ){
       now_time <- unclass(as.POSIXlt(Sys.time()))
       nowTS <- now_time[3]$hour*100 + now_time[2]$min
       cat("time is ",nowTS, "\n")
     }
	cat(" ", page)
	# urlAddr = paste0(pageHeader, formatC(page, width = 3, format = "d", flag = "0"), pageTail)
	#thepage = readLines(paste0(pageHeader, addr[page], pageTail), encoding="UTF-8")
	urlAddr = paste0(pageHeader, addr[page], pageTail)
	thepage = as.character(retrieveFile(urlAddr))
     targetLineNums = grep(targetSig, thepage)
     theWholepage <<- c(theWholepage, thepage[targetLineNums])
  }

for (page in 1:lentocpage){
  processOnePage(page)
}

theWholepage = gsub("^.*?href", '<img class="lazy" data-src', theWholepage)
theWholepage = gsub(" itemprop.*", '>', theWholepage)
sink(theFilename)
  cat(theWholepage, sep = "\n")
sink()
if(length(errorList)>0){
  cat(red("errorList: "),errorList)
}else{
  cat(red("No errors left"))
}
shell(theFilename)

