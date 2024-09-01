# this is exactly same as xhamsterUsers.R, same to pornstar

dirStr = "C:/Users/william/Desktop/scripts/xham"
setwd(dirStr)
library(rvest)
library(crayon)
source("C:/Users/william/Desktop/scripts/R/sinkfile.R")

theWholepage = character()

  # assemble contents
   assembleContents <-function(sourceData) {
    className = 'div.thumb-list__item a.video-thumb__image-container'
    keywordList <- html_nodes(sourceData, className)
    keywordHref = html_attr(keywordList, "href")
    keywordHref = as.character(keywordHref)
    keywordImg <- html_nodes(keywordList, "img")
    keywordImg = as.character(keywordImg)
    imgAlt = gsub('^.*?alt="', '', keywordImg)
    imgAlt = gsub('".*', '', imgAlt)

    keywordImg = gsub("thumb-image-container__image","lazy", keywordImg)
    keywordImg = gsub(" src"," data-src", keywordImg)
    keywordImg = gsub(' onload.*', '>', keywordImg)

    for(i in 1:length(keywordHref)){
      anchor = paste0('<a href="',keywordHref[i], '">',
               keywordImg[i], '<br>',imgAlt[i],'</a>')
      theWholepage <<- c(theWholepage, anchor)
    }
   }

startTime = format(Sys.time(), "%H:%M")

url = readLines("xhamsterUrl.txt")
lastLineNum = length(url)
cat("\n\nTotal Pages: ", lastLineNum, sep="\n")

    for (page in url){
    	cat("url: ", page, "\n")
       pagesource <- read_html(page, warn=F, encoding = "UTF-8")
       assembleContents(pagesource)
    }


theFilename = "xhamURLPages.html"
sinkfile(theWholepage, theFilename)
