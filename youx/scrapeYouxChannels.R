# collect Pinterest images with keyword

setwd("C:/Users/william/Desktop/scripts/youx")
#setwd("C:/Users/User/Pictures/sexpage")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")
cat(red("Scrape youx Channels!\n"))

urlHeader = paste0("https://www.youx.xxx/channels/")
toltalpages = 86

className = "a.thumb__link"
allLinks = character()

for(i in 1:toltalpages){
  url = paste0(urlHeader, i)
  thepage <- read_html(url)
  itemList <- thepage %>% html_nodes(className)
  thelinks = html_attr(itemList, "href")

  imgList = html_nodes(itemList, "img")
  imgsrc = html_attr(imgList, "data-src")
  imgsrc = gsub("_320x_", "", imgsrc)

  itemtitle = html_attr(imgList, "alt")

  assembleLink = paste0('<a href="https://www.youx.xxx', thelinks, '">', itemtitle, "<br>", '<img class="lazy" data-src="', imgsrc, '"></a>')
  allLinks = c(allLinks, assembleLink)
  cat(i, " of ", toltalpages, yellow("this page links: "), length(thelinks), " total links: ", length(allLinks), "\n")
}

outFilename = "youxChannels.html"
sink(outFilename)
  cat(allLinks, sep="\n")
sink()
shell(outFilename)
cat(red(outFilename, " created!"))
