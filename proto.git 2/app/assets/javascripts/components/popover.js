$(function(){
  console.log("Loading Component PopOver")
  $('[data-popover]').on('mouseover', function(event) {
    $(this).append('<div class="popover">'+$(this).attr('data-popover')+'</div>')
    $(this).one('mouseleave', function(event) {
      $(this).find('.popover').remove().empty()
    })
  })
})
