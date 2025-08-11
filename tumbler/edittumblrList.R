workpath = "C:/Users/william/Desktop/scripts/tumbler"
setwd(workpath)
inputFile = "tumblrListNew.js"
txtfile <- readLines(inputFile)
txtfile = paste0("'<img src=\"",txtfile)
txtfile = paste0(txtfile, '">\',')
sink("tumblrListNew.js")
 cat(txtfile, sep="\n")
sink()
