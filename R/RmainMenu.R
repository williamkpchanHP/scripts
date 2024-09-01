rm(list = ls())

library(crayon)
  ligSilver <- make_style("#889988")
  lime <- make_style("#10ff10")
  purple <- make_style("#9400D3")
  deeppink <- make_style("#FF1493")
  darkgreen <- make_style("#004000")
  magenta  <- make_style("#800080")
  orange  <- make_style("#E6971E")
  pink  <- make_style("#FFB6C1")
  brown  <- make_style("#DF7E43")
  gray  <- make_style("#8F8F8F")
  cyan  <- make_style("#42A783")
  puzzle  <- make_style("#CFCE90")
  paleYel  <- make_style("#E7D9A5")

# this must be added to setting chinese
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
setwd("C:/Users/william/Desktop/scripts/R")

#library(audio)
library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

mainMenu = readLines("RmainMenuList.txt")
mainMenu <- matrix(unlist(strsplit(mainMenu, split = "\\t")), ncol=2, byrow=TRUE)

readkey = function(){
	key = ""
	while(is.na(suppressWarnings(as.numeric(key)))){
		key = readline(prompt="Type 0 to llok for keyword, Enter your choice: ")
		if(key == "0" | key == "as.raw(27)") {break}
	}

	return(strtoi(key))
}

cat("\nFollowings are available R scripts.\n")

for(scriptNo in 1:nrow(mainMenu)){
	remainder = scriptNo %% 4
	if(remainder==0){
		cat(scriptNo, puzzle(mainMenu[scriptNo,2], "\t", mainMenu[scriptNo,1], "\n"))
	}else if(remainder==1){
		cat(scriptNo, paleYel(mainMenu[scriptNo,2], "\t", mainMenu[scriptNo,1], "\n"))
	}else if(remainder==2){
		cat(scriptNo, cyan(mainMenu[scriptNo,2], "\t", mainMenu[scriptNo,1], "\n"))
	}else{
		cat(scriptNo, brown(mainMenu[scriptNo,2], "\t", mainMenu[scriptNo,1], "\n"))
	}
}

keyin <- nrow(mainMenu) +1

while(keyin >nrow(mainMenu) | keyin<0){
	cat("\nSelect the script you want to try: \n")
	keyin <- readkey()
     if(keyin==0){
        searchTxt = readline(prompt="enter search txt: ")
        schID = grep(searchTxt, mainMenu[,2], ignore.case=TRUE)
        if(length(schID)!=0){
          for(i in 1:length(schID)){
            cat(schID[i], "\t", mainMenu[schID[i], 2], "\n")
          }
        }
        keyin = -1
     }
}

cat("\n\nSelected: ", mainMenu[keyin,],"\n\n")
theSeleted = paste0(mainMenu[keyin,1], mainMenu[keyin,2])
theSeleted = gsub("\\\\", "/", theSeleted)
cat("\n",theSeleted, "\n")
source(theSeleted, encoding = "UTF-8")
