(function(){
  window.Kirari.Views.ProductsListView = Backbone.View.extend({
    initialize: function() {
      if ( typeof this.collection != 'undefined' ) {
        this.collection.on('reset', this.render, this)
        this.collection.on('add', this.addOne, this)
      }
    }
  , render: function() {
      this.$el.hide().empty()

      if (this.collection.size() > 0)
        this.collection.each(_.bind(this.addOne, this))
      else
        this.$el.html('<li class="notfound">該当する商品が見つかりませんでした。</li>')

      this.$el.fadeIn()
    }
  , addOne: function(model) {
      var newItemView = new Kirari.Views.ProductItemView({
        model: model
      })
      this.$el.append(newItemView.render().el)
    }
  })
}).call(this);
