programSrcPath = "C:/Users/william/Desktop/scripts/"
setwd(programSrcPath)

cat("\n\n\nCheck file exist, src data from file!\n\n")
originalpath = readline("enter path name only, without full list:")
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


for (i in 1:length(noneTxt)) {
    targetIdx = grep(noneTxt[i], srcFile)
    if(length(targetIdx) ==1){
      cat("Idx: ",targetIdx, " ")
      srcFile[targetIdx] = ""
    }else if(length(targetIdx) ==0){
      cat("not found: targetIdx =0",i, "\ntargetIdx ",targetIdx)
    }else{
      cat("not found: targetIdx >0",i, "\ntargetIdx ",targetIdx)
    }
}

sink("nontxt.txt")
  cat(noneTxt, sep="\n")
sink()

srcFile = unique(srcFile)
# write back file
outfile = paste0(srcFileName, "mod.txt")
sink(outfile)
  cat(srcFile, sep="\n")
sink()
cat("\n\nJob completed!\n\n")

