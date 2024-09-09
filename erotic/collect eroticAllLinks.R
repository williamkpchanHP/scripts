# https://erotic.pics/mila-marquez/
# Mila Marquez
# .entry img

Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
setwd("C:/Users/william/Desktop/scripts/erotic")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

linkHeader = "https://erotic.pics/"
linkTail = "/page/"

# display billboard
cat("\n\n\n")
keyword = readline("enter keyword: ")
keyword = gsub(" ", "-", keyword)
keyword = tolower(keyword)
pageTail=""

wholePage = character()
linkClassName = "h2 a"
source("../retrieveFile.R")

ProcessStartTime = Sys.time()

Ourl = paste0(linkHeader, keyword)
 firstpage = retrieveFile(Ourl)
 itemList = html_nodes(firstpage, "a.last")
 lastpage = html_attr(itemList, 'href')
 lastpage = gsub('^.*?/page/', '', lastpage)
 lastpage = gsub('/', '', lastpage)
 lastpage = as.numeric(lastpage)


for(i in 1:lastpage){
 url = paste0(Ourl, linkTail, i)
 cat("\n",i, url, "\n")
 
 pagesource <- retrieveFile(url)

 itemList = html_nodes(pagesource, linkClassName)
 itemList = html_attr(itemList, 'href')
 itemList = as.character(itemList)

 wholePage = c(wholePage, itemList)
 wholePage = unique(sort(wholePage))
 cat(blue("\nlength(itemList) ", length(itemList),
     " length(wholePage) ", length(wholePage)))

}

theFilename = paste0("eroticLinks ", keyword, ".txt")
write(wholePage, theFilename)
cat(red("file created! ", theFilename),"\n")

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ",LoopTime,"\n\n\n")


