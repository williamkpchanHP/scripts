# given list of addr and no of images, extract gallery images
 # 'pageURL', "editURL

 # to extract gallery images, grep the only line 'window.initials'
 # break at 'imageURL'
 # grep the only useful
 # cut height afterwards
 # add '
 # same in output file
# init
 dirStr = "D:/Dropbox/MyDocs/R misc Jobs/webscraping/Text/programs/pohub/scripts"
 setwd(dirStr)

 thefileName = "borex"
 urlHead = ""

 seekkey = 'window.initials'
 chopkey = 'imageURL'

 processPages <- function(theURL){
	thepage <- tryCatch(readLines(theURL, warn=F), error = function (e) NULL)
	if (is.null(thepage)) {
		return("")
	}

	linenum = grep(seekkey, thepage)
	thepage = thepage[linenum]
	thepage = unlist(strsplit(thepage, chopkey))
	thepage = thepage[-1]

	thepage = gsub(',"height.*' , '>\',', thepage) 
	thepage = gsub('":' , '\'<img src=', thepage) 
	thepage = gsub('[\\]' , '', thepage) 
	return(thepage)
 }

 thePageList = c(
"https://xhamster.com/photos/gallery/hairy-girl-val-11498979",
"https://xhamster.com/photos/gallery/blonde-kate-nice-pussy-11372933",
"https://xhamster.com/photos/gallery/bald-pussy-kay-11362012",
"https://xhamster.com/photos/gallery/sendwich-and-cameltoes-11271260",
"https://xhamster.com/photos/gallery/busty-latina-dani-11263989",
"https://xhamster.com/photos/gallery/hairy-mature-milo-11176104",
"https://xhamster.com/photos/gallery/brooke-big-lips-10989865",
"https://xhamster.com/photos/gallery/hairy-girl-jane-10950345",
"https://xhamster.com/photos/gallery/hairy-girl-misty-10949729",
"https://xhamster.com/photos/gallery/hairy-girl-apri-10873672",
"https://xhamster.com/photos/gallery/mature-jaden-big-lips-10811218",
"https://xhamster.com/photos/gallery/mature-amber-10811181",
"https://xhamster.com/photos/gallery/blonde-girl-melanee-10787659",
"https://xhamster.com/photos/gallery/hairy-girl-amber-10782360",
"https://xhamster.com/photos/gallery/hairy-girl-lariona-10716191",
"https://xhamster.com/photos/gallery/hairy-girl-bella-10716100",
"https://xhamster.com/photos/gallery/hairy-girl-onyx-10715997",
"https://xhamster.com/photos/gallery/hairy-girl-luna-10715982",
"https://xhamster.com/photos/gallery/hairy-girl-braty-10669121",
"https://xhamster.com/photos/gallery/hairy-girl-andy-10619301",
"https://xhamster.com/photos/gallery/spread-legs-2-10617495",
"https://xhamster.com/photos/gallery/ana-black-pussy-big-clit-10579810",
"https://xhamster.com/photos/gallery/black-girl-nadia-with-big-pussy-and-clit-10559329",
"https://xhamster.com/photos/gallery/exotics-nala-with-huge-pussy-10559274",
"https://xhamster.com/photos/gallery/3x-hairy-mature-women-10410220",
"https://xhamster.com/photos/gallery/spread-legs-1-10356437",
"https://xhamster.com/photos/gallery/black-holes-10263648",
"https://xhamster.com/photos/gallery/hanging-labia-10263595",
"https://xhamster.com/photos/gallery/superclits-in-zoom-10263548",
"https://xhamster.com/photos/gallery/asian-hairy-mature-10263498",
"https://xhamster.com/photos/gallery/another-hairy-spread-9833125",
"https://xhamster.com/photos/gallery/hairy-annie-big-clit-9642459",
"https://xhamster.com/photos/gallery/clits-in-zoom-part1-9532921",
"https://xhamster.com/photos/gallery/variations-on-panties-9478573",
"https://xhamster.com/photos/gallery/mature-carol-big-lips-and-clit-9478308",
"https://xhamster.com/photos/gallery/big-clit-and-long-lips-lizzie-9478216",
"https://xhamster.com/photos/gallery/asian-hairy-ember-9477944",
"https://xhamster.com/photos/gallery/hairy-asian-mature-saya-9477903",
"https://xhamster.com/photos/gallery/clits-in-zoom-part-2-9476727",
"https://xhamster.com/photos/gallery/pussy-a-little-differently-9476365",
"https://xhamster.com/photos/gallery/superclit-wanda-9408582",
"https://xhamster.com/photos/gallery/superclit-ashlee-9406633",
"https://xhamster.com/photos/gallery/superclit-angela-9401881",
"https://xhamster.com/photos/gallery/cameltoe-9368336",
"https://xhamster.com/photos/gallery/showing-butterfly-pussy-9363307",
"https://xhamster.com/photos/gallery/lily-meaty-big-lips-9362378",
"https://xhamster.com/photos/gallery/pussy-spread-9357134",
"https://xhamster.com/photos/gallery/hairy-girl-angelina-9344245",
"https://xhamster.com/photos/gallery/best-of-spread-honey-9322520",
"https://xhamster.com/photos/gallery/sizi-big-pussy-lips-9322437",
"https://xhamster.com/photos/gallery/natalia-meaty-hairy-pussy-lips-9214479",
"https://xhamster.com/photos/gallery/best-of-spread-alison-9214451",
"https://xhamster.com/photos/gallery/best-of-spread-elsa-9214408",
"https://xhamster.com/photos/gallery/alex-meaty-pussy-lips-9214287",
"https://xhamster.com/photos/gallery/sassy-hairy-pussy-big-lips-9213791",
"https://xhamster.com/photos/gallery/best-of-spread-miko-9172978",
"https://xhamster.com/photos/gallery/black-charlie-big-lips-and-clit-9100737",
"https://xhamster.com/photos/gallery/best-of-spread-alice-9054202",
"https://xhamster.com/photos/gallery/best-of-spread-nari-8497741",
"https://xhamster.com/photos/gallery/best-of-spread-felicia-8494803",
"https://xhamster.com/photos/gallery/best-of-spread-kristen-8494665",
"https://xhamster.com/photos/gallery/mature-amber-8355740",
"https://xhamster.com/photos/gallery/mature-simone-8355103",
"https://xhamster.com/photos/gallery/mature-liandra-8288906",
"https://xhamster.com/photos/gallery/jessica-big-lips-8284258",
"https://xhamster.com/photos/gallery/hairy-mature-ellen-8278655",
"https://xhamster.com/photos/gallery/mature-helena-8274683",
"https://xhamster.com/photos/gallery/round-asses-part-3-8223018",
"https://xhamster.com/photos/gallery/round-asses-part-2-8208972",
"https://xhamster.com/photos/gallery/round-asses-part-1-8191404",
"https://xhamster.com/photos/gallery/big-hole-8174723",
"https://xhamster.com/photos/gallery/different-views-of-one-great-pussy-8097699",
"https://xhamster.com/photos/gallery/mature-savanah-7933472",
"https://xhamster.com/photos/gallery/ashley-butterfly-pussy-7918007",
"https://xhamster.com/photos/gallery/mature-ashleigh-big-clit-7896472",
"https://xhamster.com/photos/gallery/mature-hairy-sarah-7896379",
"https://xhamster.com/photos/gallery/orion-great-outer-pussy-lips-7888765",
"https://xhamster.com/photos/gallery/mature-violet-meaty-lips-7882093",
"https://xhamster.com/photos/gallery/mature-hairy-alexandra-7870982",
"https://xhamster.com/photos/gallery/mature-hairy-caressa-7870890",
"https://xhamster.com/photos/gallery/mature-hairy-lily-7850317",
"https://xhamster.com/photos/gallery/mature-hairy-charlotte-7849176",
"https://xhamster.com/photos/gallery/mature-hairy-lidia-7842642",
"https://xhamster.com/photos/gallery/mature-hairy-issabela-7842621",
"https://xhamster.com/photos/gallery/mature-hairy-debie-7842583",
"https://xhamster.com/photos/gallery/big-boobs-bbw-7834822",
"https://xhamster.com/photos/gallery/hairy-mature-laurel-7733123",
"https://xhamster.com/photos/gallery/hairy-girl-cameron-7709576",
"https://xhamster.com/photos/gallery/hairy-girl-atha-7705326",
"https://xhamster.com/photos/gallery/mature-natalia-big-clit-7664305",
"https://xhamster.com/photos/gallery/mature-hairy-alicia-7664280",
"https://xhamster.com/photos/gallery/hairy-girl-anya-7650497",
"https://xhamster.com/photos/gallery/hairy-girl-agnea-7650149",
"https://xhamster.com/photos/gallery/hairy-girl-roxy-7597784",
"https://xhamster.com/photos/gallery/hairy-girl-shanice-7593022",
"https://xhamster.com/photos/gallery/mature-nikki-7592077",
"https://xhamster.com/photos/gallery/hairy-bbw-mature-trixie-7592034",
"https://xhamster.com/photos/gallery/hairy-girl-lena-7589436",
"https://xhamster.com/photos/gallery/hairy-girl-roseanne-7589331",
"https://xhamster.com/photos/gallery/hairy-girl-rogue-7589047",
"https://xhamster.com/photos/gallery/hairy-girl-rogue-7588988",
"https://xhamster.com/photos/gallery/hairy-girl-rachel-7588494",
"https://xhamster.com/photos/gallery/hairy-girl-rabi-7588468",
"https://xhamster.com/photos/gallery/asian-hairy-mature-saya-7587804",
"https://xhamster.com/photos/gallery/mature-hairy-nadia-7581051",
"https://xhamster.com/photos/gallery/mature-hairy-monica-7581031",
"https://xhamster.com/photos/gallery/hairy-girl-matilda-7580830",
"https://xhamster.com/photos/gallery/hairy-girl-lula-7580804",
"https://xhamster.com/photos/gallery/hairy-girl-lily-7576590",
"https://xhamster.com/photos/gallery/hairy-girl-kacie-7576534",
"https://xhamster.com/photos/gallery/hairy-punk-girl-blath-7576446",
"https://xhamster.com/photos/gallery/hairy-girl-geneva-7576415",
"https://xhamster.com/photos/gallery/hairy-girl-avah-7576376",
"https://xhamster.com/photos/gallery/hairy-girl-sheila-7575361",
"https://xhamster.com/photos/gallery/hairy-girl-shylo-7575293",
"https://xhamster.com/photos/gallery/hairy-girl-sian-7575263",
"https://xhamster.com/photos/gallery/hairy-girl-vanna-7573056",
"https://xhamster.com/photos/gallery/hairy-girl-vanessa-7573020",
"https://xhamster.com/photos/gallery/hairy-girl-viki-7572996",
"https://xhamster.com/photos/gallery/hairy-girl-zoe-7572968",
"https://xhamster.com/photos/gallery/mature-hairy-tia-7567635",
"https://xhamster.com/photos/gallery/mature-hairy-violet-7566974",
"https://xhamster.com/photos/gallery/mature-hairy-wander-7566928",
"https://xhamster.com/photos/gallery/mature-hairy-vestacia-7566736",
"https://xhamster.com/photos/gallery/hairy-girl-tequilla-7566607",
"https://xhamster.com/photos/gallery/hairy-girl-tiffany-7566556",
"https://xhamster.com/photos/gallery/hairy-girl-toni-7566516",
"https://xhamster.com/photos/gallery/hairy-skye-7564492",
"https://xhamster.com/photos/gallery/great-scarlett-with-big-meaty-lips-7561979",
"https://xhamster.com/photos/gallery/charlotte-big-lips-big-clit-7561809",
"https://xhamster.com/photos/gallery/lexy-nice-pussy-7561766",
"https://xhamster.com/photos/gallery/mature-stevie-7561725",
"https://xhamster.com/photos/gallery/mature-sable-big-clit-7561684",
"https://xhamster.com/photos/gallery/hairy-mature-petra-7561654",
"https://xhamster.com/photos/gallery/mature-olena-big-pussy-lips-7561577",
"https://xhamster.com/photos/gallery/mature-hairy-pigi-7561541",
"https://xhamster.com/photos/gallery/hairy-punk-girl-sassy-7559477",
"https://xhamster.com/photos/gallery/hairy-mature-nina-7556883",
"https://xhamster.com/photos/gallery/hairy-mature-lisa-7555793",
"https://xhamster.com/photos/gallery/hairy-liandra-7549011",
"https://xhamster.com/photos/gallery/hairy-lauren-big-lips-7544101",
"https://xhamster.com/photos/gallery/hairy-leah-big-clit-7543999",
"https://xhamster.com/photos/gallery/mature-roxy-7543614",
"https://xhamster.com/photos/gallery/hairy-jay-big-lips-7543578",
"https://xhamster.com/photos/gallery/hairy-girl-mati-7543553",
"https://xhamster.com/photos/gallery/hairy-janine-7542059",
"https://xhamster.com/photos/gallery/jamie-big-lips-clit-7542033",
"https://xhamster.com/photos/gallery/asian-jade-puffy-pussy-7541940",
"https://xhamster.com/photos/gallery/jasmine-puffy-lips-7539338",
"https://xhamster.com/photos/gallery/pregnant-nastia-7539277",
"https://xhamster.com/photos/gallery/mature-big-lips-ashley-7539250",
"https://xhamster.com/photos/gallery/mature-big-lips-clit-isabella-7539215",
"https://xhamster.com/photos/gallery/mature-big-lips-clit-christina-7539168",
"https://xhamster.com/photos/gallery/mature-big-lips-clit-ashley-7538984",
"https://xhamster.com/photos/gallery/mature-big-lips-ariel-7538955",
"https://xhamster.com/photos/gallery/mature-hairy-katie-7538540",
"https://xhamster.com/photos/gallery/mature-hairy-jena-7538517",
"https://xhamster.com/photos/gallery/mature-hairy-celine-7538481",
"https://xhamster.com/photos/gallery/hairy-susanna-7538433",
"https://xhamster.com/photos/gallery/mature-hairy-sadie-7533506",
"https://xhamster.com/photos/gallery/mature-hairy-olga-7533442",
"https://xhamster.com/photos/gallery/mature-hairy-alice-7533368",
"https://xhamster.com/photos/gallery/mature-annabella-7488818",
"https://xhamster.com/photos/gallery/hairy-girl-abigail-7483109",
"https://xhamster.com/photos/gallery/asian-nari-clit-and-lips-7480497",
"https://xhamster.com/photos/gallery/big-pierced-clit-7475769",
"https://xhamster.com/photos/gallery/big-pussy-alexia-7474079",
"https://xhamster.com/photos/gallery/hairy-ashlin-big-clit-7471984",
"https://xhamster.com/photos/gallery/big-lips-hairy-pussy-7471952",
"https://xhamster.com/photos/gallery/dolly-butterfly-pussy-7471889",
"https://xhamster.com/photos/gallery/charlie-butterfly-pussy-7471826",
"https://xhamster.com/photos/gallery/adrian-puffy-lips-7471162",
"https://xhamster.com/photos/gallery/brooke-7458639",
"https://xhamster.com/photos/gallery/hairy-rose-7452146",
"https://xhamster.com/photos/gallery/hairy-mature-isabella-7452123",
"https://xhamster.com/photos/gallery/mature-nina-7451916",
"https://xhamster.com/photos/gallery/big-pussylips-nevaen-7451876",
"https://xhamster.com/photos/gallery/collection-vaginas-7416363",
"https://xhamster.com/photos/gallery/some-big-lips-7409583",
"https://xhamster.com/photos/gallery/ivy-big-holes-7324858",
"https://xhamster.com/photos/gallery/misc-asians-spread-part-2-7245926",
"https://xhamster.com/photos/gallery/violet-m-7239587",
"https://xhamster.com/photos/gallery/misc-asians-spread-part-1-7207665",
"https://xhamster.com/photos/gallery/hairy-juliette-7207296",
"https://xhamster.com/photos/gallery/latoya-hairy-pussy-7207146",
"https://xhamster.com/photos/gallery/japan-girl-mia-7204508",
"https://xhamster.com/photos/gallery/torri-all-big-7204498",
"https://xhamster.com/photos/gallery/alison-big-lips-7203100",
"https://xhamster.com/photos/gallery/hairy-lexy-meaty-lips-7198741",
"https://xhamster.com/photos/gallery/bulge-1-7195288",
"https://xhamster.com/photos/gallery/lucy-big-lips-7195258",
"https://xhamster.com/photos/gallery/big-pussy-lips-from-behind-2-7174307",
"https://xhamster.com/photos/gallery/big-pussy-lips-from-behind-7172196",
"https://xhamster.com/photos/gallery/aali-forest-pussy-7125575",
"https://xhamster.com/photos/gallery/karmen-great-pussy-7125519",
"https://xhamster.com/photos/gallery/big-lips-ariana-7043730",
"https://xhamster.com/photos/gallery/big-lips-angel-7043673",
"https://xhamster.com/photos/gallery/big-lips-amara-7043637",
"https://xhamster.com/photos/gallery/big-lips-alice-7043618",
"https://xhamster.com/photos/gallery/big-labia-alexis-7039004",
"https://xhamster.com/photos/gallery/big-lips-kristen-7001462",
"https://xhamster.com/photos/gallery/mature-hairy-flower-6978781",
"https://xhamster.com/photos/gallery/young-hairy-mia-6978733",
"https://xhamster.com/photos/gallery/blonde-sam-spread-6968653",
"https://xhamster.com/photos/gallery/mature-trisch-6905830",
"https://xhamster.com/photos/gallery/mature-lexi-6904999",
"https://xhamster.com/photos/gallery/mature-carol-big-lips-and-clit-6904967",
"https://xhamster.com/photos/gallery/mature-brandi-spread-outer-pussy-lips-6904937",
"https://xhamster.com/photos/gallery/anna-big-lips-6904549",
"https://xhamster.com/photos/gallery/older-alice-big-lips-6904460",
"https://xhamster.com/photos/gallery/nickey-long-labia-6901182",
"https://xhamster.com/photos/gallery/mature-hairy-lisa-6901111",
"https://xhamster.com/photos/gallery/mature-alissa-big-pussy-6901098",
"https://xhamster.com/photos/gallery/mature-angela-big-lips-6901064",
"https://xhamster.com/photos/gallery/hairy-mature-victoria-6900846",
"https://xhamster.com/photos/gallery/mature-big-lips-livia-6900816",
"https://xhamster.com/photos/gallery/mature-inga-big-pussy-6900777",
"https://xhamster.com/photos/gallery/mature-marlin-hairy-pussy-6900745",
"https://xhamster.com/photos/gallery/hairy-mature-maria-6898344",
"https://xhamster.com/photos/gallery/mature-lucinda-6898298",
"https://xhamster.com/photos/gallery/mature-hairy-alabama-spread-6897135",
"https://xhamster.com/photos/gallery/preggo-gabi-puffy-lips-6897050",
"https://xhamster.com/photos/gallery/cameltoe-6874770",
"https://xhamster.com/photos/gallery/hairy-mature-ada-6858940",
"https://xhamster.com/photos/gallery/misc-butterfly-pussy-lips-6826008",
"https://xhamster.com/photos/gallery/hairy-jenna-spread-6825547",
"https://xhamster.com/photos/gallery/hairy-carli-spread-6825524",
"https://xhamster.com/photos/gallery/mature-ivette-pulling-pussy-lips-6825479",
"https://xhamster.com/photos/gallery/hairy-isabell-6825433",
"https://xhamster.com/photos/gallery/hairy-khalisa-6825414",
"https://xhamster.com/photos/gallery/mature-nina-spread-6825400",
"https://xhamster.com/photos/gallery/hairy-mature-milly-spread-6824010",
"https://xhamster.com/photos/gallery/hairy-luna-6823128",
"https://xhamster.com/photos/gallery/hairy-eleanor-6822435",
"https://xhamster.com/photos/gallery/hairy-bianka-pussy-lips-6820900",
"https://xhamster.com/photos/gallery/mature-melissa-lips-6820772",
"https://xhamster.com/photos/gallery/mature-taylor-with-big-clit-and-lips-6820684",
"https://xhamster.com/photos/gallery/mature-macy-big-lips-6820622",
"https://xhamster.com/photos/gallery/hairy-mahonia-6818803",
"https://xhamster.com/photos/gallery/hairy-big-lips-6818503",
"https://xhamster.com/photos/gallery/miscelaneous-pussy-pump-last-part-6778581",
"https://xhamster.com/photos/gallery/miscellaneous-pussy-pump-part-4-6775992",
"https://xhamster.com/photos/gallery/miscellaneous-pussy-pump-part-3-6775954",
"https://xhamster.com/photos/gallery/miscellaneous-pussy-pump-part-2-6772878",
"https://xhamster.com/photos/gallery/miscelaneous-pussy-pump-part-1-6772686",
"https://xhamster.com/photos/gallery/mature-vanessa-spread-6772438",
"https://xhamster.com/photos/gallery/mature-lizzy-spread-6772397",
"https://xhamster.com/photos/gallery/big-hairy-simone-6768818",
"https://xhamster.com/photos/gallery/greatest-flowers-6766171",
"https://xhamster.com/photos/gallery/mature-yelena-spread-6766115",
"https://xhamster.com/photos/gallery/hairy-mature-laufy-spread-6766082",
"https://xhamster.com/photos/gallery/mature-kat-spread-6766031",
"https://xhamster.com/photos/gallery/big-lips-big-clit-hairy-annie-6765356",
"https://xhamster.com/photos/gallery/nice-pussy-alesia-6765278",
"https://xhamster.com/photos/gallery/big-lips-alexia-6765246",
"https://xhamster.com/photos/gallery/big-clit-and-lips-bunny-6765229",
"https://xhamster.com/photos/gallery/big-lips-adrianne-6765196",
"https://xhamster.com/photos/gallery/big-lips-alexa-6765163",
"https://xhamster.com/photos/gallery/big-lips-adriana-6765044",
"https://xhamster.com/photos/gallery/bog-lips-alex-6764995",
"https://xhamster.com/photos/gallery/hairy-latoya-big-lips-6763104",
"https://xhamster.com/photos/gallery/morgan-big-clit-and-outer-lips-6758512",
"https://xhamster.com/photos/gallery/big-pussy-lips-janelle-6758484",
"https://xhamster.com/photos/gallery/hazel-big-clit-6755172",
"https://xhamster.com/photos/gallery/sabrina-spread-big-lips-6753886",
"https://xhamster.com/photos/gallery/ash-big-o-lips-and-clit-6753840",
"https://xhamster.com/photos/gallery/tril-big-pussy-lips-and-clit-6744555",
"https://xhamster.com/photos/gallery/big-pussy-lips-from-behind-6744511",
"https://xhamster.com/photos/gallery/older-lenka-with-great-pussy-lips-6742562",
"https://xhamster.com/photos/gallery/mia-big-clit-6742542",
"https://xhamster.com/photos/gallery/great-pussy-lips-6740957",
"https://xhamster.com/photos/gallery/hanging-lips-6740851",
"https://xhamster.com/photos/gallery/mature-janey-spread-6738602",
"https://xhamster.com/photos/gallery/mature-roberta-spread-6738482",
"https://xhamster.com/photos/gallery/mature-poppy-spread-6738401",
"https://xhamster.com/photos/gallery/mature-anne-spread-6738341",
"https://xhamster.com/photos/gallery/mature-rose-spread-6738295",
"https://xhamster.com/photos/gallery/mature-carla-spread-6738259",
"https://xhamster.com/photos/gallery/hairy-lips-and-clit-1-6738179",
"https://xhamster.com/photos/gallery/inez-hairy-1-6738149",
"https://xhamster.com/photos/gallery/honey-hairy-4-6737928",
"https://xhamster.com/photos/gallery/honey-hairy-3-6737920",
"https://xhamster.com/photos/gallery/honey-hairy-2-6737905",
"https://xhamster.com/photos/gallery/honey-hairy-1-6737899",
"https://xhamster.com/photos/gallery/outer-lips-6736011",
"https://xhamster.com/photos/gallery/labia-6735844"
)

 thePagePhotoNoList = c(35,38,29,101,28,25,41,30,36,32,35,25,33,25,32,37,32,25,28,33,77,23,35,25,30,41,39,41,32,18,47,30,346,77,39,46,24,23,158,52,42,56,70,79,40,24,75,27,58,28,32,26,24,28,28,25,37,15,32,31,27,25,30,28,19,31,20,27,28,30,41,37,12,31,11,27,30,22,25,14,24,22,21,13,28,23,11,18,31,10,23,27,17,20,22,18,26,30,30,19,27,20,21,15,19,21,25,17,21,21,21,21,21,23,25,19,22,19,22,24,20,20,16,17,19,18,24,9,55,26,22,24,16,17,20,18,30,17,30,18,25,31,18,19,21,15,30,11,20,19,20,18,21,24,22,21,20,22,24,22,26,18,16,14,18,21,22,21,19,27,25,23,24,23,26,27,27,15,23,15,41,25,38,29,22,21,26,37,33,25,27,19,27,33,31,28,28,20,16,18,52,32,22,22,19,24,20,22,31,25,22,20,23,17,18,32,25,16,18,23,17,22,29,28,69,17,15,24,14,15,19,13,21,19,35,30,31,31,26,39,21,15,15,15,15,21,25,51,31,17,31,19,17,15,14,25,23,17,30,26,23,22,18,10,10,34,23,16,47,15,10,32,19,15,16,14,16,11,19,33,11,10,11,11,15,14)

 lentheList = length(thePageList)
 theExcludeList = c()

 wholeData = ""
 fullPageNo = 60

# the loop to process pages
 cat("list length: ",lentheList,"\n")
 for(i in 1:lentheList){
	cat("\n", i, ". ")
	photoNos = thePagePhotoNoList[i]

	lastPageRemainder = photoNos %% fullPageNo
	allPageNos = photoNos %/% fullPageNo

	if (lastPageRemainder !=0) {allPageNos = allPageNos +1}

	theURL = paste0(urlHead, thePageList[i])
	wholeData = c(wholeData, processPages(theURL))

	if (allPageNos >1) {
		for(k in 2:allPageNos){
			cat(k, " ")
			theURL = paste0(urlHead, thePageList[i], "/", k)
			wholeData = c(wholeData, processPages(theURL))
		}
	}

 }
# gives output
	thepageHead = readLines('picViewerHead.txt', warn = F)
	thepageTail = readLines('picViewerTail.txt', warn = F)
	sink(paste0(thefileName,".html"))
	cat(thepageHead, sep="\n")
	cat(wholeData, sep="\n")
	cat(thepageTail, sep="\n")
	sink()

	startstr="start chrome.exe --start-fullscreen \""
	shell(paste0(startstr, dirStr,"/", paste0(thefileName,".html")))

