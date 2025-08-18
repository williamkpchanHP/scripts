#Sys.setlocale(category = 'LC_ALL', 'Chinese')	# this must be added to script to show chinese
# https://www.99csw.com/index.php

setwd("C:/R programs/Extracts by R")

library(rvest)
#https://www.99csw.com/book/3783/129158.htm
pageHeader = "http://open-lit.com/"
pageTail = ""
className = "#right_Article"
navClassName = ""

addr = c(
"bid=314&id=readme",
"bid=314&id=14555",
"bid=314&id=14556",
"bid=314&id=14557",
"bid=314&id=14558",
"bid=314&id=14559",
"bid=314&id=14560",
"bid=314&id=14561",
"bid=314&id=14562",
"bid=314&id=14563",
"bid=314&id=14564",
"bid=314&id=14565",
"bid=314&id=14566",
"bid=314&id=14567",
"bid=314&id=14568",
"bid=314&id=14569",
"bid=314&id=14570",
"bid=314&id=14571",
"bid=314&id=14572",
"bid=314&id=14573",
"bid=314&id=14574",
"bid=314&id=14575",
"bid=314&id=14576",
"bid=314&id=14577",
"bid=314&id=14578",
"bid=314&id=14579",
"bid=314&id=14580",
"bid=314&id=14581",
"bid=314&id=14582",
"bid=314&id=14583",
"bid=314&id=14584",
"bid=314&id=14585",
"bid=314&id=14586",
"bid=314&id=14587",
"bid=314&id=14588",
"bid=314&id=14589",
"bid=314&id=14590",
"bid=314&id=14591",
"bid=314&id=14592",
"bid=314&id=14593",
"bid=314&id=14594",
"bid=314&id=14595",
"bid=314&id=14596",
"bid=314&id=14597",
"bid=314&id=14598",
"bid=314&id=14599",
"bid=314&id=14600",
"bid=314&id=14601",
"bid=314&id=14602",
"bid=314&id=14603",
"bid=314&id=14604",
"bid=314&id=14605",
"bid=314&id=14606",
"bid=314&id=14607",
"bid=314&id=14608",
"bid=314&id=14609",
"bid=314&id=14610",
"bid=314&id=14611",
"bid=314&id=14612",
"bid=314&id=14613",
"bid=314&id=14614",
"bid=314&id=14615",
"bid=314&id=14616",
"bid=314&id=14617",
"bid=314&id=14618",
"bid=314&id=14619",
"bid=314&id=14620",
"bid=314&id=14621",
"bid=314&id=14622",
"bid=314&id=14623",
"bid=314&id=14624",
"bid=314&id=14625",
"bid=314&id=14626",
"bid=314&id=14627",
"bid=314&id=14628",
"bid=314&id=14629",
"bid=314&id=14630",
"bid=314&id=14631",
"bid=314&id=14632",
"bid=314&id=14633",
"bid=314&id=14634",
"bid=314&id=14635",
"bid=314&id=14636",
"bid=314&id=14637",
"bid=314&id=14638",
"bid=314&id=14639",
"bid=314&id=14640",
"bid=314&id=14641",
"bid=314&id=14642",
"bid=314&id=14643",
"bid=314&id=14644",
"bid=314&id=14645",
"bid=314&id=14646",
"bid=314&id=14647",
"bid=314&id=14648",
"bid=314&id=14649",
"bid=314&id=14650",
"bid=314&id=14651",
"bid=314&id=14652",
"bid=314&id=14653",
"bid=314&id=14654",
"bid=314&id=14655",
"bid=314&id=14656",
"bid=314&id=14657",
"bid=314&id=14658",
"bid=314&id=14659",
"bid=314&id=14660",
"bid=314&id=14661",
"bid=314&id=14662",
"bid=314&id=14663",
"bid=314&id=14664",
"bid=314&id=14665",
"bid=314&id=14666",
"bid=314&id=14667",
"bid=314&id=14668",
"bid=314&id=14669",
"bid=314&id=14670",
"bid=314&id=14671",
"bid=314&id=14672",
"bid=314&id=14673",
"bid=314&id=14674",
"bid=314&id=14675",
"bid=314&id=14676",
"bid=314&id=14677",
"bid=314&id=14678",
"bid=314&id=14679",
"bid=314&id=14680",
"bid=314&id=14681",
"bid=314&id=14682",
"bid=314&id=14683",
"bid=314&id=14684",
"bid=314&id=14685",
"bid=314&id=14686",
"bid=314&id=14687",
"bid=314&id=14688",
"bid=314&id=14689",
"bid=314&id=14690",
"bid=314&id=14691",
"bid=314&id=14692",
"bid=314&id=14693",
"bid=314&id=14694",
"bid=314&id=14695",
"bid=314&id=14696",
"bid=314&id=14697",
"bid=314&id=14698",
"bid=314&id=14699",
"bid=314&id=14700",
"bid=314&id=14701",
"bid=314&id=14702",
"bid=314&id=14703",
"bid=314&id=14704",
"bid=314&id=14705",
"bid=314&id=14706",
"bid=314&id=14707",
"bid=314&id=14708",
"bid=314&id=14709",
"bid=314&id=14710",
"bid=314&id=14711",
"bid=314&id=14712",
"bid=314&id=14713",
"bid=314&id=14714",
"bid=314&id=14715",
"bid=314&id=14716",
"bid=314&id=14717",
"bid=314&id=14718",
"bid=314&id=14719",
"bid=314&id=14720",
"bid=314&id=14721",
"bid=314&id=14722",
"bid=314&id=14723",
"bid=314&id=14724",
"bid=314&id=14725",
"bid=314&id=14726",
"bid=314&id=14727",
"bid=314&id=14728",
"bid=314&id=14729",
"bid=314&id=14730",
"bid=314&id=14731",
"bid=314&id=14732",
"bid=314&id=14733",
"bid=314&id=14734",
"bid=314&id=14735",
"bid=314&id=14736",
"bid=314&id=14737",
"bid=314&id=14738",
"bid=314&id=14739",
"bid=314&id=14740",
"bid=314&id=14741",
"bid=314&id=14742",
"bid=314&id=14743",
"bid=314&id=14744",
"bid=314&id=14745",
"bid=314&id=14746"
)

theFilename = "jiuwei.html"

wholePage = character()
lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")

counter = 0
wholeList = character()
for(i in addr){
 counter = counter +1
 url = paste0(pageHeader, i, pageTail)
 cat(counter, "of",lentocpage, url, "\n\n")

 pagesource <- read_html(url, encoding="UTF-8")

 navItems = ""
 navItems = html_nodes(pagesource, navClassName)
 navItems = as.character(navItems[1])
 if(length(navItems != 0)){
#   totalPages = gsub("^.*?共","",navItems)
#   totalPages = as.numeric(gsub("页.*?$","",totalPages))
 }else{
  totalPages = 1
 }
 cat(red("totalPages: ", totalPages, "\n"))

 blockTitle = html_nodes(pagesource, "h1")
 blockTitle = paste0("<h2>", html_text(blockTitle, "h1"), "</h2>")
 wholeList = c(wholeList, blockTitle)

 itemList <- html_nodes(pagesource, className)
 itemList = as.character(itemList)

 # clean up
 itemList = gsub(' class=".*?"', '', itemList)
 wholeList = c(wholeList, itemList)
 cat(yellow("item numbers: ", length(itemList), " wholeList number: ", length(wholeList), "\n"))

 if(totalPages > 1){
    for(i in 2:totalPages){
      otherURL = paste0(url, "page",i, "/")
      cat("otherURL: ", otherURL)
      pagesource <- read_html(otherURL, encoding="UTF-8")
      itemList <- html_nodes(pagesource, className)
      itemList = as.character(itemList)
      # clean up
      itemList = gsub(' class=".*?"', '', itemList)
      wholeList = c(wholeList, itemList)
      cat(yellow("item numbers: ", length(itemList), " wholeList number: ", length(wholeList), "\n"))
    }
 }

}

sink(theFilename)
  cat(wholeList, sep="\n")
sink()
  #cat(itemList, sep="\n")

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("loop time: ",LoopTime,"\n")
