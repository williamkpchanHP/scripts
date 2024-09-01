# this is exactly same as xhamsterUsers.R, same to pornstar

library(rvest)

dirStr = "C:/Users/william/Desktop/scripts/xham"
setwd(dirStr)

theWholepage = ""


cleanUp <- function(thepage){
	thepage = gsub("\\n {1,}","",thepage)
	thepage = gsub('<div.*?>|</div>|<i .*?>|</i>','',thepage)
	thepage = gsub('<span .*?</span>| alt=".*?"',"",thepage)
	thepage = gsub('<a class="video-thumb-info__name.*?>',"",thepage)
	thepage = gsub('\\n</a>\\n\\n',"",thepage)
	thepage = gsub('class=".*?"| data-.*?".*?"| onload=".*?"| onerror=".*?"',"",thepage)
	thepage = gsub('\\n',"",thepage)
	thepage = gsub('jpg">','jpg"><br>',thepage)
	thepage = gsub('img  src','img class="lazy" data-src',thepage)
	return(thepage)
}


askforAddr <-function(){		# "abc def" -> "abc+def"
	Selection = readline(prompt="enter address header: ")
	if(Selection == "")   { 
		cat("\nblank address! exited!\n")
		break
	}
	return(Selection)		# if empty, calling program handle
}

askforNum <-function(){		
	Selection = readline(prompt="enter max number of page: ")
	return(Selection)		# if empty, calling program handle
}

askforFilename <-function(){		
	Selection = readline(prompt="enter output filename without extension, press enter for default: ")
	if(Selection == "")   { 
		Selection = "result.html"
	}
	return(paste0(Selection,".html"))
}
askforAppendFile <-function(){		
	Selection = readline(prompt="do u want to append to old results? press enter if no: ")
	if(Selection == "")   { 
		theFilename = "result.html"
		file.rename(theFilename, paste0(format(Sys.Date(), format="%m%d")," ",format(Sys.time(), "%H%M")," ",theFilename))
	}	
}
urlHeader = askforAddr()
lentocpage = askforNum()
theFilename = askforFilename()
askforAppendFile()
cat("\nlentocpage: ",lentocpage,"\n")

className = "div.video-thumb"
for (page in 1:lentocpage){
	cat(" ", page)
	urlAddr = paste0(urlHeader, page)
	pagesource = read_html(urlAddr, warn=F, encoding = "UTF-8")
	 keywordList <- html_nodes(pagesource, className)
	 keywordList = as.character(keywordList)

	theWholepage = c(theWholepage, keywordList)
}
theWholepage = cleanUp(theWholepage)

write(theWholepage, theFilename, append=TRUE)
