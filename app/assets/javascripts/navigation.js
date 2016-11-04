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

$(document).on( 'click', '.tab', function () {
  $('.tab-active').removeClass('tab-active');
  $(this).addClass('tab-active');
  target = $('.tab-content[data-position="' + $(this).attr('data-position') + '"]').addClass('tab-active');
});