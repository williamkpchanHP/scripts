# collect tags from pornpic
# 

setwd("C:/Users/william/Desktop/scripts/pornpics")
source("../retrieveFile.R")

Wholepage = character()
searchKey = ""
tagOrChannelKey = ""

checksearchKeyExist <- function(searchKey){
  setwd("C:/Users/william/Desktop/scripts/")
  optionsArrayName = "optionsArray.js"
  optionsArray = readLines(optionsArrayName)

  checkkey = gsub("\\+|-", "", searchKey)
  optionIdx = grep(checkkey, optionsArray)

  if(length(optionIdx)>0){
    cat(red("searchKey exist in optionsArray.js: ",optionIdx,"\n"))
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

jumpToTagFunction <- function(){
  searchKey <<- readline(prompt="enter searchKey:")
  chkKey = gsub(" |-", "", searchKey)
  checksearchKeyExist(chkKey)

  tagOrChannelKey <<- readline(prompt="tag Or Channel: 0/1 t/c ")
  if(tagOrChannelKey=="0"){
    tagHead = "https://www.pornpics.com/tags/"
    tagtail = "/?offset="
    offset = 1
  }else if(tagOrChannelKey=="1"){
    tagHead = "https://www.pornpics.com/search/srch.php?q="
    tagtail = "&lang=en&limit=20&offset="
    offset = 0
  }

  i = 1
  while(i>0){
    url = paste0(tagHead, searchKey, tagtail, ( (i-1)*20 + offset) )
    cat("\n", i,url, " ")
    pagesource <- readLines(url)

    if(pagesource !="[]"){
      itemList = unlist(strsplit(pagesource, '"g_url":"'))

      srcIdx = grep("https://www.pornpics.com/galleries", itemList)
      itemList = itemList[srcIdx]
      itemList = gsub('^.*?galleries', '', itemList)
      itemList = gsub('","t_url.*', '', itemList)
      Wholepage <<- c(Wholepage, itemList)
      Wholepage <<- unique(Wholepage)
      cat("length(Wholepage): ",length(Wholepage), " ", " itemList ",length(itemList))
      i = i+1
    }else{
      cat("\ntotal: ",length(Wholepage), "\n")

      outFilename = paste0(searchKey, "xhr.txt")
      sink(outFilename)
        cat(Wholepage, sep="\n")
      sink()
      cat(outFilename, " created!\n")

      i = 0
    }
  }
}

cat(red("\n\nenter keyword, after xhr.txt created,\nrun collectPornpicImgFromXhrFile.R to collect images\n\n"))

tagKey = readline(prompt="is it tag or channel file? 0/1 y/n ")

if(tagKey=="0"){
  jumpToTagFunction()
}else if(tagKey=="1"){
  jumpToTagFunction()
}

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
  pageHeader="https://www.pornpics.com/galleries/"
  pageTail=""
  className = ".thumbwook a" # pornpic
  xhrFileName = searchKey

  titleName = gsub("\\+|-", "", searchKey)

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

  theFilename = paste0("pornpics", titleName, ".js")

  sink(theFilename)
  cat("var", paste0("pornpics", titleName), " = [\n")
  cat(allPages, sep="\n")
  cat(templateTail, sep="\n")
  sink()

  cat(red(theFilename, "task complete!\n"))

  fileName = paste0("pornpics", searchKey)
  source("C:/Users/william/Desktop/scripts/updateoptionsArray.R")
}

