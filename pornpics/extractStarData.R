
# extractStarData
#setwd("C:/Users/User/Pictures/sexpage")

# Load required library
library(rvest)
library(xml2)

setwd("C:/Users/william/Desktop/scripts/pornpics")
source("../retrieveFile.R")

urlHeader = "https://www.pornpics.com/pornstars/female/"
pageNum = 1:471

Wholepage = character()
className = ".thumbwook"
for(i in pageNum){
  url = paste0(urlHeader, i)
  cat("\n",url, " ")
  pagesource <- retrieveFile(url)

  itemList <- html_nodes(pagesource, className)
  #itemList <- as.character(html_nodes(pagesource, className))

  starname <- gsub('^.*?m-name">', "", itemList)
  starname <- gsub('</span.*', "", starname)
  galleryCnt <- gsub('^.*?</i> ', "", itemList)
  galleryCnt <- gsub('</span.*', "", galleryCnt)
  galleryCnt <- as.numeric(gsub(',', "", galleryCnt))

  starUrl <- gsub('^.*?href="', "", itemList)
  starUrl <- gsub('/" tit.*', "", starUrl)
  imgUrl <- gsub('^.*?data-src="', "", itemList)
  imgUrl <- gsub('" alt.*', "", imgUrl)

  fullAdr = paste0(galleryCnt, "'",starUrl, '">', starname, ', ', galleryCnt, '<br><img src="', imgUrl, '"><br>')
  fullAdr = sort(fullAdr)

  Wholepage = c(Wholepage, fullAdr)
  cat(length(Wholepage), " ")
}

cat("\ntotal: ",length(Wholepage), "\n")
outFilename = paste0("pornPicsStarList.html")

  templateHead = readLines("templateHead.txt")
  templateTail = readLines("templateTail.txt")
  templateHead = gsub("mom50", "pornpic star list", templateHead)
  templateTail = gsub("mom50", "pornpic star list", templateTail)

sink(outFilename)
  cat(Wholepage, sep="\n")
sink()
