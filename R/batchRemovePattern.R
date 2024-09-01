datapath = 'C:/Users/william/Desktop/scripts/R'
setwd(datapath)

filterPattern = 'this.src'

allFiles <- list.files(path = datapath, pattern = "html", full.names = TRUE)
cat("Total files: ", length(allFiles), "\n")
for(i in allFiles){
  cat(i, "\n\n")
  tempFile = readLines(i)
  targetIdx = grep(filterPattern, tempFile)
  if(length(targetIdx)>0){
      cat("targetLine exist! ")
        tempFile[targetIdx] = ""
        cat("updating file! \n")
        sink(i)
          cat(tempFile, sep="\n")
        sink()
  }
  cat("imgCtr exist! no update\n")
}

cat("Job complete!")
