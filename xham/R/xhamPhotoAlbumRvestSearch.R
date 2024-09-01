# this is exactly same as xhamsterUsers.R, same to pornstar
# not yet ok
options("encoding" = "native.enc")
Sys.setlocale(category = 'LC_ALL', 'Chinese')	# this must be added to script to show chinese

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

cleanUp <- function(out){
  className = "div.thumb-list__item"
  out <- html_nodes(out, className)

  altLine = gsub('^.*? alt="', '', out)
  altLine = gsub('".*', '', altLine)

  ahref = gsub('^.*?<a .*?href="', '', out)
  ahref = gsub('".*', '', ahref)

  dataSrc = gsub('^.*? data-lazy="', '', out)
  dataSrc = gsub('".*', '', dataSrc)

  ahref = paste0('<br><a href="', ahref, '">')
  imgline = paste0('<img class="lazy" data-src="', dataSrc, '"><br>', altLine)
  
  wholeLine = paste0(ahref, imgline, "</a>")

  return(wholeLine)
}

channelName = askforName()

startTime = format(Sys.time(), "%H:%M")

  urlHead = paste0("https://zh.xhamster.com/photos/search/", channelName)
  pagesource <- read_html(urlHead, warn=F, encoding = "UTF-8")

  cleanupTxt = cleanUp(pagesource)
  theWholepage = c(theWholepage, cleanupTxt)
  lastLineNum = as.numeric(readline(prompt="enter total page number "))

  if(is.na(lastLineNum)){ 
    cat("\nblank! exited!\n")
    break
  }

  cat("\n\nTotal Pages: ", lastLineNum, sep="\n")

  if(lastLineNum>1){
    for (page in 2:lastLineNum){
     url = paste0(urlHead, "&page=", page)
    	cat(" ", page, " url: ", url, "\n")
         pagesource <- read_html(url, warn=F, encoding = "UTF-8")
         cleanupTxt = cleanUp(pagesource)
         theWholepage = c(theWholepage, cleanupTxt)
    }
  }

options("encoding" = "UTF-8")

theFilename = paste0(channelName, "_PhotoAlbumSearch_xham.html")
htmlTail = readLines("htmlTail.html")

sinkfile(theWholepage, theFilename)

sinkWkeys <-function(theWholepage, theFilename, keyName){		# sink with key values
    sink(theFilename)
      cat('<base target="_blank"><html><head><title>')
      cat(keyName)
      cat('</title>\n<meta http-equiv="Content-Type" content="text/html; charset=utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1" />\n<link rel="stylesheet" href="https://williamkpchan.github.io/maincss.css">\n<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.js"></script>')
      cat('\n<script src="https://williamkpchan.github.io/lazyload.min.js"></script>\n<script src="https://williamkpchan.github.io/mainscript.js"></script>\n<script src="https://williamkpchan.github.io/commonfunctions.js"></script>\n<script>\n  var showTopicNumber = false;\n  var bookid = "')
      cat(keyName)
      cat('"\n  var markerName = "img"\n</script>\n<style>\nbody{width:80%;margin-left: 5%; font-size:20px;}\nh1, h2 {color: gold;}\nstrong {color: orange;}\nimg {width: 50%; max-width:120%; display: inline-block; margin-top: 2%;margin-bottom: 1%; border-radius:3px;}\n</style></head><body onkeypress="chkKey()"><center>\n<h1>')
      cat(keyName)
      cat('</h1>\n<pre><center>')
      cat(theWholepage, sep="\n")
      cat(htmlTail, sep="\n")
    sink()
}
