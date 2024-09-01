datapath = 'C:/Users/william/Desktop/scripts/R'
setwd(datapath)

readbookLine = "<script src='https://williamkpchan.github.io/LibDocs/readbook.js'></script>"

imgControlLine = '<script src="imgControl.js"></script>'
newLine = paste0(readbookLine, "\n", imgControlLine)

allFiles <- list.files(path = datapath, pattern = "html", full.names = TRUE)
cat("Total files: ", length(allFiles), "\n")
for(i in allFiles){
  cat(i, "\n")
  tempFile = readLines(i)
  targetIdx = grep("readbook.js", tempFile)
  if(length(targetIdx)>0){
      cat("targetLine exist! ")
      imgCtrIdx = grep(imgControlLine, tempFile)
      if(length(imgCtrIdx)==0){
        cat("imgCtr not exist! ")
        tempFile[targetIdx] = newLine
        cat("updating file! \n\n")
        sink(i)
          cat(tempFile, sep="\n")
        sink()
      } else{
        cat("imgCtr exist! no update\n")
      }
  }
}

cat("Job complete!")
