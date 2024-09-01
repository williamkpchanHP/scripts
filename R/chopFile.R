# chop file into many block files

library(crayon)
cat(yellow(format(Sys.time(), "%H:%M:%OSs"),"\n"))
library(rvest)

setwd('C:/Users/william/Desktop/scripts/R/')

htmlHeader = readLines("htmlHeader.html", warn = F)
htmlTail = readLines("htmlTail.html", warn = F)

#outDirStr = "D:/Dropbox/MyDocs/R misc Jobs/webscraping/Text/programs/pohub/scripts"
#setwd(outDirStr)

dirStr = "C:/Users/william/Desktop/scripts/allHtmls"
setwd(dirStr)

cat(red("\n\n\nTo chop big file to small files!\n\n"))
dataFile = readLines(readline(prompt="enter data filename: "), warn = F)
outFile = readline(prompt="enter output filename without extension: ")
outputPageNum = readline(prompt="enter number of pages to output: ")
outputPageNum = as.numeric(outputPageNum)

dataLength = length(dataFile)
blockSize = dataLength %/% outputPageNum

for(i in 0:(outputPageNum-1)){
   if(i != (outputPageNum-1)){
     block = dataFile[(i*blockSize+1):((i+1)*blockSize)]
   }else{
     block = dataFile[(i*blockSize+1):dataLength]
   }
     outfileName = paste0(outFile,i,".html")
# debug code to check details
#cat("\n",i, (i*blockSize+1), ((i+1)*blockSize), length(block))
	sink(outfileName)
      cat('<base target="_blank"><html><head><title>',paste0(outFile,i),'</title>\n', sep="")
      cat('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">\n')
      cat('<meta name="viewport" content="width=device-width, initial-scale=1" />\n')
      cat('<link rel="stylesheet" href="https://williamkpchan.github.io/maincss.css">\n')
      cat('<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.js"></script>\n')
      cat('<script src="https://williamkpchan.github.io/lazyload.min.js"></script>\n')
      cat('<script type="text/javascript" src="https://williamkpchan.github.io/mainscript.js"></script>\n')
      cat('<script src="https://williamkpchan.github.io/commonfunctions.js"></script>\n')
      cat('<script src="https://d3js.org/d3.v4.min.js"></script>\n')
      cat('<script>\n')
      cat('  var showTopicNumber = false;\n')
      cat('  var topicEnd = "";\n')
      cat('  var bookid = "',paste0(outFile,i),'"\n', sep="")
      cat('  var markerName = "img"\n')
      cat('</script>\n')
      cat('<style>\n')
      cat('body{width:100%;margin-left: 0%;cursor: none; font-size:22px;}\n')
      cat('h1, h2 {color: gold;}\n')
      cat('strong {color: orange;}\n')
      cat('pre{width:100%;}\n')
      cat('div{display: inline-block; width:32%;}\n')
      cat('</style></head><body onkeypress="chkKey()"><center>\n')
    
      cat("Total Titles: ",length(block), "<br><br>\n")
      cat('<div id="toc"></div><br>\n')
      cat('<pre><center><br><br>')

	cat(block, sep="\n")
	cat(htmlTail, sep="\n")
	sink()
     cat(red("\n",outfileName, "completed!"))
}

cat(red("\n\nFiles created located in ", dirStr, "\n\n"))