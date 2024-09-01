datapath = 'C:/Users/william/Desktop/scripts/R'
setwd(datapath)

originalLine = '<script src="imgControl.js"></script>'

newLine = '<script src="https://williamkpchan.github.io/imgControl.js"></script>'

allFiles <- list.files(path = datapath, pattern = "html", full.names = TRUE)
cat("Total files: ", length(allFiles), "\n")
for(i in allFiles){
  cat(i, "\n\n")
  tempFile = readLines(i)
  targetIdx = grep(originalLine, tempFile)
  if(length(targetIdx)>0){
      cat("targetLine exist! ")
        tempFile[targetIdx] = newLine
        cat("updating file! \n")
        sink(i)
          cat(tempFile, sep="\n")
        sink()
  } else{
        cat("target not exist! no update\n")
  }
}

cat("Job complete!")
