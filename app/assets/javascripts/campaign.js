app.campaign = {

  clone_template: function (id) {
    
    var c = $('.campaign-template[data-id="' + id + '"]');
    
    if (!c.length > 0) return;

    $('#campaign_question').val(c.attr('data-question'));

    c.find('.emoticon').each(function (i, e) {
      app.emoticon.clone($(e));
    });
    
  },

}

app.emoticon = {

  clone: function (emoticon) {
    
    position =  emoticon.attr('data-position');
    id =        emoticon.attr('data-id');
    label =     emoticon.attr('data-label');
    message =   emoticon.attr('data-message');
    img_src =   emoticon.find('img').attr('src');

    target_tab =  $('.emoticon-selector[data-position="' + position + '"]');
    target_form = $('.emoticon-form[data-position="' + position + '"]');

    target_tab.find('button').css('background-image', 'url("' + img_src + '")');
    target_tab.find('label').html(label);

    target_form.find('input.label').val(label);
    target_form.find('input.message').val(message);
    target_form.find('input.emoticon_id').val(id);

  }

}