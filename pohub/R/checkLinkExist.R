# make a list of all html files
# for each file, open file and check first line is <base target=_blank>
# if yes
#   replace \n\n<img src="https:// by <img src="https://
# fileList at 71
rm(list = ls())

library(crayon)
  ligSilver <- make_style("#889988")
  lime <- make_style("#10ff10")
  purple <- make_style("#9400D3")
  deeppink <- make_style("#FF1493")
  darkgreen <- make_style("#004000")
  magenta  <- make_style("#800080")
  orange  <- make_style("#E6971E")
  pink  <- make_style("#FFB6C1")
  brown  <- make_style("#DF7E43")
  gray  <- make_style("#8F8F8F")
  cyan  <- make_style("#42A783")
  puzzle  <- make_style("#CFCE90")
  paleYel  <- make_style("#E7D9A5")

dirStr = "C:/Users/william/Desktop/scripts/pohub"
setwd(dirStr)
# fileList = list.files(dirStr)
fileList = readLines("fileList.txt")

cat(orange("\nLength(fileList):", length(fileList), "\n"))

for(pointer in 125:length(fileList)){
  filename = fileList[pointer]
  cat(yellow("\n\npointer:", pointer, " of ", length(fileList)), " filename:", filename, "\n")

  if(!file.exists(filename)) {
    cat(brown("\nfile disappeared!\n"))
  }else{
    testtFile = readLines(filename)
    if(testtFile[1]=="<base target=_blank>"){
      cat(deeppink("\n", filename, " Length: ", length(testtFile), "\n"))
      # clean up anchors
      anchorIdx = grep("<a href", testtFile)
      result = testtFile[-(anchorIdx+1)] # remove next line, it is empty
      anchorIdx = grep("<a href", result) # re inde since some line removed
      for(i in anchorIdx){
        result[i] = paste(result[i], result[i+1], collapse = '')
      }
      result =  result[-(anchorIdx+1)]
      anchorIdx = grep("^$", result)
      result =  result[-anchorIdx]
    }else{
      cat(red("\nFile header incorrect!\n\n"))
      break 
   }
  
    # check link exist
    rmLine = as.numeric()
      cat("ongoing...")
      anchorIdx = grep("<a href", result)
      cat(green("length(anchorIdx) ",length(anchorIdx), "\n"))
      for(i in anchorIdx){
        imgurl = gsub('^.*src="|"></a>.*', '', result[i])
        linkurl = gsub('^.*<a href="|">.*', '', result[i])

        imgTmp <- tryCatch(
                 readLines(imgurl, warn=F), silent = TRUE,
                 error = function (e) NULL
               )
        if (is.null(imgTmp)) { # if not exist, record it
              cat(paste(i, "X "))
              rmLine = c(rmLine, i)
              next() # skip to the next url.
        }else{                 # if exist, check link
            tmp <- tryCatch(
                 readLines(linkurl, warn=F), silent = TRUE,
                 error = function (e) NULL
            )
            noExist = grep("currently unavailable", tmp)

            if (length(noExist)!=0) {  # it is unavailable
              cat(paste(i, "X "))
              rmLine = c(rmLine, i)
              next() # skip to the next url.
            }else{
              (cat(green(".")))
            }
        }
  
        result = result[-rmLine]
        cat(yellow("length(result)", length(result)), "\n")
        sink(filename)
        cat(result, sep="\n")
        sink()
  
        if(length(result)<3){  # this is empty file
          cat(red("\n\n\nwarning: length(result)<3\n\n", "filename ", filename, "\n"))
          file.remove(filename)
        }
      }
  }
}