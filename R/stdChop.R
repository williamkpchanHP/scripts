# Note, to process long list, break the job into sub jobs to avoid lost of all data
# to break into sub jobs, change the for loop counter in every operation

rm(list = ls())
Sys.setlocale(category = 'LC_ALL', 'Chinese')	# this must be added to script to show chinese
library(crayon)

setwd("C:/Users/william/Desktop/scripts/R")
pageHeader="https://www.pichunter.com/tags/all/Dance/"
pageTail = ""

theFilename = "pichunterDance.htm"
addr = 1:27
pageHead = '<div class="thumbtable">'
pageEnd = '<div class="thumb sizer">'

theWholepage = character()
errorList = character()

lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

filterGabage <- function(theContent){
   gabageLines = grep("<div id|<script", theContent) # will remove whole line
   return(theContent = theContent[-gabageLines])
}

chopHead <- function(thepage, pageHead){
	headlinenum = grep(pageHead, thepage)
	cat(" ", headlinenum)
	return(thepage[-(1:(headlinenum-1))])
}

chopTail <- function(thepage, pageTail){
	taillinenum = grep(pageTail, thepage)  # chop tail
	cat( " ", taillinenum, "\n")
	if(length(taillinenum) != 0){
		return(thepage[-(taillinenum[1]:length(thepage))]) # begin from the second grep
	} else {
		return("")
	}
}

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
     h1LineNums = grep(pageHead, thepage)

     if(length(h1LineNums) >0){
       thepage = chopTail(chopHead(thepage, pageHead), pageEnd)
       #thepage = filterGabage(thepage)
	  theWholepage <<- c(theWholepage , "<div class='topic'>\n",thepage, "\n</div>\n")
     }else{
       errorList <<- c(errorList,page)
     }
  }

for (page in 1:lentocpage){
  processOnePage(page)
}

if(length(errorList)>0){  # retry the errorList
   cat(yellow("retry the errerlist: "),errorList)
   revivelist = errorList
   revivelist = as.numeric(revivelist)
   errorList = character()
   for (page in revivelist){ # here page dose not start from 1, but from errorList
     processOnePage(page)
	cat(pageHeader, addr[page], pageTail, "\n", sep="")
   }
}

sink(theFilename)
  cat(theWholepage, sep = "\n")
sink()
if(length(errorList)>0){
  cat(red("errorList: "),errorList)
}else{
  cat(red("No errors left"))
}
shell(theFilename)

