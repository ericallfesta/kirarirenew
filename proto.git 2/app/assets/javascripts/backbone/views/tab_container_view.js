(function(){
  window.Kirari.Views.TabContainerView = Backbone.View.extend({
    initialize: function() {
      this.on('toggle', this.toggleTab, this)
      this.render()
    }
  , render: function() {
      this.$el.find('.tabs .item > a').each(function(index, target) {
        $(this).addClass('tab')
      })
      return this
    }
  , events: {
    }
  , toggleTab: function(type) {
      this.$('.active').removeClass('active')
      this.$('[data-tab="'+type+'"] .tab').addClass('active')
      this.$('.tab-panel[data-tab="'+type+'"]').addClass('active')
    }
  })
}).call(this);
