(function() {
  window.Kirari.Views.GlobalHeaderView = Backbone.View.extend({
    el: '#global-header'
  , initialize: function() {
      var self = this
      this.$('[data-dropdown]').each(function(i, target) {
        extend_events = {}
        extend_events['mouseleave .' + $(target).data('container')] = _.bind(function(arg) { self.dropdownHide(arg, target) }, this)
        self.delegateEvents(_.extend(self.events, extend_events))
      })
    }
  , events: {
      'click [data-dropdown]': 'dropdownShow',
      'focus .search-query': 'refreshSearchBar',
      'blur .search-query': 'refreshSearchBar',
      'keydown .search-query': 'refreshSearchBar',
      'keyup .search-query': 'refreshSearchBar',
      'keypress .search-query': 'refreshSearchBar'
    }
  , dropdownShow: function (event) {
      this.$('.'+event.target.dataset.dropdown).show()
      return false
    }
  , dropdownHide: function (event, target) {
      this.$('.'+target.dataset.dropdown).hide()
    }
  , refreshSearchBar: function (event) {
      if ( this.$('.search-query').val() == '' ) {
        this.$('.search-submit').removeClass('active')
      } else {
        this.$('.search-submit').addClass('active')
      }
    }
  })
}).call(this);
