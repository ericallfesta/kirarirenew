(function(){
  window.Kirari.Views.NewReportFormView = Backbone.View.extend({
    el: '#new-report-form'
  , initialize: function() {
    }
  , events: {
      'open': 'open'
    }
  , open: function() {
      this.$el.fadeIn()
      linefix()
      $('textarea.autosize').autosize({ append : '\n\n' }).trigger('autosize.resize');
    }
  })
}).call(this);
