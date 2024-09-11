# collect Pinterest images with keyword

setwd("C:/Users/william/Desktop/scripts/allHtmls")
#setwd("C:/Users/User/Pictures/sexpage")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")
cat(red("Scrape href and images!\n"))
cat("8xxx.net\n")

loopType = readline("select single url or search keyword: 0/1 ")

if(loopType == 0){
    url = "http://user.8xxx.net/i/287785-pierced-busty-milf/gallery20264576/"
    url <- readline(prompt="enter url:")
    allimgs = singlepage(url)
    savefile <- function(allimgs){
}else{
  searchkeyword()
}

# singlepage function
singlepage <- function(urk){
    className = ".xhumb a"

    xxx.netIdx = grep("xxx.net", url)
    if(length(xxx.netIdx)>0){ className = ".xhumb a" }

    thepage <- read_html(url)
    itemList <- thepage %>% html_nodes(className)
    itemListurl = html_attr(itemList, "href")
    itemListurl = paste0('http://user.8xxx.net', itemListurl)

    # loop to collect images from itemListurl
    allImgs = character()
    for(i in 1:length(itemListurl)){
      url <- itemListurl[i]
      cat(url,"\n")
      thepage <- read_html(url)
      theimgp <- thepage %>% html_nodes(".col p")
      theimg <- theimgp %>% html_nodes("img")
      theimg = html_attr(theimg, "src")

      allImgs = c(allImgs, theimg)
    }

    allImgs = paste0('<img loading="lazy" src="', allImgs, '">')
    cat(yellow("Total imgs: "), length(allImgs),"\n")
    return(allImgs)
}

# get single Page Imgs
getSinglePageImgs <- function(thepage){
    # get page links
    itemList <- thepage %>% html_nodes(".col .xhumb a")
    itemListurl = html_attr(itemList, "href")
    itemListurl = paste0('http://user.8xxx.net', itemListurl)

    wholeAllimgs = character(0)
    # get images
    for(i in 1:length(itemListurl)){
      url = itemListurl[i]
      allimgs = singlepage(url)
      wholeAllimgs = c(wholeAllimgs, allimgs)
    }
    return(wholeAllimgs)
}

# savefile function
savefile <- function(allimgs){
    outFilename = "temploopImgs.html"
    write(allimgs, outFilename, append=TRUE)
    shell(outFilename)
}
# searchkeyword function
searchkeyword <- function(){
    allimgs = character(0)
    currentPageNum = 1
    keyword = "pierced"
    keyword <- readline(prompt="enter keyword:")
    
    url = paste0("http://user.8xxx.net/?search=", keyword)

      thepage <- read_html(url)
      onepageImgs = getSinglePageImgs(thepage)

      # get pagination
      pagination <- thepage %>% html_nodes(".pagination a")
      nextpage = html_attr(pagination, "href")
      nextpage = nextpage[length(nextpage)]
      nextPageNum = as.numeric(gsub("^.*?page=","",nextpage))

      nextpage = paste0("http://user.8xxx.net", nextpage)

      while(nextPageNum>currentPageNum){
        thepage <- read_html(url)
        pagination <- thepage %>% html_nodes(".pagination a")
        nextpage = html_attr(pagination, "href")
        nextpage = nextpage[length(nextpage)]
        nextPageNum = as.numeric(gsub("^.*?page=","",nextpage))

        nextpage = paste0("http://user.8xxx.net", nextpage)
        onepageImgs = getSinglePageImgs(thepage)

      }


      thepage <- read_html(nextpage)



      savefile(onepageImgs)
}
