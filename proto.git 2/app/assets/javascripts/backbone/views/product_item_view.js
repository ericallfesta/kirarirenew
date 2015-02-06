(function(){
  window.Kirari.Views.ProductItemView = Backbone.View.extend({
  initialize: function(options) {
      this.model.on('change', this.render, this)
      if ( typeof this.template == 'undefined' ) {
        this.template = JST['products/item']
      }
    }
  , render: function() {
      var $el = $(this.el)
      try {
        if ( this.model.isValid() ) {
          this.setElement(this.template({ product: this.model.attributes }))
        }
      } catch (err) {
        console.log(err)
      }
      return this
    }
  })
}).call(this);
