document.addEventListener("turbolinks:load", function() {

  var notice = $('.flash');

  if(notice.is('*')) {
    setTimeout(function() {
      notice.slideUp();
    },4000);
  }

});
