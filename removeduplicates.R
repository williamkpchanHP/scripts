# screen out repeated markers and remove duplicates
cat("\n\n\nscreen out repeated markers and remove duplicates\n\n")
# load file
srcPath = readline("enter source path name:")
setwd(srcPath)

srcFileName = readline("enter source file name:")
srcFile = readLines(srcFileName)

opeSrc = srcFile
cat("\nlength(opeSrc): ", length(opeSrc))
# extract keyData
startingMark = readline("enter start Marker (without begin mark):")
startingMark = paste0("^",startingMark)

endMark = readline("enter end Marker (without until mark):")
endMark = paste0(endMark, ".*")

keyData = gsub(startingMark, "", opeSrc)
keyData = gsub(endMark, "", opeSrc)
duplicatedKey = which(duplicated(keyData))

# result to submit
opeSrc = opeSrc[-duplicatedKey]
cat("\nfinal length(opeSrc): ", length(opeSrc), "\n\n\n")

# write to file
outFileName = paste0(srcFileName, " mod.txt")
sink(outFileName)
  cat(opeSrc, sep = "\n")
sink()
