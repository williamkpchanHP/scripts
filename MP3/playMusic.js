var allMusicNames = ['七月落薇花 吳詠梅.mp3', '古典音樂.mp3', '工程機械.mp3', '排簫 24首.mp3', '梁凱莉癡雲.mp3', '程桂蘭  二泉映月.mp3', '輕音樂 26首.mp3', '輕音樂 30首.mp3']
var options = '';  // build the List select option

for (var i = 0; i < allMusicNames.length; i++) {
         options += '<option value="' + './mp3/' +allMusicNames[i]+ '">' + allMusicNames[i] + '</option>';
}
$("#selectMusic").html(options);

function changeAudioSource(source) {
  selectElement = document.getElementById('selectMusic');
  selectedOption = selectElement.value;
  console.log('Selected option: ' + selectedOption);

  soundID = document.getElementById('myaudio');
  soundID.src = selectedOption;
  soundID.load();
  soundID.play();
  soundID.volume = 0.05;
}

