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

askforURL <-function(){
	Selection = readline(prompt="enter Batch Filename without extension: ")
	return(Selection)		# if empty, calling program handle
}

theWholePage = character(0)

extractShamePage <- function(theURL){
	thepage = readLines(theURL, warn = F)
	linenum = grep(linesig, thepage)
	thepage = thepage[linenum]
	thewordlist = unlist(strsplit(thepage, '<div class="icnt">'))
	thewordlist = thewordlist[-1]
	thewordlist = gsub('<div class="bg anmt">.*', '<br>', thewordlist)
	thewordlist = gsub(' onmouseover.*\">', '><br>', thewordlist)
	return(thewordlist)
}

# =========
# entry point
Sys.setlocale(category = "LC_ALL", locale = "chs")

thefileName = askforURL()
if(thefileName == ""){
	break
}
thefile = paste0(thefileName, ".txt")
theList = readLines(thefile, warn = F)
lentheList = length(theList)

wholeData = ""
for(i in 1:lentheList){
	cat(i, " ")
	wholeData = c(wholeData, extractShamePage(theList[i]))
}

wholeData = sort(unique(wholeData))

sink(paste0(thefileName, " shame.html"))
cat("<base target=_blank>\n")
cat("<style>body { font-size: 18px; background-color: #000000; color: #109030;}a { text-decoration: none;	color: #28B8B8;}a:visited { color: #389898;}A:hover {   color: yellow;}A:focus {   color: red;}img {width: 600px; margin:5px auto;}html {height: 100%; overflow: scroll;}::-webkit-scrollbar {width: 0px;  background: transparent;}</style>\n<body><center>\n")
cat(wholeData, sep="\n")
sink()

startstr="start chrome.exe --start-fullscreen "
shell(paste0(startstr, dirStr,"/", paste0("\"",thefileName," shame.html\"")))
