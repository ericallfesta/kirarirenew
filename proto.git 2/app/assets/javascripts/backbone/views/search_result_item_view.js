(function(){
  window.Kirari.Views.SearchResultItemView = Backbone.View.extend({
    tagName: 'li'
  , initialize: function(options) {
      this.$el.html('<a href="' + options['href'] + '" class="search_item">' + options['label'] + '</a>')
      this.$el.addClass(options['class'])
    }
  })
}).call(this)
