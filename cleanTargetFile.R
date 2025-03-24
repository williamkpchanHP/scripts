# this interpret the cmdFile and clean the target file
rm(list = ls())

# this must be added to setting chinese
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")

#library(audio)
library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

# ask for cmdFileName
cat(white("\n\n\nTo filter and remove img lines!\n\n"))

imgsrc = readline("Select image src path, 1 pornpic, 2 xham, 3 freematures, 4 allHtmls: ")
if(imgsrc == "1"){
  setwd("C:/Users/william/Desktop/scripts/pornpics")
}else if(imgsrc == "2"){
  setwd("C:/Users/william/Desktop/scripts/xham")
}else if(imgsrc == "3"){
  setwd("C:/Users/william/Desktop/scripts/freematures")
}else if(imgsrc == "4"){
  setwd("C:/Users/william/Desktop/scripts/allHtmls")
}
cat(red("\n\ncurrent working path: ", getwd(), "\n\n\n"))

cat(yellow("please select command file!\n"))
choosefile = readline("select command file(txt file, press enter to default, jobcommands.txt): ")
if(choosefile==""){
  choosefile = "jobcommands.txt"
}

cmdFile = readLines(choosefile)


#cat(blue(cmdFile), "\n\n", sep="\n")
cat(green("file: ", choosefile, "\n"))

#cmdFile
targetFileName = cmdFile[1]
cat(yellow("\ntargetFileName: ", targetFileName, "\n"))
# check empty lines
emptycmdIdx = grep("^$", cmdFile)
if(length(emptycmdIdx)>0){
  cmdFile = cmdFile[-emptycmdIdx] # remove empty lines
}

# processss cmd file
targetFile = readLines(targetFileName)
emptyIdx = grep("^$", targetFile)
if(length(emptyIdx)!=0){
  targetFile = targetFile[-emptyIdx] # remove empty lines
}

#### cleanup cmds
cmdFile = cmdFile[-1]
if(imgsrc == "1"){
  cmdFile = gsub('https://cdni.pornpics.com/1280/', '', cmdFile)
  cmdFile = gsub('.jpg', '', cmdFile)
}else if(imgsrc == "2"){
  cmdFile = gsub('https://ic-ph-nss.xhcdn.com/a/', '', cmdFile)
  cmdFile = gsub('https://thumb-p.*?.com/a/', '', cmdFile)
  cmdFile = gsub('_1000.jpg', '', cmdFile)
}else if(imgsrc == "3"){
  cmdFile = gsub('http://freematuresgallery.com/pics/', '', cmdFile)
  cmdFile = gsub('.jpg', "',", cmdFile)
}

allLines = 1:length(cmdFile)
oddNum <- function(x) subset(x, x %% 2 == 1)
oddLines = allLines[oddNum(allLines)]
imgLines = cmdFile[oddLines]  # odd lines are img url
cmdLines = cmdFile[-oddLines] # net line is cmd

# check repeat imgLines
imgLinesLen = length(imgLines)
chkRepeat = unique(imgLines)
  if(imgLinesLen != length(chkRepeat)){
    cat(red("\n\nWarning! repeated imgLines:\n\n\n"))
    for(i in imgLines[duplicated(imgLines)]){
      cat(yellow(i, "\n"))
    }
    break
  }

# run the rest loop
startLine = 0
for(i in 1:length(imgLines)){
  # find the first line idx
  mark = imgLines[i]
  cat("\n",mark,": ")
  markIdx = grep(mark, targetFile)
  if(length(markIdx)!=1){
    cat(red("Wrong img line! ", "length(markIdx): ",length(markIdx)), " ")
  }
  action = cmdLines[i]

  if(action == "+"){
    startLine = markIdx
    cat("startLine: ", startLine, " ")
  }else{
    endLine = markIdx
    if(startLine == 0){ # first line is last line
      startLine = endLine
    }

    cat("startLine: ", startLine, " ")
    cat("endLine: ", endLine, "")
    if(startLine <=endLine){  # make sure endLine> startLine
      for(k in startLine:endLine){
        targetFile[k] = ""
      }
      # cat(green("result k: ",targetFile[k], "\n"))
    }
    startLine = 0
  }
}

emptyIdx = grep("^$", targetFile)
if(length(emptyIdx)!=0){
  targetFile = targetFile[-emptyIdx] # remove empty lines
}

outFilename = paste0(targetFileName, " cleaned.txt")
sink(outFilename)
  cat(targetFile, sep="\n")
sink()
cat(red("\n",outFilename, " created!\n"))
####

cat(yellow(choosefile, "job completed\n"))
