# collect xhr from pornpic
# cory+chase
#setwd("C:/Users/User/Pictures/sexpage")

setwd("C:/Users/william/Desktop/scripts/pornpics")
source("../retrieveFile.R")

checkSchkeyExist <- function(schkey){
  setwd("C:/Users/william/Desktop/scripts/")
  optionsArrayName = "optionsArray.js"
  optionsArray = readLines(optionsArrayName)

  checkkey = gsub("\\+|-", "", schkey)
  optionIdx = grep(checkkey, optionsArray)

  if(length(optionIdx)>0){
    cat(red("schkey exist in optionsArray.js: ",optionIdx,"\n"))
    cat(yellow(optionsArray[optionIdx],"\n"))

    setwd("C:/Users/william/Desktop/scripts/pornpics")
    continuePrompt = readline(prompt="Continue? 0/1: ")
    if(continuePrompt == "0"){
       return
    }else{
      break
    }
  }
}

cat(red("\n\nenter keyword, after xhr.txt created,\nrun collectPornpicImgFromXhrFile.R to collect images\n\n"))

urlHeader = "https://www.pornpics.com/search/srch.php?q="
schkey = readline(prompt="enter schkey:")
schkey = gsub(" |-", "+", schkey)

pageNum = readline(prompt="enter number of pages to collect(max: 500): ")
if(pageNum == ""){
  pageNum = 100
}else{
  pageNum = as.numeric(pageNum)
}

checkSchkeyExist(schkey)

limitKey = "&lang=en&limit="
limitNum = 100
offsetkey = "&offset="
offset = limitNum
Wholepage = character()
for(i in 1:pageNum){
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
  if(length(itemList)< 88){break}
}
cat("\ntotal: ",length(Wholepage), "\n")
outFilename = paste0(schkey, "xhr.txt")
sink(outFilename)
  cat(Wholepage, sep="\n")
sink()
cat(outFilename, " created!\n")

continuekey = readline(prompt="continue to collect all images? yn 0/1: ")

dhms <- function(t){
    paste(t %/% (60*60*24), "day" 
         ,paste(formatC(t %/% (60*60) %% 24, width = 2, format = "d", flag = "0")
               ,formatC(t %/% 60 %% 60, width = 2, format = "d", flag = "0")
               ,formatC(t %% 60, width = 2, format = "d", flag = "0")
               ,sep = ":"
               )
         )
}

if(continuekey == "0" |continuekey == ""){
  schkey = gsub("\\+|-", "", schkey)
  pageHeader="https://www.pornpics.com/galleries/"
  pageTail=""
  className = ".thumbwook a" # pornpic
  xhrFileName = schkey
  titleName = xhrFileName
  xhrFileName = paste0(xhrFileName, ".txt")
  xhr = Wholepage

  allPages = character()
  xhrlen = length(xhr)
  ProcessStartTime = Sys.time()

  for(i in 1:xhrlen){
    url = paste0(pageHeader,xhr[i],pageTail)
    cat(red(i, "of",xhrlen), url,"\n")
    pagesource <- retrieveFile(url)
  
    itemList <- html_nodes(pagesource, className)
  
    itemList = html_attr(itemList, 'href')
    itemList = as.character(itemList)
    itemList = gsub('https://cdni.pornpics.com/1280/', '\'', itemList)
    itemList = gsub('\\.jpg', '\',', itemList)
  
    allPages = c(allPages, itemList)
  
    if(i == 10){
      ProcessEndTime = Sys.time()
      LoopTime = as.numeric(ProcessEndTime - ProcessStartTime, units="secs")
      ecTime = xhrlen*LoopTime/10
  
      cat(red(
          "\n\n Expect to complete at: ", as.character(ProcessStartTime + ecTime),"\n",
          "per cycle time: ", dhms(LoopTime/10),"\n",
          "Expected total time: ", dhms(ecTime),"\n\n"
         ))
    }
  }


  templateHead = readLines("templateHead.txt")
  templateTail = readLines("templateTail.txt")
  templateHead = gsub("mom50", titleName, templateHead)
  templateTail = gsub("mom50", titleName, templateTail)
  templateTailidx = grep("showRange", templateTail)
  templateTail = templateTail[-(templateTailidx:length(templateTail))]
  rmidx = grep("^/$", allPages) 
  if(length(rmidx)>0){
    allPages = allPages[-rmidx]
  }

  theFilename = paste0("pornpics", schkey, ".js")

  sink(theFilename)
  cat("var", paste0("pornpics", schkey), " = [\n")
  cat(allPages, sep="\n")
  cat(templateTail, sep="\n")
  sink()

  cat(red(theFilename, "task complete!\n"))

  fileName = paste0("pornpics", schkey)
  source("C:/Users/william/Desktop/scripts/updateoptionsArray.R")
}

