$(function(){
  console.log('Loading component: Tabs')
  $('.tabs-container .tabs').on('click', '.tab', function() {
    console.log('click')
    var tabName = $(this).closest('[data-tab]').attr('data-tab')
    $(this).closest('.tabs').find('.active').removeClass('active')
    $(this).addClass('active')
    $(this).closest('.tabs-container').find('.tab-panel.active').removeClass('active')
    $(this).closest('.tabs-container').find('.tab-panel[data-tab="'+tabName+'"]').addClass('active')
  })
})
