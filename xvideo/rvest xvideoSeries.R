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

dirStr = "C:/Users/william/Desktop/scripts/xvideo"
setwd(dirStr)

htmlHeader = readLines("htmlHeader.html", warn = F)
htmlTail = readLines("htmlTail.html", warn = F)

dirStr = "C:/Users/william/Desktop/scripts"
setwd(dirStr)

askforURL <-function(){		# "abc def" -> "abc+def"
	Selection = readline(prompt="enter url without last /: ")
	return(Selection)		# if empty, calling program handle
}
askforTotal <-function(){
	Selection = readline(prompt="enter total pages: ")
	return(Selection)		# if empty, calling program handle
}
askforOutputName <-function(){
	Selection = readline(prompt="enter output name: ")
	return(Selection)		# if empty, calling program handle
}
askforCat <-function(){
	Selection = readline(prompt="select category: 0 Channel, model/ 1 Search/ 2 PornstarUpload, 0/1/2 : ")
	return(Selection)		# if empty, calling program handle
}

boilPages <- function(theURL){
  cat(theURL, "\n")
  pagesource <- read_html(theURL, warn=F, encoding = "UTF-8")

  className = "div.thumb, p.title, .phimage a"

  keywordList <- as.character(html_nodes(pagesource, className))
  return(keywordList)
}

# cleanUp
cleanUp <- function(out){
  altLine = gsub('^.*? alt="', '', out)
  altLine = gsub('".*', '', altLine)

  dataSrc = gsub('^.*? data-src="', '', out)
  dataSrc = gsub('".*', '', dataSrc)

  ahref = gsub('<a .*?viewkey=', '', out)
  ahref = gsub('".*', '', ahref)

  ahref = paste0('<a href="https://www.pornhub.com/embed/', ahref, '">')
  imgline = paste0('<img class="lazy" data-src="', dataSrc, '"><br>', altLine)
  
  wholeLine = paste0(ahref, imgline, "</a>")

  return(wholeLine)
}


# =========
# entry point
theName = askforURL()
if(theName == ""){
	break
}
totalPages = askforTotal()
if(totalPages == ""){
	totalPages = askforTotal()
}
totalPages = as.numeric(totalPages)
category = askforCat()
if(category == "0"){
	category = "/videos?page="
}else if(category == "1"){
	category = "&page="
}else if(category == "2"){
	category = "?page="
}else{
	break
}

outputName = askforOutputName()
outputName = paste0("xvideo_", outputName, ".html")
allTheList =""
allTheList = c(allTheList, boilPages(theName))

if(totalPages > 1){
  for(i in 2:totalPages){
    thenewName = paste0(theName, category, i)
    allTheList = c(allTheList, boilPages(thenewName))
  }
}

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

