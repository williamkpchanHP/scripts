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

assembly = character()
dhms <- function(t){
    paste(t %/% (60*60*24), "day" 
         ,paste(formatC(t %/% (60*60) %% 24, width = 2, format = "d", flag = "0")
               ,formatC(t %/% 60 %% 60, width = 2, format = "d", flag = "0")
               ,formatC(t %% 60, width = 2, format = "d", flag = "0")
               ,sep = ":"
               )
         )
}

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

collectContent <- function(url){
    cat(url, "\n")
    pagesource <- retrieveFile(url)
    #title = .gallery-thumb-info__name
    #img = img.hidden-thumb-image
    #counters = .gallery-thumb-info__quantity

    className = ".gallery-thumb a"
    itemList <- html_nodes(pagesource, className)

     links = as.character(html_attr(itemList, "href"))
     linksTxt = as.character(html_nodes(pagesource, ".gallery-thumb-info__name"))
     linksTxt = gsub("<.*?>", "", linksTxt)

     images = html_nodes(itemList, "noscript img")
     imgSrc = as.character(html_attr(images, "src"))
     counters = as.character(html_nodes(pagesource, ".gallery-thumb-info__quantity"))
     counters = gsub("<.*?>", "", counters)

     #cat("links[1] ", links[1], "\n")
     #cat("linksTxt[1] ", linksTxt[1], "\n")
     #cat("imgSrc[1] ", imgSrc[1], "\n")
     #cat("counters[1] ", counters[1], "\n")

     result = paste0('\'', '<a href="',links, '"><img class="lazy" data-src="', imgSrc, '"><br>', linksTxt, " ",counters, '\',')
     #cat("result[1] ", result[1], "\n")

     cat(yellow("length(resut): ", length(result), " "))
     assembly <<- c(assembly, result)
     cat(green("total length of assembly: ", length(assembly), "\n"))
    }


# main
 titleName = "xhamsterPhotosTOC"

  setwd("C:/Users/william/Desktop/scripts/xham")

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")

# main loop here
urlHeader = "https://xhamster.com/photos/"
totalPages = 725

for(k in 1:totalPages){
  pageurl = paste0(urlHeader, k)
  cat(pink("\n", k, " of ", totalPages, "\n"))
  collectContent(pageurl)
}

#writeClipboard(assembly)
setwd("C:/Users/william/Desktop/scripts/xham/R")
templateHead = readLines("templateHeadArrayXhamFoto.txt")
templateTail = readLines("templateTailArrayXhamFoto.txt")
templateHead = gsub("penny-barber", paste0(titleName, ": ",length(assembly)), templateHead)
templateTail = gsub("penny-barber", paste0(titleName, ": ",length(assembly)), templateTail)


assembly = gsub("'", ".", assembly)
assembly = gsub("<div>", "'", assembly)
assembly = gsub("</div>", "',", assembly)
assembly = gsub("<k>", "'<k>", assembly)
assembly = gsub("</k>", "</k>',", assembly)

asmFilename = paste0("xhamFoto ",titleName, length(assembly), ".html")

setwd("C:/Users/william/Desktop/scripts/xham")
theFilename = paste0('Xham All Photo Albums Toc.html')

  sink(asmFilename)
  cat(templateHead, sep="\n")
  cat(assembly, sep="\n")
  cat(templateTail, sep="\n")
  sink()


ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ", dhms(LoopTime),"\n\n\n")
cat(theFilename, "created!", "Total links: ", length(assembly), "\n")
