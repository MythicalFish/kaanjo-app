//document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
  
  var notice = $('.flash');

  if(notice.is('*')) {
    setTimeout(function() {
      notice.slideUp(100);
    },4000);
  }

});
