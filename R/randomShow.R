# to execute random html file
dirStr = "C:/Users/william/Desktop/scripts/R"
showFolder = "C:/Users/william/Desktop/scripts/allHtmls"
setwd(showFolder)
allHtmls = list.files(pattern = "html")
key = ""
while(key != "."){
	key = readline(prompt="enter any key except enter: ")
	if(key == ".")   { 
		cat("\nblank address! exited!\n")
		break
	}

    pointer = sample(length(allHtmls), 1)
    thefile = paste0('"',allHtmls[pointer],'"')
    shell(thefile)
    allHtmls = allHtmls[-pointer]
}

