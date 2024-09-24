rm(list = ls())
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#setwd("C:/Users/User/Pictures/sexpage/pornpic/")
setwd("C:/Users/william/Desktop/scripts/xham")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

source("../retrieveFile.R")
pageHeader="https://xhamster.com/"
endpage = 70
pageTail=""
className = ".subsection .video-thumb__image-container" #
wholePage = character()

for(i in 1:endpage){
 url = paste0(pageHeader, i)
 pagesource <- retrieveFile(url)
 itemList <- html_nodes(pagesource, className)

 hrefList = html_attr(itemList, 'href')
 videoList = html_attr(itemList, "data-previewvideo")
 imgList = html_element(itemList, "img")
 textList = html_attr(imgList, "alt")
 textList = gsub("'", " ", textList)

 imgList = html_attr(imgList, 'src')
 links = paste0('<a href="', hrefList, '"><img src="',
    imgList, '"><br>',textList,'</a><br>', '<video autoplay controls><source src="', videoList,
    '"></video>')
 wholePage = c(wholePage, links)
}

wholePage = sort(unique(wholePage))

theFilename = "xhamTrends.html"
sink(theFilename)
cat(wholePage, sep="\n")
sink()

cat("Job complete!\n")