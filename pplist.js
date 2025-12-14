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
showlong = true
longLength = 50
favListObj = {};
MAX_ARRAY_SIZE = 20

// Initialize historyarray with default value or from localStorage
let historyArray = [];
const STORAGE_KEY = 'historyArrayData';

loadArrayFromLocalStorage();
console.log('LocalStorage key:', STORAGE_KEY);
console.log('Current array:', historyArray);
displayArray()


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
  if(showlong){
    topicNo = topicNo + longLength
    showLongTopic()
  }else{
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
    if (tipsNamesubstr === "archive" || tipsNamesubstr === "nudexxx" || tipsNamesubstr === "pornpic" || tipsNamesubstr === "xhamFot"|| tipsNamesubstr === "xhamVid" || tipsNamesubstr === "pornhub"|| tipsNamesubstr === "SEXYPIC"|| tipsNamesubstr === "xhamste") {
      topic = lineHeader + topic + lineTail
    }
  
    document.querySelector('#question').innerHTML = topic;
    document.querySelector('#questionsLeft').innerHTML = topicNo;
    document.querySelector('body').focus();
    gototop()
  }
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
  if(showlong){
    topicNo = topicNo - longLength
  }
  if (topicNo >= 0) {
    showTopic();
  }else if(topicNo === 0) {
      jpBut.classList.disabled = true;
  }else{
      jpBut.classList.disabled = false;
  }
}

function jpback() {
  if(showlong){
    topicNo = topicNo - longLength *2
    if(topicNo<0){topicNo = 0}
    showLongTopic()
  }else{
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


function randommyFav() {  // choose not from favList
  let favList = JSON.parse(localStorage.getItem('favList')) || [];
  ArrayPtr = Math.floor(Math.random() * favList.length);
  tipsListName = favList[ArrayPtr]
  $("#totalLen").html(tipsListName);
  loadArray(tipsListName)
}

function randommyChoice() {  // choose not from favList
  let favList = JSON.parse(localStorage.getItem('favList')) || [];
  let resultArray = optionsArray.filter(item => !favList.includes(item));

  ArrayPtr = Math.floor(Math.random() * resultArray.length);
  tipsListName = resultArray[ArrayPtr]
  $("#totalLen").html(tipsListName);
  loadArray(tipsListName)
}

function loadArray(filename) {
  tipsListName = filename
  addItem(tipsListName)

  if(filename == "xxxImgsListOK"){
    url = "allHtmls/xxxImgsListOK.js"
  }else if(filename == "auntjudys"){
    url = "pornpics/auntjudys.js"
  }else if(filename == "favorites"){
    url = "favorites.js"
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
  }else if(filename.substring(0, 6) == "tumblr"){
    url = "tumbler/"+filename+".js"
  }else{
    url = filename + ".js"
  }
    script = document.createElement('script');
    script.src = "https://williamkpchanhp.github.io/scripts/"+url
    script.type = 'text/javascript';

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

       if (localStorage.getItem("favListObj") === null) {
         favListObj = {};
       } else{
         favListObj = JSON.parse(localStorage.getItem("favListObj"));
       }

       init()  // showTopic
       showmarkList(markList)
console.log("url\n",url,"\nlineHeader:\n",lineHeader,"\n\n")
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

// this is for pplistExam to show long list and put at bottom
function showLongTopic() {
 fullTopic = ""
 showlength = longLength
 if(questionList.length<longLength){showlength = questionList.length}

 let favList = JSON.parse(localStorage.getItem('favList')) || [];
 if (favList.includes(tipsListName)) {
   document.querySelector('#location').innerHTML = "❤️"+topicNo;
 }else{
   document.querySelector('#location').innerHTML = topicNo;
 }

 for( i = 0; i < showlength; i++){
  topicNo = topicNo + 1;
  if (topicNo > questionList.length) { topicNo = 0}

  var pointer = topicNo;
  topic = questionList[pointer];
  tipsNamesubstr = tipsListName.substring(0, 7)
    if (tipsNamesubstr === "archive" || tipsNamesubstr === "nudexxx" || tipsNamesubstr === "pornpic" || tipsNamesubstr === "xhamFot"|| tipsNamesubstr === "xhamVid" || tipsNamesubstr === "pornhub"|| tipsNamesubstr === "SEXYPIC"|| tipsNamesubstr === "tumblr*"|| tipsNamesubstr === "xhamste") {
    topic = lineHeader + topic + lineTail
  }
  fullTopic = fullTopic +"<br>"+ topic
 }
  document.querySelector('#question').innerHTML = fullTopic;
  document.querySelector('#questionsLeft').innerHTML = topicNo;
  document.querySelector('body').focus();
  gototop()
}


function addFav() {
    let favList = JSON.parse(localStorage.getItem('favList')) || [];
    if (!favList.includes(tipsListName)) {
        favList.push(tipsListName);
        localStorage.setItem('favList', JSON.stringify(favList));
        alert(`${tipsListName} added to favorites!`);
    } else {
        alert(`${tipsListName} is already in favorites.`);
    }
}

function rmFav() {
    let favList = JSON.parse(localStorage.getItem('favList')) || [];
    if (favList.includes(tipsListName)) {
        favList = favList.filter(item => item !== tipsListName);
        localStorage.setItem('favList', JSON.stringify(favList));
        alert(`${tipsListName} removed from favorites.`);
    } else {
        alert(`${tipsListName} is not in favorites.`);
    }
}



function showFav() {
    const favList = JSON.parse(localStorage.getItem('favList')) || [];
    const favListDiv = document.getElementById('favList');
    //favListDiv.innerHTML = favList.length ? favList.join(' ') : 'No favorites added.';
    if(favList.length >0){
      favListStr = ""
      for ( i = 0; i < favList.length; i++) {
        favListStr = favListStr + "<span class='redbut' onclick=loadArray('" + favList[i]
        + "')>"
        + favList[i]
        + "</span> "
      }
      document.querySelector('#favList').innerHTML = favListStr;
    }else{
      document.querySelector('#favList').innerHTML = "<br><y>search result: <r>None!</r></y><br>";
    }

}

function hideFav() {
      document.querySelector('#favList').innerHTML = "";
}

function recfavList(modList, modListValue) {
  if (!favListObj[modList]) {
    favListObj[modList] = []; // Initialize as empty array if doesn't exist
  }
  favListObj[modList].push(modListValue);
  serializedObj = JSON.stringify(obj);
  localStorage.setItem("favListObj", serializedObj);
}

$(document).ready(function() {
 $("img").dblclick( function() {
    imgsrc = this.src;
    pointer = questionList.findIndex(question => question.includes(imgsrc));
 console.log(imgsrc, pointer)
    //recfavList(tipsListName, modListValue)
 });
});


// This is localStorage management
// show status messages
// display the array
// load array from localStorage
// save array to localStorage
// add a random item to the array
// clear the array
// Event listeners


// Function to display the array
function displayArray() {
  if (historyArray.length === 0) {
    arrayDisplay.innerHTML = '<span class="empty-array">Array is empty.</span>';
  } else {
    arrayDisplay.textContent = JSON.stringify(historyArray, null, 2);
  }
}

// Function to load array from localStorage
function loadArrayFromLocalStorage() {
  try {
    const storedData = localStorage.getItem(STORAGE_KEY);
    
    if (storedData) {
        historyArray = JSON.parse(storedData);
        console.log(`Array loaded from localStorage with ${historyArray.length} items`, 'success');
    } else {
        // Initialize with default data if nothing is stored
        historyArray = [];
        console.log('No data found in localStorage. Using default array.', 'info');
    }
  } catch (error) {
    console.error('Error loading from localStorage:', error);
    historyArray = ["Error loading data"];
    console.log('Error loading data from localStorage. Using empty array.', 'error');
  }
  
  displayArray();
}

// Function to save array to localStorage
function saveArrayToLocalStorage() {
  try {
    console.log(`historyArray.length to save: ${historyArray.length} items`);
    console.log("historyArray: ",historyArray);

    historyArray = [...new Set(historyArray)];

    localStorage.setItem(STORAGE_KEY, JSON.stringify(historyArray));
    console.log(`Array saved to localStorage with ${historyArray.length} items`, 'success');
  } catch (error) {
    console.error('Error saving to localStorage:', error);
    console.log('Error saving data to localStorage', 'error');
  }
  displayArray();
}

// Function to add a random item to the array
function addRandomItem() {
  const items = [
    "Random Item " + Math.floor(Math.random() * 1000),
    "New Entry " + Date.now().toString().slice(-4),
    "Sample Data " + Math.floor(Math.random() * 100),
    "Test Item " + String.fromCharCode(65 + Math.floor(Math.random() * 26)),
    "Generated at " + new Date().toLocaleTimeString()
  ];
  
  const randomItem = items[Math.floor(Math.random() * items.length)];
  historyArray.push(randomItem);
  displayArray();
  console.log(`Added: "${randomItem}" to the array`, 'info');
}

// Function to add an item to the array
function addItem(theItem) {
  historyArray.push(theItem);
  if (historyArray.length >= MAX_ARRAY_SIZE) {
      // Remove the first (oldest) item
      lastRemovedItem = historyArray.shift();
      console.log(`Removed oldest item: "${lastRemovedItem}"`, 'warning');
  }
console.log("historyArray to save: ", historyArray)
  saveArrayToLocalStorage();
}

// Function to clear the array
function clearArray() {
  if (historyArray.length > 0) {
    historyArray = [];
    displayArray();
    console.log('Array cleared', 'info');
  } else {
    console.log('Array is already empty', 'info');
  }
}


// Disable right-click context menu
document.addEventListener('contextmenu', function(e) {
    e.preventDefault();
});


$("body").on( "swipeleft", function( event ) {jpback();} );
$("body").on( "swiperight", function( event ) {jpButClick();});
//$("img").click( "jpButClick()");

randommyChoice()
