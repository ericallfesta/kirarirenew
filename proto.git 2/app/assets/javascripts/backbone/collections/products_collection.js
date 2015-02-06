(function(){
  window.Kirari.Collections.ProductsCollection = Backbone.Collection.extend({
    initialize: function(models, options) {}
  , pages: 0
  , total: 0
  , queries: {}
  , parse: function(resp, xhr) {
      this.pages = resp.pages
      this.total = resp.total
      this.queries = resp.queries
      return resp.result
    }
  , model: Kirari.Models.ProductModel
  , url: '/search/result.json'
  })
}).call(this);
