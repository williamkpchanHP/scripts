# collect Pinterest images with keyword

setwd("C:/Users/william/Desktop/scripts/youx")
#setwd("C:/Users/User/Pictures/sexpage")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")
cat(red("Scrape youx Links!\n"))

channelName = readline("enter channel name: ")
urlHeader = paste0("https://www.youx.xxx/channels/", channelName, "/picture/")
toltalpages = as.numeric(readline("enter total pages: "))

className = ".thumb__link"
allLinks = character()

for(i in 1:toltalpages){
  url = paste0(urlHeader, i)
  thepage <- read_html(url)
  itemList <- thepage %>% html_nodes(className)
  thelinks = html_attr(itemList, "href")
  allLinks = c(allLinks, thelinks)
  cat(i, " of ", toltalpages, yellow("this page links: "), length(thelinks), " total links: ", length(allLinks), "\n")
}
  allLinks = gsub("^.*?url=", "", allLinks)
  allLinks = gsub("&amp;.*?$", "", allLinks)
  allLinks = gsub("%252F", "/", allLinks)
  allLinks = gsub("%253A", ":", allLinks)

outFilename = "youxLinks.txt"
sink(outFilename)
  cat(allLinks, sep="\n")
sink()
shell(outFilename)
cat(red(outFilename, " created!"))
