app.emoticons = {
  add: function (id) {
    e = $('#emoticon-selection').find('.emoticon[data-id="' + id + '"]');
    e.removeClass('hide');
    e.find('input[type="checkbox"]').prop('checked', true);
    app.modal.hide('#emoticon-library');
  }
}