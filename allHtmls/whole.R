
dtr = "C:/Users/william/Desktop/scripts/allHtmls"
setwd(dtr)

toc = readLines("list.txt")
for(i in toc){
cat(". ")
  content = readLines(i)
  content = gsub("\\\\/", "/", content)
  idx = grep("\\/", content)
  sink(i)
   cat(content, sep="\n")
  sink()
}

