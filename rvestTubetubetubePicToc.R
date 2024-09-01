# collect tubetubetube javpornpics toc

Sys.setlocale(category = 'LC_ALL', 'Chinese')
setwd("C:/Users/william/Desktop/scripts")
#setwd("C:/Users/User/Pictures/sexpage")

#library(audio)
library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

cat("\n")
className = ".item a"
pageHeader = "https://www.tubetubetube.com/javpornpics/"
totalPages = 11

theFilename = 'tubetubetubePics.html'
allLinks = character()
wholePage = character()

addr = 1:totalPages

lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")

dhms <- function(t){
    paste(t %/% (60*60*24), "day" 
         ,paste(formatC(t %/% (60*60) %% 24, width = 2, format = "d", flag = "0")
               ,formatC(t %/% 60 %% 60, width = 2, format = "d", flag = "0")
               ,formatC(t %% 60, width = 2, format = "d", flag = "0")
               ,sep = ":"
               )
         )
}

for(i in 1:length(addr)){
 cat(i, "/", length(addr), " ")

 url = paste0(pageHeader, i )
 cat(url, "\n")
 pagesource <- read_html(url)

 itemList <- html_nodes(pagesource, className)
 itemHref = html_attr(itemList, "href")
cat(red("length(itemHref): ",length(itemHref)) )
 images = html_nodes(itemList, "img")
 imgSrc = html_attr(images, "src")

 linksTxt = html_attr(images, "alt")
 linksTxt = gsub("\\\\'", "", linksTxt)

 result = paste0('\'', itemHref, '"><img src="', imgSrc, '"><br>',linksTxt, '\',')
 cat(yellow("length(result): ",length(result), "\n"))

 allLinks = c(allLinks, result)

 if(i == 10){
   ProcessEndTime = Sys.time()
   LoopTime = as.numeric(ProcessEndTime - ProcessStartTime, units="secs")
   ecTime = length(addr)*LoopTime/10

   cat(red(
        "\n\n Expect to complete at: ", as.character(ProcessStartTime + ecTime),"\n",
        "per cycle time: ", dhms(LoopTime/10),"\n",
        "Expected total time: ", dhms(ecTime),"\n\n"
      ))
 }
}

templateHead = readLines("templateHeadPohub.txt")
templateTail = readLines("templateTailPohub.txt")
templateHead = gsub("dreamgirlsmembers", "pohubFemaleCupD", templateHead)
templateTail = gsub("dreamgirlsmembers", "pohubFemaleCupD", templateTail)

sink(theFilename)
cat(templateHead, sep="\n")
cat(allLinks, sep="\n")
cat(templateTail, sep="\n")
sink()

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ", dhms(LoopTime),"\n\n\n")
cat(theFilename, "created\n")
