# this download cannot download full page and reason unknown

# this must be added to setting chinese
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
setwd("C:/Users/User/Pictures/sexpage")

#library(audio)
library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

pageHeader="https://www.xvideos.com/pornstars-index/"
pageTail=""
className = ".thumb a, .with-sub"

titleName = "Pornstars"
theFilename = paste0("Xvideos", titleName, ".html")
wholePage = character()

# remember to remove &#9;
addr = 0:372

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
 #guess_encoding(pagesource)
 #pagesource <- read_html(paste0(pageHeader,addr[i],pageTail), encoding = "UTF-8")
 #url = paste0(pageHeader,addr[i],pageTail)
 url = paste0(pageHeader,addr[i],pageTail)
 cat(url, "\n")
 pagesource <- read_html(url)

 itemList <- html_nodes(pagesource, className)
 itemList = as.character(itemList)

 itemList = gsub('<script>document.write.*?<img ', '<img class="lazy" data-', itemList)
 itemList = gsub(' id=.*', '>', itemList)
 itemList = gsub('<span.*?>', '', itemList)
 itemList = gsub('\\t', '', itemList)
 itemList = gsub('\\n', '', itemList)
 itemList = gsub('<a href=\"', '<div><a href=\"https://www.xvideos.com', itemList)
 itemList = gsub('</span>', '</a></div>', itemList)
 itemListhref = grep("href", itemList)
 itemListadiv = grep("</div", itemList)
 itemList = paste0( itemList[itemListhref], itemList[itemListadiv])

  for(i in 1:length(itemList)){
   starName = character()
   starName = gsub('\"><img.*', '', itemList[i])
   starName = gsub('.*/', '',  starName)
   itemList[i] = gsub('<img', paste0(starName, '<img'), itemList[i])
  }
 #writeClipboard(itemList)

 wholePage = c(wholePage, itemList)

 if(i == 10){
   ProcessEndTime = Sys.time()
   LoopTime = as.numeric(ProcessEndTime - ProcessStartTime, units="secs")
   ecTime = length(addr)*LoopTime/10

   cat(red(
        "\n\n Expect to complete at: ", as.character(ProcessStartTime + ecTime),"\n",
        "per cycle time: ", dhms(LoopTime/10),"\n",
        "total time: ", dhms(ecTime),"\n\n"
      ))
 }
}

#writeClipboard(wholePage)
templateHead = readLines("templateHead.txt")
templateTail = readLines("templateTail.txt")
templateHead = gsub("mom50", titleName, templateHead)

sink(theFilename)
cat(templateHead, sep="\n")
cat(wholePage, sep="\n")
cat(templateTail, sep="\n")
sink()

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ", dhms(LoopTime),"\n\n\n")
cat(theFilename, "created\n")
