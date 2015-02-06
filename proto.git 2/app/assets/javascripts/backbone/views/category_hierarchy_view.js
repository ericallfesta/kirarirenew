(function(){
  window.Kirari.Views.CategoryHierarchyView = Backbone.View.extend({
    initialize: function() {
      this.collection.on('reset', this.render, this)
      this.level = parseInt(this.$el.attr('data-hierarchy-level'))
      this.on("update", this.update, this)
    }
  , kind: "categories"
  , level: 0
  , child: undefined
  , selectedId: undefined
  , events: {
      'click .tag-item': 'categorySelect'
    }
  , render: function () {
      this.$el.empty()
      this.collection.each(_.bind(this.addOne, this))
      this.trigger("rendered")
    }
  , addOne: function (model) {
      this.$el.append('<li><a href="#" class="search_item tag-item" data-id="'+model.get('id')+'">'+model.get("name")+'</a></li>')
    }
  , categorySelect: function (event) {
      event.preventDefault()
      event.stopPropagation()
      this.selectedId = $(event.target).data('id')
      this.trigger("update", this)
    }
  , update: function () {
      var level = this.level;
      $('.category-hierarchy').each(function (){
        if (level < $(this).data('hierarchy-level')) $(this).html('')
      })
      this.$('li').removeClass('active')
      this.$('[data-id='+this.selectedId+']').closest('li').addClass('active')
      if ( this.hasChild() ) {
        this.child.collection.fetch({
          reset: true,
          data: { "parent": this.selectedId }
        })
      }
    }
  , hasChild: function() {
      return typeof this.child != 'undefined'
    }
  })
}).call(this)
