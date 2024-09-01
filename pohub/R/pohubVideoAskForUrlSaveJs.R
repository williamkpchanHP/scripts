setwd("C:/Users/william/Desktop/scripts/R")
library(rvest)
library(crayon)

content = character()
excludeKeywords = tolower(readLines("excludeKeywords.txt"))
includeKeywords = tolower(readLines("includeKeywords.txt"))

askforRelated <-function(){		# "abc def" -> "abc+def"
	Selection = readline(prompt="enter relating url: ")
	return(Selection)		# if empty, calling program handle
}

collectContents <- function(thepage){
  # find out link details
  className = ".linkVideoThumb"
  keywords = html_nodes(thepage, className)
  keywords = as.character(keywords)

  includeList = character()
  includeIdx = unlist(sapply(includeKeywords, function(i){grep(i, tolower(keywords))}))
  if(length(includeIdx)>0){
    includeList = keywords[includeIdx]
  }

  rmvIdx = unlist(sapply(excludeKeywords, function(i){grep(i, tolower(keywords))}))
  if(length(rmvIdx)>0){
    keywords = keywords[-rmvIdx]
  }

  keywords = c(keywords, includeList) # put the includeList back

  keywords = gsub(' title.*<img','><img',keywords)
  keywords = gsub('data-mxptype=.*?href','href',keywords)
  imgUrl = gsub('^.*?data-thumb_url="', "", keywords)
  imgUrl = gsub('" .*', "", imgUrl)
  keywords = gsub('<img.*','<img class="lazy" data-src="',keywords)
  keywords = paste0(keywords, imgUrl, '"></a>')
  keywords = gsub('/view_video.*?viewkey=','https://www.pornhub.com/embed/',keywords)

  content <<- c(content, keywords)
}

####### entry point
output = " "
while(output != ""){
  cat("\n")
  content = character()
  urlAddr = askforRelated()
  if( urlAddr == ""){break}

  thepage = read_html(urlAddr, warn=F, encoding = "UTF-8")
  collectContents(thepage)	# process this page first

  reqMultiPage = readline(prompt="enter Max page number: ")
  if( reqMultiPage != ""){
    reqMultiPage = as.numeric(reqMultiPage)
  }

  if( reqMultiPage >1){
    for(i in 2:reqMultiPage){
      cat(i, " ")
      urlAddr = paste0(urlAddr, "&page=", i)
      thepage = read_html(urlAddr, warn=F, encoding = "UTF-8")
      collectContents(thepage)	# process this page first
    }
  }

  content = unique(content)
  content = paste0("'",content,"',")

  outputName = "pohubVid.js"
  outputFile = readLines(outputName)
  closingIdx = grep("]", outputFile)
  outputFile = outputFile[-closingIdx]

  file.rename(outputName, paste0(outputName,"_backup",format(Sys.Date(), format="%y%m%d"), ".js"))

  content = c(outputFile, content, "]")
# filter unwanted
  javIdx = grep("javascript", content)
  if(length(javIdx)>0){
    content = content[-javIdx]
  }

  privateImg = "https://di.phncdn.com/videos/202001/17/277230941/original/(m=eafTGgaaaa)(mh=wnFVQlrY7kaySULa)3.jpg"
  privateIdx = grep(privateImg, content)
  if(length(privateIdx)>0){
    content = content[-privateIdx]
  }

  pohubExcludeList = readLines("pohubExcludeList.txt")
  excludeIdx = unlist(sapply(pohubExcludeList, function(i){grep(i, content)}))
  if(length(excludeIdx)>0){
    content = content[-excludeIdx]
  }

# save file
  sink(outputName)
  cat(content, sep="\n")
  sink()
  shell("pohubVidListEnd.html")
}

