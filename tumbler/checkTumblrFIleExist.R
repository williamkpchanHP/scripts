setwd("C:/Users/william/Desktop/scripts/tumbler")
originalurl = readLines("tumblrList.js")  # url addr to be verified
urlIdx = grep("<img loading", originalurl)
url = originalurl[urlIdx]
url = gsub('^.*?src="', '', url)
url = gsub('".*', '', url)

noneTxt = character()
for (i in url) {
    cat(". ")
    tmp <- tryCatch(
             readLines(url(i), warn=F), silent = TRUE,
             error = function (e) NULL
           )
    if (is.null(tmp)) {
      print(paste(i, " doesn't exist"))
      noneTxt = c(noneTxt, i)
      next() # skip to the next url.
    }else{
     # run ocr
    }

}


for (i in noneTxt) {
    targetIdx = grep(i, originalurl)
    cat("not exist: ",targetIdx, originalurl[targetIdx], "\n")
    originalurl[targetIdx] = ""
}

# write back file
sink("tumblrList-backup.js")
  cat(originalurl, sep="\n")
sink()
