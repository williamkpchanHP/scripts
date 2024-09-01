# to extract gallery pages use 'window.initials>'
# 'pageURL', "editURL
# to extract gallery images, grep the only line 'window.initials'
# break at 'imageURL'
# grep the only useful
# cut height afterwards
# add '
# same in output file
# enter the URLs in theList below

dirStr = "C:/Users/william/Desktop/scripts/xham"
setwd(dirStr)
# !!!!!!!!!!!!!!!!!!!!!! remember to change file name
thefileName = "chinese-amateur" # no extension
thefileName = readline(prompt="enter output filename without extension: ")
if( thefileName == ""){
  cat("\nNo Name, Exited!\n")
  break
}


htmlTitle = thefileName

seekkey = 'window.initials'
chopkey = 'pageURL'
boilPages <- function(theURL){
	thepage = readLines(theURL, warn = F)
	linenum = grep(seekkey, thepage)
	thepage = thepage[linenum]
	thepage = unlist(strsplit(thepage, chopkey))
	thepage = thepage[-1]

	linenum = grep("imageURL", thepage)
	thepage = thepage[linenum]

	thepage = gsub('.*imageURL":' , '\'<img class="lazy" data-src=', thepage) 
	thepage = gsub(',"height.*' , '>\',', thepage) 
	thepage = gsub('\\\\/' , '/', thepage) 
	return(thepage)
}


# =========
# entry point

urlHead = "https://xhamster.com/photos/gallery/"
theList = c(
"4k-freak-sheisnovember-6-creampie-nipples-bdsm-blowjob-ass-15790799",
"4k-freak-sheisnovember-6-creampie-nipples-bdsm-blowjob-ass-15790799/2",
"4k-freak-sheisnovember-6-creampie-nipples-bdsm-blowjob-ass-15790799/3",
"4k-hd-msnovember-big-natural-tits-huge-nipples-black-areolas-11985580",
"big-areolas-15780561",
"big-areolas-15780561/2",
"big-beautiful-dark-nipples-areolas-areolae-15390467",
"big-sexy-titties-15811092",
"big-titties-tits-fuck-erect-black-nipples-bbc-inside-boobs-12009376",
"bounty-from-olderwomanfun-15777730",
"come-and-eat-my-sacred-apple-15790462",
"eat-my-fat-pussy-2378162",
"ebony-fuck-buddy-15788914",
"extreme-taboo-msnovember-7-big-dick-hardcore-black-creampie-15791006",
"extreme-taboo-msnovember-7-big-dick-hardcore-black-creampie-15791006/2",
"extreme-taboo-msnovember-7-big-dick-hardcore-black-creampie-15791006/3",
"extreme-taboo-msnovember-7-big-dick-hardcore-black-creampie-15791006/4",
"extreme-taboo-msnovember-7-big-dick-hardcore-black-creampie-15791006/5",
"extreme-taboo-msnovember-7-big-dick-hardcore-black-creampie-15791006/6",
"giant-ebony-natural-tits-nipples-areolas-black-hard-large-12003755",
"giant-ebony-titties-nipples-areolas-udders-hangers-boobs-4k-15804792",
"giant-nipples-huge-areolas-on-step-daughter-cleaning-for-dad-12257178",
"hd-all-black-ebony-nipples-areolas-tits-by-teen-msnovember-15791384",
"hd-massive-ebony-nipples-areolas-bigtits-mix-by-msnovember-15791634",
"in-with-the-new-15808822",
"kittys-pics-15777567",
"lingerie-moments-13745830",
"mega-nipples-areolas-black-tits-mix-3-real-natural-breasts-15804912",
"my-pussy-ass-tits-2-15785337",
"my-titties-out-15786273",
"only-giant-black-nipples-areolas-ebony-saggy-udders-breasts-15807303",
"only-giant-black-nipples-areolas-ebony-saggy-udders-breasts-15807303/2",
"pink-pussy-15786601",
"pull-my-huge-breasts-giant-nipples-and-big-black-areolas-out-12008764",
"pussy-ass-feet-15800688",
"redbone-freak-msnovember-4-large-areolas-bigtits-anal-roug-15777650",
"saggy-tits-15779165",
"saggy-tits-15779165/2",
"sams-own-14822441",
"south-african-closeuppussy-15780442",
"step-dad-lov-big-black-titties-nipples-areolas-step-daughter-12049679",
"taboo-ass-sheisnovember-4-gigantic-nipples-areolas-coitus-15777647",
"vicki-bam-xxx-9441510",
"vicki-bam-xxx-9441510/2"
)
#"chinese-amateur-14643006"
#"female-genital-piercings-5617451",
#"female-genitals-2790323",
#"bulgarian-female-genital-piercing-2-2758983",
#"genital-id-12375115",
#"russian-slave-amateur-bdsm-genital-piercing-3046609",
#"russian-whore-amateur-erotica-1683641",
#"female-genital-jewelry-977655",
#"female-genitals-142679",
#"bulgarian-female-genital-piercing-804741",
#"painted-genitals-1255009",
#"genital-torture-02-14307429"
#"random-nipple-stand-outs-13715697",
#"u-never-fail-to-make-my-nipples-stick-out-x-7870736",
#"random-nipples-4715501",
#"clearing-out-my-phone-2-12926738",
#"cleaning-out-phone-12040580",
#"kymppilasses-girl-1-10264301",
#"reign-of-tits-vol-5-15540127",
#"big-mature-tits-vol-13-15065540",
#"best-big-mature-tits-vol-3-14835654",
#"best-big-mature-tits-vol-1-14833447",
#"thick-meaty-sexy-14854815"
#"even-on-her-day-off-work-jayne-still-send-me-sexy-pics-3191174",
#"this-is-how-jayne-spends-her-days-off-i-m-not-complaining-3728601",
#"amateur-girls-send-sexy-pics-15769295",
#"amateur-15769263",
#"karen-summer-even-in-her-mature-years-she-is-still-hot-11602464",
#"i-fucked-her-twenty-years-ago-and-she-came-back-6414977",
#"i-fucked-her-fifteen-years-ago-and-she-came-back-last-night-7174803",
#"milf-have-sexy-body-fuck-her-to-be-happy-and-creampie-inside-13206578",
#"sexy-milf-with-big-tits-shows-her-ass-and-cunt-at-the-beach-14047789",
#"off-work-recreation-days-8374208",
#"pics-my-baby-mama-still-sends-me-15805435",
#"off-work-14604354",
#"date-day-with-work-gf-11624357",
#"uk-milf-takes-her-knickers-off-11224396",
#"day-off-desires-10893172",
#"have-the-day-off-10173700"
#"nipple-tie-1802571",
#"piercings-in-pussy-and-clit-14343544",
#"beautiful-pussy-and-clit-11821441",
#"clamped-nipples-pussy-and-clit-babygirl-ddlg-milf-shaved-15779487",
#"clamped-nipples-pussy-and-clit-babygirl-ddlg-milf-shaved-15779487/2",
#"nipple-clips-11502136",
#"nipples-and-binder-clips-2885795",
#"giant-black-nipples-and-monster-areolas-tits-sheisnovember-15808291",
#"only-giant-black-nipples-areolas-ebony-saggy-udders-breasts-15807303",
#"huge-areolas-nipples-and-tits-5-15016593",
#"huge-areolas-nipples-and-tits-3-14712602",
#"clip-the-nipples-1533978",
#"nipples-tied-and-pulled-tight-what-a-slut-14681748",
#"nipples-tied-13925458",
#"pumped-nipples-tied-6092329",
#"big-nippled-tied-tits-bondage-4-5605872",
#"big-tits-bondage-14424576",
#"tied-boobs-nipple-torture-15772834",
#"big-tied-nipples-in-tank-top-13575143",
#"tied-nipples-11532849",
#"bound-and-tied-nipples-13580538",
#"rope-tight-tits-tied-nipples-1641637",
#"thick-fat-tits-tied-and-nipple-rings-9755705",
#"w3n0nas-nips-9697576",
#"latina-little-tits-long-nipples-9472550",
#"blonde-tits-tied-nipples-clamped-9399111",
#"mature-with-super-saggy-tits-9384452",
#"foxy-long-tied-lactating-nipples-9301955",
#"w3n0nas-nips-9697576",
#"w3n0nas-nips-9697576",
#"foxy-long-tied-lactating-nipples-9301955",
#"tied-nipples-clamped-and-face-fucked-hard-5754250",
#"tied-nipples-4149712",
#"tied-tits-and-suctioned-nipples-3915435",
#"tits-tied-nipples-clamped-2087923",
#"i-want-your-big-nipples-bound-tied-2546452",
#"nipples-tied-and-pulled-tight-what-a-slut-14681748",
#"nipples-tied-13925458",
#"pumped-nipples-tied-6092329",
#"nipples-tied-13925458",
#"nipple-tie-1802571"
#"hanky-panky-with-a-gilf-13528701",
#"gorgeous-gilf-pussy-14170786",
#"pumping-my-fwb-13233947",
#"nipple-pumping-13128220",
#"clit-pumping-gilf-grandmother-id-like-to-fuck-13127237",
#"sexy-gilf-12708386",
#"tiffany-pumping-6-2711065",
#"tiffany-pumping-5-2710976",
#"pussy-pumping-with-sub-belle-7-2670416",
#"pussy-pumping-with-sub-belle-6-2607964",
#"tiffany-pumping-2-2598958",
#"tiffany-pumping-1-2597554",
#"pussy-pumping-with-sub-belle-5-2575886",
#"pussy-pumping-with-sub-belle-4-2214169",
#"pussy-pumping-with-sub-belle-3-2214137",
#"baseball-bat-sex-2193627",
#"pussy-pumping-with-sub-belle-2-2193333",
#"weird-object-insertion-butternut-squash-1859419",
#"pussy-pumping-with-sub-belle-1843972",
#"kerri-first-photos-1843682",
#"playpiercing-tiffany-1737149",
#"playing-with-sub-belle-1721010",
#"nicole-young-summer-fun-part-3-1715271",
#"nicole-a-young-newbie-pussy-pumper-1680004",
#"my-asian-tranny-1678746",
#"pussy-pumping-1544026"
#"lady-sonia-and-red-xxx-can-it-get-any-better-14670514",
#"red-xxx-14468222",
#"milf-red-xxx-in-black-gossard-superboost-bra-13359545",
#"milf-red-xxx-in-red-gossard-superboost-bra-13359450",
#"red-xxx-my-favourite-redhead-milf-and-other-redheads-13193919",
#"mistress-red-xxx-11851651",
#"red-xxx-mistress-in-white-satin-gossard-wonderbra-11670128",
#"red-xxx-ass-11562458",
#"red-xxx-lady-sonia-11507929",
#"red-xxx-10538081",
#"red-xxx-9830226",
#"mistress-red-xxx-melting-me-7876681",
#"red-xxx-5437586",
#"red-xxx-4573425",
#"sexy-red-xxx-4030332",
#"red-xxx-hot-2879130",
#"red-xxx-sexy-lady-2872524",
#"fotos-de-la-red-xxx-1993163",
#"u-k-mistress-red-xxx-tribute-1991029",
#"milf-red-xxx-1436000",
#"red-xxx-2-1389067",
#"red-xxx-1389035",
#"red-xxx-1036770",
#"lenny-in-red-xxx-466630",
#"red-xxx-in-nylons-2901887",
#"sexy-red-xxx-styffing-her-tits-and-pussy-in-somones-face-15067521",
#"lady-red-14923293",
#"lady-in-red-4288128",
#"lady-in-red-4288123",
#"lady-in-red-4288102",
#"lady-in-red-4288092",
#"lady-in-red-4288090",
#"lady-in-red-4288084",
#"lady-in-red-4288131",
#"lady-in-red-4288099",
#"lady-in-red-4288114",
#"lady-in-red-4288120",
#"lady-in-red-4288089",
#"red-xxx-with-morphed-tits-11195934",
#"red-xxx-vol-1-20-40609",
#"red-xxx-vol-21-40-41039",
#"linda-in-red-6inch-heals-xxx-14406699",
#"lady-xxx-red-11061112",
#"red-on-top-beautifully-bare-down-below-xxx-4477358",
#"big-red-booty-xxx-4145622",
#"cartoons-porn-red-riding-hood-and-the-little-wolf-xxx-4093095",
#"xxx-mass-red-latex-2643866",
#"kryztal-red-wishes-you-a-merry-xxx-mas-766429",
#"reds-xxx-3735239",
#"xxx-red-light-xxx-interracial-farm-1117474",
#"proud-cocks-and-submissive-dolls-xxx-red-light-xxx-649042",
#"xxx-red-light-xxx-quality-seeds-into-fertile-wombs-412777",
#"xxx-red-light-xxx-black-men-make-happy-white-women-541200",
#"xxx-red-light-xxx-potency-inside-elegance-480759",
#"xxx-red-light-xxx-interracial-coctail-433006",
#"xxx-red-light-xxx-fair-match-303903"
# 'the-pussy-of-my-girlfriend-15786888',
# 'the-pussy-of-my-girlfriend-15786888/2',
# 'linda-la-vagina-de-mi-amiga-andrea-15785140',
# 'my-pranks-in-the-evenings-15805171',
# 'my-photos-15806979',
# 'photo-shoot-freind-15811520',
# 'nadine-steffi-hot-photo-shooting-11313700',
# 'busty-russian-girl-2-2984062',
# 'busty-russian-girl-2969774',
# 'photos-of-me-15807846',
# 'hairy-girl-with-massive-boobs-15735619',
# 'beautiful-girls-with-hot-boobs-hairy-pussy-06-c5m-1595090',
# 'beautiful-girls-with-hot-boobs-hairy-pussy-c5m-1285716',
# 'beautiful-girls-with-hot-boobs-hairy-pussy-c5m-1285642',
# 'beautiful-girls-with-hot-boobs-hairy-pussy-06-c5m-1595090',
# 'beautiful-girls-with-hot-boobs-hairy-pussy-04-c5m-1334880',
# 'beautiful-girls-with-hot-boobs-hairy-pussy-03-c5m-1334829',
# 'russian-mature-wifes-with-big-boobs-and-hairy-pussy-14452594',
# 'big-beautiful-girls-with-big-boobs-15663269',
# 'beautiful-girls-with-hot-boobs-hairy-pussy-02-c5m-1286079',
# 'beautiful-girls-with-hot-boobs-hairy-pussy-04-c5m-1334880',
# 'beautiful-girls-with-hot-boobs-hairy-pussy-03-c5m-1334829',
# 'hairy-girls-with-great-natural-tits-pt-3-12931741',
# 'hairy-girls-with-big-breasts-12071505',
# 'hairy-girls-with-big-breasts-2-12148083',
# 'linda-vagina-5912436',
# 'una-linda-vagina-ustedes-que-opinan-de-estas-fotos-caseras-3042785'
# # # "great-tits-random-pictures-march-2019-11632373",
# "great-tits-random-pictures-january-2018-9363108",
# "great-tits-random-pictures-august-2018-10417373",
# "great-tits-random-pictures-december-2017-9215883",
# "great-tits-random-pictures-on-a-sunday-6698970",
# "great-tits-random-pictures-june-2018-10199644",
# "great-tits-random-pictures-june-2018-10139023",
# "great-tits-random-pictures-next-part-january-2018-9457170",
# "great-tits-random-pictures-22nd-june-2018-10218631",
# "great-tits-random-pictures-november-2018-10899736",
# "great-tits-february-album-random-pictures-2019-11376948",
# "great-tits-some-new-bras-and-random-pictures-sept-2018-10582675",
# "great-tits-sunny-days-random-pictures-8th-july-2018-10294082",
# "great-tits-february-album-random-pictures-13-02-19-11411554",
# "great-tits-loving-them-random-pictures-june-2018-10252746",
# "great-tits-random-mix-wednesday-fix-6875706",
# "great-tits-random-mix-on-a-wednesday-6712950",
# "great-tits-random-mix-up-14th-july-2018-10321377",
# "great-tits-random-june-2018-10155898",
# "great-tits-randoms-march-18-9691281",
# "great-tits-different-pictures-happy-new-year-2019-11214877",
# "candica-swanepoel-topless-tulum-march-2019-14132917",
# "nadine-new-pics-march-2019-part-1-11530090",
# "march-2019-11519284",
# "march-2019-11514261",
# "cum-diary-march-2019-11501365",
# "nadine-new-pics-march-2019-part-2-11574680",
# "new-pictures-march-2020-13826990",
# "semen-on-pictures-march-19-11531035",
# "great-tits-just-out-the-shower-and-new-bra-march-2018-9713226",
# "great-tits-cold-day-2-outfits-keep-you-warm-march-2018-9624351",
# "great-tits-night-out-and-fresh-out-the-shower-march-2018-9785613",
# "best-instagram-girls-march-2019-11820065",
# "march-2019-new-guy-in-town-hotel-encounter-11738413",
# "goon-diary-march-2019-11718201",
# "hentai-collection-of-march-2019-4-11675515",
# "march-2019-recent-monica-for-men-11674776",
# "hentai-collection-of-march-2019-3-11671717",
# "march-2019-wank-diary-11664674",
# "the-last-day-of-march-2019-11662955",
# "march-2019-11660641",
# "top-30-wanks-of-march-2019-11649405",
# "maisie-williams-super-magazine-march-2019-11645755",
# "latest-feb-march-2019-11642734",
# "march-2019-11637970",
# "new-pics-march-2019-11625281",
# "march-2019-c-11624045",
# "barbara-palvin-exit-march-2019-issue-38-11618829",
# "elle-fanning-hb-march-2019-11618583",
# "jerk-off-journal-march-2019-11617661",
# "hentai-collection-of-march-2019-11593849",
# "march-2019-11583324",
# "sophie-turner-and-maisie-williams-glamour-uk-march-2019-11573659",
# "march-2019-amateur-milf-european-11569235",
# "fun-times-march-2019-we-hit-it-hard-11567846",
# "march-2019-11562477","pierced-nipples-and-pussys-11-1715526",
# "pierced-nipples-and-pussys-5-1715247",
# "pierced-nipples-and-pussys-11-1-1715532",
# "all-sexy-pierced-nipples-and-pussys-3194090",
# "pierced-nipples-and-pussys-4-1554004",
# "pierced-nipples-and-pussys-8-1715427",
# "pierced-nipples-and-pussys-6-1715301",
# "pierced-nipples-and-pussys-1715478",
# "pierced-nipples-and-pussys-1553981",
# "pierced-nipples-and-pussys-3-1553999",
# "pierced-nipples-and-pussys-2-1553987",
# "pierced-nipples-and-pussys-7-1715336",
# "pierced-nipples-and-pussys-10-1715508",
# "pierced-nipples-and-pussy-13058624",
# "pierced-nipples-and-pussy-lips-10685977",
# "sexy-piercing-nipple-pussys-7-15543186",
# "sexy-piercing-nipple-pussys-6-14776538",
# "sexy-piercing-nipple-pussys-5-14087709",
# "sexy-piercing-nipple-pussys-4-13417541",
# "sexy-piercing-nipple-pussys-3-13385696",
# "sexy-piercing-nipple-pussys-2-fucking-12636077",
# "sexy-piercing-nipple-pussys-12455801",
# "wifes-big-nipples-and-pussy-12053711",
# "mandys-hairy-pussy-big-pierced-milky-nipples-and-fat-ass-15794753",
# "lulu-chu-pierced-nipples-and-asian-pussy-14253862",
# "me-and-pussys-12106224",
# "legs-ass-and-pussys-spread-5159718",
# "bbw-big-buts-and-pussys-1785712",
# "interracial-fuck-sluts-ass-and-pussys-stretched-789410",
# "more-bbw-wifes-pierced-nipples-13310281",
# "kims-pierced-nipples-x-6479871",
# "girlfriends-pierced-nipples-4616718",
# "my-matures-tits-pierced-nipples-3129701",
# "rihannas-pierced-nipples-3125903",
# "girlfriends-pierced-nipples-2507679",
# "suzys-big-pierced-nipples-6-2378649",
# "suzys-big-pierced-nipples-4-2333156",
# "suzys-big-pierced-nipples-3-2297675",
# "suzys-big-pierced-nipples-2-2271290",
# "chloes-pierced-nipples-14906925",
# "suzys-big-pierced-nipples-5-2354880",
# "suzys-big-pierced-nipples-2242734",
# "pierced-nipples-clits-and-pussy-7084112",
# "natasha-18yo-teenager-with-piercings-in-nipples-and-pussy-14463366",
# "piercing-tits-nipples-and-pussy-10487446",
# "ill-pussys-479784",
# "pussys-pics-4-6427300",
# "pierced-nipples-and-14365044",
# "leah-winters-pierced-nipples-and-leggy-pornstar-12362156",
# "sexy-milf-pierced-nipples-and-fat-ass-11918204",
# "i-see-them-pierced-nipples-and-nice-ass-10560857",
# "tattoos-pierced-nipples-and-some-of-both-7844454",
# "pierced-nipples-and-bouncing-weights-7044309",
# "pierced-nipples-and-clits-4729423",
# "pierced-nipples-and-tits-6307419",
# "big-boobs-pierced-nipples-and-self-fisting-n-c-316758"
# wide-open-cunt-12707595",
# open-cunts-13511144",
# wide-open-cunt-and-insertions-13240367",
# open-gaping-cunt-and-insertions-7-12838060",
# wide-open-gaping-and-stuffed-full-11-13015154",
# wide-open-cunt-13460570",
# huge-wide-open-cunt-and-insertions-16-13196776",
# wide-open-cunt-and-insertions-13-13126243",
# yummy-cunts-15520352",
# open-cunts-12962192",
# wide-open-cunt-and-insertions-8-12920509",
# open-cunts-13994910",
# my-wide-open-cunt-11471956",
# balackmail-fotze-open-cunt-of-his-slut-1-11991314",
# open-cunt-explain-1-15022853"
# "all-sexy-pierced-nipples-and-pussys-3194090",
# "pierced-nipples-and-pussy-13058624",
# "pierced-nipples-and-pussys-10-1715508",
# "pierced-nipples-and-pussys-11-1-1715532",
# "pierced-nipples-and-pussys-11-1715526",
# "pierced-nipples-and-pussys-1553981",
# "pierced-nipples-and-pussys-1715478",
# "pierced-nipples-and-pussys-2-1553987",
# "pierced-nipples-and-pussys-3-1553999",
# "pierced-nipples-and-pussys-4-1554004",
# "pierced-nipples-and-pussys-5-1715247",
# "pierced-nipples-and-pussys-6-1715301",
# "pierced-nipples-and-pussys-7-1715336",
# "pierced-nipples-and-pussys-8-1715427"

lentheList = length(theList)
cat("\ntotal pages: ", lentheList, "\n\n")
wholeData = ""
for(i in 1:lentheList){
	cat(i, " ")
	theURL = paste0(urlHead, theList[i])
	wholeData = c(wholeData, boilPages(theURL))
}
	writeClipboard(wholeData)
	cat("data copied to clipboard!\n")

filedir = "C:/Users/william/Desktop/scripts/R/xhamster/photo"
setwd(filedir)
	sink(paste0(thefileName,".html"))
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
       cat('  var showTopicNumber = false;\n')
       cat('  var topicEnd = " ";\n')
       cat('  var bookid = "',htmlTitle,'"\n', sep="")
       cat('  var markerName = "img"\n')
	  cat('</script>\n')
	  cat('<style>\n')
	  cat('body{width:100%;margin-left: 0%; font-size:22px;}\n')
	  cat('h1, h2 {color: gold;}\n')
	  cat('strong {color: orange;}\n')
	  cat('pre{width:100%;}\n')
	  cat('</style></head><body onkeypress="chkKey()"><center>\n')
	  cat('<div id="toc"></div>\n')
	  cat('<pre><center>\n')

       cat(wholeData, sep="\n")

	  cat('<script src="https://williamkpchan.github.io/LibDocs/readbook.js"></script>\n<script src="imgControl.js"></script>\n')
	  cat('<script>var lazyLoadInstance= new LazyLoad({elements_selector:".lazy"});</script>\n')
	  cat('</pre></body></html>\n')
	sink()
	cat(red("Job completed!\n"))
	cat(format(Sys.time(), "%H:%M"),"\n")

	startstr="start launcher.exe --start-fullscreen \""
	shell(paste0(startstr, dirStr,"/", paste0(thefileName,".html")))

