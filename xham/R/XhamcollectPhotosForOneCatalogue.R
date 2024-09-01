# use the workhorse: retrieveFile.R to collect multiple cabinet photos
# input: url only, will find out number of following links by workhorse
# this is the controller of retrieveFile.R

#setwd("C:/Users/william/Desktop/scripts/R")
setwd("C:/Users/william/Desktop/scripts/xham/R")
library(rvest)
library(crayon)

source("retrieveFile.R") # the workhorse here
source("sinkfile.R")

# not work urlAddr = "https://xhamster.com/users/worshipaandp/photos"
# work urlAddr = "https://xhamster.com/photos/gallery/all-women-show-their-beautiful-pussys-15640849"

urlAddr = readline("enter url: ")
#"https://xhamster.com/photos/gallery/chinese-amateur-14643006"
theFilename = readline("enter output file name without extension: ")
# remember to modify exclusionList if needed
exclusionList = ""
allAlbumList = character()
allLinkList = character()
allPhotoList = character()

cat("collectLinks urlAddr\n")
  pagesource <- read_html(urlAddr, warn=F)
  className = ".xh-paginator-button "
  keywordList <- html_nodes(pagesource, className)
  links = html_attr(keywordList, "href")
  linksline = grep("https", links)
  links = links[linksline]

    if(length(links) != 0){
      lastLine = links[length(links)]
      lastLineNum = as.numeric(gsub("http.*/", "", lastLine))

      links = urlAddr
      for(num in 2:lastLineNum){
        newlinks = paste0(urlAddr, "/", num)
        links = c(links, newlinks)
      }
    }else{ links = urlAddr }

    cat("\n\nfound links: ",links, sep="\n")

collectImgs(links)
theFilename = paste0(theFilename, ".html")
sinkfile(allPhotoList, theFilename)
