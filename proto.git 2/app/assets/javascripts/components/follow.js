$(function(){
  $('.btn-follow').on('ajax:success', function(data, textStatus, jqXHR) {
    var target = $(data.currentTarget)

    if ( textStatus == '' ) {
      target.next().addClass('active')
    } else {
      target.prev().addClass('active')
    }
    target.removeClass('active')
  })
})
