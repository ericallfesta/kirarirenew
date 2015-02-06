(function(){
  window.Kirari.Views.KirariButtonView = Backbone.View.extend({
    initialize: function() {
    }
  , events: {
      'click': 'click'
    }
  , click: function(event) {
      event.preventDefault()
      event.stopPropagation()

      if (this.$el.hasClass('done')) return false;

      var Fav = Backbone.Model.extend({
        url: this.$el.attr('href')
      })

      var newFav = new Fav()

      newFav.save({}, {
        success: _.bind(this.success, this)
      , error: _.bind(this.error, this)
      })
    }
  , success: function(model) {
      this.$el.addClass('done')
      this.$('.msg').html(model.get('msg'))
      $('.count', this.$el.closest('.krr-btn-container')).html(model.get('count'))
      console.log(this.$el.closest('.krr-btn-container'))
    }
  , error: function(data) {
    }
  })
}).call(this);
