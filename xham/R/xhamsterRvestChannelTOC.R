# this is exactly same as xhamsterUsers.R, same to pornstar

dirStr = "C:/Users/william/Desktop/scripts/xham"
setwd(dirStr)
library(rvest)
library(crayon)

theWholepage = character()

askforName <-function(){		# "abc def" -> "abc+def"
	Selection = readline(prompt="enter channel name: ")
	if(Selection == "")   { 
		cat("\nblank address! exited!\n")
		break
	}
	return(Selection)		# if empty, calling program handle
}

  # assemble contents
   assembleContents <-function(sourceData) {
    className = 'div.channel-thumb-container__image-container a.channel-thumb-container__image-container-image'
    keywordList <- html_nodes(sourceData, className)
    keywordHref = html_attr(keywordList, "href")
    keywordHref = as.character(keywordHref)
    keywordImg <- html_nodes(keywordList, "img")
    keywordImg = as.character(keywordImg)
    keywordImg = gsub('class=".*?"', '', keywordImg)
    keywordImg = gsub(' src', ' class="lazy" data-src', keywordImg)
    keywordImg = gsub(' alt=', ' title=', keywordImg)
    #keywordImg = gsub(' onload.*', '>', keywordImg)

    for(i in 1:length(keywordHref)){
      anchor = paste0('<a href="',keywordHref[i], '">',
               keywordImg[i], '</a>')
      theWholepage <<- c(theWholepage, anchor)
    }
   }

channelName = "xhamsterChannels"

startTime = format(Sys.time(), "%H:%M")

url = "https://xhamster.com/channels"
  pagesource <- read_html(url, warn=F, encoding = "UTF-8")

  paginatorclassName = ".xh-paginator-button "
  keywordList <- html_nodes(pagesource, paginatorclassName)

  links = html_attr(keywordList, "href")
  linksline = grep("https", links)
  links = links[linksline]
  if(length(links) != 0){
    lastLine = links[length(links)]
    lastLineNum = as.numeric(gsub("http.*/", "", lastLine))
  }

  cat("\n\nTotal Pages: ", lastLineNum, sep="\n")

  assembleContents(pagesource)

for (page in 2:lastLineNum){
     url = paste0("https://xhamster.com/channels/", page)

	cat(" ", page, " url: ", url, "\n")
     pagesource <- read_html(url, warn=F, encoding = "UTF-8")
     assembleContents(pagesource)
}

theFilename = paste0("xhamster_", channelName, ".html")
htmlTitle = gsub("\\.html", "", theFilename)

sink(theFilename)
  cat('<base target="_blank"><html><head><title>',htmlTitle,'</title>\n', sep="")
  cat('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">\n')
  cat('<meta name="viewport" content="width=device-width, initial-scale=1" />\n')
  cat('<link rel="stylesheet" href="https://williamkpchan.github.io/maincss.css">\n')
  cat('<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.js"></script>\n')
  cat('<script src="https://williamkpchan.github.io/lazyload.min.js"></script>\n')
  cat('<script type="text/javascript" src="https://williamkpchan.github.io/mainscript.js"></script>\n')
  cat('<script src="https://williamkpchan.github.io/commonfunctions.js"></script>\n')
  cat('<script src="https://d3js.org/d3.v4.min.js"></script>\n')
  cat('<script>\n')
      cat('  var showTopicNumber = false;\n')
      cat('  var topicEnd = " ";\n')
      cat('  var bookid = "',htmlTitle,'"\n', sep="")
      cat('  var markerName = "img"\n')
  cat('</script>\n')
  cat('<style>\n')
  cat('body{width:100%;margin-left: 0%; font-size:22px;}\n')
  cat('h1, h2 {color: gold;}\n')
  cat('strong {color: orange;}\n')
  cat('pre{width:100%;}\n')
  cat('</style></head><body onkeypress="chkKey()"><center>\n')
  cat('Total: ', length(theWholepage), '<br>\n')
  cat('<div id="toc"></div>\n')
  cat('<center>\n')
  cat(theWholepage, sep="\n")
  cat('<script src="https://williamkpchan.github.io/LibDocs/readbook.js"></script>\n<script src="imgControl.js"></script>')
  cat('<script>var lazyLoadInstance= new LazyLoad({elements_selector:".lazy"});</script>\n')

  cat('</body></html>\n')
sink()
cat(red("\nJob completed!\n"))
endTime = format(Sys.time(), "%H:%M")
cat(cyan("\noutfile file: "), white(theFilename), "\n\n")

cat("startTime: ", startTime, " endTime: ",endTime,"\n\n")
shell(theFilename)
