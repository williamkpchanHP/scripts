# collect milfsover30 Batch
# read milfsover30Batch.txt
rm(list = ls())

Sys.setlocale(category = 'LC_ALL', 'Chinese')
setwd("C:/Users/william/Desktop/scripts/projects/milfsover30")

library(rvest)
library(crayon)
 ligRed <- make_style("#dd9988")

typeName = readline("category or star? 0/1: ")
if(typeName == "0"){
  type = "tag"
  pageTail=""
  schkeyList = readline("enter category name:")
  catName = schkeyList
  theHeader = paste0("http://milfsover30.com/", type, "/")
}else{
  type = "models"
  pageTail="?letter="
  schkeyList = c(LETTERS, "#")
  catName = type
  theHeader = paste0("http://milfsover30.com/", type, "/", pageTail)
}

theFilename = paste0("milfsover30", catName, ".html")
className = ".post a"

dhms <- function(t){
    paste(t %/% (60*60*24), "day" 
         ,paste(formatC(t %/% (60*60) %% 24, width = 2, format = "d", flag = "0")
               ,formatC(t %/% 60 %% 60, width = 2, format = "d", flag = "0")
               ,formatC(t %% 60, width = 2, format = "d", flag = "0")
               ,sep = ":"
               )
         )
}

# main loop
wholePage = character()
for(key in schkeyList){
  cat(ligRed("\nNumber", match(key,schkeyList), "of",length(schkeyList), "schkey: ", key,"\n"))
  url = paste0(theHeader, key)
  cat(url,'\n')
  pagesource <- read_html(url)
  itemList <- html_nodes(pagesource, className)
  cat(red("length(itemList): ", length(itemList), " "))
  itemHref = html_attr(itemList, 'href')
  itemImg = html_nodes(itemList, 'img')
  itemSrc = html_attr(itemImg, 'src')
  result = gsub('http://cdn.milfsover30.com/wp-content/uploads/|-230x345|-195x260|width="230" height="345" | class.*?""',"",itemSrc)

  result = gsub('11.jpg|1.jpg',"",result)
  point = 0
  for(i in result){
    point = point +1
    wholePage = c(wholePage, '">',itemHref[point])
    for(k in 1:16){
      imgLine = paste0("'",i,k,"',")
      wholePage = c(wholePage, imgLine)
    }
  }

  cat(red("length(wholePage): ", length(wholePage)))
}

templateHead = readLines("templateHeadmilfsover30.txt")
templateTail = readLines("templateTailmilfsover30.txt")
templateHead = gsub("dreamgirlsmembers", "pohubFemaleCupD", templateHead)
templateTail = gsub("dreamgirlsmembers", "pohubFemaleCupD", templateTail)

sink(theFilename)
cat(templateHead, sep="\n")
cat(wholePage, sep="\n")
cat(templateTail, sep="\n")
sink()
cat("\nJob complete!\n")
