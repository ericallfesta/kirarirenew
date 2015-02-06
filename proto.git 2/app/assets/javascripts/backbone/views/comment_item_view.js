(function(){
  window.Kirari.Views.CommentItemView = Backbone.View.extend({
    initialize: function(options) {
      this.model.on('change', this.render, this)
      if ( typeof this.template == 'undefined' ) {
        this.template = JST['comments/item']
      }
    }
  , render: function() {
      var $el = $(this.el)
      try {
        if ( this.model.isValid() ) {
          $el.html(this.template({ comment: this.model.attributes }))
        }
      } catch (err) {
        console.log(err)
      }
      return this
    }
  })
}).call(this);
