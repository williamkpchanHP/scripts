# https://erotic.pics/mila-marquez/
# Mila Marquez
# .entry img

Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
setwd("C:/Users/william/Desktop/scripts/erotic")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

url = readline("enter url: ")
url = gsub(" ", "-", url)
url = tolower(url)

pageTail=""

wholePage = character()
wholefmgList = character()

imgClassName = ".entry img"

  retrieveFile <- function(urlAddr){
    retryCounter = 1
    while(retryCounter < 5) {
      cat("...try ",retryCounter, "\n") 
      retriveFile <- tryCatch(read_html(urlAddr, warn=F, encoding = "UTF-8"), 
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
        retryCounter = 200  # to jump out of loop
      }else if(grepl("Error in open.connection", retriveFile)){
        cat(red("unable to connect! \n"), urlAddr,"\n")
        retryCounter <- retryCounter + 1
        retriveFile = "<html></html>"  # if end of loop this will be returned
        retryCounter = 200  # to jump out of loop
      }else if(grepl("unknown error", retriveFile)){
        retriveFile = "<html></html>"  # if end of loop this will be returned
        retryCounter = 200  # to jump out of loop
      }else{
        #cat(green(" \tseems OK! "))
        retryCounter = 200  # to jump out of loop
      }
    }
    #cat(green(" loop end retry counts: ", retryCounter, "\n"))
    return(retriveFile)
  }

 cat(url, "\n")
 pagesource <- read_html(url)

 itemList <- html_nodes(pagesource, imgClassName)

 itemList = html_attr(itemList, 'src')
 itemList = as.character(itemList)
 itemList = paste0('<img src="', itemList, '">')

 itemList = unique(sort(itemList))
 cat("length(itemList) ", length(itemList))

 wholePage = c(wholePage, url,"\n",itemList)

theFilename ="erotic.html"
write(wholePage, theFilename, append=TRUE)
cat(red("file created! ", theFilename),"\n")

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ",LoopTime,"\n\n\n")


