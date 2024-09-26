Sys.setlocale(category = 'LC_ALL', 'Chinese')
setwd("C:/Users/william/Desktop/scripts/xham/R")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

wholePage = character()
links = character()
className = "a.video-thumb__image-container"


collectXhamPage <- function(url){
 cat(yellow("\nurl:",url, "\n"))
 pagesource <- read_html(url)

 itemList <- html_nodes(pagesource, className)
 links <<- c(links, html_attr(itemList, "href"))
 previewvideo = html_attr(itemList, "data-previewvideo")

 images = html_nodes(itemList, "noscript img")
 imgSrc = html_attr(images, "src")
 linksTxt = html_attr(images, "alt")
 #linksTxt = paste0(titleName,", " ,linksTxt)
 linksTxt = gsub("'", " ", linksTxt)

 sprite <- html_nodes(pagesource, "div.thumb-image-container__sprite")
 sprite = html_attr(sprite, "data-sprite")
 spriteTxt = paste0('<br><img src="', sprite, '"><br>')

 videoTxt = paste0('<br><video controls preload="none" preload="none" loop autoplay><source src="', previewvideo, '"></video>')

 result = paste0('<a href="', links, '"><img src="', imgSrc, '"><br>', linksTxt, '</a><br>', videoTxt,'<br>')
 wholePage <<- sort(unique(wholePage))
 wholePage <<- c(wholePage, result)
}

opMode = readline(prompt="enter batchMode or single url? 0/1: ")

if(opMode=="1"){
  url = readline(prompt="enter url: ")
  titleName = readline(prompt="enter titleName: ")
  theFilename = paste0(titleName, ".html")
  collectXhamPage(url)
}else{
  urlbatch = readLines("urlRelated.txt")
  theFilename = paste0("Related.html")

  for(i in urlbatch){
    collectXhamPage(i)
  }
}

links = sort(unique(links))
cat("\n\nbegin relating...\n\n")
counter = 0
linksLen = length(links)
for(i in links){
  counter = counter + 1
  cat( counter, "of", linksLen, i)
  collectXhamPage(i)
}

wholePage = sort(unique(wholePage))

setwd("C:/Users/william/Desktop/scripts/xham")
  sink(theFilename)
  cat(wholePage, sep="\n")
  sink()

cat(red("\n", theFilename, "created! Total links: ", length(wholePage), "\n"))
theFilename = paste0('"',theFilename,'"')
      write(url, file="xhamsterBatchProcessHistory.txt", append=TRUE)
      cat(yellow("\nxhamsterBatchProcessHistory.txt updated!\n"))
