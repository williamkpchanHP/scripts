#Sys.setlocale(category = 'LC_ALL', 'Chinese')	# this must be added to script to show chinese
# https://www.99csw.com/index.php

setwd("C:/R programs/Extracts by R")

library(crayon)
library(rvest)
#https://www.99csw.com/book/3783/129158.htm
pageHeader = "http://www.xys.org/xys/classics/seqing/dengcao-heshang/"

addr = c(
"dengcao1.txt",
"dengcao10.txt",
"dengcao11.txt",
"dengcao12.txt",
"dengcao2.txt",
"dengcao3.txt",
"dengcao4.txt",
"dengcao5.txt",
"dengcao6.txt",
"dengcao7.txt",
"dengcao8.txt",
"dengcao9.txt"
)

theFilename = "dengcao.html"
wholepage = character()

lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")

for(i in 1:length(addr)){
 url = paste0(pageHeader, addr[i])
 cat("\n",i, blue(url), "\n")
 # Sys.sleep(sample(2:6, 1))
 pagesource <- readLines(url)
  wholepage = c(wholepage, pagesource)
}

options("encoding" = "UTF-8")
sink(theFilename)
  cat(wholepage, sep = "\n")
sink()

ProcessEndTime = Sys.time()
cat("\n", format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("loop time: ",LoopTime,"\n")
