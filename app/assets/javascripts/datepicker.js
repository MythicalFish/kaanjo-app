//document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
  
  if(!$('.datepicker').is('*'))
    return;

  app.datepicker = $('.datepicker').first();

  $('*').on('click', function() {
    if( !$(this).is( '.datepicker *' ) )
      $('.datepicker ul:not(.hide)').addClass('hide');
  });

  $('body').on('click', '.datepicker span', function() {
    setTimeout(function() {
      app.datepicker.find('ul').removeClass('hide');
    },50);
  });

  $('.datepicker .range-selector').dateRangePicker({}).
  bind('datepicker-change',function(e,o) {
    from = o.value.split(' to ')[0];
    until = o.value.split(' to ')[1];
    window.location = window.location.href.split('?')[0] + '?t=range&f='+from+'&u='+until;
  });

});
