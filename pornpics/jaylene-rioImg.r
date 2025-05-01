dirStr = "C:/Users/user/mpg/Text/programs/projects/pornpics"
setwd(dirStr)

thekeyword = "pornpics anilos"
imgSeekkey = "class='thumbwook'>"

theAddr = readLines(paste0(thekeyword," adr.txt"))
thenum = length(theAddr)
theWholePage = character(0)
theWholeAddrList = character(0)
boilPages <- function(searchKey){
	for(i in 1:thenum){
	    cat(i," ")
	    if(i%%100 == 0){
		cat("\n")
	    }
		thepage = readLines(theAddr[i])

		linenum = grep(imgSeekkey, thepage)
		theImgList = thepage[linenum]

		theImgList = unlist(strsplit(theImgList, "<"))
		adrLinenum = grep(' href', theImgList)
		theImgList = theImgList[adrLinenum]

		theImgList = gsub(".* href='" , '<img src="', theImgList)  
		theImgList = gsub("' data.*>" , '">', theImgList) 

		theWholePage <<- c(theWholePage, theImgList)
	}

	sink(paste0(thekeyword,".html"))
	cat(theWholePage, sep="\n")
	sink()
}



seekforAdrkey <- function(thepage, linkAdrkey){
	linenum = grep(linkAdrkey, thepage)
	return(thepage[linenum + 1])
}

boilit <- function(thepage){
	rplword = '/view_video.php\\?viewkey='
	substword = 'https://www.pornhub.com/embed/'
	thepage = gsub(rplword, substword, thepage)
	thepage = gsub(' title=.*\">' , '>', thepage)  
	return(paste0(thepage,"\n"))
}

# =========
# entry point
Sys.setlocale(category = "LC_ALL", locale = "chs")

# thekeyword = askforKey()
# if(thekeyword == ""){
# 	break
# }

# asknum = askforNum()
# if(asknum != "")   {
# 	thenum = as.numeric(asknum)
# } else{
# 	thenum = 10
# }

boilPages()
startstr="start chrome.exe --start-fullscreen "
# note to quote the long filename
## shell(paste0(startstr, dirStr,"/", paste0(thekeyword,".html\"")))
# http://www.pornhub.com/pornstars?page=15
# http://www.pornhub.com/video?c=96&page=10
