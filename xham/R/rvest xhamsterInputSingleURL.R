# a outfile will be created and open by chrome
# paste0("pohub ",theName,".html")
# htmlHeader.html and htmlTail.html is attached files

library(crayon)
  ligSilver <- make_style("#889988")
  lime <- make_style("#10ff10")
  gold <- make_style("#eeae00")
  purple <- make_style("#9400D3")
  deeppink <- make_style("#FF1493")
  darkgreen <- make_style("#004000")
  magenta  <- make_style("#800080")
  orange  <- make_style("#D93B6A")
  pink  <- make_style("#E98B8A") # note dont change this code
  brown  <- make_style("#B8937C")
  gray  <- make_style("#403E5D")
  blue  <- make_style("#12BBEC")
cat(yellow(format(Sys.time(), "%H:%M:%OSs"),"\n"))
library(rvest)

dirStr = "C:/Users/william/Desktop/scripts/xham"
setwd(dirStr)

htmlHeader = readLines("htmlHeader.html", warn = F)
htmlTail = readLines("htmlTail.html", warn = F)

dirStr = "C:/Users/william/Desktop/scripts/xham"
setwd(dirStr)

askforURL <-function(){		# "abc def" -> "abc+def"
	Selection = readline(prompt="enter url without last /: ")
	return(Selection)		# if empty, calling program handle
}

askforOutputName <-function(){
	Selection = readline(prompt="enter output name: ")
	return(Selection)		# if empty, calling program handle
}

boilPages <- function(theURL){
  cat(theURL, "\n")
  pagesource <- read_html(theURL, warn=F, encoding = "UTF-8")

  className = "div.phimage a, .thumb-list__item a"

  keywordList <- as.character(html_nodes(pagesource, className))
  return(keywordList)
}

# cleanUp
cleanUp <- function(out){
  emptyI = grep("^$", out)
  out = out[-emptyI]

  out = gsub(' class="video-thumb.*?href', ' href', out)
  out = gsub(' data-sprite.*?<img', '><img', out)
  out = gsub('thumb-image-container__image', 'lazy', out)
  out = gsub(' src', 'data-src', out)
  out = gsub(' onload.*', '></a>', out)

  out = gsub(' class="video-thumb-info__name role-pop"', '', out)
  out = gsub(' data-role.*?>', '>', out)

  return(out)
}


# =========
# entry point
theName = askforURL()
if(theName == ""){
	break
}

outputName = askforOutputName()
outputName = paste0("xham_", outputName, ".html")
allTheList =""
allTheList = c(allTheList, boilPages(theName))

allTheList = cleanUp(allTheList)
allTheList = unique(allTheList)
#out = allTheList

options("encoding" = "UTF-8")
	sink(outputName)
	cat(htmlHeader, sep="\n")
	cat("Total: ", length(allTheList))
	cat(allTheList, sep="\n")
	cat(htmlTail, sep="\n")
	sink()

cat(pink(getwd()))
cat(pink("\nFile created:"), outputName,"\n")
shell(outputName)
cat(red("Job completed!\n"))

