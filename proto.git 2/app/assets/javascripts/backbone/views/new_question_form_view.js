(function(){
  window.Kirari.Views.NewQuestionFormView = Backbone.View.extend({
    el: '#new-question-form'
  , initialize: function() {
    }
  , events: {
      'open': 'open'
    }
  , open: function() {
      this.$el.fadeIn()
      $('textarea.autosize').autosize({ append : '\n\n' }).trigger('autosize.resize');
    }
  })
}).call(this);
