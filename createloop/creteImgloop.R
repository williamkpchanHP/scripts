# this interpret the cmdFile and clean the target file
rm(list = ls())

# this must be added to setting chinese
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
#setwd("C:/Users/User/Pictures/sexpage/pornpic/")
setwd("C:/Users/william/Desktop/scripts/createloop")

#library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

# ask for imageUrl
#http://www.hot-peaches.com/galleries/abbywinters.com/Daliah/01/63-xl_daliah063.jpg

cat(yellow("please enter image Url!\n"))
imageUrl = readline("please enter image Url: ")

outname = gsub("^.*?\\.","",imageUrl)
outname = gsub("\\..*?$","",outname)
cat("outname: ", outname, "\n")

endnum = 150
digitNum = ""
while(digitNum == ""){
  digitNum = readline("please enter seq digits: ")
  if(is.na(as.numeric(digitNum))){ digitNum = "" }
}

digitNum = as.numeric(digitNum)
if(digitNum == 2){endnum = 99}

imageUrlHeader = gsub("\\.jpg","",imageUrl)

leadzero = readline("lead zero y/n? ")
if(leadzero == "y"){
  imageUrlHeader = substr(imageUrl,1,nchar(imageUrl)-digitNum-4)
}else{
  urldigitnum = as.numeric(readline("number of digits in url: "))
  imageUrlHeader = substr(imageUrl,1,nchar(imageUrl)-urldigitnum-4)
}
cat("imageUrlHeader: ", imageUrlHeader, "\n")


itemList = character()
for(i in 1:endnum){

  if(leadzero == "y"){
    imgLine = paste0(i,'<br><img class="lazy" data-src="',
        imageUrlHeader,
        formatC(i, width = digitNum, format = "d", flag = "0"),
        '.jpg"><br>')
  }else{
    imgLine = paste0(i,'<br><img class="lazy" data-src="',
        imageUrlHeader, i, '.jpg"><br>')
  }

  itemList = c(itemList, imgLine)
}
templateHead = readLines("templateHead.txt")
templateTail = readLines("templateTail.txt")


outFilename = paste0(outname, ".html")
sink(outFilename)
  cat(templateHead, sep="\n")
  cat(itemList, sep="\n")
  cat(templateTail, sep="\n")
sink()
cat(red("\n",outFilename, " created!\n"))
####

# update history
historyLog = readLines("createHistoryLog.txt")

  sink("createHistoryLog.txt", append = TRUE)
    cat(paste0(imageUrlHeader,",",digitNum), sep="\n")
  sink()
cat("createHistoryLog.txt updated!\n")

shell(outFilename)
