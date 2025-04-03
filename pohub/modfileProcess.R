setwd("C:/Users/william/Desktop/scripts/pohub")
library(crayon)
 ligSilver <- make_style("#889988")

noModList = ""
filelist = readLines("modlist.txt")

  for(i in 1:length(filelist)){
    cat("\n",i)
    content = readLines(filelist[i]) # read content first

    cat("\nfirstline: " ,content[1],"\n") # show first line
    newfielname = gsub("mod", "", filelist[i])
    newfielname = gsub("js1", "js", newfielname)
    cat(" newfielname: " ,newfielname,"\n")

    arrayName = gsub("\\.js","", newfielname)
    modifiedLine1 = paste0("var ", arrayName, " = [")
    content[1] = modifiedLine1

    bookidIdx = grep("bookid", content)
    if(length(bookidIdx)!=0){
      cat("\nto remove bookidIdx: ", bookidIdx)
      content = content[-bookidIdx]
      cat(" content cleaned!")

      sink(newfielname)
        cat(content, sep="\n")
      sink()
      file.remove(filelist[i])
      cat(green(newfielname, " saved! ", filelist[i], " deleted\n"))
  }
}
