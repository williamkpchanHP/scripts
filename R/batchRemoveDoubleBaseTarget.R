datapath = 'C:/Users/william/Desktop/scripts/R'
setwd(datapath)

# filterPattern = 'this.src'

allFiles <- list.files(path = datapath, pattern = "html", full.names = TRUE)
cat("Total files: ", length(allFiles), "\n")
for(i in allFiles){
  cat(i, "\n\n")
  tempFile = readLines(i)
  targetIdx = grep("<base target", tempFile)
  if(length(targetIdx)>1){
      cat("target exist! ")
        # rectify mistake line 2
        # tempFile[2] = '<meta http-equiv="Content-Type" content="text/html; charset=utf-8">'
        tempFile[targetIdx[2]] = ""
        cat("updating file! \n")
        sink(i)
          cat(tempFile, sep="\n")
        sink()
  }else{
      cat("target not exist\n")
  }
}

cat("Job complete!")
