# this is exactly same as xhamsterUsers.R, same to pornstar

dirStr = "C:/Users/william/Desktop/scripts/xham"
setwd(dirStr)
library(rvest)
library(crayon)
source("sinkfile.R")

theWholepage = character()

askforName <-function(){		# "abc def" -> "abc+def"
	Selection = readline(prompt="enter search keyword, not url: ")
	if(Selection == "")   { 
		cat("\nblank address! exited!\n")
		break
	}
	return(Selection)		# if empty, calling program handle
}

  # assemble contents
   assembleContents <-function(sourceData) {
      className = 'div.thumb-list__item a.video-thumb__image-container'
      keywordList <- html_nodes(sourceData, className)
      keywordHref = html_attr(keywordList, "href")
      keywordHref = as.character(keywordHref)
      keywordImg <- html_nodes(keywordList, "img")
      keywordImg = as.character(keywordImg)
      keywordImg = gsub("thumb-image-container__image","lazy", keywordImg)
      keywordImg = gsub(" src"," data-src", keywordImg)
      keywordImg = gsub(' onload.*', '>', keywordImg)

      for(i in 1:length(keywordHref)){
        anchor = paste0('<a href="',keywordHref[i], '">',
               keywordImg[i], '</a>')
        theWholepage <<- c(theWholepage, anchor)
      }
    }

channelName = askforName()

startTime = format(Sys.time(), "%H:%M")

  urlHead = paste0("https://xhamster.com/search/", channelName, "?quality=hd")
  cat("urlHead ",urlHead, "\n")
  pagesource <- read_html(urlHead, warn=F, encoding = "UTF-8")
  lastLineNum = as.numeric(readline(prompt="enter total page number "))

  if(is.na(lastLineNum)){ 
    cat("\nblank! exited!\n")
    break
  }

  cat("\n\nTotal Pages: ", lastLineNum, sep="\n")

  assembleContents(pagesource)

  if(lastLineNum>1){
    for (page in 2:lastLineNum){
     url = paste0(urlHead, "&page=", page)
    	cat(" ", page, " url: ", url, "\n")
         pagesource <- read_html(url, warn=F, encoding = "UTF-8")
         assembleContents(pagesource)
    }
  }

theFilename = paste0(channelName, "_VidSearch_xham.html")
cat("theFilename ", theFilename)
sinkfile(theWholepage, theFilename)
