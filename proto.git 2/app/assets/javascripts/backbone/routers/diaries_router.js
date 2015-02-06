(function() {
  window.Kirari.Routers.DiariesRouter = Backbone.Router.extend({
    initialize: function() {
      if ( Kirari.Comments ) {
        var data = Kirari.Comments
      } else {
        var data = []
      }
      this.collection = new Kirari.Collections.CommentsCollection(data, this._resourceData())
      new Kirari.Views.CommentsListView({
        el: '#current-comments-list'
      , collection: this.collection
      })
      new Kirari.Views.CommentFormView({
        el: '#new-comment'
      , collection: this.collection
      })
    }
  , _resourceData: function() {
      return {
        type: $('#new-comment').attr('data-writing-collection'),
        id: $('#new-comment').attr('data-writing-id')
      }
    }
  })
}).call(this);
