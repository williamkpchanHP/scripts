Sys.setlocale(category = 'LC_ALL', 'Chinese')
setwd("C:/Users/william/Desktop/scripts/pohub/R")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")
source("../../retrieveFile.R")
wholePage = character()
links = character()
#className = ".gtm-event-thumb-click,.fade,.fadeUp,.videoPreviewBg,.linkVideoThumb,.js-linkVideoThumb"
className = ".linkVideoThumb"

collectPohubPage <- function(url){
 cat(yellow("\nurl:",url, "\n"))
 pagesource <- read_html(url)
 #writeClipboard(as.character(pagesource))
 itemList <- html_nodes(pagesource, className)
 locallink = paste0("https://www.pornhub.com", html_attr(itemList, "href"))
cat("\nlen(locallink): ", length(locallink))
 links <<- c(links, locallink)
 linksTxt = html_attr(itemList, "title")
 linksTxt = gsub("'", " ", linksTxt)
cat(" len(linksTxt): ", length(linksTxt))

 images = html_nodes(itemList, "img")
cat(" len(images): ", length(images))
 imgSrc = html_attr(images, "src")
cat(" len(imgSrc): ", length(imgSrc))

 result = paste0('<a href="', locallink, '"><img src="', imgSrc, '"><br>', linksTxt, '</a><br>')
cat(" len(result): ", length(result))
 wholePage <<- c(wholePage, result)
 wholePage <<- sort(unique(wholePage))
cat(" len(wholePage): ", length(wholePage), "\n")
}

cat(red("enter single url or batchMode from urlRelated.txt\n"))
opMode = readline(prompt="enter batchMode or single url? 0/1: ")

cat(red("enter single relating or multiple relating\n"))
relateMode = readline(prompt="enter singleMode or multi mode? 0/1: ")

if(opMode=="1"){
  url = readline(prompt="enter url: ")
  titleName = readline(prompt="enter titleName: ")
  theFilename = paste0(titleName, ".html")
  collectPohubPage(url)
}else{
  cat("load from urlRelated.txt...\n")
  urlbatch = readLines("urlRelated.txt")
  theFilename = paste0("Related.html")

  for(i in urlbatch){
    collectPohubPage(i)
  }
}

links = sort(unique(links))

if(relateMode!="0"){

  cat("\n\nbegin relating...\n\n")
  counter = 0
  linksLen = length(links)
  for(i in links){
    counter = counter + 1
    cat( counter, "of", linksLen, i)
    collectPohubPage(i)
  }

  linksLen = length(links)
  for(i in links){
    counter = counter + 1
    cat( "third:", counter, "of", linksLen, i)
    collectPohubPage(i)
  }
}

wholePage = sort(unique(wholePage))

cat("\nlength of wholePage: ", length(wholePage))

outFilename = titleName
wholePage = gsub('<a href="https://www.pornhub.com/view_video.php\\?viewkey=', "'", wholePage)

wholePage = paste0(wholePage, "'," )

jsheader = paste0("var ", "pornhub", outFilename, " = [")
jstai11 = "];"
jstai12 = "lineHeader = '<a href=\"https://www.pornhub.com/view_video.php\?'"
jstai13 = "lineTail = ''"

outFilename = paste0("pornhub", outFilename, ".js")

setwd("C:/Users/william/Desktop/scripts/pohub")
  sink(outFilename)
  cat(jsheader, sep="\n")
  cat(wholePage, sep="\n")
  cat(jstai11, sep="\n")
  cat(jstai12, sep="\n")
  cat(jstai13, sep="\n")
  sink()

cat(red("\n", theFilename, "created! Total links: ", length(wholePage), "\n"))

fileName = paste0("pornhub", titleName)
source("C:/Users/william/Desktop/scripts/updateoptionsArray.R")
