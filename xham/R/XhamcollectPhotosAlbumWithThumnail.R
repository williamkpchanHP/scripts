# use the workhorse: C:/Users/william/Desktop/scripts/R/retrieveFile.R to collect multiple cabinet photos
# input: url only, will find out number of following links by workhorse
# this is the controller of retrieveFile.R
# usage: mod the urlheader and output file name

setwd("C:/Users/william/Desktop/scripts/R")
library(rvest)
library(crayon)

source("C:/Users/william/Desktop/scripts/R/retrieveFile.R") # the workhorse here
albumHeaderList = c(
"https://xhamster.com/users/joytwosex/photos"
)
exclusionList = c(
"https://xhamster.com/photos/gallery/joytwosex-tribute-to-julie-spiegel-side-by-side-comparison-15812959",
"https://xhamster.com/photos/gallery/joytwosex-hi-guys-15788036",
"https://xhamster.com/photos/gallery/joytwosex-hubby-gives-and-receives-15579424",
"https://xhamster.com/photos/gallery/hairy-joytwosex-playing-with-my-big-cock-15476121",
"https://xhamster.com/photos/gallery/joytwosex-destroying-hubbys-little-ass-15318602",
"https://xhamster.com/photos/gallery/hairy-milf-joytwosex-and-hubby-showing-cocks-14415330",
"https://xhamster.com/photos/gallery/hairy-milf-joytwosex-and-hubby-showing-cocks-14415330",
"https://xhamster.com/photos/gallery/hairy-joytwosex-hubby-and-me-14116577",
"https://xhamster.com/photos/gallery/hairy-joytwosex-and-hubby-playing-with-dildo-14117269",
"https://xhamster.com/photos/gallery/joytwosex-playing-with-husbands-tight-asshole-13586752",
"https://xhamster.com/photos/gallery/joytwosex-husband-big-shaved-cock-13270475",
"https://xhamster.com/photos/gallery/joytwosex-husband-big-shaved-cock-13270475",
"https://xhamster.com/photos/gallery/joytwosex-hubbys-big-shaved-cock-12455292",
"https://xhamster.com/photos/gallery/hairy-mature-wife-toes-in-husband-ass-12171057",
"https://xhamster.com/photos/gallery/fucking-my-hairy-wife-11164890",
"https://xhamster.com/photos/gallery/husband-big-hairy-cock-11037423"
)
# "https://xhamster.com/users/ilovemums/photos"
# "https://xhamster.com/users/brekomerk23/photos",
# "https://xhamster.com/users/samsnead1973/photos",
# "https://xhamster.com/users/kingklausder3/photos",
# "https://xhamster.com/users/hondacvc/photos",
# "https://xhamster.com/users/klausmasterdom/photos",
# "https://xhamster.com/users/bouge2la/photos",
# "https://xhamster.com/users/fullmoonbitch/photos"
# "https://xhamster.com/users/tranlam4545454/photos",
# "https://xhamster.com/users/hockeynut27/photos",
# "https://xhamster.com/users/comejaiba/photos",
# "https://xhamster.com/users/sumofme/photos",
# "https://xhamster.com/users/yor101/photos",
# "https://xhamster.com/users/luckywebsta/photos",
# "https://xhamster.com/users/abbeywantsit/photos",
# "https://xhamster.com/users/delfiglola/photos",
# "https://xhamster.com/users/cowman58/photos",
# "https://xhamster.com/users/pro-boobs/photos",
# "https://xhamster.com/users/zhiglov83x/photos",
# "https://xhamster.com/users/sexysexyfetish/photos"
# "https://xhamster.com/users/vovapost/photos",
# "https://xhamster.com/users/maquiavelo1957/photos",
# "https://xhamster.com/users/iloveolderwomen1980/photos",
# "https://xhamster.com/users/tittenfreak8/photos",
# "https://xhamster.com/users/hotblade6/photos",
# "https://xhamster.com/users/sexdrive65/photos",
# "https://xhamster.com/users/samsnead1973/photos",
# "https://xhamster.com/users/bi_bbwlover/photos",
# "https://xhamster.com/users/luvthematures/photos",
# "https://xhamster.com/users/worshipaandp/photos"
# "https://xhamster.com/users/bertveendam/photos",
# "https://xhamster.com/users/mustertrump/photos",
# "https://xhamster.com/users/petproject/photos",
# "https://xhamster.com/users/candidate/photos",
# "https://xhamster.com/users/cuckynbull/photos",
# "https://xhamster.com/users/mail69/photos",
# "https://xhamster.com/users/phrenny/photos",
# "https://xhamster.com/users/lakebird/photos",
# "https://xhamster.com/users/feebee/photos",
# "https://xhamster.com/users/sheisnovember/photos",
# "https://xhamster.com/users/orlandoguy40/photos"
# "https://xhamster.com/users/katerinapupkin/photos",
# "https://xhamster.com/users/borys666/photos",
# "https://xhamster.com/users/zam_pano/photos",
# "https://xhamster.com/users/txwood/photos",
# "https://xhamster.com/users/99bob/photos",
# "https://xhamster.com/users/fredbirdy/photos",
# "https://xhamster.com/users/ardientes69/photos"
# "https://xhamster.com/users/beetledoc/photos",
# "https://xhamster.com/users/scubadiver66/photos",
# "https://xhamster.com/users/xxlpxx/photos",
# "https://xhamster.com/users/lancemanj/photos",
# "https://xhamster.com/users/chocolatefan/photos",
# "https://xhamster.com/users/20brazui/photos",
# "https://xhamster.com/users/kingbullshorm/photos",
# "https://xhamster.com/users/singermask/photos",
# "https://xhamster.com/users/mhsm44/photos",
# "https://xhamster.com/users/hockeynut27/photos",
# "https://xhamster.com/users/lours24/photos",
# "https://xhamster.com/users/willynilly54/photos",
# "https://xhamster.com/users/bi_man2use/photos",
# "https://xhamster.com/users/housebitch76/photos",
# "https://xhamster.com/users/housebitch76/photos",
# "https://xhamster.com/users/samsnead1973/photos"
# "https://xhamster.com/users/rd1005/photos",
# "https://xhamster.com/users/borys666/photos",
# "https://xhamster.com/users/jumungadong/photos",
# "https://xhamster.com/users/riffraff999/photos",
# "https://xhamster.com/users/lipstickpussy/photos",
# "https://xhamster.com/users/timmuhtom99/photos",
# "https://xhamster.com/users/miclhigh/photos",
# "https://xhamster.com/users/luckywebsta/photos",
# "https://xhamster.com/users/pcortal/photos",
# "https://xhamster.com/users/yourolddroog/photos",
# "https://xhamster.com/users/wifewants9inches/photos",
# "https://xhamster.com/users/lurks99/photos",
# "https://xhamster.com/users/xekekox/photos"


for(allAlbumHeader in albumHeaderList){
    output = gsub("https://xhamster.com/users/", "", allAlbumHeader)
    output = gsub("/photos", "Albums.html", output)
    
    allAlbumList = character()
    allLinkList = character()
    allPhotoList = character()
    allAlbumTitles = character()
    
    collectLinks(allAlbumHeader) # many page links in this user
    for(thelink in allLinkList){ collectAlbumTitle(thelink) } # get all albums links, img and title
    
    htmlTitle = gsub("\\.html", "", output)
    allAlbumTitles = paste0('<div><b>', allAlbumTitles, '</div>')
    allAlbumTitles = gsub('<br><a ', '</b><br><a ', allAlbumTitles)
    allAlbumTitles = gsub('\\n', '', allAlbumTitles)
    
    sink(output)
      cat('<base target="_blank"><html><head><title>',htmlTitle,'</title>\n', sep="")
      cat('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">\n')
      cat('<meta name="viewport" content="width=device-width, initial-scale=1" />\n')
      cat('<link rel="stylesheet" href="https://williamkpchan.github.io/maincss.css">\n')
      cat('<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.js"></script>\n')
      cat('<script src="https://williamkpchan.github.io/lazyload.min.js"></script>\n')
      cat('<script type="text/javascript" src="https://williamkpchan.github.io/mainscript.js"></script>\n')
      cat('<script src="https://williamkpchan.github.io/commonfunctions.js"></script>\n')
      cat('<script src="https://d3js.org/d3.v4.min.js"></script>\n')
      cat('<script>\n')
      cat('  var showTopicNumber = true;\n')
      cat('  var topicEnd = "<span class=\'red\'>, </span>";\n')
      cat('  var bookid = "',htmlTitle,'"\n', sep="")
      cat('  var markerName = "b"\n')
      cat('</script>\n')
      cat('<style>\n')
      cat('body{width:100%;margin-left: 0%; font-size:22px;}\n')
      cat('h1, h2 {color: gold;}\n')
      cat('strong {color: orange;}\n')
      cat('pre{width:100%;}\n')
      cat('div{display: inline-block; width:32%;}\n')
      cat('</style></head><body onkeypress="chkKey()"><center>\n')
    
      cat("Total Titles: ",length(allAlbumTitles), "<br><br>\n")
      cat('<div id="toc"></div><br>\n')
      cat('<br><br>')
    
      for(element in allAlbumTitles){
        cat(element, sep="\n")
        cat("\n")
      }
      cat('<script src="https://williamkpchan.github.io/LibDocs/readbook.js"></script>\n')
      cat('<script>var lazyLoadInstance= new LazyLoad({elements_selector:".lazy"});$("img").click(function() { window.open(this.src)})</script>\n')
      cat('</pre></body></html>\n')
    sink()
    cat(red("Job completed!\n"))
    cat(yellow("output file is: ", output, "\n"))
    shell(output)
}