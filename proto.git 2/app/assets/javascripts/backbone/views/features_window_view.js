(function(){
  window.Kirari.Views.FeaturesWindowView = Backbone.View.extend({

    // ---- Properties ----

    waitMsec: 5000
  , currentFeatureId: 0
  , renderedOrder: 0
  , windowWidth: 700

    // ---- Backbone methods ----

  , initialize: function() {
      $(window).on('resize', _.bind(this.resize, this))
      this.renderLayout()

      $('#features-container')
        .append('<div class="go-prev"> </div>')
        .append('<div class="go-next"> </div>')
    }

  , events: {
      'click [data-feature-id]': 'toggleFeature',
      'update-order': 'render',
      'update-layout': 'renderLayout',
      'click .go-prev': 'decrementOrder',
      'click .go-next': 'incrementOrder'
    }

  , render: function() {
      if ( this.currentFeatureId == 0 ) {
        this.currentFeatureId = 1*this._firstFeatureSlot().attr('data-feature-id')
      }

      this.$('.active').removeClass('active')
      this._currentFeatureSlot().addClass('active')

      var order = 1*this._currentFeatureSlot().attr('data-order')

      if ( this.renderedOrder != order ) {
        // this.$('.window .inner').animate({ marginLeft: -1*order*this.windowWidth})
        this.$('.window .inner section').css('z-index', 1)
        this.$('.window .inner section').eq(this.renderedOrder).css('z-index', 2)

        var exSection = this.$('.window .inner section');
        var renderedOrder = this.renderedOrder;
        this.$('.window .inner section').eq(order).css('z-index', 3).fadeIn('normal', function () {
          exSection.eq(renderedOrder).hide()
        })

        this.renderedOrder = order
      }
      else {
        this.$('.window .inner section').eq(order).fadeIn('slow')
      }
      if ( typeof this.interval != 'undefined' ) {
        clearInterval(this.interval)
      }
      this.interval = setInterval(_.bind(this.incrementOrder, this), this.waitMsec)
    }

    // ---- Original methods ----

  , renderLayout: function() {
      /*
      this.windowWidth = 1*$("#content").innerWidth()

      var totalWidth = 0
      _.each(this.$('.window .item'), function(item) {
        $(item).css({ left: totalWidth })
        totalWidth = totalWidth + this.windowWidth
      }, this)
      */
      this.render()
    }

  , toggleFeature: function(event) {
      event.preventDefault()
      event.stopPropagation()
      this.currentFeatureId = $(event.target).attr('data-feature-id')
      this.$el.trigger('update-order')
    }

  , decrementOrder: function() {
      var nextFeatureSlot = this._prevFeatureSlot()
      if ( nextFeatureSlot.size() == 0 ) {
        nextFeatureSlot = this._lastFeatureSlot()
      }
      this.currentFeatureId = nextFeatureSlot.attr('data-feature-id')
      this.$el.trigger('update-order')
    }

  , incrementOrder: function() {
      var nextFeatureSlot = this._nextFeatureSlot()
      if ( nextFeatureSlot.size() == 0 ) {
        nextFeatureSlot = this._firstFeatureSlot()
      }
      this.currentFeatureId = nextFeatureSlot.attr('data-feature-id')
      this.$el.trigger('update-order')
    }

  , resize: function() {
      if ( this.windowWidth != $("#content").innerWidth() ) {
        this.$el.trigger('update-layout')
      }
    }

    // ---- Utilitiy methods ----

    /**
     * Get first element has the data-feature-id attribute in .slots element
     *
     * @method _firstFeatureSlot
     * @return {jQuery}
     */
  , _firstFeatureSlot: function() {
      return this.$('.slots [data-feature-id]').first()
    }

    /**
     * Get last element has the data-feature-id attribute in .slots element
     *
     * @method _firstFeatureSlot
     * @return {jQuery}
     */
  , _lastFeatureSlot: function() {
      return this.$('.slots [data-feature-id]').last()
    }

    /**
     * Get current element has the correct data-feature-id attribute in .slots element
     *
     * @method _currentFeatureSlot
     * @return {jQuery}
     */
  , _currentFeatureSlot: function() {
      return this.$('[data-feature-id="'+this.currentFeatureId+'"]')
    }

    /**
     * Get previous element has the data-order attribute is prev in .slots element
     *
     * @method _nextFeatureSlot
     * @return {jQuery}
     */
  , _prevFeatureSlot: function() {
      return this._currentFeatureSlot().parent().prev().find('[data-feature-id]')
    }

    /**
     * Get next element has the data-order attribute is next in .slots element
     *
     * @method _nextFeatureSlot
     * @return {jQuery}
     */
  , _nextFeatureSlot: function() {
      return this._currentFeatureSlot().parent().next().find('[data-feature-id]')
    }
  })
}).call(this)
