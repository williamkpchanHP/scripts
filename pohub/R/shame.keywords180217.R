# shameless embed location: <meta property="og:video" content="https://www.shameless.com/embed/101331"/>
# locate <figure itemprop="itemListElement, this is the content line
# https://www.shameless.com/tags/shaved-pussy/
# https://www.shameless.com/tags/shaved-pussy/2/  ~ 81

# https://www.shameless.com/search/?q=aunt
# number of pages:4
# get line 121
# replace <div class="icnt">
# with new line
# chop <div class="bg anmt">
# and afterwards

dirStr = "C:/Users/user/mpg/Text/programs/pohub/scripts/shame"
setwd(dirStr)

linesig = '<figure itemprop="itemListElement'
searchHead = 'https://www.shameless.com/search/'

askforKey <-function(){		# "abc def" -> "abc+def"
	Selection = readline(prompt="enter key words: ")
	if(Selection != "")   {
	  	Selection = tolower(gsub(" ", "+", Selection))
  	}
	return(Selection)		# if empty, calling program handle
}

askforNum <-function(){		
	Selection = readline(prompt="enter max number of page: ")
	return(Selection)		# if empty, calling program handle
}

theWholePage = character(0)

boilPages <- function(searchKey){
	for(i in 1:thenum){
	    cat(i," ")
	    if(i%%100 == 0){
		cat("\n")
	    }
		# https://www.shameless.com/search/?q=aunt
		# https://www.shameless.com/search/2/?q=aunt
		thepage = readLines(paste0(searchHead, i, '/?q=', thekeyword))
		linenum = grep(linesig, thepage)
		thepage = thepage[linenum]
		thewordlist = unlist(strsplit(thepage, '<div class="icnt">'))
		thewordlist = thewordlist[-1]
		thewordlist = gsub('<div class="bg anmt">.*', '<br>', thewordlist)
		thewordlist = gsub(' onmouseover.*\">', '><br>', thewordlist)

		theWholePage <<- c(theWholePage, thewordlist)
	}

	sink(paste0(thekeyword, " shame.html"))
	cat("<base target=_blank>\n")
	cat("<style>body { font-size: 18px; background-color: #000000; color: #109030;}a { text-decoration: none;	color: #28B8B8;}a:visited { color: #389898;}A:hover {   color: yellow;}A:focus {   color: red;}img {width: 600px; margin:5px auto;}html {height: 100%; overflow: scroll;}::-webkit-scrollbar {width: 0px;  background: transparent;}</style>\n<body><center>\n")
	cat(theWholePage, sep="\n")
	sink()
}



# =========
# entry point
Sys.setlocale(category = "LC_ALL", locale = "chs")

thekeyword = askforKey()
if(thekeyword == ""){
	break
}

thenum = 10
asknum = askforNum()
if(asknum != "")   {
	thenum = as.numeric(asknum)
}
boilPages()
startstr="start chrome.exe --start-fullscreen "
# note to quote the long filename
shell(paste0(startstr, dirStr,"/", paste0("\"",thekeyword," shame.html\"")))
