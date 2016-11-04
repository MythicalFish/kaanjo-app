app.campaign = {

  clone_template: function (id) {
    
    var c = $('.campaign-template[data-id="' + id + '"]');
    
    if (!c.length > 0) return;

    $('#campaign_question').val(c.attr('data-question'));

    c.find('.emoticon').each(function (i, e) {
      var emoticon = $(e);
      app.scenario.populateForm({
        position: i,
        id: emoticon.attr('data-id'),
        label: emoticon.attr('data-label'),
        message: emoticon.attr('data-message'),
        img_src: emoticon.find('img').attr('src')
      });
    });
    
  },

}

app.scenario = {

  target_tab: function (pos) { return $('.emoticon-selector[data-position="' + pos + '"]'); },
  target_form: function (pos) { return $('.scenario-form[data-position="' + pos + '"]'); },

  populateForm: function (attr) {

    tab = app.scenario.target_tab(attr.position);    
    form = app.scenario.target_form(attr.position);    
    
    tab.find('img').attr('src', attr.img_src);
    tab.find('label').html(attr.label);

    form.find('input.label').val(attr.label);
    form.find('input.message').val(attr.message);
    form.find('input.emoticon_id').val(attr.id);

  },

  emptyForm: function (position) {
    
    app.scenario.populateForm({
      position: position,
      id: null,
      label: null,
      message: null,
      img_src: null
    });

  },

  drop: function (position) {
    app.scenario.emptyForm(position);
    app.scenario.target_form(position).addClass('scenario-disabled');
  }

}