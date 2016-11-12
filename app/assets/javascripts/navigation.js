
$(document).on('click', '.step-take', function () {

  step = $(this).parents('.step');

  valid = true;  
  
  step.find('input').each(function () {
    if (!valid) return;
    if (!$(this).valid()) {
      $(this).focus();
      valid = false;
    }
  });

  if (!valid) return;

  target = $(this).attr('data-target');

  if (!target) { target = step.next('.step'); }  
  $('.step').hide();
  $(target).show();

  var progress = $('.progression');

  if (progress.is('*')) {
    var distance = parseInt(progress.attr('data-distance'));
    progress.attr('data-distance', distance + 1);
  }

});

$(document).on( 'click', '.tab', function () {
  $('.tab-active').removeClass('tab-active');
  $(this).addClass('tab-active');
  target = $('.tab-content[data-position="' + $(this).attr('data-position') + '"]').addClass('tab-active');
});