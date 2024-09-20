programSrcPath = "C:/Users/william/Desktop/scripts/"
setwd(programSrcPath)

cat("\n\nCheck file exist, src data from file!\n\n")
originalpath = readline("enter path name only:")
originalpath = paste0(programSrcPath, originalpath)
setwd(originalpath)
cat("\ncurrent src path: ", originalpath)

srcFileName = readline("enter src file name including extension:")
srcFile = readLines(srcFileName)

cleanup = function(linetxt){
  lineIdx = grep(linetxt, srcFile)
  cat("clean: ",lineIdx)
  srcFile[lineIdx] = ""
}
urlIdx = grep("<img loading", srcFile)
url = srcFile[urlIdx]
url = gsub('^.*?http', 'http', url)
url = gsub('">.*', '', url)

rmidx = grep("^\n", url)
if(length(rmidx)>0){
  url = url[-rmidx]
}

noneTxt = character()
cat("Total urls: ", length(url), "\n")
counter = 0
for (i in url) {
    counter = counter+1
    cat(counter, ". ")
    tmp <- tryCatch(
             readLines(url(i), warn=F), silent = TRUE,
             error = function (e) NULL
           )
    if (is.null(tmp)) {
      print(paste(i, "doesn't exist"))
      noneTxt = c(noneTxt, i)
      next() # skip to the next url.
    # }else{
     # run ocr
    }
}

for (i in noneTxt) {
    targetIdx = grep(i, srcFile)
    if(length(targetIdx) ==1){
      cat("Idx: ",targetIdx, " ")
      srcFile[targetIdx] = ""
    }else{
      cat("unknown:\n","i: ",i, "\ntargetIdx ",targetIdx, "\nsrcFile[targetIdx]",srcFile[targetIdx], "\n")
      break
    }
}

srcFile = unique(srcFile)
# write back file
outfile = paste0(srcFileName, "mod.txt")
sink(outfile)
  cat(srcFile, sep="\n")
sink()
cat("\n\nJob completed!\n\n")

