<base target="_blank"><html><head><title>nyxamaraBatch: 112</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="https://williamkpchan.github.io/maincss.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.js"></script>
<script src="https://williamkpchanhp.github.io/LibDocs/literature/proverbs.js"></script>
<script src='../mainscript.js'></script>

</head>
<style>
body { background-color: black; font-size: 18px; color: gray; justify-content: center; align-content: center; width: 100%; margin-left: 0%;}

.tip { width: 100%;}
.code { background-color: #000500; border-radius: 8px; border: 1px solid DarkSlateGray; padding: 5px; }
.tip-number { margin: auto; color: #20A020; text-transform: uppercase; letter-spacing: 0.1rem; font-weight: bolder; font-size: 26px;}
.js-tip, .cssTip, .cssExplain { margin: auto; padding: 2px 2px; font-size: 24px; line-height: 1.5;}
.tip-button { background-color: #003020; outline: none; padding: 10px 10px; display: inline-block; margin: auto; font-size: 1rem; margin-top: 2.5rem; cursor: pointer; font-weight: bolder; border: none; border-radius: 8px; color: #10C030;}
.disabled { background-color: #D8D8D8 !important; color: #888; cursor: not-allowed !important;}
a { text-decoration: none; color: #487878;}
a:visited { color: #784838;}
A:hover {	color: yellow;}
A:focus {	color: red;}
code { color: #488838;; background-color: #001010; font-size: 18px;}
pre { color: gray; background-color: #000500; font-size: 24px; width:100%; white-space: pre-wrap; background-image:inherit;}
pre img {max-width: 100%; display: block; margin-left: auto; margin-right: auto;}
video {width: 60%;}
div {display:inline-block; width:100%; vertical-align:text-top;}
</style>

<body onkeypress="chkKey()">
<br>
<span id="dateAndTime" onclick="showDateAndTime()"><script>showDateAndTime();</script></span>
<div class="tip-number" onclick="forward()" ondblclick="randomNum()">nyxamaraBatch: 112</div>
<br>
<pre class="js-tip"></pre>
<button class="tip-button" onclick="forward()">Tips Left: <span class="tip-limit-count"></span></button>
<br>

<br>
<script>
// List of JavaScript tips
var tipsList = [
'',
'<k>https://xhamster.com/photos/gallery/come-perv-over-me-15787498</k>',
'MTRkNzVjYjQ4NmJiY2JkYmZiZmI1ODFhNjk0OTk0YjU/jpeg/000/495/822/205',
'ZTczYTY4NzBjNjYxZDg4ZTg2NjU0ZWE3OTY0ZTExNDU/jpeg/000/505/737/492',
'NzVmZWQ1MDU2MTBhN2Y4MTNmODA2MTZmOTlhMDNlMDA/jpeg/000/505/737/490',
'NDc1NDQ0NGM2M2UzNTZiOGUwOGJkZDRkMzEwMDEwZDI/jpeg/000/505/737/489',
'MTlhNjYxZWFlOWEyN2RjMDJkZjYzMWM0ZjY0NTJjYzY/jpeg/000/505/737/487',
'MTY1NWRjMzMxZjFjYWVkZDVjYzI3NTE2MTlhM2Q5M2M/jpeg/000/502/624/700',
'NjZkYzlkODQ0ZDE3OWFkYjUyYTc5MmZmM2Q3NGU2Mjk/jpeg/000/502/624/684',
'Y2QwN2M4ZDBhM2I4MzI5M2U0OGU2NTM4MjcwYjNiYzk/jpeg/000/502/624/647',
'YmZjNDE2NTIwNzA1M2JhMDc0Y2IwYzRhMWNiM2NjYzc/jpeg/000/502/624/541',
'ZjNmYjcyMzUxNDJkYmMxZGI5Y2U3MGJiMTZjNjM2ODA/jpeg/000/502/624/513',
'MDcxYTg1YTUwNmFlNmFjMDhjOGJlN2FmZjY2OGMzM2E/jpeg/000/502/624/512',
'MzhiNTQ2OWMwMTk2N2YxYzAyYjdhZDU3YjM3ODRjN2U/jpeg/000/502/624/493',
'NGJiZmI2Yjk3MDRjY2MzZTlkM2ZjZTNlZWVmZjZkNzM/jpeg/000/502/624/466',
'NDcxNjBkOTFmNWMyZjdhYzRjYTg3NTk2Yjg4MWI4NWM/jpeg/000/502/624/460',
'MjZjNDk3ZjhlNTFhYTRlNGYwOTUxMGMwMTk5NGQxMWU/jpeg/000/502/624/427',
'NjkwMjc5NjU5NTAwZmZhZDFlOGJkMzg1YzE5YTc2OWY/jpeg/000/502/624/400',
'NTdlNmVlN2EwOGE1OTg3ZGQ4M2ZhNzdlMWI2YjllOTY/jpeg/000/502/624/390',
'MWFlNTI3ODJlYmEwZWIwZTIwOWI4ZWZkNWQwZmYyMGQ/jpeg/000/502/624/365',
'OGJlYTE4ZTQ4OTQ2NDUwZmE0YmU3YTY1MTNmZGM2ZDk/jpeg/000/502/624/352',
'OGQ5YWIzOTlhMTc1MDkzZjk0YWNlY2FmODFmYzI4OTk/jpeg/000/502/624/329',
'YWI3OTMzY2UwZmU0ZTg5OGE5ODViYjRmMzkyZmNjMTE/jpeg/000/502/624/089',
'ODE2ZGZiMjZlZTFiZWYyZGVkN2JkNjlmYWY1YzBkOGE/jpeg/000/502/624/061',
'YzI3Y2IzOTY3Y2IzZDMyNTAyY2MwNzk5MTdkMjZhMDI/jpeg/000/502/624/051',
'ODZlZTM3MDVhZmQ3NWM4MmFlMzM4Zjc1ODg3YzQ5ZTI/jpeg/000/502/624/028',
'YzJkNjAwZDk0YTJmMDA4ZGJjODFlMjUwYTg3MWY3MzM/jpeg/000/501/154/498',
'YjJhNmI3NjYxNjJkYzI0YmYzZDBlZDUyNTA1NDBkYmM/jpeg/000/501/154/493',
'MjU1MjcxYWJhYTRlNWQyM2M4OTIwMDM1OTMzOWNiMGU/jpeg/000/499/565/450',
'NTYzNDcyN2JkOTExZDFmMDJmODczNWNjYzQ1MmQ3NjE/jpeg/000/499/565/434',
'ZDI2MmFlYzBkM2NkZjg1MjgxYjU5MDNjYTFhYzFhZjc/jpeg/000/497/675/196',
'MzE2MWEyZTk4ZGFiYTZjZGM1Y2E2OGVkZGYxZGNhNjQ/jpeg/000/497/234/910',
'OGQ3NzRkMWI4ZGNmNjk0NzA5NDIxNmNiNWU3YThiZDY/jpeg/000/496/684/775',
'NWZmNjMwMzhiZjVmYmFjNzg1MGFmMTdlYzdlM2FjY2M/jpeg/000/495/890/224',
'Nzg3OTU4OTA5YTAyZTJjOTliZWE3Mjc2YTViYjIwYTE/jpeg/000/495/890/209',
'Zjg4ZjIwZjZlOWM2ODdjYWFlYzYxOGJhMTQzZjdhNTk/jpeg/000/495/890/185',
'MDZjMzEzOGJjOThlYzVlMTc4Yjc1YzQ1MzA1NjM4NTk/jpeg/000/495/890/137',
'OWZmZmY3MzA5M2Y3ODUxYTY2MTE5NTQwNTRhOGJlNWE/jpeg/000/495/890/126',
'ZDYxZjVhZWUzZmRkMjFlZmMxNzVjYzVhMTdlZTJjZGY/jpeg/000/495/890/092',
'ZjdhZTQzZTNkYjkxMzcwZWFlZjU3ZDc5MDJiYjlhOTI/jpeg/000/495/890/075',
'NjhjYTM3MTRmNDk0OTk2Yzg4ZjlkNWUzMzRhZWY3ZTQ/jpeg/000/495/890/056',
'ZjY4MWY1YjY3MDM2MWUyZGE2OGEwZTA1OTIzMjVkNzI/jpeg/000/495/890/016',
'NmQ5NzZmMmRhMjJlNzBmMzAwN2E2OGZmN2ZiMzcxNzM/jpeg/000/495/889/968',
'ZDM2ODg0YTA0NDRiNWIyMDE0MjExMjVmOWU3MmRhMGE/jpeg/000/495/889/961',
'Mzc4ZGUzZjUyZjZhNjVjNDdiYmM5YmM4YTNkODM5MTI/jpeg/000/495/889/944',
'OGFhZDdmZDMxY2I0YmZhMTczYTM4NDk0YzhlNzIwMWY/jpeg/000/495/889/926',
'YzZkYzZhNjRmY2ViNmRlYzUyNjU1MzM5MzVjNDU2MGI/jpeg/000/495/889/332',
'OWRhNWRkYmNlMzMyODdhZWViZDEyNTI0YTVmOTYxNDQ/jpeg/000/495/889/157',
'NTNkNDhkY2FmZjE2YmM0MzRmZWExZmJlMDdhMmFmZDU/jpeg/000/495/822/692',
'YjhkNTc3MTZlNGY1MDMwY2RjMTYwMWFjNDdlNGVmNDM/jpeg/000/495/822/678',
'YjVlMDkwZjg2MDRlMWU2NmQ2MmI2MTU3MDU0Y2U1MGQ/jpeg/000/495/822/488',
'Yzg2Yzc4NWZiNTVhZTY0OGE4NGVlNTQyYTlkZTAzNzI/jpeg/000/495/822/372',
'OTFiOGM4NWI5ODkwNjdlZTIyN2M5MmQ4ZGVjMTQ0NDI/jpeg/000/495/822/202',
'ZDBhNWU3MmE4ZmJiNDY3MDgwNDVmYmExOGQwYzc2MTU/jpeg/000/495/822/201',
'YjgxOWNkNWQyNjliNzcyMGViZjVhYzRmMDRjY2VmZTk/jpeg/000/495/822/200',
'YWM3ZWI4Nzg5M2NmY2EzMDczZmM1OTgwMTIyMTQ0MjQ/jpeg/000/495/822/199',
'<k>https://xhamster.com/photos/gallery/your-new-pupgirl-15787860</k>',
'YTljNjg5OGQ0YmM5MDkwMjVjNmIyZGM0NmZkMDdhNzg/jpeg/000/496/045/944',
'MzEwNWM2ZWRhYWYwMTI3MjVmOWVmMDBlYzljMmYzNjQ/jpeg/000/499/565/235',
'YTk0ODgzM2VlZmY1NzQ4NzdhNmMxNGVmYzNmM2EzNzI/jpeg/000/499/565/227',
'Zjk0MzczYTE4YWVlOTc1ZWM4NGJlOTIxYjRmNzM2ZjU/jpeg/000/499/565/224',
'YjRkNDljZGIwYTM2YzA4YmEwM2NjYTc1YTAwMWQ4MGM/jpeg/000/496/535/114',
'ZjVmZjllM2RkNjE2OWUwZjAzNDZhZTA0NmNkYWRjYzk/jpeg/000/496/535/093',
'OTE3OTNiODNhYjg1ZGFkYWFmZDM0YTUzZDA3MGU5NzE/jpeg/000/496/535/028',
'YmU3OGFlZjVhMzU4OTRhYjE1MzkzZTVjODgyNWJmYTI/jpeg/000/496/535/021',
'NjE1ZThjOTgxZGFhYTdhOWEwYjc3ZDFmMmJlNDZlYzI/jpeg/000/496/534/984',
'NGM3MzI2OWEyYjM4YzM3MTMzZjM4MDljNGQ0NzgwYWI/jpeg/000/496/046/463',
'MWQwNDA2ZTZiMDJlNjdmOGNkZDYxYjczYjFkYmVmZmI/jpeg/000/496/046/446',
'NzhjNTAyYWZiOWMwOWMxY2NmN2Q2OWMxOGU5ZTc2YTA/jpeg/000/496/046/439',
'YzU2ZDJkN2ZmOWRiNmQ3ODMxNWUzM2Q0MGU0ZjVlNjY/jpeg/000/496/046/435',
'MWVmZjJjYTljMjE0OWQ1ZmYxOGM1ZGZlN2Y4Y2JiYmU/jpeg/000/496/046/426',
'YTg0OTYwYThiNWM5MjJhMThkYTZhOTFjMDhmN2FiMTU/jpeg/000/496/046/413',
'OWVhMThlZmJjY2NiNDQ0NTFiNTNmZDc3NmMyZDExOGU/jpeg/000/496/046/403',
'NzFhODc2YTAyOTE4ZjNiN2U5Y2NjNjQ1ODZmZmFiYjU/jpeg/000/496/046/390',
'MWY2ZTQ4MDQ5OGMzMWVkMDJhNzYyNjhkNTM1YzNjYmY/jpeg/000/496/046/369',
'N2UzNThjMTM0NjE5MmY2MjNmNDk5NWRiNGNlZTRhNzY/jpeg/000/496/046/356',
'NmM5MDVlZjNkOTdkZWNlMGNlMmY5ZjMxNWRjMmE2OTA/jpeg/000/496/046/340',
'MTRlNTQ2OGNhMzcyYzViYTM3Mzg2NTI5MjU1YzAwMzg/jpeg/000/496/045/953',
'NDkwNWUyYmZmMDk3MGQwM2UyMjRmODgxZmFhNjBiZTI/jpeg/000/496/045/948',
'OGJiNjk3MTA5YzA2MGJhYjgwOTM3NmM0YzNmMDZjYzE/jpeg/000/496/045/943',
'ZmRiZWRiMmRhMDRkZTRjOGJlOGQ5MWFlMzE4Y2RhZmY/jpeg/000/496/045/927',
'MTc0Yzg4NjUwMzgxYjUxNTI2MGU0OGJlZjNiZDI5MTg/jpeg/000/496/045/893',
'MmY4NGY0YzIwNDk2NWU5MWQyOGRkNzI2MzA2NzliYjc/jpeg/000/496/045/891',
'YWUyYzAzYWU3YzM4YWYwYWQ3ZmQ2YjA3N2I5N2ZlYTc/jpeg/000/496/045/860',
'OGI3MzJlNTQyZjk3ZjFiNDRjNWMzYWNiNDA1YWQwN2U/jpeg/000/496/045/857',
'MzhlMWExOTUzNjA5OGZjOWM4MjYyODBhZDZmZmI2MDI/jpeg/000/496/045/854',
'ZTAzZGFhY2RlNzMyNWY5MDM3NTE2YWU2NTZmNzU3MDA/jpeg/000/496/045/842',
'MWIwOTQ3ZTViMDdhN2FjMmEyYTk4OGU2M2UyNzQ4ZWQ/jpeg/000/496/045/840',
'<k>https://xhamster.com/photos/gallery/wanna-fuck-me-15895301</k>',
'NmViN2MwZGQ0NTlkM2ZkZTk4ZjE5OTgxNGU2YjBiMDQ/jpeg/000/512/029/302',
'MTQ5NmNjOTQ2NDJlYmUzZWY5NjBkODg5ODVmOWRkZDk/jpeg/000/512/029/342',
'NzY5MTMyMjFmOWY0NTZhYjI3ZjM2NmQ1ZmRiOTY4YTA/jpeg/000/512/029/341',
'Mjg1MWI2ZTQ1MjQ0NGIyZjM1NjQ3MTk0NzA0N2Y0Mjk/jpeg/000/512/029/340',
'MzRhM2YyYzQwYTAwN2Q1ZDcyY2ZiNGJjNjc4Y2JiZDg/jpeg/000/512/029/337',
'MjdjZjE1NzdlYjg4ZWE5YWM5Njc2OThmNzcwN2IwYmI/jpeg/000/512/029/336',
'ZDFkZWY3MmM5MTU2OTJhYzQxMzVkY2MxYzI1ZmJkYjI/jpeg/000/512/029/335',
'NTI5MWE0YzM5OTA5NGUxZDQ5NDg2ODc2NWNhYjRhNzI/jpeg/000/512/029/334',
'ZTZjNzgyYzhlYzYxNjY0M2JjZDdjMTUwN2Q5N2NlNGU/jpeg/000/512/029/322',
'MDU3ZThlYmU5ZTRlZGQ5NmJjYWUyNDI1ZjRiZmE5OGU/jpeg/000/512/029/321',
'ZWYzMjU0ZTc2YWUyYjY4ZDEzMDc4Njc5YTkyNzE4Y2U/jpeg/000/512/029/320',
'NGE2NWRiYjM1ODE5OTMwMmI0YTcyMjE3ZjI1ZmY0Mjg/jpeg/000/512/029/318',
'NWZjM2Q5ZDdlNTRhZGEyZWMzNTE4ZDQ4MjJmNDZjZDI/jpeg/000/512/029/316',
'MGQwZjI2MmY0MmIxNDk0MTMwNjg2NDA3MjhlZDAyMTg/jpeg/000/512/029/315',
'ZmQ2Mjc5NDBiY2U3NjEyMjcxYWQ3OGYyMmY0YzZhN2Y/jpeg/000/512/029/314',
'YTU5NzM2ZGE3YTFkZjU1NmQ3OWI4OWE4YzQxNTg2MzQ/jpeg/000/512/029/313',
'M2RmNGY4OTFlNzE5OWE4ODQ5Zjc4OGU2Y2M1MWY4OGE/jpeg/000/512/029/311',
'ZjBiYmQ1YzBhNDdkOTdkYWU3ZjdiNWViYjhiYmM1MDU/jpeg/000/512/029/310',
'MDkzN2ZhY2JkYzhjNjJmNjZlMWNjYjFlMDNiYmE1NmI/jpeg/000/512/029/309',
'YjVhYzcwYjU1ZDI0ZGEwMzA4Y2ZjMDE2MzMxZDAyZTc/jpeg/000/512/029/307',
'NTMwMDQ4MGM4NDYxMGEwNzQ5ZTM4NDMyNTNhZjc5MmM/jpeg/000/512/029/306',
'ODZjMjYyZjkxZGJlNjNhOGMyZTU1MjY0YzRiNmYwOWM/jpeg/000/512/029/305',
'ZGJlYTRmMjdmOTQxMjE0ZjY0N2Y0MDA4MzQ5MmViMTA/jpeg/000/512/029/304',
'YTdlMmY0ZjZhMzNjMjJlZDE1NmE5NjhiZTcyZjMxOGY/jpeg/000/512/029/303',
'',
];
lineHeader = '<img src="https://ic-ph-nss.xhcdn.com/a/'
lineTail = '_1000.jpg">'
showRange = 60
bookid = "nyxamaraBatch: 112"
initSelectRange = 30000
showSrcSwitch = true
noShuffle = true;
showHelpTxt = `+ addToIgnoreLst\n- removeFmIgnoreLst\n2 setRange\nA toggle_automode\nb backClick\nc callCalculator\ne scrollTo Bottom\nf forward\nH showHelp\nI setInterval\nr randomNum\nR removeNumFmIgnoreLst\ns setRange\nS toggle_showSrcSwitch\nT alertTotal\nt scrollTo Top\nv viewIgnoreLst\nx showAnswer\nz showTenYear`
</script>

<script src='https://williamkpchan.github.io/showTips.js'></script>
<script src='showLongTips.js'></script>


</body>
</html>

