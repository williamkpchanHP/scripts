# https://www.pichunter.com/sites/all/All_Over_30/214
# https://www.pichunter.com/sites/all/
# https://www.pichunter.com/sites/all/everything/10

Sys.setlocale(category = 'LC_ALL', 'Chinese')
#setwd("C:/Users/User/Pictures/sexpage")
setwd("C:/Users/william/Desktop/scripts/pichunter")

library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")
# https://www.nudexxx.pics/channels/all-over-30/
# ll_channel_names = readLines("All_channel_names.txt") # list of some channel names

# global variables
 all_src_Links = character()
 all_img_Links = character()
 className = ".grid-item a"

# supportive function comes first
collectUrl <- function(url){
    tmp <- tryCatch(
             read_html(url, warn=F), silent = TRUE,
             error = function (e) NULL
           )
    if (is.null(tmp)) {
      cat("\n doesn't exist\n")
      return("<html></html>")
    }else{
      return(tmp)
    }
}

find_included_sites_Url <- function(url){
  pagesource <- collectUrl(url)
  itemList <- html_nodes(pagesource, className)
  itemHref = html_attr(itemList, "href")

}

load_channel_src <- function(pageHeader, titleName, pageTail){
  totalPages = 1000
  for(i in 1:totalPages){
      cat(i, "of", totalPages, "")
        url = paste0(pageHeader, titleName, pageTail, i )

      cat(url, "\n")
      pagesource <- collectUrl(url)
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
    pagesource <- collectUrl(url)

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
   all_img_Links = unique(all_img_Links)
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
    titleName = srcFile[src]

    the_output_Filename = paste0('nudexxx ',titleName, ".html")
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