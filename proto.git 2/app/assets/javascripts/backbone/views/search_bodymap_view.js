(function() {
  window.Kirari.Views.SearchBodymapView = window.Kirari.Views.BodymapView.extend({
    initialize: function () {
      this.on("update", this.update, this)
    }
  , kind: "bodymap"
  , selectedId: undefined
  , events: {
      'click .part': 'clickBodyPart'
    , 'click .close': 'closePanel'
    , 'mouseover .part': 'showPop'
    , 'mouseout .part': 'hidePop'
    , 'mouseover .pop': 'hidePop'
    , 'click [data-tag]': 'tagSelect'
    }
  , tagSelect: function (event) {
      event.preventDefault()
      event.stopPropagation()
      this.selectedId = $(event.target).data("tag")
      this.trigger("update", this)
    }
  , update: function () {
      console.log("update search bodymap view")
    }
  })
}).call(this)
