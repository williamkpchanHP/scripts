# collect Pinterest images with keyword

setwd("C:/Users/william/Desktop/scripts/youx")
#setwd("C:/Users/User/Pictures/sexpage")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")
cat(red("Scrape youx Stars!\n"))

#urlHeader = paste0("https://www.youx.xxx/channels/")
starUrls = readLines("youxStar.txt")
totalUrls = length(starUrls)

className = ".thumb__link"
allLinks = character()

for(i in 1:totalUrls){
  url = starUrls[i]
  thepage <- read_html(url)
  itemList <- thepage %>% html_nodes(className)
  itemLink = html_attr(itemList, "href")
  itemLink = gsub("^.*?url=", "", itemLink)
  itemLink = gsub("&amp;.*?$", "", itemLink)
  itemLink = gsub("%252F", "/", itemLink)
  itemLink = gsub("%253A", ":", itemLink)

  imgsrc = html_nodes(itemList, "img")
  imgsrc = html_attr(imgsrc, "data-src")

  itemtitle = gsub("https://www.youx.xxx/tag/", "", url)
  itemtitle = gsub("-", " ", itemtitle)

  imgsrc = paste0('<img src="', imgsrc, '">')

  pageLink = paste0('<a href="', itemLink, '">', imgsrc, '</a>')
  pageLink = paste(pageLink, collapse = '')

  assembleLink = paste0('<div><a href="', url, '">', itemtitle, '</a>', "<br>", pageLink, '</div>')
  allLinks = c(allLinks, assembleLink)
  cat(i, " of ", totalUrls, yellow("this page links: "), length(itemList), " total links: ", length(allLinks), "\n")
}

outFilename = "youxAllStarsNew.html"
sink(outFilename)
  cat(allLinks, sep="\n")
sink()
shell(outFilename)
cat(red(outFilename, " created!"))
