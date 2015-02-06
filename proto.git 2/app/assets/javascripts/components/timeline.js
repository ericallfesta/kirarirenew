$(function(){
  $('.data-link').on('click', function () {
    location.href = $(this).attr('data-href')
  })
})
