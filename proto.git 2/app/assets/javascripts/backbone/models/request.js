(function(){
  window.Kirari.Models.Request = Backbone.Model.extend({
    url: '/requests.json'
  , toJSON: function() {
      return { request: _.clone( this.attributes ) }
    }
  })
}).call(this);
