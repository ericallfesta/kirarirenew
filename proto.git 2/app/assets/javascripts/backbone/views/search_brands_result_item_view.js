(function(){
  window.Kirari.Views.SearchBrandsResultItemView = Backbone.View.extend({
    tagName: 'li'
  , initialize: function() {
      this.$el.html('<a href="#" class="search_item" data-id="'+this.model.get("id")+'">' + this.model.get("name_with_kana") + '</a>')
    }
  })
}).call(this)
