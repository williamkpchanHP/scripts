setwd("C:/Users/william/Desktop/scripts/pohub")
library(crayon)
 ligSilver <- make_style("#889988")


# check lineheader exist in file, if yes rename it
checklineheader <- function(){
  setwd("C:/Users/william/Desktop/scripts/pornpics")
  filelist = readLines("allhtmllist.txt")
  cat("\ntotal file number: ", length(filelist))
  for(i in 1:length(filelist)){
     cat("\n", i, filelist[i])
     content = readLines(filelist[i])
     lineheaderIdx = grep("lineheader", content)
     if(length(lineheaderIdx)>0){
       newname = paste0(filelist[i], ".line")
       file.rename(filelist[i], newname)
       cat(red(" renamed ", filelist[i], " to ", newname))
     }
  }
}



cat(red("\n\n\n\nDAnger!!! make sure this is correctly coded"))
continueKey = readline("enter y to continue :")
if(continueKey != "y"){
  break
}else{
  checklineheader()
}


  #for(i in 1:length(filelist)){
  #  oldname = filelist[i]
  #  newname = gsub(" ", "", oldname)
  #  newname = gsub("pohub", "", newname)
  #  newname = gsub("\\+|-", "", newname)
  #  newname = paste0("pornhub", newname)
  #  newname = gsub("\\.html", "\\.js1", newname)
  #  if(newname !=oldname){
  #    file.rename(oldname, newname)
  #  }
  #}

  for(i in 1:length(filelist)){
    cat("\n",i)
    content = readLines(filelist[i])
    cat("\nfilename" ,filelist[i],"\n")
    tipsListIdx = grep("tipsList", content)
    cat(' tipsListIdx ', tipsListIdx)

    if(length(tipsListIdx)!=0){
      content = content[-(1:tipsListIdx)]
      cat(" content cleaned!")

      showRangeidx = grep("showRange", content)
      cat(' showRangeidx ', showRangeidx)
      if(length(showRangeidx)!=0){
        content = content[-(showRangeidx:length(content))]
        cat(" content tail cleaned!")
      }

      lineTailidx = grep("lineTail = ''", content)
      if(length(lineTailidx)!=0){
        content[lineTailidx] = "lineTail = '</a></div>'"
        cat(" lineTail cleaned!")
      }

      sink(paste0("mod",filelist[i]))
        cat(content, sep="\n")
      sink()
      cat(paste0("mod",filelist[i], " saved"))
  }else{
    cat(red(filelist[i]), "not mod!\n")
    noModList = c(noModList, filelist[i])
  }
}

cat(noModList)

