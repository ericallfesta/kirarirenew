(function(){
  window.Kirari.Views.BodymapView = Backbone.View.extend({
    el: '#bodymap',
    initialize: function() {
      $(window).on('keydown', _.bind(this.keydown, this))
    }
  , events: {
      'click .part': 'clickBodyPart',
      'click .close': 'closePanel',
      'mouseover .part': 'showPop',
      'mouseout .part': 'hidePop',
      'mouseover .pop': 'hidePop'
    }
  , clickBodyPart: function(event) {
      event.preventDefault()
      event.stopPropagation()
      var targetPanel = this._targetPanel(event)
      $('#bodymap .panels').fadeIn('fast');
      targetPanel.show();
      if ( typeof this.currentPanel != 'undefined' ) {
        this.currentPanel.fadeOut('fast')
      }
      this.currentPanel = targetPanel
    }
  , closePanel: function(event) {
      if ( typeof this.currentPanel != 'undefined' ) {
        $('#bodymap .panels').fadeOut('fast')
        this.currentPanel.fadeOut('fast')
        this.currentPanel = undefined
      }
    }
  , showPop: function(event) {
      $(event.currentTarget).addClass('hover')
    }
  , hidePop: function(event) {
      $(event.currentTarget).closest('.hover').removeClass('hover')
      
      event.stopPropagation()
    }
  , keydown: function(event) {
      if ( (event.keyCode == 8 /* BACKSPACE */ || event.keyCode == 243 /* ESC */ ) && $("*:focus").size() == 0 ) {
        this.closePanel()

        event.preventDefault()
      }
    }
  , _targetPanel: function(event) {
      return $('#bodymap .panels .panel.'+$(event.currentTarget).data('target'))
    }
  })
}).call(this)
