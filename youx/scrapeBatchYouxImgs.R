# collect Pinterest images with keyword

setwd("C:/Users/william/Desktop/scripts/youx")
#setwd("C:/Users/User/Pictures/sexpage")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")
cat(red("Batch Scrape youx Imgs!\n"))

srcFilename = "youxLinks.txt"
outFilename = "youxNaughtyheadnurse.html"

outFilename = readline("what is the short output file name?")
outTitle = outFilename
outFilename = paste0(outFilename, ".html")

templateHead = readLines("templateHead.txt")
templateTail = readLines("templateTail.txt")
templateHead = gsub("youxAllover30", outTitle, templateHead)
templateTail = gsub("youxAllover30", outTitle, templateTail)

allImgs = character()
className = ".thumb__img, .gallery-thumb img"
removeTxt = "_300x_|_320x_|_640x_"
replaceTxt = "gthumb"
putinTxt = "content"


theLinks = readLines(srcFilename)
totalLinks = length(theLinks)

for(i in 1:totalLinks){
  cat(i, " of ", totalLinks, " ")
  thepage <- read_html(theLinks[i])
  itemList <- thepage %>% html_nodes(className)
  imgdatasrc = html_attr(itemList, "data-src")
  imgsrc = html_attr(itemList, "src")
  imgsrc = c(imgsrc, imgdatasrc)
  imgsrcIdx = grep("cdncontent|cdnwg|cdnxw", imgsrc)
  imgsrc = imgsrc[imgsrcIdx]

  imgsrc = gsub(removeTxt, "", imgsrc)
  imgsrc = gsub(replaceTxt, putinTxt, imgsrc)
  imgsrc = paste0("'", imgsrc, "',")
  allImgs = c(allImgs, imgsrc)
  cat(yellow("this page imgs: "), length(imgsrc), " total imgs: ", length(allImgs), "\n")
}

sink(outFilename)
  cat(templateHead, sep="\n")
  cat(allImgs, sep="\n")
  cat(templateTail, sep="\n")
sink()
shell(outFilename)
cat(red("Job complete! "))
