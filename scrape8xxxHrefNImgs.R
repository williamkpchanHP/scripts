
setwd("C:/Users/william/Desktop/scripts/allHtmls")
#setwd("C:/Users/User/Pictures/sexpage")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")
source("../retrieveFile.R")


# doSingleUrl function, within one url, multiple addrs each with one image only
doSingleUrl <- function(thisurl){
    cat("\nthis album url: ", thisurl, "\n\n")
    className = ".xhumb a"
    allImgs = character()

    xxx.netIdx = grep("xxx.net", thisurl)
    if(length(xxx.netIdx)>0){ className = ".xhumb a" }

    thepage <- retrieveFile(thisurl)
    if(!is.character(thepage)){
      itemList <- thepage %>% html_nodes(className)
      itemListurl = html_attr(itemList, "href")
      itemListurl = paste0('http://user.8xxx.net', itemListurl)

      # loop to collect images from itemListurl
      for(i in 1:length(itemListurl)){
        itemurl <- itemListurl[i]
        #cat(itemurl,"\n")
        thepage <- retrieveFile(itemurl)
        if(!is.character(thepage)){

          theimgp <- thepage %>% html_nodes(".col p")
          theimg <- theimgp %>% html_nodes("img")
          theimg = html_attr(theimg, "src")

          allImgs = c(allImgs, theimg)
        }else{
          cat("unable to connect itemurl!", itemurl, "\n")
        }
      }
    }else{
      cat("unable to connect thisurl!", thisurl, "\n")
    }

    allImgs = paste0('<img loading="lazy" src="', allImgs, '">')
    cat(yellow("\n\nthis album total imgs: "), length(allImgs),"\n\n")
    return(allImgs)
}

# getOnePageMultiAlbums, this one link contain multiple albums
# and each albums got multi image links
getOnePageMultiAlbums <- function(thepage){
    # get page links
    itemList <- thepage %>% html_nodes(".col .xhumb a")
    itemListurl = html_attr(itemList, "href")
    itemListurl = paste0('http://user.8xxx.net', itemListurl)

    wholeAllimgs = character(0)
    # get images from every albums
    albumLen = length(itemListurl)
    for(i in 1:albumLen){
      cat("album", i, "of", albumLen,"\n")
      url = itemListurl[i]
      allimgs = doSingleUrl(url)
      wholeAllimgs = c(wholeAllimgs, allimgs)
      cat(white("\n\nthisOnePageMultiAlbums total imgs: ", length(wholeAllimgs),"\n\n"))
    }
    return(wholeAllimgs)
}

# savefile function
savefile <- function(allimgs){
    outFilename = "8xxxImgsList.js"
    allimgs = paste0("'", allimgs, "',")
    allimgs = c(allimgs, "]")

    outFile = readLines(outFilename)
    outFile = outFile[-length(outFile)]
    outFile = c(outFile, allimgs)
    sink(outFilename)
    cat(outFile, sep="\n")
    sink()
    shell("8xxxImgs.html")
}

# searchkeyword function
searchkeyword <- function(){
    currentPageNum = 1

    keyword <<- readline(prompt="enter keyword:")
    typeof <- readline(prompt="search or category? 0/1 ")
    keyword <<- gsub(" ", "%20", keyword)
    if(typeof == "0"){
      searchurl = paste0("http://user.8xxx.net/?search=", keyword)
    }else{
      searchurl = paste0("http://user.8xxx.net/c/", keyword)
    }
    cat("\n\nBegin...\n")
      thepage <- retrieveFile(searchurl)

      # collect images from albums first
      totalAlbumimgs <<- getOnePageMultiAlbums(thepage)

      # get pagination
      pagination <- thepage %>% html_nodes(".pagination a")
      nextpage = html_attr(pagination, "href")
      nextpage = nextpage[length(nextpage)]
      nextPageNum = as.numeric(gsub("^.*?page=","",nextpage))
      if(length(nextPageNum) == 0){nextPageNum = 0}
      nextpageUrl = paste0("http://user.8xxx.net", nextpage)
      cat(red("\n\nnextpageUrl: ", nextpageUrl,"\n\n"))

      while(nextPageNum>currentPageNum){
        cat(red("\n\ncurrentPageNum: ",currentPageNum, "nextPageNum", nextPageNum,"\n\n"))
        currentPageNum = nextPageNum
        thepage <- retrieveFile(nextpageUrl)
        onepageImgs = getOnePageMultiAlbums(thepage)
        totalAlbumimgs <<- c(totalAlbumimgs, onepageImgs)

        pagination <- thepage %>% html_nodes(".pagination a")
        nextpage = html_attr(pagination, "href")
        nextpage = nextpage[length(nextpage)]
        nextPageNum = as.numeric(gsub("^.*?page=","",nextpage))

        nextpageUrl = paste0("http://user.8xxx.net", nextpage)
        cat(blue("totalAlbumimgs: ", length(totalAlbumimgs), "\n"))
      }
      savefile(totalAlbumimgs)
      cat(red("\nsearch completed!\n"))
}

# main loop
cat(red("Scrape href and images!\n"))
cat("http://user.8xxx.net\n")
    totalAlbumimgs = character(0)
    keyword = character(0)
loopType = readline("select single url or search keyword: 0/1 ")

if(loopType == 0){
    # url = "http://user.8xxx.net/i/287785-pierced-busty-milf/gallery20264576/"
    url <- readline(prompt="enter url:")
    allimgs = doSingleUrl(url)
    savefile(allimgs)
    cat(green("\nsingle url completed!\n"))
    cat(green("\ntotal images: ", length(allimgs), "\n"))

}else{
    searchkeyword()
}

