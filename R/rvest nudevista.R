# handle nudevista search
# a outfile will be created and open by chrome
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

dirStr = "C:/Users/william/Desktop/scripts/R"
setwd(dirStr)

htmlHeader = readLines("htmlHeader.html", warn = F)
htmlTail = readLines("htmlTail.html", warn = F)

dirStr = "C:/Users/william/Desktop/scripts"
setwd(dirStr)

askforURL <-function(){		# "abc def" -> "abc+def"
	Selection = readline(prompt="enter keyword: ")
	return(Selection)		# if empty, calling program handle
}

boilPages <- function(theURL){
  cat(theURL, "\n")
  pagesource <- read_html(theURL, warn=F, encoding = "UTF-8")

  className = "td a"

  keywordList <- as.character(html_nodes(pagesource, className))
  keywordListIdx <- grep("video.nudevista", keywordList)
  keywordList = keywordList[keywordListIdx]
  keywordList = gsub("<i .*?</i>", "", keywordList)
  keywordList = gsub('src="//', 'src="https://', keywordList)
  keywordList = gsub(' itemprop="thumbnailUrl"', '', keywordList)
  keywordList = gsub(' class="b".*?</a>', '></a>', keywordList)
  keywordList = gsub(' class="title".*?>', '>', keywordList)
  keywordList = gsub(' class="name".*?>', '>', keywordList)


  return(keywordList)
}

# cleanUp
cleanUp <- function(out){
  out = gsub("\n", " ", out)
  out = gsub(" {1,}", " ", out)
  out = gsub("<a", "\n<a", out)
  removeLine = grep('<a href="javascript', out)
 # if(length(removeLine)!=0){
 #   out = out[-removeLine]
 # }
  substword = '<a href="https://www.pornhub.com/embed/'
  out = gsub('<a href="/', substword, out)
  out = gsub('<div.*?</a>', '</a>', out)
  out = gsub(' title=".*?<img', '><img', out)
  out = gsub(' title="', '>', out)
  out = gsub('"></a>', '</a>', out)
  out = gsub(' src=.*?data-src', ' class="lazy" data-src', out)
  out = gsub(' data-image.*?>', '><br>', out)
  out = gsub(' data-medium.*?>', '><br>', out)
  out = gsub('view_video.php\\?viewkey=', '', out)

  return(out)
}


# =========
# entry point
theName = askforURL()
if(theName == ""){
	break
}
theName = gsub(" ", "+", theName)
theName = paste0("https://www.nudevista.com/?q=", theName)

allTheList =""
allTheList = c(allTheList, boilPages(theName))

# allTheList = cleanUp(allTheList)
#out = allTheList

options("encoding" = "UTF-8")
	sink("nudevistaOutput.html")
	cat(htmlHeader, sep="\n")
	cat(allTheList, sep="\n")
	cat(htmlTail, sep="\n")
	sink()

cat(pink(getwd()))
cat(pink("\nnudevistaOutput.html created"))
shell("nudevistaOutput.html")
cat(red("Job completed!"))

