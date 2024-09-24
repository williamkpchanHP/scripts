# screen out urls
cat("\n\n\nscreen out urls\n\n")
# load file
srcPath = readline("enter source path name:")
setwd(srcPath)

srcFileName = readline("enter source file name:")
srcFile = readLines(srcFileName)

opeSrc = srcFile
cat("\nlength(opeSrc): ", length(opeSrc))
# extract keyData
startingMark = readline("enter start Marker:")
targetID = grep(startingMark, opeSrc)

endMark = readline("enter end Marker:")
endMark = paste0(endMark, ".*")

keyData = opeSrc[targetID]
keyData = gsub(startingMark, "", keyData)
keyData = gsub(endMark, "", keyData)

# result to submit
cat("\nfinal length(keyData): ", length(keyData), "\n\n\n")

# write to file
outFileName = paste0(srcFileName, " extracted.txt")
sink(outFileName)
  cat(keyData, sep = "\n")
sink()
