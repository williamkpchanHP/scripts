<base target="_blank"><html><head><title>thehappybuttonBatch: 74</title>
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
<div class="tip-number" onclick="forward()" ondblclick="randomNum()">thehappybuttonBatch: 74</div>
<br>
<pre class="js-tip"></pre>
<button class="tip-button" onclick="forward()">Tips Left: <span class="tip-limit-count"></span></button>
<br>

<br>
<script>
// List of JavaScript tips
var tipsList = [
'',
'<k>https://xhamster.com/photos/gallery/a-girl-and-her-toys-16110556</k>',
'MTc4ZmM4OGQyNWZmNDNkNzgzOTg5NzExNDFiZjNlM2Q/jpeg/000/515/557/857',
'MzYxMjc0MmMwMzBjNDUwYTMzMDkzMDE4OWQwYjExNzM/jpeg/000/515/557/856',
'NzI0ODk0YzQ3OTk3MDQ1OWM1M2VjODJiZDUzODhiNmQ/jpeg/000/515/557/855',
'N2M4YWJmMzhhZWJkMTQ0ZjEzMGU2NTQzMGU0MzIzMjM/jpeg/000/515/557/854',
'YjhmYTk2NjNmMGFhNTFiMzg3ZmJhZDE4ODQ3NzdkMDI/jpeg/000/515/557/853',
'YzllMjNhODc0YzNjYTQwYzg4YWQ1YWVhNzk3YjM1ZTI/jpeg/000/515/557/852',
'Mzc1ZTAwMjc0ZDVlNTVhMDc5ODI4MzFiMmYyODBkN2I/jpeg/000/515/557/851',
'ZDdmNzFkOWJiZDA4YzlkMjdmNWUwYTg4NjdhMDlkMDA/jpeg/000/515/557/850',
'ZDU4M2Y5MWQ1ZDg0NWEzMGM4MjBhZTkxOGMzNGM4NWM/jpeg/000/515/557/849',
'<k>https://xhamster.com/photos/gallery/working-on-my-tan-lines-16340492</k>',
'MDNjMGIwNmU5YjhkOWIyYzI0MmQ3NWFhNzkwOWI3ODA/jpeg/000/518/156/429',
'M2IzOGViOWQ4YTNhZTJjMjAxYWY2ODdhNTY5MzY0ZTA/jpeg/000/518/156/428',
'ZWNiMmNjYTljYmJiM2U2NDhlZjhlOWMzMjRiZWI0OTQ/jpeg/000/518/156/427',
'YjEwZTM4MmJjMjM5MzMwMTkwZTY0YmFjZTM1NTFkMzg/jpeg/000/518/156/426',
'Y2I0ODMxN2EyM2M2NGE0YmE0ZmMwMTRkYWNiOGYxZjE/jpeg/000/518/156/425',
'NmI2MjM5ZjRjMDZiYzhlYjFmZWVlMTA0MTVhNzQxNjM/jpeg/000/518/156/424',
'MGViNTgxZGJlODNjM2Q4MjZjNjViNzI5N2I3MjM1OWU/jpeg/000/518/156/422',
'ZGZiMjcwYzA1ODg5NDU3M2E3ZjVkNGM5ZGJkMDY5MjQ/jpeg/000/518/156/421',
'<k>https://xhamster.com/photos/gallery/natural-16270070</k>',
'MzY5MDc3ZjUxNWYwOWJkMGIwZGNiZWY4ZTgzYjU4ZWI/jpeg/000/517/495/024',
'ZTA2OTVjNzhmMjliYmJiMmE2YzNiMTljYjIwZmNiZjU/jpeg/000/517/495/028',
'YWE0NjFhM2JhMTQ4ZmVjYmMwZmMzNTU2OGI0ZDVmN2Y/jpeg/000/517/495/027',
'NzgwNjBiM2M3MjAyYjAyYzQyNWJlYmUzNTU5YzIwNmI/jpeg/000/517/495/026',
'NTQyYzQ2YWM4NjM3NjJhNTQ1YThiYmJjNjBmYzYxNDQ/jpeg/000/517/495/025',
'<k>https://xhamster.com/photos/gallery/happy-thankgiving-now-lets-eat-16093318</k>',
'YjM1MTBiMzYzMjQ2YTU3MTBkZDE5YzYyZmMyN2U2M2M/jpeg/000/515/332/844',
'ZTc0OTgxZWMxNTE3YjdlODJhNDAzNjEyZWNhMmQ3NDM/jpeg/000/515/332/847',
'N2ZmZTI2MGY3YzcwZTExNzMwZTRmNGMxN2RkZDA2NWY/jpeg/000/515/332/846',
'MzAyZTk0NGQzMWNjZDM0NDBlZDlhZGIxM2Q1YjUwYWM/jpeg/000/515/332/845',
'ZjU4ZjAwMmY0ZjVhNmZjMjY1NDFhMDRjNjNmMzkzYjI/jpeg/000/515/332/843',
'<k>https://xhamster.com/photos/gallery/some-bunny-is-having-fun-16084425</k>',
'MTNlOTdkM2UyOGMyODFmODQ3NmUyNzcwNjBhOTc3YzY/jpeg/000/515/213/376',
'ZWU5ZTlkNmYwMTdhZDI3N2UxZmYwZTI5NmQxMTFkYjc/jpeg/000/515/213/375',
'N2YyMzkxNWMwZGVmNzk2NDEyN2M0NDE4YTMwMjgyZTQ/jpeg/000/515/213/372',
'Yzc4OTIxZTZlNjYxMTVmNGE1ZmMzZWRjZWZjYzhhYTU/jpeg/000/515/213/371',
'<k>https://xhamster.com/photos/gallery/isn-t-she-pretty-16250280</k>',
'NGM5NmVjMDc4YzY1ZTYzZDI3N2E4YTc5ODU0ZmI0N2Q/jpeg/000/517/289/812',
'OTY0ZmE5ODk0YmUxNDIxMzY1ZjRhNGI2ZTM5MzRhYTI/jpeg/000/517/289/815',
'OWEzMjMwOWEzN2VmYzY4MGNiN2RiMjVmYzJkYmRhMmI/jpeg/000/517/289/814',
'YTU4N2UwNjI3YzA1YTE0OTJhZGI4MTJkYWYwMzFlODM/jpeg/000/517/289/813',
'<k>https://xhamster.com/photos/gallery/back-from-vacation-16262225</k>',
'NjBjZmRmNjhiN2I2YmNhNDA5NjY0MDViODU4ZDU1OWY/jpeg/000/517/401/554',
'MDBmMThlZmQzZmM0ZGE1Mzk2MjFlMjE4YmU2ODNiZDY/jpeg/000/517/401/555',
'ZDRlYzhmNWVlZjQ3YjMxNDE4NzFhYWExZTE3MTIzYjE/jpeg/000/517/401/556',
'<k>https://xhamster.com/photos/gallery/suck-my-clit-16106888</k>',
'ZTNkNDU4YmRhMTJmYTNjOTFiYTM5ZmE4MTgxMjJiYTQ/jpeg/000/515/510/101',
'ZDk4NTIyOGI2OTI1NDgzZWQ5NzllNTg5YmQ1NjVkYjc/jpeg/000/515/510/100',
'<k>https://xhamster.com/photos/gallery/black-panties-16345427</k>',
'N2JiZWY1Njc5NWQ3NDVhMzQyYzRmMjAzZDE3MDgwMDE/jpeg/000/518/190/652',
'ZTcyM2M3MjYzZTE4MzIyMGJmNTRjMmZhNzJmZDUzODU/jpeg/000/518/190/653',
'<k>https://xhamster.com/photos/gallery/a-little-suction-16235946</k>',
'MjgxMTk5ZWI2NDYxZTlmNzk1NTA5NjFhZmExNzkyNTQ/jpeg/000/517/130/229',
'ZmVjNDk0MjRiZDA3M2Q4MTE2M2QwZjdhZjgzMWE0YzA/jpeg/000/517/130/228',
'NTdjMmU2ZTcyNDEwNTVmNzdiODM0YTE2YjU2Mzk1ZWM/jpeg/000/517/130/227',
'ZTM1Y2U4ZDg4NGE2NTE1YzFmZTc4ZTExNjRkNDJmNWU/jpeg/000/517/130/226',
'Y2JiODM5ZjRlMTQ0MzFhMTExODg0YWEzOTE1ZmY5MmI/jpeg/000/517/130/225',
'ODk5ZmEwOGE4NWVhYjhiZGE3YmViMDIxODNlY2RiOTY/jpeg/000/517/130/224',
'ODJjNDhkZTg4YzIxZmRjNWExNmIwZmQ2YjhjMTljNTM/jpeg/000/517/130/223',
'MDYxYmI2ZTRmYWNkYzQxMWNlMWNlMzU2ZWNhMmI3NmQ/jpeg/000/517/130/222',
'N2ZhZmIzNDRiMmQxOWYzZmM3ODdmODY3ODYxNWQ5YWM/jpeg/000/517/130/247',
'NjFmYjljMmZlOTA0MDY3YWY1YzdkN2I2NDgzMzYzZWI/jpeg/000/517/130/246',
'<k>https://xhamster.com/photos/gallery/wanna-taste-16086901</k>',
'MjA1YWZhOTljNzQ1OTI1YWQ5MmNhYTFlOTBhY2MyYzg/jpeg/000/515/253/777',
'<k>https://xhamster.com/photos/gallery/touch-myself-16225208</k>',
'ZWJlNjM3ZDM5ODBkZThhMTQ2NTA4YzhlY2E0NjU5ODY/jpeg/000/517/014/420',
'<k>https://xhamster.com/photos/gallery/snug-as-a-bug-16241493</k>',
'ZjIxNzg0N2RkNjlmZjAwYzFkMzg4MmUxNTlmMTczYWE/jpeg/000/517/197/048',
'<k>https://xhamster.com/photos/gallery/pumped-16090873</k>',
'MDNiZDUxZjI0ZTVkMGQ4YjZhOGQ1MzIyYTMyYTdiM2E/jpeg/000/515/302/073',
'<k>https://xhamster.com/photos/gallery/peak-a-boo-16089857</k>',
'YjFlMWUyYTA4MjFjN2E0ZmFhZDhjNjE1MzYyZTA3MmU/jpeg/000/515/290/257',
'<k>https://xhamster.com/photos/gallery/back-up-16234595</k>',
'NWE5MTFhMDE2YzA1ZWEzOGUwYmQxZmJkNWEyYjc1YTM/jpeg/000/517/116/451',
'',
];
lineHeader = '<img src="https://ic-ph-nss.xhcdn.com/a/'
lineTail = '_1000.jpg">'
showRange = 60
bookid = "thehappybuttonBatch: 74"
initSelectRange = 30000
showSrcSwitch = true
noShuffle = true;
showHelpTxt = `+ addToIgnoreLst\n- removeFmIgnoreLst\n2 setRange\nA toggle_automode\nb backClick\nc callCalculator\ne scrollTo Bottom\nf forward\nH showHelp\nI setInterval\nr randomNum\nR removeNumFmIgnoreLst\ns setRange\nS toggle_showSrcSwitch\nT alertTotal\nt scrollTo Top\nv viewIgnoreLst\nx showAnswer\nz showTenYear`
</script>

<script src='https://williamkpchan.github.io/showTips.js'></script>
<script src='showLongTips.js'></script>


</body>
</html>

