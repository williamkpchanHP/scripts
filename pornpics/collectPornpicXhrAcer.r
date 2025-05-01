# collect xhr from pornpic
# cory+chase
setwd("C:/Users/User/Pictures/sexpage")

urlHeader = "https://www.pornpics.com/search/srch.php?q="
schkey = readline(prompt="enter schkey:")
schkey = gsub(" |-", "+", schkey)

limitKey = "&lang=en&limit="
limitNum = as.numeric(readline(prompt="enter limitNum:"))
offsetkey = "&offset="
offset = limitNum
Wholepage = character()
for(i in 1:1000){
  url = paste0(urlHeader, schkey, limitKey, limitNum, offsetkey, offset*(i-1))
  cat("\n",url, " ")
  pagesource <- readLines(url)
  itemList = unlist(strsplit(pagesource, '","'))
  itemListIdx = grep("g_url", itemList)
  itemList = itemList[itemListIdx]
  itemList = gsub('^.*?galleries', '', itemList)

  rmIdx = grep("nofollow", itemList) # some url have pictures included
  if(length(rmIdx)>0){ itemList = itemList[-rmIdx] }

  Wholepage = c(Wholepage, itemList)
  cat(length(Wholepage), " ")
  if(length(itemList)<limitNum){break}
}
cat("\ntotal: ",length(Wholepage), "\n")
outFilename = paste0(schkey, ".txt")
sink(outFilename)
  cat(Wholepage, sep="\n")
sink()
cat(outFilename, " created!\n")