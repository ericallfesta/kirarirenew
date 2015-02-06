(function(){
  window.Kirari.Views.RequestFormView = Backbone.View.extend({
    initialize: function() {
    }
  , events: {
      'click h3': 'toggle',
      'submit': 'submit',
    }
  , toggle: function (event) {
      event.preventDefault()
      event.stopPropagation()

      this.$el.toggleClass('show')
    }
  , submit: function (event) {
      event.preventDefault()
      event.stopPropagation()

      this.$el.addClass('loading')

      var newRequest = new window.Kirari.Models.Request()
      newRequest.set('body', this.$('[name=body]').val())
      newRequest.save({}, { success: _.bind(this.success, this) })
    }
  , success: function (data) {
      this.$el.removeClass('loading')
      this.$el.addClass('complete')
      this.$('[name=body]').val('')

      var $this = this
      var hideTimer = setTimeout(function (){
        $this.hide()
      }, 3000)
    }
  , hide: function () {
      var $this = this;
      $('.complete .complete').animate({
        opacity: 0
      }, function (){
        $this.$el.removeClass('complete')
        $this.$el.removeClass('show')
        $('.complete').css('opacity', 1)
      })
    }
  })
}).call(this);
