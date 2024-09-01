
# remember to modify exclusionList if needed
setwd("C:/Users/william/Desktop/scripts/R")
library(rvest)
library(crayon)

# remember to keep / at end of allAlbumHeader
allAlbumHeader = "https://www.pichunter.com/search/clit ring/"
excludeKeywords = readLines("excludeKeywords.txt")

output = gsub("https://www.pichunter.com/search/", "", allAlbumHeader)
output = gsub("/", "", output)
output = paste0("pichunter-", output, ".html")

allAlbumList = character()
allLinkList = character()
allPhotoList = character()

extImg = function(anchor){
  n = gsub('<a n="', '', anchor)
  n = as.numeric(gsub('".*', '', n))
  imgAddrHead = gsub('^.*src="', '', anchor)
  imgAddrHead = gsub('_.*', '_', imgAddrHead)
  if(!is.na(n)){
    for(items in 1:n){
      theImg = paste0('<img class="lazy" data-src="',imgAddrHead, items, '_o.jpg">')
      allPhotoList <<- c(allPhotoList, theImg)
    }
  }
}

collectAlbums = function(url){
  pagesource <- read_html(url, warn=F, encoding = "UTF-8")
  impClassName = "a.pop-execute"
  keywordList <- html_nodes(pagesource, impClassName)
  keywordList = as.character(keywordList)

  for(anchor in keywordList){
    extImg(anchor) 
  }
}

startTime = format(Sys.time(), "%H:%M")

cat(yellow("\ncollect link info...", "\nallAlbumHeader: ", allAlbumHeader, "\n"))
pagesource <- read_html(allAlbumHeader, warn=F, encoding = "UTF-8")
className = ".fibonacci_pagination"
keywordList <- html_nodes(pagesource, className)
links = as.character(keywordList)
linksline = gsub('.*maxpages="','', links)
linksline = gsub('".*','', linksline)
links = as.numeric(linksline)
cat(red("total albums: ", links,"\n"))
impClassName = "a.pop-execute"
keywordList <- html_nodes(pagesource, impClassName)
keywordList = as.character(keywordList)

for(anchor in keywordList){
  extImg(anchor) 
} # get all albums links

if(length(links)>0){
  for(linkNum in 2:links){
    url = paste0(allAlbumHeader, linkNum)
    cat("url", url,"\n")
    collectAlbums(url) 
  }
}

htmlTitle = gsub("\\.html", "", output)

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
  cat('<div id="toc"></div>\n')
  cat('<pre><center>\n')
  cat(allPhotoList, sep="\n")
  cat('<script src="https://williamkpchan.github.io/LibDocs/readbook.js"></script>\n<script src="imgControl.js"></script>')
  cat('<script>var lazyLoadInstance= new LazyLoad({elements_selector:".lazy"});</script>\n')

  cat('</pre></body></html>\n')
sink()
cat(red("\nJob completed!\n"))
endTime = format(Sys.time(), "%H:%M")
cat(cyan("\noutput file: "), white(output), "\n\n")

cat("startTime: ", startTime, " endTime: ",endTime,"\n\n")
shell(output)
