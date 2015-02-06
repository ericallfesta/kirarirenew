/**
 *= require jquery
 *= require jquery_ujs
 *= require underscore
 *= require underscore.string
 *= require backbone
 *= require backbone_rails_sync
 *= require backbone_datalink
 *= require backbone/kirari
 *= require modernizr
 *= require_tree ./lib
 *= require_tree ./components
 */

window.JST || (window.JST = [])

if (typeof console == 'undefined' || typeof console.log == 'undefined') {
  var console = { log: function (){} }
}

$(function() {
  // Include underscore.string into underscore
  _.mixin(_.string.exports());

  window.Kirari.Workspace = {
    global_header: new Kirari.Views.GlobalHeaderView,
    init: function(router, root) {
      if ( typeof root == 'undefined' ) root = '/'
      this.router = new router()
      if ( typeof Backbone.history == 'undefined' ) {
        Backbone.history = new Backbone.History()
      }
      if ( Modernizr.history ) {
        Backbone.history.start({ pushState: true, root: root })
      } else {
        Backbone.history.start({ root: root })
      }
    }
  }
})
