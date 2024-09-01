# encodeLinks

setwd("C:/Users/william/Desktop/scripts/youx")
#setwd("C:/Users/User/Pictures/sexpage")

library(crayon)
 ligSilver <- make_style("#889988")
cat(red("encode Links!\n"))

txtSrc = readLines("youxAllStarsNew.html")
totalLines = length(txtSrc)

txtSrc = gsub("&tag=.*?", '"', txtSrc)
# encode strings

keyvec = c('<div><a href="https://www.youx.xxx/tag/', 'k!1', '.bhcont.com/galleries/', 'k!2', '.youx.xxx/content/', 'k!3', '.youx.xxx/gthumb/', 'k!4', '.youx.xxx/tube/th/', 'k!5', '<a href="http://galleries-pornstar.com/', 'k!6', '<a href="http://goldenbbw.com/', 'k!7', '<a href="http://sexywomeninlingerie.com/', 'k!8', '<a href="http://uniquebondage.com/', 'k!9', '<a href="http://xxxonxxx.com/', 'k!10', '<a href="https://galleries-pornstar.com/', 'k!a', '<a href="https://www.pornalin.com/video/', 'k!b', '<a href="https://www.pornpictureshq.com/galleries/', 'k!c', '<a href="https://www.twpornstars.com/p/', 'k!d', '<a href="https://xxxdessert.com/', 'k!e', '<a href="https://xxxonxxx.com/', 'k!f', '<img src="https://', 'k!g', '_320x_', 'k!h', 'cdn7.youx.xxx/videos/th/', 'k!i', 'cdnpa7.youx.xxx/contents/videos_screenshots/', 'k!j', 'cdnwg7.youx.xxx/', 'k!k', 'cdnxd7', 'k!l', 'galleries/srv2/gthumb/', 'k!m', '\\.jpg"></a>', 'k!n', 'galleries/gthumb/', 'k!o', '<a href="https://www.youx.xxx/videos/', 'k!p','<a href="https://www.youx.xxx/', 'k!q')
keyMat = matrix(keyvec, ncol = 2, byrow = TRUE)

keyMatRows = nrow(keyMat)

for(i in 1:keyMatRows){
  keyCounter = grep(keyMat[i,1], txtSrc)
  cat(keyMat[i,1], " occurences: ", length(keyCounter), "\n")
  txtSrc = gsub(keyMat[i,1], keyMat[i,2], txtSrc)
}

outFilename = "youxAllStarsNew.txt"
sink(outFilename)
  cat(txtSrc, sep="\n")
sink()
shell(outFilename)
cat(red(outFilename, " created!"))
