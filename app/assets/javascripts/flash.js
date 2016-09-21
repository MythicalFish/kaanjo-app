//document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
  
  var notice = $('.flash');

  if(notice.is('*')) {
    setTimeout(function() {
      notice.slideUp();
    },4000);
  }

});
