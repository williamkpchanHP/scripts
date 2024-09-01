# collect Pinterest images with keyword

setwd("C:/Users/william/Desktop/scripts/allHtmls")
#setwd("C:/Users/User/Pictures/sexpage")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")
cat(red("Scrape images!\n"))
cat("xxxdessert.com|xxxonxxx.com|girlsofdesire.org|youx.xxx|pornpictureshq|babes.plus}photosdefillesporno|maturepornhere\n")

url = "https://www.youx.xxx/alsscan/petite-teen-fucking-young/"
url <- readline(prompt="enter url:")
className = "noname"

youxIdx = grep("youx.xxx", url)
if(length(youxIdx)>0){
  className = ".thumb__img"
  removeTxt = "_300x_|_320x_|_640x_"
  replaceTxt = "gthumb"
  putinTxt = "content"
}

xxxdessertIdx = grep("xxxdessert.com", url)
if(length(xxxdessertIdx)>0){
  className = ".gallery-preview a, .gallery-thumb"
  removeTxt = "_300x_"
  replaceTxt = "gthumb"
  putinTxt = "content"
}

xxxonxxxIdx = grep("xxxonxxx.com", url)
if(length(xxxonxxxIdx)>0){
  className = ".one-thumb a"
  #cat(red("className: ", className))
  removeTxt = "_300x_"
  replaceTxt = "gthumb"
  putinTxt = "content"
}

girlsofdesireIdx = grep("girlsofdesire.org", url)
if(length(girlsofdesireIdx)>0){
  className = "td.vtop a"
  removeTxt = "tn_"
  replaceTxt = "gthumb"
  putinTxt = "content"
}

pornpictureshqIdx = grep("pornpictureshq.com", url)
if(length(pornpictureshqIdx)>0){
  className = "img"
  removeTxt = "_300x_|_320x_|_640x_"
  replaceTxt = "gthumb"
  putinTxt = "content"
}

babesIdx = grep("babes.plus", url)
if(length(babesIdx)>0){
  className = '.pics a'
  removeTxt = 'hd-'
  replaceTxt = '^/'
  putinTxt = "https://babes.plus/"
}

maturepornhereIdx = grep("maturepornhere.com", url)
if(length(maturepornhereIdx)>0){
  className = '.gallerythumb'
  removeTxt = 'hd-'
  replaceTxt = 'thumbs'
  putinTxt = "large"
}

photosdefillIdx = grep("photosdefillesporno", url)
if(length(photosdefillIdx)>0){
  className = '.highslide img'
  removeTxt = ''
  replaceTxt = '/uploads'
  putinTxt = "https://photosdefillesporno.com/uploads"
}

thepage <- read_html(url)
copythepage = as.character(thepage)
#writeClipboard(copythepage)
# Extract the image URLs using CSS selectors or XPath:
itemList <- thepage %>% html_nodes(className)

if( substr(itemList[1], start = 1, stop = 4) == "<img" ){
  if(length(grep("data-src", itemList[1])>0)){
    imgsrc = html_attr(itemList, "data-src")
  }else(
    imgsrc = html_attr(itemList, "src")
  )
}else{
  imgsrc = html_attr(itemList, "img")
  images = html_nodes(itemList, "img")
  imgsrc = html_attr(images, "src")
}
imgsrc = gsub(removeTxt, "", imgsrc)
imgsrc = gsub(replaceTxt, putinTxt, imgsrc)
if(substr(imgsrc[1], start = 1, stop = 2) == "//"){
  imgsrc = paste0("https:", imgsrc)
}

imgsrc = paste0('<img src="', imgsrc, '">')
cat(yellow("Total imgs: "), length(itemList), " total imgsrc: ", length(imgsrc), "\n")

outFilename = "temp.html"
sink(outFilename)
  cat(imgsrc, sep="\n")
sink()
shell(outFilename)
