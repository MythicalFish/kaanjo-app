app.modal = {
  
  show: function (target) {
    
    $('#modal').css('display', 'block');
    $('#modal > div').css('display', '');
    $(target).css('display', 'block');
    setTimeout(function () {
      $('#modal').css('opacity', 1);
      $(target).delay(500).css('opacity', 1);
    }, 50);

  },

  hide: function () {
  
    $('#modal > div').css('opacity', 0);
    $('#modal').delay(500).css('opacity', 0);
    
    setTimeout(function () {
      $('#modal > div').css('display', '');
      $('#modal').css('display', '');
    }, 500);
    
  }
}

$(document).on('click', '#modal', function (e) {
  if($(e.target).is('#modal'))
    app.modal.hide($(this));
});