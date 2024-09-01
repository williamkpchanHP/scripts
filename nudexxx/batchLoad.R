# all-over-30, karups-older-women, scoreland
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#setwd("C:/Users/User/Pictures/sexpage")
setwd("C:/Users/william/Desktop/scripts/nudexxx")

# https://www.nudexxx.pics/channels/all-over-30/
# ll_channel_names = readLines("All_channel_names.txt") # list of some channel names

# global variables
 all_src_Links = character()
 all_img_Links = character()

# supportive function comes first
source("../retrieveFile.R")

load_channel_src <- function(pageHeader, titleName, pageTail){
  totalPages = 1000
  for(i in 1:totalPages){
      cat(i, "of", totalPages, "")
        url = paste0(pageHeader, titleName, pageTail, i )

      cat(url, "\n")
      pagesource <- retrieveFile(url)
      itemList <- html_nodes(pagesource, className)
      itemHref = html_attr(itemList, "href")
      itemHref = gsub("^.*?url=", "", itemHref)

      result = itemHref
     # cat("sample: ", result[1], "\n\n")
     cat(yellow("length(result): ",length(result), "  "))
     totalResults = totalResults + length(result)
     cat(blue("totalResults: ", totalResults, "  "))

     all_src_Links <<- c(all_src_Links, result)
     cat(white("all_src_Links: ", length(all_src_Links), "\n\n"))
     if(length(result)<30) {break}  # channel break
  }
  cat(yellow("\n", titleName, " load_channel_src complete\n"))
}


# main loop
cat("\n")
    cat(red("\n\nread list from batchJobList.txt\n"))
    srcFile = readLines("batchJobList.txt") # list of some channel names
    typeName ="4"
    totalsrcPages = length(srcFile)

    templateHead = readLines("templateLongHeadNudexxx.txt")
    templateTail = readLines("templateLongTailNudexxx.txt")

for(src in 1:totalsrcPages){ # collect target urls from channel
    # prepare data for supportive functions 
    # https://www.nudexxx.pics/load.php?&pornstar=andi-james
    # https://www.nudexxx.pics/load.php?&channel=femjoy
    # https://www.nudexxx.pics/load.php?&categories=bdsm
    pageHeader = "https://www.nudexxx.pics/load.php?&"
    pageTail="&p="
    className = ".item a"
    titleName = srcFile[src]

    the_output_Filename = paste0('nudexxx ',titleName, ".html")
    the_output_Filename = gsub("/", "-", the_output_Filename)
    all_img_urls = character()
    wholePage = character()
    totalResults = 0
    cat(red("\n", src, "of",totalsrcPages), yellow("title Name: ",titleName, "\n\n"))

    # collect urls according to channel name
    load_channel_src(pageHeader, titleName, pageTail)
    all_channel_urls = all_src_Links # this is reslts from load_channel_src
    all_channel_urls = sort(all_channel_urls)

    sink("all_channel_urls.txt") # save long temp results 
      cat(all_channel_urls, sep="\n")
    sink()

    # provide urls to img collect function
    load_all_channel_imgs(all_channel_urls)
    all_img_urls = all_img_Links # this is results from load_all_channel_imgs

    # save output file
    save_output(all_img_urls, the_output_Filename)

    # continue to next channel
}
# sink("All_channel_names.txt")
#   cat(All_channel_names, sep="\n")
# sink()