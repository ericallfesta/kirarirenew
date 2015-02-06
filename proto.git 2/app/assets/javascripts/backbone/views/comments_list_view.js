(function(){
  window.Kirari.Views.CommentsListView = Backbone.View.extend({
    initialize: function() {
      if ( typeof this.collection != 'undefined' ) {
        this.collection.on('reset', this.render, this)
        this.collection.on('add', this.addOne, this)
      }
    }
  , render: function() {
      this.collection.each(_.bind(this.addOne, this))
    }
  , addOne: function(model) {
      var newItemView = new Kirari.Views.CommentItemView({
        model: model
      })
      this.$el.append(newItemView.render().el)
    }
  })
}).call(this);
