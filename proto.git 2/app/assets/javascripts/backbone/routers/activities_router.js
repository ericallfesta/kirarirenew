(function(){
  window.Kirari.Routers.ActivitiesRouter = Backbone.Router.extend({
    initialize: function() {
      this.tabContainer = new Kirari.Views.TabContainerView({
        el: '#activities-container'
      })
    }
  , routes: {
      '' : 'all',
      'activities' : 'all',
      'reports' : 'reports',
      'activities/reports' : 'reports',
      'questions' : 'questions',
      'activities/questions' : 'questions',
      'diaries' : 'diaries',
      'activities/diaries' : 'diaries'
    }
  , all: function() {
      this.tabContainer.trigger('toggle', 'all')
    }
  , reports: function() {
      this.tabContainer.trigger('toggle', 'reports')
    }
  , questions: function() {
      this.tabContainer.trigger('toggle', 'questions')
    }
  , diaries: function() {
      this.tabContainer.trigger('toggle', 'diaries')
    }
  })
}).call(this);
