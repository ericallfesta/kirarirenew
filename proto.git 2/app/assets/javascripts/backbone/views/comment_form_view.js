(function() {
  window.Kirari.Views.CommentFormView = Backbone.View.extend({
    el: '#new-comment'
  , Comment: Kirari.Models.CommentModel
  , initialize: function() {
      _.bindAll(this, 'updateBody', 'submit')
      this.model = new this.Comment({ body: '' })
      this.model.on('change', this.reflesh, this)
    }
  , events: {
      'blur [name=body]' : 'updateBody',
      'submit' : 'submit'
    }
  , updateBody: function(event) {
      this.model.set('body', this.$('[name=body]').val())
    }
  , reflesh: function(event) {
      this.$('[name=body]').val(this.model.get('body'))
    }
  , submit: function(event) {
      event.preventDefault()
      event.stopPropagation()
      var newModel = new this.Comment(this.model.attributes)
      newModel.collectionType = this.collection.type
      newModel.collectionId = this.collection.id
      newModel.save({}, {
        success: _.bind(function (model) {
          $('.num .figure').text($('.num .figure').text() - - 1);
          $('.no-items').hide()
          this.collection.add(model.attributes)
        }, this)
      })
      this.model.set('body', '')
    }
  });
}).call(this);
