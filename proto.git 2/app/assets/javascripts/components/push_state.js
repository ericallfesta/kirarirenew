(function(){
  $(document).on('click', 'a[data-pushstate]', function(event) {
    if ( Backbone.history && Backbone.history._hasPushState ) {
      event.preventDefault()
      if ($(this).hasClass('self-destruct')) $(this).fadeOut('fast', function (){
        Backbone.history.navigate($(this).attr('href'), true)
      })
      else
        Backbone.history.navigate($(this).attr('href'), true)
      return false
    }
  })
}).call(this);
