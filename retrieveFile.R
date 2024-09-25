library(rvest)
library(crayon)
 ligSilver <- make_style("#889988")

# retrieveFile
  retrieveFile <- function(urlAddr){
    cat(yellow("\n",urlAddr,"\n"))
    retryCounter = 1
    while(retryCounter < 5) {
      cat("...try ",retryCounter) 
      retriveFile <- tryCatch(read_html(urlAddr, warn=F, encoding = "UTF-8"), 
                        warning = function(w){
                         cat(silver("code param error "));
                         return(" code param error ")
                        }, 
                        error = function(e) {
                          if(grepl("Error in open.connection", e)){
                            cat(silver(" Error in open.connection "))
                            return("Error in open.connection")
                          }else if(grepl("Error in doc_parse_raw", e)){
                            cat(silver(" Error in doc_parse_raw, "))
                            return(read_html(urlAddr, warn=F))
                          }else{
                            cat(red(" unknown error "))
                            return("unknown error")
                          }
                        }
                     )
      if (grepl("code param error", retriveFile)) {
        cat(red(" Error in connection, try 5 secs later!\n"))
        retryCounter <- retryCounter + 1
        retriveFile = "<html></html>"  # if end of loop this will be returned
      }else if(grepl("Error in open.connection", retriveFile)){
        cat(red("unable to connect! \n"), urlAddr,"\n")
        retryCounter <- retryCounter + 1
        retriveFile = "<html></html>"  # if end of loop this will be returned
        cat(retriveFile)
        # retryCounter = 200  # to jump out of loop
      }else if(grepl("unknown error", retriveFile)){
        retriveFile = "<html></html>"  # if end of loop this will be returned
        retryCounter = 200  # to jump out of loop
      }else{
        cat(green(" \tseems OK! "))
        retryCounter = 200  # to jump out of loop
      }
    }
    cat(green(" loop end retry counts: ", retryCounter, "\n"))
    return(retriveFile)
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
