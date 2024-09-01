setwd("C:/Users/william/Desktop/scripts/hotnakedwomen")
tgt = readLines("modelList.txt")
tgtidx = grep('<a href', tgt)
tgt = tgt[tgtidx]
tgt = gsub('<a href="/', "", tgt)
tgt = gsub('".*', '', tgt)

sink("modelList.txt")
cat(tgt, sep="\n")
sink()
