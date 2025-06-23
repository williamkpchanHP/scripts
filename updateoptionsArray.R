setwd("C:/Users/william/Desktop/scripts/")
optionsArrayName = "optionsArray.js"
optionsArray = readLines(optionsArrayName)
optionsArray[length(optionsArray)] = paste0("'", fileName, "',\n", "]")
sink(optionsArrayName)
 cat(optionsArray, sep="\n")
sink()
cat(yellow("\n\n",fileName,"- optionsArray.js updated!\n\n\n"))
