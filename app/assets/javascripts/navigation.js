app.step = function(target) {
  $('.step').hide();
  $(target).show();
}

$(document).ready(function () {
  $('.tab-state').change(function () {
    $(this).parent().find('.state').each(function () {
      if (this.checked) {
        $(this).attr('aria-selected', 'true');
      } else {
        $(this).removeAttr('aria-selected');
      }
    });
  });
});