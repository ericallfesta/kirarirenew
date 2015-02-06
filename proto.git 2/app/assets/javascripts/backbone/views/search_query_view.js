(function(){
  window.Kirari.Views.SearchQueryView = Backbone.View.extend({
    el: '#search-by-query'
  , initialize: function (options) {
      this.on("update", this.update, this)
      if (options && options.q) $('[name=q]').val(options.q)
    }
  , q: undefined
  , events: {
      'keydown [name=q]': 'keyDown',
      'click .search-submit': 'submit'
    }
  , keyDown: function (event) {
      if ( event.keyCode == 13 ) { // Enter
        this.q = $(event.target).val()
        this.trigger("update", this)
      }
    }
  , submit: function() {
    this.q = $(this.el).find('[name=q]').val()
    this.trigger("update", this)
  }
  , update: function () {
    }
  })
}).call(this)
