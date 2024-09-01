# all-over-30, karups-older-women, scoreland
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#setwd("C:/Users/User/Pictures/sexpage")
setwd("C:/Users/william/Desktop/scripts/nudexxx")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")
# https://www.nudexxx.pics/channels/all-over-30/
# ll_channel_names = readLines("All_channel_names.txt") # list of some channel names

# global variables
 all_src_Links = character()
 all_img_Links = character()

# supportive function comes first
# retrieveFile
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

load_all_channel_imgs <- function(url_vector){
    totalPages = length(url_vector)
    totalimg_Results = 0
    cat(green("\n\n", titleName, " load all channel imgs\n\n"), blue("total url_vector: ", totalPages, "\n\n"))

  for(i in 1:totalPages){
    cat(i, "of", totalPages, "")
      url = url_vector[i]
      url = gsub('\\.html.*', '', url)
      url = gsub('^.*?(\\d{5})', "\\1", url)  # v.imp!!!
      url = paste0("https://www.nudexxx.pics/gallery.php?id=", url)

    cat("imgurl: ",url, "\n")
    pagesource <- retrieveFile(url)

    # channel_name <- html_nodes(pagesource, ".tlinks a")
    # channel_name_Idx = grep("channels", channel_name)
    # if(length(channel_name_Idx)>0){
    #   channel_name = channel_name[channel_name_Idx]
    #   channel_name = html_attr(channel_name)
    #   cat("\nchannel_name: ", orange(channel_name))
    #   All_channel_names <<- unique(c(All_channel_names, channel_name))
    #   cat(" channel name total number: ", length(All_channel_names), "\n")
    # }

    img_itemList <- html_nodes(pagesource, className)
    img_itemHref = html_attr(img_itemList, "href")

      img_itemHrefIdx = grep("full", img_itemHref)
      img_itemHref = img_itemHref[img_itemHrefIdx]

      img_result = gsub('https://cdn.nudexxx.pics/content/galleries/|-full.jpg', '', img_itemHref)
      img_result = paste0("'", img_result)
      img_result = paste0(img_result, "',")

   cat(yellow("length(img_result): ",length(img_result), "  "))
   totalimg_Results = totalimg_Results + length(img_result)
   cat(blue("totalimg_Results: ", totalimg_Results, "  "))

   all_img_Links <<- c(all_img_Links, img_result)
   all_img_Links <<- unique(all_img_Links)
   cat(white("all_img_Links: ", length(all_img_Links), "\n"))
  }
  cat(green("\n",titleName, " load_all_channel_imgs\n"))
}

save_output <- function(all_img_urls, the_output_Filename){
   templateHead = gsub("nudexxx brazzers", titleName, templateHead)
   templateTail = gsub("nudexxx brazzers", titleName, templateTail)

   cat(red("length(all_img_urls) before unique: ",length(all_img_urls), "\n"))
   all_img_urls = unique(all_img_urls)
   cat(green("length(all_img_urls) after unique: ",length(all_img_urls), "\n"))
   all_img_urls = sort(all_img_urls)

   showRangeIdx = grep("showRange", templateTail)
   if(length(all_img_urls)<80){
     templateTail[showRangeIdx] = paste0("showRange = ", length(all_img_urls))
   }else{
     templateTail[showRangeIdx] = "showRange = 80"
   }


   setwd("C:/Users/william/Desktop/scripts/nudexxx")

   sink(the_output_Filename)
   cat(templateHead, sep="\n")
   cat(all_img_urls, sep="\n")
   cat(templateTail, sep="\n")
   sink()
   cat("\n", the_output_Filename, " created!\n\n\n\n\n\n\n")
}

# main loop
cat("\n")
    cat(red("\n\nread list from all_channel_urls.txt\n"))
    srcFile = readLines("all_channel_urls.txt") # list of some channel names

    totalsrcPages = length(srcFile)
    titleName = readline("enter project title: ")
    className = ".item a"

    templateHead = readLines("templateLongHeadNudexxx.txt")
    templateTail = readLines("templateLongTailNudexxx.txt")

    pageHeader = "https://www.nudexxx.pics/load.php?&"
    pageTail="&p="

    the_output_Filename = paste0('nudexxx ',titleName, ".html")
    the_output_Filename = gsub('/','-',the_output_Filename)

    # provide urls to img collect function
    load_all_channel_imgs(srcFile)
    # all_img_Links  is results from load_all_channel_imgs

    # save output file
    save_output(all_img_Links, the_output_Filename)

