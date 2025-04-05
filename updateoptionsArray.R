setwd("C:/Users/william/Desktop/scripts/")
optionsArray = readLines("optionsArray.js")
optionsArray[length(optionsArray)] = paste0("'", fileName, "',\n", "]")
cat(yellow("optionsArray.js updated!\n"))
