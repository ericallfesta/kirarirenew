(function(){
  window.Kirari.Collections.BrandsCollection = Backbone.Collection.extend({
    initialize: function(models, options) {}
  , model: Kirari.Models.BrandModel
  , url: '/brands.json'
  })
}).call(this);
