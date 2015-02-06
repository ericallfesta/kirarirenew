(function(){
  window.Kirari.Routers.ProductsRouter = Backbone.Router.extend({
    initialize: function() {
      this.newReportForm = new Kirari.Views.NewReportFormView({
        model: new Kirari.Models.Report()
      })
      this.newQuestionForm = new Kirari.Views.NewQuestionFormView({
        model: new Kirari.Models.Question()
      })
    }
  , routes: {
      'products/:id#report': 'openReport',
      'products/:id#question': 'openQuestion'
    }
  , openReport: function() {
      this.newReportForm.$el.trigger('open')
    }
  , openQuestion: function() {
      this.newQuestionForm.$el.trigger('open')
    }
  })
}).call(this);
