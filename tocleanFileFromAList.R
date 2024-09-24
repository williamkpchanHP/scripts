programSrcPath = "C:/Users/william/Desktop/scripts/"
setwd(programSrcPath)

cat("\n\n\nremove specified data from specified file!\n\n")
originalpath = readline("enter path name only:")

setwd(originalpath)
cat("\ncurrent src path: ", originalpath)

tobeCleanFileName = readline("enter tobeClean file name including extension:")
tobeClean = readLines(tobeCleanFileName)

rmidx = grep("^\n", tobeClean)
if(length(rmidx)>0){  tobeClean = tobeClean[-rmidx] }

cat("Total tobeCleans: ", length(tobeClean), "\n")

toCleanList = readline("enter specified Clean List including extension:")
toClean = readLines(toCleanList)

counter = 0
for (i in toClean) {
    counter = counter+1
    cat(counter, ". ")
    targetIdx = grep(i, tobeClean)

    if (length(targetIdx)==1) {
      tobeClean[targetIdx] = ""
    }else(
      cat("targetIdx not found!", targetIdx, "\n")
    )
}

outFileName = paste0(tobeCleanFileName," Cleaned.txt")
sink(outFileName)
  cat(tobeClean, sep="\n")
sink()

cat("\n\nJob completed!\n\n")
