(function(){
  window.Kirari.Collections.CommentsCollection = Backbone.Collection.extend({
    initialize: function(models, options) {
      if ( typeof options != 'undefined' ) {
        this.type = options['type']
        this.id = 1*options['id']
      } else {
        this.type = 'none'
        this.id = 0
      }
    }
  , model: Kirari.Models.CommentModel
  , url: function() {
      return _.sprintf('/%s/%d/comments', this.type, this.id)
    }
  })
}).call(this);
