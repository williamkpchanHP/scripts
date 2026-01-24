# sort pornpicStarList.js
filename ='C:/Users/william/Desktop/scripts/pornpics/pornpicStarList.js'
src = readLines(filename)
for(i in 2:length(src)-3){
  starnum = gsub("^.*?, " ,"", src[i])
  starnum = gsub("<br>.*" ,"", starnum)
  src[i] = paste0(starnum,src[i])
}
sink(filename)
cat(src, sep="\n")
sink()
