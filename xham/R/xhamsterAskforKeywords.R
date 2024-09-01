# ask for xhamster keyword and extract jpg
library(rvest)
library(crayon)

dirStr = "C:/Users/william/Desktop/scripts/xham"
setwd(dirStr)
source("retrieveFile.R") # the workhorse here

# remember to modify exclusionList if needed
exclusionList = readLines("exclusionList.txt")
excludeKeywords = readLines("excludeKeywords.txt")
allAlbumList = character()
allLinkList = character()
allPhotoList = character() # all images here

askforKey <-function(){		# "abc def" -> "abc+def"
	Selection = readline(prompt="enter key words: ")
	if(Selection != "")   {
	  	Selection = tolower(gsub(" ", "+", Selection))
  	}
	return(Selection)		# if empty, calling program handle
}

askforNum <-function(){		
	Selection = readline(prompt="each page may gives 56 albums, enter max number of page: ")
	return(Selection)		# if empty, calling program handle
}

MakeKey <- function(Selection){
	searchHead = 'https://xhamster.com/search/photos?q='
	# another search header: 
	# https://xhamster.com/photos/search/beautiful+pierced+pussy

	return(paste0(searchHead, Selection))
}

collectAllAlbumList <- function(searchKey){  # return to allAlbumList
	for(i in 1:thenum){
	    cat(i," ")
	    if(i%%100 == 0){
		cat("\n")
	    }

          theurl = paste0(MakeKey(thekeyword), "&p=", i)
          cat("url: ", theurl,"\n")

		pagesource = read_html(theurl, warn=F, encoding = "UTF-8")
          className = '.thumb-list__item a'
          keywordList <- html_nodes(pagesource, className)

          keywordList <- html_attr(keywordList, "href")
          keywordList = as.character(keywordList)

		allAlbumList <<- c(allAlbumList, keywordList)
	}
}

# =========
# entry point

thekeyword = askforKey()
if(thekeyword == ""){
	break
}

output = paste0(thekeyword, ".html")
thenum = 2
asknum = askforNum()
if(asknum != "")   {
	thenum = as.numeric(asknum)
} else{
	thenum = 2 # should not be large to avoid less pages available and error
}
cat("Collecting ", thenum, " toc pages...\n")
startTime = format(Sys.time(), "%H:%M")

collectAllAlbumList(allAlbumList)

# for(thelink in allAlbumList){ collectAlbumTitle(thelink) } # get all albums links, img and title

collectLinks(allAlbumList) # collect multi links in each album

# each link includes muitlple photo titles, collect all title links
allPointerLink = allLinkList
allLinkList = character() # reset allLinkList

collectImgs(allPointerLink) # collect images

    htmlTitle = thekeyword
    allAlbumTitles = character()

    sink(output)
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
      cat('  var topicEnd = "";\n')
      cat('  var bookid = "',htmlTitle,'"\n', sep="")
      cat('  var markerName = "img"\n')
      cat('</script>\n')
      cat('<style>\n')
      cat('body{width:100%;margin-left: 0%;cursor: none; font-size:22px;}\n')
      cat('h1, h2 {color: gold;}\n')
      cat('strong {color: orange;}\n')
      cat('pre{width:100%;}\n')
      cat('div{display: inline-block; width:32%;}\n')
      cat('</style></head><body onkeypress="chkKey()"><center>\n')
    
      cat("Total Titles: ",length(allAlbumTitles), "<br><br>\n")
      cat('<div id="toc"></div><br>\n')
      cat('<pre><center><br><br>')
    
      for(element in allPhotoList){
        cat(element, sep="\n")
      }
      cat('<script src="https://williamkpchan.github.io/LibDocs/readbook.js"></script>\n<script src="imgControl.js"></script>\n')
      cat('<script>var lazyLoadInstance= new LazyLoad({elements_selector:".lazy"});</script>\n')
      cat('</pre></body></html>\n')
    sink()
    cat(red("Job completed!\n"))
    cat(yellow("output file is: ", output, "\n"))

    endTime = format(Sys.time(), "%H:%M")
    cat("startTime: ", startTime, " endTime: ",endTime,"\n")

# no shell to avoid big files

# startstr="start chrome.exe --start-fullscreen "
# note to quote the long filename
# shell(paste0(startstr, dirStr,"/", paste0(thekeyword,".html\"")))
# shell(paste0(startstr, "\"file:///",dirstr, outputfileName,"\""))

