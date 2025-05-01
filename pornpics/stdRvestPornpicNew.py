# collect pornpics.com/galleries
# this download cannot download full page and reason unknown

# clear all variables
# import sys
# sys.modules[__name__].__dict__.clear()

# clear all variables
for constant in dir():
    exec('del '+ constant)
    del constant

# determine the current working directory
import os
current_dir = os.getcwd()
print("Current working directory:", current_dir)

# print in color in Python, can use ANSI escape sequences
# ANSI escape codes for different colors
RED = '\033[91m'
GREEN = '\033[92m'
YELLOW = '\033[93m'
BLUE = '\033[94m'
RESET = '\033[0m'

# Print colored text
print(RED + "This text is red." + RESET)
print(GREEN + "This text is green." + RESET)
print(YELLOW + "This text is yellow." + RESET)
print(BLUE + "This text is blue." + RESET)


# Use encode() to convert a String to UTF-8
string = "this"
string_encoding = string.encode()
# string.encode(encoding = 'UTF-8')
print('The encoded version is:', string_utf)

# determine the encoding of a string loaded from a file by using the chardet library.
#example
import chardet

# Read the contents of the file
with open("file.txt", "rb") as file:
    data = file.read()

# Detect the encoding of the data
data = "what"
result = chardet.detect(data)
encoding = result["encoding"]
confidence = result["confidence"]

print("Detected encoding:", encoding)
print("Confidence:", confidence)

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
setwd("C:/Users/User/Pictures/sexpage/pornpic/")

#library(audio)
library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

pageHeader="https://www.pornpics.com/galleries/"
#pageTail="/"
pageTail=""
className = ".thumbwook a" # pornpic

collectUrl <- function(url){
    tmp <- tryCatch(
             read_html(url, warn=F), silent = TRUE,
             error = function (e) NULL
           )
    if (is.null(tmp)) {
      cat("\n doesn't exist\n")
      return("<html></html>")
    }else{
      return(tmp)
    }
}


#### look for XHR
urlHeader = "https://www.pornpics.com/search/srch.php?q="
schkey = readline(prompt="enter schkey:")
schkey = gsub(" |-", "+", schkey)

limitKey = "&lang=en&limit="
#limitNum = as.numeric(readline(prompt="enter limitNum:"))
limitNum = 100
offsetkey = "&offset="
offset = limitNum
addr = character()
cat(green("\nrequest XHR:\n"))

for(i in 1:1000){
  url = paste0(urlHeader, schkey, limitKey, limitNum, offsetkey, offset*(i-1))
  cat("\n",url, " ")
  pagesource <- readLines(url)
  itemList = unlist(strsplit(pagesource, '","'))
  itemListIdx = grep("g_url", itemList)
  itemList = itemList[itemListIdx]
  itemList = gsub('^.*?galleries', '', itemList)

  rmIdx = grep("nofollow|g_url", itemList) # some url have pictures included
  if(length(rmIdx)>0){ itemList = itemList[-rmIdx] }

  addr = gsub("\\\\/", "", addr)
  addr = c(addr, itemList)
  cat(length(addr), " ")

  if(length(itemList)<97){break}
}
cat("\ntotal: ",length(addr), "\n")
outFilename = paste0(schkey, ".txt")
  addr = gsub("\\\\/", "", addr)
  addr = sort(addr)

sink(outFilename)
  cat(addr, sep="\n")
sink()
cat(red(outFilename, " created!\n"))
####

cat(green("\nrequest for imgs\n"))
wholePage = character()

# remember to remove &#9;
# addr = readLines(paste0(titleName, ".txt"))
  addr = gsub("\\\\/", "", addr)

titleName = schkey
lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")

finishBeep <- function(rptCnt){ # beep count
    while(rptCnt>0){
        play(sin(1:6000/10))
        Sys.sleep(0.2)
     rptCnt = rptCnt-1
    }
}

dhms <- function(t){
    paste(t %/% (60*60*24), "day" 
         ,paste(formatC(t %/% (60*60) %% 24, width = 2, format = "d", flag = "0")
               ,formatC(t %/% 60 %% 60, width = 2, format = "d", flag = "0")
               ,formatC(t %% 60, width = 2, format = "d", flag = "0")
               ,sep = ":"
               )
         )
}

# addr = readLines("spreading.txt")

for(i in 1:length(addr)){
 cat(i, "/", length(addr), " ")
 #guess_encoding(pagesource)
 #pagesource <- read_html(paste0(pageHeader,addr[i],pageTail), encoding = "UTF-8")
 #url = paste0(pageHeader,addr[i],pageTail)
 url = paste0(pageHeader,addr[i],pageTail)
 cat(url, "\n")

 pagesource <- collectUrl(url)
 itemList <- html_nodes(pagesource, className)

 itemList = html_attr(itemList, 'href')
 itemList = as.character(itemList)
 itemList = gsub('https://cdni.pornpics.com/1280/', '\'', itemList)
 itemList = gsub('\\.jpg', '\',', itemList)

 wholePage = c(wholePage, itemList)

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

#writeClipboard(wholePage)
templateHead = readLines("templateHead.txt")
templateTail = readLines("templateTail.txt")
templateHead = gsub("mom50", titleName, templateHead)
templateTail = gsub("mom50", titleName, templateTail)

theFilename = paste0("pornpics", titleName, ".html")

sink(theFilename)
cat(templateHead, sep="\n")
cat(wholePage, sep="\n")
cat(templateTail, sep="\n")
sink()

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ", dhms(LoopTime),"\n\n\n")
cat(red(theFilename, "created\n"))
#finishBeep(1)
