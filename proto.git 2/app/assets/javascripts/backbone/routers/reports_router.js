(function() {
  window.Kirari.Routers.ReportsRouter = Backbone.Router.extend({
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

      // copied from search_basic_router
      var productCollection = new Kirari.Collections.ProductsCollection()
        , searchView = new Kirari.Views.SearchView({ collection: productCollection })
      new Kirari.Views.ProductsListView({
        el: '#current-products-list'
      , collection: productCollection
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
