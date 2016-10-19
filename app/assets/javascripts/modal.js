app.modal = {
  show: function (target) {
    $(target).removeClass('hide');
    $(target).css('opacity', 1).delay(500).find('.modal-box').css('opacity', 1);
  },
  hide: function (target) {
    $(target).find('.modal-box').css('opacity', 0)
    setTimeout(function () { $(target).css('opacity', 0); }, 500);
    setTimeout(function () { $(target).addClass('hide'); }, 1050);
  }
}