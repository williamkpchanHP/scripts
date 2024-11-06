# chop big file into small files
# setwd("C:/Users/User/Pictures/sexpage")
setwd("C:/Users/william/Desktop/scripts")
#fapHeader = readLines("fapHead.txt")
#fapTail = readLines("fapTail.txt")
fileHeader = readLines("fileHeader.txt")
fileTail = readLines("fileTail.txt")

fileBodyPath = readline("enter target chopp file full path :")
fileBodyPath = paste0(fileBodyPath, "/")
fileBodyName = readline("enter target chopp file full name :")
fullBodyFileName = paste0(fileBodyPath,fileBodyName)
cat(yellow("\nLoading file...\n"))

fileBody = readLines(fullBodyFileName)
cat(green("\nfullBodyFileName: ",fullBodyFileName, "\n"))

setwd(fileBodyPath)

outnameBody = readline("enter chop outname: ")
outnameHead = "xham"
outnameTail = ".html"

allLines = length(fileBody)
cat(yellow("\nTotal lines target to be chopped:", allLines, "\n"))
totalPages = as.numeric(readline("enter how many output pages: "))
if(totalPages > 0){
  eachPageLines = round(allLines/totalPages)
}

cat("\nsample line:\n\n",yellow(fileBody[1], "\n"))
replaceHeader = readline("\nenter replaceHeader: ")
cat(yellow("\nfiltering...\n"))

fileBody = gsub(replaceHeader, "'", fileBody)
fileBody = gsub("$", "',", fileBody)
cat("\nresult sample line:\n\n",red(fileBody[1], "\n"))
goahead = readline("\n\ngo ahead? 1/0 y/n: ")
if(goahead != "1"){
  cat(red("aaborted!"))
  break
}
cat(red("\nprocessing...\n"))
# the last page will be handled independently
 for(page in 1:(totalPages-1)){
  cat(red("."))
  outputFileName = paste0(outnameHead,outnameBody, "P",page, outnameTail)

  startLine = 1 + (page-1) * eachPageLines
  endLine = page * eachPageLines

  sink(outputFileName)
    cat(fileHeader, sep="\n")
    for(lines in startLine:endLine){
      cat(fileBody[lines], "\n")
    }
    cat(fileTail, sep="\n")
  sink()
 }

# lastly create last page
  outputFileName = paste0(outnameHead,outnameBody, totalPages, outnameTail)
  page = totalPages
  startLine = 1 + (page-1) * eachPageLines
  endLine = allLines

  sink(outputFileName)
    cat(fileHeader, sep="\n")
    for(lines in startLine:endLine){
      cat(fileBody[lines], "\n")
    }
    cat(fileTail, sep="\n")
  sink()

cat(red("\n\n\nJob completed\n"))

