tipsListName = ""
suffleTable = []
ignoreList = [];
ignoreListname = ""
markList = [];
markListname = ""
topicNo = ""
topic = ""
actualID = ""
questionList = []
shuffleSW = false


const selectElement = document.getElementById('myChoice');
optionsArray.forEach(optionText => {
 const option = document.createElement('option');
 option.value = optionText; // Set the value attribute
 option.textContent = optionText; // Set the display text
 selectElement.appendChild(option); // Append the option to the select
});

function init() {
    listItem = "Array names: "
     for (variableName in window) { // list all window objects
        if (window[variableName] instanceof Array) { 
          listItem = listItem + ", " + variableName; 
        }
     }

  $("#totalLen").html(tipsListName+": "+questionList.length);
  topicNo = questionList.length;
  shuffle(questionList)
  showTopic()
}

function shuffle(array) {
 suffleTable = Array.from(Array(questionList.length).keys()) // cannot use eq sign

 if(shuffleSW){
   currentIndex = array.length;
   while (currentIndex != 0) {
     randomIndex = Math.floor(Math.random() * currentIndex);
     currentIndex--;
     [array[currentIndex], array[randomIndex]] = [array[randomIndex], array[currentIndex]];
     [suffleTable[currentIndex], suffleTable[randomIndex]] = [suffleTable[randomIndex], suffleTable[currentIndex]];
   }
 }else{
   topicNo = Math.floor(Math.random()  * questionList.length)
 }
}

function showTopic() {
  topicNo = topicNo - 1;
  if (topicNo < 0) { topicNo = questionList.length-1}
  actualID = suffleTable[topicNo]

  while(ignoreList.includes(actualID)){
    topicNo = topicNo - 1
    if (topicNo < 0) { topicNo = questionList.length-1}
    actualID = suffleTable[topicNo]
  }

  var pointer = topicNo;
  topic = questionList[pointer];
  tipsNamesubstr = tipsListName.substring(0, 7)
  if (tipsNamesubstr === "archive" || tipsNamesubstr === "nudexxx" || tipsNamesubstr === "pornpic" || tipsNamesubstr === "xhamFot" || tipsNamesubstr === "pornhub"|| tipsNamesubstr === "SEXYPIC"|| tipsNamesubstr === "xhamste") {
    topic = lineHeader + topic + lineTail
  }

  document.querySelector('#question').innerHTML = topic;
  document.querySelector('#questionsLeft').innerHTML = topicNo;
  document.querySelector('body').focus();
  gototop()
}

function gotoQues() {
  pointer = questionList.length+1
  while(pointer > questionList.length){
    pointer = Number(prompt("goto item number", topicNo))
  }
  showPointerQue(pointer)
}

function randQues() {
  randomPtr = Math.floor(Math.random() * questionList.length);
  showPointerQue(randomPtr)
}

function autojp() {
  //var timeStep = Number(prompt("Please enter period in seconds: ", "7")) * 1000; // Convert to milliseconds
  //var cycleNum = Number(prompt("Please enter cycle number: ", "50"));
  var timeStep = 6*1000
  var cycleNum = 50
  if (timeStep > 0 && cycleNum > 0) {
    let count = 0; // Initialize counter
    //$("#automode").html("<r>Auto:On</r>")
    const intervalId = setInterval(() => {
      jpback();
      count++;
      if (count >= cycleNum) {
        clearInterval(intervalId); // Stop the interval
      }
    }, timeStep);
  }
  //$("#automode").html("<lg>Auto:Off</lg>")
}

function showPointerQue(pointer) {
  topicNo = pointer;
  showTopic()
  //var topic = questionList[pointer];
  //document.querySelector('#question').innerHTML = topic;
  //document.querySelector('#questionsLeft').innerHTML = topicNo;
  //document.querySelector('body').focus();
  gototop();
}

function gototop() {
  window.scrollTo(0,0);
}

function ignoreIt() {
  actualID = suffleTable[topicNo]
  ignoreList.push(actualID);
  ignoreListStr = ignoreList.join(" ");
  localStorage.setItem(ignoreListname, ignoreListStr)
  document.querySelector('#schRst').innerHTML = "<br><y>topic ignored:</y> <r>" + topicNo + "</r>"
}

function markIt() {
  actualID = suffleTable[topicNo]
  markList.push(actualID);
  markList = [...new Set(markList)];
  markListStr = markList.join(" ");
  localStorage.setItem(markListname, markListStr)
  showmarkList(markList)
}
function recordIt() {
  let tipsListNamedata = JSON.parse(localStorage.getItem(tipsListName)) || []
  tipsListNamedata.push(topic)
  localStorage.setItem(tipsListName, JSON.stringify(tipsListNamedata))

console.log("recordIt: ",tipsListName, topic)
  //localStorage.setItem(keyname, value)
}
function clearIt() {
  window.localStorage.removeItem(tipsListName);
console.log("clearIt: ",tipsListName, topic)
}

function summaryIt() {
  const value = localStorage.getItem(tipsListName);
  const itemdiv = document.createElement('div');
  itemdiv.textContent = `tipsListName: ${tipsListName}, Value: ${value}`;

  const storageList = document.getElementById('localStorageList');
  storageList.innerHTML = ''; // Clear previous content
  storageList.appendChild(itemdiv);
}

function findkeyword() {
  keyword = ""
  while(keyword == ""){
    keyword = prompt("enter keyword to search: ", keyword)
  }

  keyword = keyword.toLowerCase();
  targetNum = [];

  for ( i = 0; i < questionList.length; i++) {
    searchString = questionList[i].toLowerCase();

    if(typeof(searchString)=="string"){
      searchResult = searchString.indexOf(keyword);
      if(searchResult >= 0){
        targetNum.push(i);
      }
    }
  }

  if(targetNum.length >0){
    targetNumStr = ""
    for ( i = 0; i < targetNum.length; i++) {
      targetNumStr = targetNumStr + "<span class='redbut' onclick=showPointerQue("
      + targetNum[i]
      + ")>"
      + targetNum[i]
      + "</span> "
    }
    document.querySelector('#schRst').innerHTML = "<br><y>search result:</y> <r>" + keyword+ "</r><br>" + targetNumStr;
  }else{
    document.querySelector('#schRst').innerHTML = "<br><y>search result: <r>None!</r></y><br>";
  }
  window.location = '#schRst';
}

$(".answer").click(function () {
   $(this).toggleClass("appear");
});

function jpButClick() {
  var jpBut = document.querySelector('#jumpButton');
  if (topicNo >= 0) {
    showTopic();
  }else if(topicNo === 0) {
      jpBut.classList.disabled = true;
  }else{
      jpBut.classList.disabled = false;
  }
}

function jpback() {
  topicNo = topicNo + 2;
  actualID = suffleTable[topicNo]
  while(ignoreList.includes(actualID)){
    topicNo = topicNo + 2
    console.log("\ninside topicNo ",topicNo, "actualID ",actualID)
    if (topicNo >= questionList.length) { topicNo = 0}
    actualID = suffleTable[topicNo]
  }
  if (topicNo <= questionList.length){
      showTopic()
  } else {
    topicNo = questionList.length -1;
      showTopic()
  }
}

function chkKey() {
  var testkey = getChar(event);
  if(testkey == 'b'){jpback();}
  else if(testkey == 'f'){jpButClick();}
  else if(testkey == 'F'){findkeyword();}
  else if(testkey == 'i'){ignoreIt();}
  else if(testkey == 'm'){markIt();}
  else if(testkey == 'g'){gotoQues();}
  else if(testkey == 's'){speak();}
  else if(testkey == 't'){gototop();}
  else if(testkey == 'R'){randommyChoice();}
  else if(testkey == 'r'){randQues();}
  else if(testkey == 'e'){window.scrollTo(0,document.body.scrollHeight);}
  else{chkOtherKeys(testkey)} 
}
function getChar(event) {
  if (event.which!=0 && event.charCode!=0) {
    return String.fromCharCode(event.which)   // the rest
  } else {
    return null // special key
  }
}

function useChosen() {
  var myChoice = document.getElementById("myChoice");
  var choiceIndex = myChoice.selectedIndex;
  tipsListName = myChoice.options[choiceIndex].text // first to know the question name
  loadArray(tipsListName)
}

function randommyChoice() {
  ArrayPtr = Math.floor(Math.random() * optionsArray.length);
  tipsListName = myChoice.options[ArrayPtr].text // first to know the question name
  loadArray(tipsListName)
}

function loadArray(filename) {
  tipsListName = filename
  if(filename == "xxxImgsListOK"){
    url = "allHtmls/xxxImgsListOK.js"
  }else if(filename == "auntjudys"){
    url = "pornpics/auntjudys.js"
  }else if(filename == "favorites"){
    url = "pornpics/favorites.js"
  }else if(filename == "TumblerVideos"){
    url = "tumbler/TumblerVideos.js"
  }else if(filename == "tumblrList"){
    url = "tumbler/tumblrList.js"
  }else if(filename == "phubStars"){
    url = "pohub/phubStars.js"
  }else if(filename == "pohubVid"){
    url = "pohub/pohubVid.js"
  }else if(filename == "puhbBatch2024"){
    url = "pohub/puhbBatch2024.js"
  }else if(filename == "booklist"){
    url = "allHtmls/booklist.js"
  }else if(filename.substring(0, 8) == "archiveg"){
    url = "archivegalleries/"+filename+".js"
  }else if(filename.substring(0, 7) == "nudexxx"){
    url = "nudexxx/"+filename+".js"
  }else if(filename.substring(0, 7) == "pornpic"){
    url = "pornpics/"+filename+".js"
  }else if(filename.substring(0, 7) == "xhamFot"){
    url = "xham/"+filename+".js"
  }else if(filename.substring(0, 7) == "xhamste"){
    url = "xham/"+filename+".js"
  }else if(filename.substring(0, 7) == "pornhub"){
    url = "pohub/"+filename+".js"
  }else{
    url = filename + ".js"
  }
    script = document.createElement('script');
    script.src = "https://williamkpchanhp.github.io/scripts/"+url
    script.type = 'text/javascript';
console.log("src ", script.src)
    script.onload = function () { // remember to put all waiting jobs inside here 
       questionList = eval(filename);
       ignoreListname = "ignore" + filename
       markListname = "mark" + filename
       if (localStorage.getItem(ignoreListname) === null) {
         ignoreList = [];
       } else{
         ignoreList = localStorage.getItem(ignoreListname).split(' ').map(Number);
       }

       if (localStorage.getItem(markListname) === null) {
         markList = [];
       } else{
         markList = localStorage.getItem(markListname).split(' ').map(Number);
       }
       init()  // showTopic
       showmarkList(markList)
    };

    document.head.appendChild(script);
}

function seekListName() {
  findkeyword = ""
  while(findkeyword == ""){
    findkeyword = prompt("enter list name to search for: ", findkeyword)
  }

  findkeyword = findkeyword.toLowerCase();
  targetListNum = [];

  for ( i = 0; i < optionsArray.length; i++) {
    searchString = optionsArray[i].toLowerCase();

    if(typeof(searchString)=="string"){
      searchResult = searchString.indexOf(findkeyword);
      if(searchResult >= 0){
        targetListNum.push(i);
      }
    }
  }

  if(targetListNum.length >0){
    targetListNumStr = ""
    for ( i = 0; i < targetListNum.length; i++) {
      targetListNumStr = targetListNumStr + "<span class='redbut' onclick=loadArray('"+optionsArray[targetListNum[i]]
      + "')>"
      + optionsArray[targetListNum[i]]
      + "</span> "
    }
    document.querySelector('#schRst').innerHTML = "<br><y>search result:</y> <r>" + findkeyword+ "</r><br>" + targetListNumStr;
  }else{
    document.querySelector('#schRst').innerHTML = "<br><y>search result: <r>None!</r></y><br>";
  }
  window.location = '#schRst';
}


function showmarkList(markList) {
  if(markList.length >0){
    markListStr = ""
    markList = [...new Set(markList)];

    for ( i = 0; i < markList.length; i++) {
      markListStr = markListStr + "<span class='redbut' onclick=showPointerQue("
      + suffleTable.indexOf(markList[i])
      + ")>"
      + suffleTable.indexOf(markList[i])
      + "</span> "
    }
    document.querySelector('#markLst').innerHTML = "<br><y>marked Topics:</y> " + markListStr+ "<br>"
  }else{
    document.querySelector('#markLst').innerHTML = "<br><y>marked Topics: <r>None!</r></y><br>";
  }
}

$("body").on( "swipeleft", function( event ) {jpback();} );
$("body").on( "swiperight", function( event ) {jpButClick();});
$("img").click( "jpButClick()");

randommyChoice()
