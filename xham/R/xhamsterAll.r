# https://xhamster.com/22197
# video-thumb__image-container thumb-image-container

# chop from top to
# thumb-list thumb-list--sidebar thumb-list--promoted-video
# chop from pager-section to end

setwd("D:/Dropbox/MyDocs/R misc Jobs/webscraping/Text/programs/projects/xhamster")
totalpages = 22197
pageHeader="https://xhamster.com/"

pageHead = "thumb-list thumb-list--sidebar thumb-list--promoted-video"
pageTail = "pager-section"

filename = "xhamsterP4.html"
theWholepage = ""
for (page in 19972:totalpages){
    cat(" ", page)
    thepage=readLines(paste0(pageHeader,page))
    headlinenum=grep(pageHead, thepage)  # chop head
    thepage=thepage[-(1:headlinenum)]

    taillinenum=grep(pageTail, thepage)  # chop tail
    thepage=thepage[-(taillinenum:length(thepage))]
    theWholepage = c(theWholepage , thepage)
}
sink(filename)
cat(theWholepage, sep="\n")
sink()

#======