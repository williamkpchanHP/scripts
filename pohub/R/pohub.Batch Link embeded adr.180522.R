
dirStr = "C:/Users/user/mpg/Text/programs/pohub/scripts"
setwd(dirStr)

askforURL <-function(){
	Selection = readline(prompt="Note! no input file! addr embbed! enter output name without extension: ")
	return(Selection)		# if empty, calling program handle
}

seekkey = '<div class="preloadLine"></div>'
imgkey = '<textarea name="caption" placeholder'

boilPages <- function(theURL){

	thepage = readLines(theURL, warn = F)
	thepage = gsub('\t' , '', thepage) 

	theImg = grep(imgkey, thepage)
	theImg = thepage[theImg + 2]
	theembedURL = gsub('.*wkey=', '<a href ="https://www.pornhub.com/embed/', theURL)  
	theembedURL = paste0(theembedURL ,'">', theImg, "</a>")  

	thepage = seekforkey(thepage)
	thepage = gsub('.*wkey=', '<a href ="https://www.pornhub.com/embed/', thepage)
	thepage = gsub(' title=".*>', '>', thepage)  
	thepage = gsub('.*data-image' , '<img src', thepage)  
	thepage = gsub('.*data-mediumthumb' , '<img src', thepage)  
	thepage = gsub('jpg.*' , 'jpg"></a>', thepage)
	thepage = c(theembedURL, thepage)
	return(thepage)
}


seekforkey <- function(thepage){
	linenum = grep(seekkey, thepage)
	linenum = sort(c(linenum + 4, linenum + 9))
	thepage = thepage[linenum]
}


# =========
# entry point
thefileName = askforURL()
if(thefileName == ""){
	break
}

urlHead = "https://www.pornhub.com/view_video.php?viewkey="

theList = c("1165523815", "1256054892", "1280409873", "1341800948", "1425616490", "1523831974", "1538644238", "2048170070", "216904624", "328463014", "416094783", "839992381", "ph559bfd0abec3c", "ph55a41f5d840c7", "ph55d3d46c877a3", "ph56575549e4099", "ph56e7fe1389007", "ph56f19ed342e28", "ph56fbbb5c48c5a", "ph57382ec1a7db8", "ph573833662028a", "ph57383490db4d1", "ph5738383a66973", "ph57383921b1a19", "ph5752eb417b079", "ph57754520b7c27", "ph57754721b9956", "ph577b215d3a711", "ph57924bfbd26eb", "ph579af05d9c741", "ph57b1aca07af84", "ph584b29db2ab1f", "ph5884cb9685d8c", "ph5898c6a84bc1b", "ph58a2433a4fdd2", "ph58a399376e82c", "ph58a3998e13fb9", "ph58af55e201fa5", "ph58d29e5ae5ea1", "ph58e51f534c412", "ph5949e3d03f21c", "ph594ddee6d6091", "ph5a123c7736e10", "69007645", "ph59f7e1d160615", "ph59ab27fb2febd", "ph5ab1dae322a5c", "ph5ab98b0d4b7c0")

lentheList = length(theList)

wholeData = ""
for(i in 1:lentheList){
	cat(i, " ")
	theURL = paste0(urlHead, theList[i])

	wholeData = c(wholeData, boilPages(theURL))
}
#	wholeData = sort(unique(wholeData)) this cause problem
	sink(paste0(thefileName,".html"))
	cat("<base target=_blank>\n")
	cat("<style>\nhtml {height: 100%; overflow: scroll;}\n::-webkit-scrollbar { width: 0px; background: transparent;}\nbody { font-size: 24px; background-color: #000000; color: #109030;}\na { text-decoration: none;    color: #28B8B8;}\na:visited { color: #389898;}\nA:hover {   color: yellow;}\nA:focus {   color: red;}\nimg {width:32%;}\n</style>\n")

	cat(wholeData, sep="\n")
	sink()

	startstr="start chrome.exe --start-fullscreen "
	# note to quote the long filename
	shell(paste0(startstr, dirStr,"/", paste0("\"",thefileName,".html\"")))
