(function() {
  window.Kirari.Routers.SearchBasicRouter = Backbone.Router.extend({
    initialize: function (options) {
      /* brands = new Kirari.Collections.BrandsCollection()
      brands.fetch({ reset: true })
      new Kirari.Views.SearchBrandsByKanaView({ collection: brands })
      new Kirari.Views.BodymapView */
      var productCollection = new Kirari.Collections.ProductsCollection()
        , searchView = new Kirari.Views.SearchView({ collection: productCollection })
      new Kirari.Views.ProductsListView({
        el: '#current-products-list'
      , collection: productCollection
      })
    }
  , routes: {
    }
  })
}).call(this);
