datapath = 'C:/Users/william/Desktop/scripts/R'
setwd(datapath)

# filterPattern = 'this.src'
addline = '<script>\nvar lazyLoadInstance = new LazyLoad({ elements_selector: ".lazy" });\n</script>'

allFiles <- list.files(path = datapath, pattern = "html", full.names = TRUE)
cat("Total files: ", length(allFiles), "\n")
for(i in allFiles){
  tempFile = readLines(i)
  targetIdx = grep("readbook.js", tempFile)
  if(length(targetIdx)>0){
      targetIdx = grep("imgControl.js", tempFile)
        tempFile[targetIdx + 1] = addline
        cat("updating file! \n")
        sink(i)
          cat(tempFile, sep="\n")
        sink()
  }else{
      cat("target not exist\n")
  }
}

cat("Job complete!")
