# find all imgs
# find all _frame1.jpg

# convert from
# https://64.media.tumblr.com/tumblr_st3oxa3BxH1azpm5m_frame1.jpg
# to 
# https://va.media.tumblr.com/tumblr_st3oxa3BxH1azpm5m.mp4
# mod to
# '<video controls loop><source src="https://va.media.tumblr.com/tumblr_sk2l77TdQu1aaoc2q.mp4" type="video/mp4" autoplay></source></video>',


workpath = "C:/Users/william/Desktop/scripts/tumbler"
setwd(workpath)

cat("\nopen tumble archive, open devtools, copy html contents,\npaste into tumblrTextFile.txt and go ahead!!\n")
library(rvest)
inputFile = "tumblrTextFile.txt"
html <- read_html(inputFile)
image_urls <- html %>%
  html_nodes("img") %>%
  html_attr("srcset") %>%
  na.omit() %>%
  unique()

cat("\nstr(image_urls):\n")
cat(str(image_urls), "\n")

# find all _frame1.jpg
videoIdx = grep("_frame1.jpg", image_urls)
videoList = image_urls[videoIdx]
cat("\nstr(videoList):\n")
cat(str(videoList), "\n")

# convert from
# https://64.media.tumblr.com/tumblr_st3oxa3BxH1azpm5m_frame1.jpg
# to 
# https://va.media.tumblr.com/tumblr_st3oxa3BxH1azpm5m.mp4
videoList = gsub("64.media","va.media",videoList)
videoList = gsub("_frame1.jpg.*",".mp4",videoList)
head(videoList)

# mod to
# '<video controls loop><source src="https://va.media.tumblr.com/tumblr_sk2l77TdQu1aaoc2q.mp4" type="video/mp4" autoplay></source></video>',
videoList = paste0('\'<video controls loop><source src="', videoList, '" type="video/mp4" autoplay></source></video>\',')
# videoList conpleted

# handle images here
image_urls = gsub(".*?w, ", "", image_urls)
image_urls = gsub(" .*", "", image_urls)
image_urls = paste0('\'<img src="', image_urls)
image_urls = paste0(image_urls, '">\',')
# handle images completed

theFilename = "TumblerVideos.js"
TumblerFile = readLines(theFilename)
lastLine = length(TumblerFile)-1
TumblerFile = TumblerFile[-(lastLine:length(TumblerFile))]
TumblerFile = c(TumblerFile, videoList, image_urls, "]", "TumblerVideos = imgList")

sink(theFilename)
  cat(TumblerFile, sep="\n")
sink()

cat(red("\n",workpath, "/",theFilename, "Updated!\n"))
