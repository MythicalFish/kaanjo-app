$(document).ready(function () {
  
  
  app.rangepicker = $('.datepicker .range-selector');

  if (!app.rangepicker.is('*')) return;

  app.rangepicker.dateRangePicker({}).
  bind('datepicker-change',function(e,o) {
    from = o.value.split(' to ')[0];
    until = o.value.split(' to ')[1];
    window.location = window.location.href.split('?')[0] + '?t=range&f='+from+'&u='+until;
  });
  
  /*
  app.datepicker = $('.datepicker');

  if (!$('.datepicker').is('*'))
    return;

  $('*').on('click', function () {
    if (!$(this).is('.datepicker *'))
      app.datepicker.find('ul:not(.hide)').addClass('hide');
  });

  $('body').on('click', '.datepicker span', function () {
    setTimeout(function () {
      app.datepicker.find('ul').removeClass('hide');
    }, 50);
  });
  */

});
