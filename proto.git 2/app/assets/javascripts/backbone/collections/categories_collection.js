(function(){
  window.Kirari.Collections.CategoriesCollection = Backbone.Collection.extend({
    initialize: function(models, options) {}
  , model: Kirari.Models.CategoryModel
  , url: '/categories.json'
  })
}).call(this);
