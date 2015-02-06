(function() {
  window.Kirari.Routers.AppsRouter = Backbone.Router.extend({
    initialize: function (options) {
      if ( $('#features-container').size() > 0 ) {
        new Kirari.Views.FeaturesWindowView({
          el: '#features-container'
        })
      }

      new Kirari.Views.BodymapView
    }
  , routes: {
    }
  })
}).call(this);
