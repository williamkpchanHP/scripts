# collect all photos from all sub albums, takes a long time to finish
# use the workhorse: retrieveFile.R to collect multiple cabinet photos
# input: url only, will find out number of following links by workhorse
# this is the controller of retrieveFile.R
# enter url of one cabinet

setwd("C:/Users/william/Desktop/scripts/R")
library(rvest)
library(crayon)

source("retrieveFile.R") # the workhorse here

allAlbumHeader = "https://zh.xhamster.com/users/sexypumacat/photos"
output = "sexypumacat.html"

allAlbumList = character()
allLinkList = character()
allPhotoList = character()

collectLinks(allAlbumHeader) # many page links in this user
for(thelink in allLinkList){ collectAlbums(thelink) } # get all albums links

#allPageHeader = allAlbumList
allLinkList = character() # reset allLinkList
collectLinks(allAlbumList) # collect multi links in each album

# each link includes muitlple photo titles, collect all title links
allPointerLink = allLinkList
allLinkList = character() # reset allLinkList

collectImgs(allPointerLink) # collect images

#collectImgs(allLinkList)

sink(output)
  cat('<base target="_blank"><html><head><title>xhamPhoto</title>\n')
  cat('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">\n')
  cat('<meta name="viewport" content="width=device-width, initial-scale=1" />\n')
  cat('<link rel="stylesheet" href="https://williamkpchan.github.io/maincss.css">\n')
  cat('<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.js"></script>\n')
  cat('<script src="https://williamkpchan.github.io/lazyload.min.js"></script>\n')
  cat('<script type="text/javascript" src="https://williamkpchan.github.io/mainscript.js"></script>\n')
  cat('<script src="D:/Dropbox/Public/commonfunctions.js"></script>\n')
  cat('<script src="https://d3js.org/d3.v4.min.js"></script>\n')
  cat('<script>\n')
  cat('  var showTopicNumber = true;\n')
  cat('  var bookid = "xhamPhoto"\n')
  cat('  var markerName = "img"\n')
  cat('</script>\n')
  cat('<style>\n')
  cat('body{width:100%;margin-left: 0%; font-size:22px;}\n')
  cat('h1, h2 {color: gold;}\n')
  cat('strong {color: orange;}\n')
  cat('pre{width:100%;}\n')
  cat('</style></head><body onkeypress="chkKey()"><center>\n')
  cat('<div id="toc"></div>\n')
  cat('<pre>\n')
  cat(allPhotoList, sep="\n")
  cat('<script src="https://williamkpchan.github.io/LibDocs/readbook.js"></script>\n')
  cat('<script>var lazyLoadInstance= new LazyLoad({elements_selector:".lazy"});$("img").click(function() { window.open(this.src)})</script>\n')
  cat('</pre></body></html>\n')
sink()
cat(red("Job completed!\n"))