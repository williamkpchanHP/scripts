# this download cannot download full page and reason unknown

# this must be added to setting chinese
Sys.setlocale(category = 'LC_ALL', 'Chinese')
#Sys.setlocale(, 'English')  

#options("encoding" = "native.enc")
#options("encoding" = "UTF-8")
setwd("C:/Users/william/Desktop/scripts")

#library(audio)
library(rvest)

pageHeader="http://6mature9.com/galleries/"
pageTail=""

wholePage = character()
theFilename = "6mature9.html"
# "list",

# remember to remove &#9;
#addr = 1:20
addr = c(
"http://6mature9.com/galleries/all30/2021/11/MBGXaQx9/",
"http://6mature9.com/galleries/all30/2022/01/vMiA4mRv/",
"http://6mature9.com/galleries/all30/2022/03/86CsCMbo/",
"http://6mature9.com/galleries/all30/2022/03/mKct7wrX/",
"http://6mature9.com/galleries/all30/2022/05/bV4h2BMD/",
"http://6mature9.com/galleries/all30/2022/05/KBr79JxJ/",
"http://6mature9.com/galleries/all30/2022/06/7kJq2maE/",
"http://6mature9.com/galleries/all30/2022/06/oY58YLd5/",
"http://6mature9.com/galleries/all30/2022/06/SBTi9tZf/",
"http://6mature9.com/galleries/all30/2022/06/TUS3T6iL/",
"http://6mature9.com/galleries/all30/2022/06/Uo62LXEz/",
"http://6mature9.com/galleries/all30/2022/07/ekD3FUWU/",
"http://6mature9.com/galleries/all30/2022/08/5DsHUbj2/",
"http://6mature9.com/galleries/all30/2022/08/bha9iA8J/",
"http://6mature9.com/galleries/all30/2022/08/ghHf5DjA/",
"http://6mature9.com/galleries/all30/2022/08/i6tMDnFa/",
"http://6mature9.com/galleries/anil/2022/05/tNvZ9HhA/",
"http://6mature9.com/galleries/anil/2022/07/52Y3qyWS/",
"http://6mature9.com/galleries/anil/2022/07/n5F2NboQ/",
"http://6mature9.com/galleries/anil/2022/08/3S8divmK/",
"http://6mature9.com/galleries/anil/2022/08/JPgFE99k/",
"http://6mature9.com/galleries/atkaj/2021/11/Riqu73Fp/",
"http://6mature9.com/galleries/atkaj/2022/07/J7Fho9qt/",
"http://6mature9.com/galleries/atkaj/2022/07/jXTpDA8q/",
"http://6mature9.com/galleries/atkaj/2022/08/JiGo7BUG/",
"http://6mature9.com/galleries/atkaj/2022/08/KD4HRewD/",
"http://6mature9.com/galleries/atkh/2022/08/8XBr4eST/",
"http://6mature9.com/galleries/atkh/2022/08/gaKxM3PC/",
"http://6mature9.com/galleries/ftvm/2022/03/GuzJ4Fb/",
"http://6mature9.com/galleries/m40/2022/04/YTSq5Eku/",
"http://6mature9.com/galleries/m40/2022/06/cgZpg3K2/",
"http://6mature9.com/galleries/m40/2022/08/hFB5KmL/",
"http://6mature9.com/galleries/m50/2022/03/PWo6EDMt/",
"http://6mature9.com/galleries/m50/2022/07/6Rj4sR4u/",
"http://6mature9.com/galleries/m60/2021/08/pQMbM8Ne/",
"http://6mature9.com/galleries/m60/2021/10/G3rCRLMX/",
"http://6mature9.com/galleries/m60/2022/03/6WnEj93x/",
"http://6mature9.com/galleries/m60/2022/08/Z5GTNjTj/",
"http://6mature9.com/galleries/mb/2022/05/p5q558RC/",
"http://6mature9.com/galleries/mb/2022/05/w8UZ3Lxc/",
"http://6mature9.com/galleries/mb/2022/07/V5jsWW6z/",
"http://6mature9.com/galleries/mb/2022/08/Q8dmCh2q/",
"http://6mature9.com/galleries/mnl/2022/01/qWHc8BK9/",
"http://6mature9.com/galleries/mnl/2022/02/BZTKP8j2/",
"http://6mature9.com/galleries/mnl/2022/03/nNeaq6Rx/",
"http://6mature9.com/galleries/mnl/2022/03/okf54FiP/",
"http://6mature9.com/galleries/mnl/2022/04/b4j9QQ43/",
"http://6mature9.com/galleries/mnl/2022/04/xynbMFr4/",
"http://6mature9.com/galleries/mnl/2022/05/o3DqGEnQ/",
"http://6mature9.com/galleries/mnl/2022/05/r63FJCvG/",
"http://6mature9.com/galleries/mnl/2022/07/89UXrHEY/",
"http://6mature9.com/galleries/mnl/2022/07/BS3JMw42/",
"http://6mature9.com/galleries/mnl/2022/07/EBfP3j43/",
"http://6mature9.com/galleries/mnl/2022/07/k7PwWaEf/",
"http://6mature9.com/galleries/mnl/2022/07/L8z7UihT/",
"http://6mature9.com/galleries/mnl/2022/07/NXMeQw7r/",
"http://6mature9.com/galleries/mnl/2022/08/fu3vNcSA/",
"http://6mature9.com/galleries/mnl/2022/08/qxKjqJr7/",
"http://6mature9.com/galleries/mnl/2022/08/Rjm7Y7Ar/",
"http://6mature9.com/galleries/mnl/2022/08/zfy9E8ad/",
"http://6mature9.com/galleries/row/2022/01/RF7i2ZM5/",
"http://6mature9.com/galleries/row/2022/02/QkFR5CZ6/",
"http://6mature9.com/galleries/row/2022/06/A3czqzBp/",
"http://6mature9.com/galleries/row/2022/07/24JMT9s6/",
"http://6mature9.com/galleries/row/2022/08/3kTrfU59/",
"http://6mature9.com/galleries/row/2022/08/8q45KLTL/",
"http://6mature9.com/galleries/ssl/2022/04/PW9VHhbw/",
"http://6mature9.com/galleries/ssl/2022/05/TzF7o5CV/",
"http://6mature9.com/galleries/ssl/2022/06/Gk52Awkv/",
"http://6mature9.com/galleries/ssl/2022/06/Yp8nckhA/",
"http://6mature9.com/galleries/ssl/2022/08/8hpK4ECU/",
"http://6mature9.com/galleries/ssl/2022/08/Bg7XSDLi/",
"http://6mature9.com/galleries/ssl/2022/08/ML5z9U3e/",
"http://6mature9.com/galleries/ssl/2022/08/QBN2Ztqx/",
"http://6mature9.com/galleries/wah/2021/11/AEGz6hCB/",
"http://6mature9.com/galleries/wah/2022/03/JMzA2no9/",
"http://6mature9.com/galleries/wah/2022/03/y3KMT7xM/",
"http://6mature9.com/galleries/wah/2022/05/V7VqisHC/",
"http://6mature9.com/galleries/wah/2022/06/SqnpG4Q2/",
"http://6mature9.com/galleries/wah/2022/06/Tb9nrufx/",
"http://6mature9.com/galleries/wah/2022/07/Qar94WcC/",
"http://6mature9.com/galleries/wah/2022/07/wmxU6N/",
"http://6mature9.com/galleries/wah/2022/08/Maru3UW2/",
"http://6mature9.com/galleries/wah/2022/08/t79PPLHw/",
"http://6mature9.com/galleries/xxxps/2022/04/dwMtm8dJ/",
"http://6mature9.com/galleries/xxxps/2022/08/8HafDKfk/",
"http://6mature9.com/galleries/xxxps/2022/08/F9mcPs/"
)

className = ".thumbwook a" # pornpic
#className = "h1, #content"
#className = ".card-link" # pinkfineart links
#className = ".card a" # pinkfineart

lentocpage = length(addr)
cat("\nlentocpage: ",lentocpage,"\n")

ProcessStartTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")

finishBeep <- function(rptCnt){ # beep count
    while(rptCnt>0){
        play(sin(1:6000/10))
        Sys.sleep(0.2)
     rptCnt = rptCnt-1
    }
}

for(i in 1:length(addr)){
 cat(i, "/", length(addr), " ")
 url = paste0(pageHeader,addr[i],pageTail)
 for(i in 1:15){
   itemList = paste0(url, i,".jpg")
   itemList = gsub('http', '<br><img class="lazy" data-src="https', itemList)
   itemList = gsub('jpg', 'jpg">\n', itemList)
   wholePage = c(wholePage, itemList)
 }
}

#writeClipboard(wholePage)

sink(theFilename)
cat(wholePage)
sink()

ProcessEndTime = Sys.time()
cat(format(Sys.time(), "%H:%M:%OS"),"\n")
LoopTime = trunc(as.numeric(ProcessEndTime - ProcessStartTime, units="secs"))
cat("Task completed! loop time: ",LoopTime,"\n\n\n")
#finishBeep(1)
