setwd("C:/Users/william/Desktop/scripts/R")
library(rvest)
library(crayon)

urlheader ="https://www.pornhub.com/video/search?search="
urltail = "&page="
content = character()

askforKey <-function(){		# "abc def" -> "abc+def"
	Selection = readline(prompt="enter key words: ")
	if(Selection != "")   {
	  	Selection = tolower(gsub(" ", "+", Selection))
  	}
	return(Selection)		# if empty, calling program handle
}

collectContents <- function(thepage){
  # find out link details
  className = ".linkVideoThumb"
  keywords = html_nodes(thepage, className)
  keywords = as.character(keywords)
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
output = "."
while(output != ""){
  cat("\n")
  content = character()
  output = askforKey()
  if( output == ""){break}
  urlAddr = paste0(urlheader,output)
  maxPageNum = as.numeric(readline(prompt="enter max page number: "))
  thepage = read_html(urlAddr, warn=F, encoding = "UTF-8")

  # find out max page number
  cat(red("total pages is: ", maxPageNum,"\n"))
  collectContents(thepage)	# process this page first
  if(maxPageNum > 1){
    for(i in 2:maxPageNum){
      cat(i," ")
      urlAddr = paste0(urlheader, output, urltail, i)
      thepage = read_html(urlAddr, warn=F, encoding = "UTF-8")
      collectContents(thepage)
    }
  }
  outputFile = paste0(output, "_pohubVideo.html")
  htmlTitle = output
  javIdx = grep("javascript", content)
  content = content[-javIdx]
  content = unique(content)
  sink(outputFile)
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
    cat('Total: ', length(content),"<br>\n")
    cat('<div id="toc"></div>\n')
    cat('<center>\n')
    cat(content, sep="\n")
    cat('<script src="https://williamkpchan.github.io/LibDocs/readbook.js"></script>\n<script src="imgControl.js"></script>')
    cat('<script>var lazyLoadInstance= new LazyLoad({elements_selector:".lazy"});</script>\n')
    cat('</pre></body></html>\n')
  sink()
  shell(outputFile)
}