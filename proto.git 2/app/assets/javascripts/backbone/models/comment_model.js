(function(){
  window.Kirari.Models.CommentModel = Backbone.Model.extend({
    initialize: function(options) {
      this.collectionType = _.clone(options.type)
      this.collectionId = _.clone(1 * options.id)
    }
  , toJSON: function() {
      return { comment: _.clone( this.attributes ) }
    }
  , url: function() {
      if ( this.collection ) {
        var base = this.collection.url()
        if ( this.isNew() ) {
          return base
        }
        return base + (base.charAt(base.length - 1) == '/' ? '' : '/') + encodeURIComponent(this.id);
      } else {
        return _.sprintf('/%s/%d/comments.json', this.collectionType, this.collectionId)
      }
    }
  });
}).call(this);
