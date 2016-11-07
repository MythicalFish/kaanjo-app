app.campaign = {

  clone_template: function (id) {
    
    var c = $('.campaign-template[data-id="' + id + '"]');
    
    if (!c.length > 0) return;

    $('#campaign_question').val(c.find('.question').text());
    $('#campaign_social_proof').val(c.attr('data-social-proof'));

    c.find('.emoticon').each(function (i, e) {
      var emoticon = $(e);
      app.scenario.populateFields({
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

  tab: function (pos) { return $('.scenario-selector[data-position="' + pos + '"]'); },
  form: function (pos) { return $('.scenario-form[data-position="' + pos + '"]'); },

  populateFields: function (attr) {

    tab = app.scenario.tab(attr.position);    
    form = app.scenario.form(attr.position);    
    
    tab.find('img').attr('src', attr.img_src);
    tab.removeClass('scenario-disabled');
    form.removeClass('scenario-disabled');

    form.find('input.scenario_emoticon-id').val(attr.id);
    form.find('input.scenario_enabled').val(true);

    label1 = tab.find('label');
    if (label1.text().length == 0)
      label1.text(attr.label);
      
    label2 = form.find('input.scenario_label');
    if (label2.val().length == 0)
      label2.val(attr.label);
      
    message = form.find('input.scenario_message');
    if (message.val().length == 0)
      message.val(attr.message);

  },

  disable: function (pos) {
    app.scenario.tab(pos).addClass('scenario-disabled').find('img').attr('src','');
    app.scenario.form(pos).addClass('scenario-disabled').find('input.scenario_enabled').val(false);
  }

}

app.emoticon = {

  upload: function () {
    
  },

  library: function () {
    app.modal.show('#emoticon-library');
  },

  select: function(id) {

    e = $('#emoticon-library').find('.emoticon[data-id="' + id + '"]');      
      
    app.scenario.populateFields({
      position: $('.tab.tab-active').attr('data-position'),
      id: id,
      label: e.attr('data-label'),
      message: null,
      img_src: e.find('img').attr('src') 
    });
      
    app.modal.hide();

  }

}

$(document).on('click', '.scenario-selector.scenario-disabled', function() {
  app.emoticon.library($(this).attr('data-position')); 
});