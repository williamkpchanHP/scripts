# collect all photos from all sub albums, takes a long time to finish
# use the workhorse: retrieveFile.R to collect multiple cabinet photos
# input: url only, will find out number of following links by workhorse
# this is the controller of retrieveFile.R
# enter url of one cabinet

# remember to modify exclusionList if needed
setwd("C:/Users/william/Desktop/scripts/R")
library(rvest)
library(crayon)
source("retrieveFile.R") # the workhorse here
source("sinkfile.R")
# allAlbumHeader do not end with /
gatePass = FALSE # special permission

allAlbumHeader = readline(prompt="enter user url e.g. ..users/../photos: ")
#"https://xhamster.com/users/stanford0923/photos"
#"https://xhamster.com/users/joytwosex/photos"
#"https://xhamster.com/users/matureworld/photos"
#"https://xhamster.com/users/gorilust/photos"
#"https://xhamster.com/users/rd1005/photos"
#"https://xhamster.com/users/nektariaaslam/photos"
#"https://xhamster.com/users/sweetnorm/photos"
#"https://xhamster.com/users/jackhorneramberwaves/photos"
#"https://xhamster.com/users/ricocollege001/photos"
#"https://xhamster.com/users/expo123b/photos"
#"https://xhamster.com/users/jstudd/photos"
#"https://xhamster.com/users/hulkhoganbrother/photos"
#"https://xhamster.com/users/hugeones38/photos"
#"https://xhamster.com/users/piggyowner/photos"
#"https://xhamster.com/users/trythisone3x3/photos"
#"https://xhamster.com/users/elizabethsoulmate0/photos"
#"https://xhamster.com/users/openmilf/photos"
#"https://xhamster.com/users/zeeboy77/photos"
#"https://xhamster.com/users/yooop/photos"
#"https://xhamster.com/users/munichgold/photos"
#"https://xhamster.com/users/xienna/photos"
#"https://xhamster.com/users/ardientes69/photos"
#"https://xhamster.com/users/reposterman/photos"
#"https://xhamster.com/users/mrisa/photos"
#"https://xhamster.com/users/elizabeth_p/photos"
#"https://xhamster.com/users/kraut1945/photos"
#"https://xhamster.com/users/inkbrothersbg/photos"
#"https://xhamster.com/users/pornartstudio/photos"
#"https://xhamster.com/users/alfred_holanda/photos"
#"https://xhamster.com/users/justdavid509/photos"
#"https://xhamster.com/users/countryboy8418/photos"
#"https://xhamster.com/users/chowderedpleb/photos"
#"https://xhamster.com/users/marrowkip/photos"
#"https://xhamster.com/users/joroke_iv/photos"
#"https://xhamster.com/users/roseandjohn99/photos"
#"https://xhamster.com/users/spankmann75/photos"
#"https://xhamster.com/users/tigress69/photos"
#"https://xhamster.com/users/samsnead1973/photos"
#"https://xhamster.com/users/mrluva/photos"
#"https://xhamster.com/users/kinklover45/photos"
#"https://xhamster.com/users/petproject/photos"
#"https://xhamster.com/users/beetledoc/photos"
#"https://xhamster.com/users/pryce26/photos"
#"https://xhamster.com/users/yarayara358/photos"
#"https://xhamster.com/users/marobbo1960/photos"
#"https://xhamster.com/users/fastnfurious33/photos"
#"https://xhamster.com/users/forcedobedience/photos"
#"https://xhamster.com/users/jimbow1946/photos"
#"https://xhamster.com/users/masterg329/photos"
#"https://xhamster.com/users/shylilgirl_/photos"
#"https://xhamster.com/users/clarkwilliam/photos"
#"https://xhamster.com/users/nipman-/photos"
#"https://xhamster.com/users/wetgurl/photos"
#"https://xhamster.com/users/fchang69/photos"
#"https://xhamster.com/users/fastnfurious33/photos"
#"https://xhamster.com/users/kzo/photos"
#"https://xhamster.com/users/quad777222/photos"
#"https://xhamster.com/users/hannah100000/photos"
#"https://xhamster.com/users/kell2538/photos"
#"https://xhamster.com/users/theeuroslut/photos"
#"https://xhamster.com/users/tranlam4545454/photos"
#"https://xhamster.com/users/carlsmith206/photos"
#"https://xhamster.com/users/toomuchfuntn/photos"
#"https://xhamster.com/users/crazyguy8355/photos"
#"https://xhamster.com/users/liana1211/photos"
#"https://xhamster.com/users/callboybbsr9/photos"
#"https://xhamster.com/users/mybigpussy1/photos"
#"https://xhamster.com/users/homer168/photos"
#"https://xhamster.com/users/cunts_on_my_mind/photos"
#"https://xhamster.com/users/luvmesumcurves/photos"
#"https://xhamster.com/users/capricon-96/photos"
#"https://xhamster.com/users/hitmannr47/photos"
#"https://xhamster.com/users/doomguy2020/photos"
#"https://xhamster.com/users/wadsoffun/photos"
#"https://xhamster.com/users/smartvideo1990/photos"
#"https://xhamster.com/users/girlsoutwest_com/photos"
#"https://xhamster.com/users/jokebroker/photos"
#"https://xhamster.com/users/nipples55/photos"
#"https://xhamster.com/users/1awesome/photos"
#"https://xhamster.com/users/lovin_large_ladies/photos"
#"https://xhamster.com/users/lateshay38jtits/photos"
#"https://xhamster.com/users/sugarplum_onlyfans/photos"
#"https://xhamster.com/users/nylonlisa/photos"
#"https://xhamster.com/users/nippleorgasm/photos"
#"https://xhamster.com/users/borek23/photos"
#"https://xhamster.com/users/willynilly54/photos"
#"https://xhamster.com/users/sheisnovember/photos"
#"https://xhamster.com/users/mrspinklady/photos"
#"https://xhamster.com/users/pro-boobs/photos"
#"https://xhamster.com/users/txwood/photos"

#"https://xhamster.com/users/zam_pano/photos"
#"https://xhamster.com/users/milky_mari/photos"
#"https://xhamster.com/users/rosado666/photos"
#"https://xhamster.com/users/yourolddroog/photos"
#"https://xhamster.com/users/b0b104/photos"
#"https://xhamster.com/users/bisexcouple50/photos"
#"https://xhamster.com/users/newshops/photos"
#"https://xhamster.com/users/sexdrive65/photos"
#"https://xhamster.com/users/hrob111/photos"
#"https://xhamster.com/users/phrenny/photos"
#"https://xhamster.com/users/starlight376/photos"
#"https://xhamster.com/users/lovehomeporn/photos"
#"https://xhamster.com/users/kymppilasse/photos"
#"https://xhamster.com/users/sackdudel/photos"
#"https://xhamster.com/users/scorpionsting1964/photos"
#"https://xhamster.com/users/bikinifanatics/photos"
#"https://xhamster.com/users/herrsneedrie/photos"
#"https://xhamster.com/users/dedu88/photos"
#"https://xhamster.com/users/bi_man2use/photos"
#"https://xhamster.com/users/missveepee/photos"
#"https://xhamster.com/users/spike0069/photos"
#"https://xhamster.com/users/hunter-h/photos"

#"https://xhamster.com/users/cachonda1222/photos"
#"https://xhamster.com/users/tango481/photos"

# "https://xhamster.com/users/bigted666/photos"
# "https://xhamster.com/users/blondii/photos"
# https://xhamster.com/users/raymiec/photos"
# https://xhamster.com/users/pcoladaddy/photos"
# https://xhamster.com/users/iloveolderwomen1980/photos"
# https://xhamster.com/users/caribbeancom-xxx/photos
# allAlbumHeader = "https://xhamster.com/users/exposedslutsrule/photos"
# allAlbumHeader = "https://xhamster.com/users/johnjerker/photos"
# allAlbumHeader = "https://xhamster.com/users/jerking_off_my_dick/photos"
# allAlbumHeader = "https://xhamster.com/users/rusty1000/photos"
# allAlbumHeader = "https://xhamster.com/users/venompoland/photos"
# allAlbumHeader = "https://xhamster.com/users/resangel/photos"
# allAlbumHeader = "https://xhamster.com/users/lovin_large_ladies/photos"
# allAlbumHeader = "https://xhamster.com/users/grigorispl/photos/"

exclusionList = readLines("C:/Users/william/Desktop/scripts/R/exclusionList.txt")
excludeKeywords = readLines("C:/Users/william/Desktop/scripts/R/excludeKeywords.txt")
gatePassList = readLines("C:/Users/william/Desktop/scripts/R/gatePassList.txt")
theFilename = gsub("http.*?xhamster.com/users/", "", allAlbumHeader)
theFilename = gsub("/photos", "", theFilename)
theFilename = paste0(theFilename, "_photos_xham.html")
output = gsub("/photos", "", theFilename)

allAlbumList = character()
allLinkList = character()
allPhotoList = character()

startTime = format(Sys.time(), "%H:%M")

collectLinks(allAlbumHeader) # many page links in this user

for(thelink in allLinkList){ collectAlbums(thelink) } # get all albums links

#allPageHeader = allAlbumList
allLinkList = character() # reset allLinkList

collectLinks(allAlbumList) # collect multi links in each album

# each link includes muitlple photo titles, collect all title links
allPointerLink = allLinkList
allLinkList = character() # reset allLinkList

collectImgs(allPointerLink) # collect images

#collectImgs(allLinkList)
sinkfile(allPhotoList, theFilename)
