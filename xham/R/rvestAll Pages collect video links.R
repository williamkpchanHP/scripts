# collect video links on pages
# input: url, number of following pages
library(rvest)

urlHeader = "https://xhamster.com/channels/chick-pass"
#"https://www.xvideos.com/pornstars/tigerr-benson"
classname = "div.thumb a"
wholePage = character()
for(i in 1:1){
  # url = paste0(urlHeader, i)
  url = paste0(urlHeader)
  thepage <- read_html(url)
  keywordList <- thepage %>% html_nodes(classname) %>% as.character()
  keywordList = gsub("<div.*?>|</div>","\n",keywordList)
  wholePage = c(wholePage, keywordList, "\n\n")
}
desktopFolder = "C:/Users/william/Desktop/scripts/R"

filename = "xhamster_chick-pass.html"
dest = paste0(desktopFolder, filename)
sink(dest)
cat(wholePage)
sink()

