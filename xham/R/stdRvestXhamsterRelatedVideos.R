
Sys.setlocale(category = 'LC_ALL', 'Chinese')
setwd("C:/Users/william/Desktop/scripts/xham/R")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

cat(yellow("\n\n\n\n\nsrc program location: xham/R, ", "\nmay nrun in batchMode or use single url", 
"\ndefault batch mode file is urlRelated.txt ", "\noutput files is Related.html\n",
red("remember to rename output file and clear batch mode src file")))


source("../../retrieveFile.R")
wholePage = character()
links = character()
className = "a.video-thumb__image-container"


collectXhamPage <- function(url){
    cat(yellow("\nurl:",url, "\n"))
    pagesource <- retrieveFile(url)

    if(is.list(pagesource)){
      itemList <- html_nodes(pagesource, className)
      link = html_attr(itemList, "href")
      cat("link: ", length(link),"")
      links <<- c(links, link)
      cat("links: ", length(links),"")
      previewvideo = html_attr(itemList, "data-previewvideo")
      cat("previewvideo: ", length(previewvideo),"")

      images = html_nodes(itemList, "noscript img")
      imgSrc = html_attr(images, "src")
      cat("imgSrc: ", length(imgSrc),"")
      linksTxt = html_attr(images, "alt")
      #linksTxt = paste0(titleName,", " ,linksTxt)
      linksTxt = gsub("'", " ", linksTxt)
      cat("linksTxt: ", length(linksTxt),"")

      sprite <- html_nodes(pagesource, "div.thumb-image-container__sprite")
      sprite = html_attr(sprite, "data-sprite")
      spriteTxt = paste0('<br><img src="', sprite, '"><br>')

      videoTxt = paste0('<br><video controls preload="none" preload="none" loop autoplay><source src="', previewvideo, '"></video>')
      cat("videoTxt: ", length(videoTxt),"")

      result = paste0('<a href="', link, '"><img src="', imgSrc, '"><br>', linksTxt, '</a><br>', videoTxt,'<br>')
      cat("result: ", length(result),"")
      wholePage <<- sort(unique(wholePage))
      wholePage <<- c(wholePage, result)
      cat("wholePage: ", length(wholePage), "\n")
     }else{
       cat(red("error in received page!\n"))
     }
}

opMode = readline(prompt="enter batchMode or single url? 0/1: ")

if(opMode=="1"){
  url = readline(prompt="enter url: ")
  titleName = readline(prompt="enter titleName: ")
  theFilename = paste0(titleName, ".html")
  collectXhamPage(url)
}else{
  batchFileName = readline("enter batch file name without .txt, or press enter for default urlRelated.txt: ")
  if(batchFileName == ""){
    urlbatch = readLines("urlRelated.txt")
  }else{
    batchFileName = paste0(batchFileName, ".txt")
    cat(green("\n\nbatch file name is ", batchFileName))
    urlbatch = readLines(batchFileName)
  }
  cat(orange("\n\n\noutput filename is: Related.html\n"))
  theFilename = paste0("Related.html")

  counter = 0
  lenurlbatch = length(urlbatch)
  for(i in urlbatch){
  counter = counter +1
  cat(counter, "of", lenurlbatch)
    collectXhamPage(i)
  }
}

links = sort(unique(links))
cat("\n\nbegin relating... links:", length(links),"\n\n")
counter = 0
linksLen = length(links)
for(i in links){
  counter = counter + 1
  cat( counter, "of", linksLen,"\n")
  collectXhamPage(i)
}

cat(red("saved temp file!\n"))
  sink(paste("temp",theFilename))
  cat(wholePage, sep="\n")
  sink()

oneMore = readline(prompt="run the third loop? y/n 0/1 y/n: ")
if(oneMore == "0"){
  links = sort(unique(links))
  cat(red("\n\nbegin relating again... links:", length(links),"\n\n"))
  counter = 0
  linksLen = length(links)
  for(i in links){
    counter = counter + 1
    cat( counter, "of", linksLen, i)
    collectXhamPage(i)
  }
}

wholePage = sort(unique(wholePage))

setwd("C:/Users/william/Desktop/scripts/xham")
  sink(theFilename)
  cat(wholePage, sep="\n")
  sink()

cat(red("\n", theFilename, "created! Total links: ", length(wholePage), "\n"))
theFilename = paste0('temp',theFilename)
