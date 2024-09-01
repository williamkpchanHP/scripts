# https://www.pornhub.com/pornstars?page=2~1694
# https://www.pornhub.com/pornstars?gender=female&cup=d
# https://www.pornhub.com/pornstars?gender=female&cup=d&page=98
# this must be added to setting chinese
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
#setwd("C:/Users/User/Pictures/sexpage")
setwd("C:/Users/william/Desktop/scripts")
#setwd("C:/Users/User/Pictures/sexpage")

#library(audio)
library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

cat("\n")
className = ".wrap"
# https://www.pornhub.com/pornstars?gender=female
# https://www.pornhub.com/pornstars?gender=female&page=2

pageHeader = "https://www.pornhub.com/pornstars?gender=female&page="
totalPages = 1694

theFilename = 'pohubFemaleStarList.html'
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
 itemHref <- html_nodes(itemList, "a:first-child")
 itemHref = html_attr(itemHref, "href")
 itemHrefIdx = grep("/model/|/pornstar/",itemHref)
 itemHref = itemHref[itemHrefIdx]
 images = html_nodes(itemList, "img")
 imgSrc = html_attr(images, "src")

 linksTxt = html_attr(images, "alt")
 linksTxt = gsub("\'", "", linksTxt)

 videosNum = html_nodes(itemList, ".videosNumber")
 videosNum = gsub("<.*?>| Videos ", "", videosNum)
 result = paste0(formatC(videosNum, width = 5, format = "d", flag = "0"), '\'', itemHref, '"><img src="', imgSrc, '"><br>', videosNum, " ",linksTxt, '\',')
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
#allLinks = gsub("/view_video.php\\?viewkey=", "", allLinks)
cat(red("length(allLinks) before unique: ",length(allLinks), "\n"))
allLinks = unique(allLinks)
cat(green("length(allLinks) after unique: ",length(allLinks), "\n"))
allLinks = sort(allLinks, decreasing=TRUE)
allLinks = gsub("^.*?\'", "\'", allLinks)

#modelIdx = grep("/model/",allLinks)
#allLinks = allLinks[modelIdx]

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
