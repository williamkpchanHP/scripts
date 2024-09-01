datapath = 'C:/Users/william/Desktop/scripts/R'
setwd(datapath)

allFiles <- list.files(path = datapath, pattern = "urlList .*\\.html\\.txt", full.names = TRUE)
cat("Total files: ", length(allFiles), "\n")
allContent = character()
  for(i in allFiles){
    temp = readLines(i)
    allContent = c(allContent, temp)
  }

sink("masterUrlList.txt")
    cat(allContent, sep="\n")
sink()

cat("Job complete!")
