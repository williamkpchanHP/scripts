$("img").click(function() {
 $('img').css('max-height', $(window).height());
 window.location = "#topic-" + topicpointer;
})

$("img").dblclick(function() {
 $('img').css('max-height', '100%');
 window.location = "#topic-" + topicpointer;
})

function pageScroll() {
    window.scrollBy(0,1);
    scrolldelay = setTimeout(pageScroll,10);
}

function randomScroll(){
  topicpointer = Math.floor(Math.random() * topicLength)
  window.location = "#topic-" + topicpointer;
  pageScroll();
}

window.addEventListener('click', function (evt) {
    if (evt.detail === 3) {
      var x = window.scrollX;
      var y = window.scrollY;

      $("body").toggleClass('stop-scrolling');
      window.scrollTo(x, y);
    }
});

