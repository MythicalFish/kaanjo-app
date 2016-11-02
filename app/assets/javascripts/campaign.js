app.campaign = {

  populate: function (id) {
    var c = $('.campaign-template[data-id="' + id + '"]');
    if (!c.length > 0) return;
    console.log('found');
  },

  add: function (id) {
    e = $('#emoticon-selection').find('.emoticon[data-id="' + id + '"]');
    e.removeClass('hide');
    e.find('input[type="checkbox"]').prop('checked', true);
    app.modal.hide('#emoticon-library');
  },

  getReaction: function (id) {

    $.ajax({
      type: 'GET', url: '/get_reaction_data',
      data: { id: id },
      complete: function(r) {
        console.log(JSON.parse(r.responseText));
      }
    });

  },

  showForm: function (id) {
    $('.emoticon-form').hide();
    $('.emoticon-form[data-id="' + id + '"]').show();
  }
}