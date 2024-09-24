programSrcPath = "C:/Users/william/Desktop/scripts/"
setwd(programSrcPath)

cat("\n\n\nCheck URL exist, src data from file!\n\n")
originalpath = readline("enter path name only:")

setwd(originalpath)
cat("\ncurrent src path: ", originalpath)

srcFileName = readline("enter src file name including extension:")
url = readLines(srcFileName)

rmidx = grep("^\n", url)
if(length(rmidx)>0){  url = url[-rmidx] }

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
    }
}

outFileName = paste0(srcFileName," UrlNotExist.txt")
sink(outFileName)
  cat(noneTxt, sep="\n")
sink()

cat("\n\nJob completed!\n\n")
