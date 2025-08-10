# procedures:
# save the source string in text file: imgSrcfile.txt
# use r to process file

# strsplit the img tags
# extract img lines
# stripes > and after

# strsplit by w,
# extract last line

# note to extracy video, look for "791348874533076992" and the link with it
rm(list = ls())

workpath = "C:/Users/william/Desktop/scripts/tumbler"
setwd(workpath)
cat("\n\n\n")
cat("\nopen tumble archive, open devtools, copy source string contents,\npaste into srcfile.txt and go ahead!!\n")
inputFile = "imgSrcfile.txt"
srcFile = readline("enter src file name without extension, press enter for default: imgSrcfile.txt : ")

if(srcFile != ""){
  inputFile = paste0(srcFile, ".txt")
}
cat(yellow("inputFile: ",inputFile, "\n"))

txtfile <- readLines(inputFile)
cat(yellow(inputFile, " original line numbers: ", length(txtfile),"\n"))

txtfile <- unlist(strsplit(txtfile, "<img"))
cat(yellow(inputFile, " after split line numbers: ", length(txtfile),"\n"))

imgIdx <- grep("srcset", txtfile)
txtfile = txtfile[imgIdx]
cat(yellow(inputFile, " after grep srcset line numbers: ", length(txtfile),"\n"))

wholePage = character()
for(i in 1:length(txtfile)){
  imgline = txtfile[i]
  imgline = gsub('">.*', '', imgline)

  imgURLs = unlist(strsplit(imgline, "w,"))
  lastImg = imgURLs[length(imgURLs)]
  #lastImg = gsub('^.*? https', 'https', lastImg)  # remove first space character
  lastImg = sub(".*?(https.*)", "\\1", lastImg)  # remove first space character

  lastImg = gsub(' .*', '">\',', lastImg)  # remove space character and after
#cat(lastImg, "\n")
  lastImg = gsub('https', '\'<img src="https', lastImg)  # remove first space character

  wholePage = c(wholePage, lastImg)
}

cat("\nlength of wholePage: ", length(wholePage))

outFilename = readline("enter output js filename without extension: ")

jsheader = paste0("var ", "tumblr_", outFilename, " = [")
jstai11 = "];"
jstai12 = "lineHeader = '<img src=\"https://64.media.tumblr.com/'"
jstai13 = "lineTail = '.jpg\">'"

#wholePage = gsub("https://64.media.tumblr.com/", "", wholePage)

outFilename = paste0("tumblr_", outFilename, ".js")
sink(outFilename)
  cat(jsheader, sep="\n")
  cat(wholePage, sep="\n")
  cat(jstai11, sep="\n")
  cat(jstai12, sep="\n")
  cat(jstai13, sep="\n")
sink()

cat(red("\n",workpath, "/",outFilename, "Updated!\n"))

fileName = outFilename
source("C:/Users/william/Desktop/scripts/updateoptionsArray.R")
