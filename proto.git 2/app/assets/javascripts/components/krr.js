$(function() {
  $('[krr-view]').each(function(){
    var viewName = $(this).attr('krr-view')
      , view = window.Kirari.Views[viewName]
    if ( typeof view != 'undefined' ) {
      new view({ el: $(this) })
    }
  })
})
