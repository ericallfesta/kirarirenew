$(function () {
  var $list = $('<ul id="variation-list"></ul>')
  $('.variation-title').each(function () {
    var targetId = $(this).closest('.variation').data('variation-id')
    $list.append('<li data-variation-id="' + targetId + '">' + $(this).text() + '</li>')
  })
  $list.appendTo('body')

  $('.variation-title').on('click', function (e) {
    if ($list.is(':visible')) return
    var offset = $(this).offset()
    var menuTopPos = offset.top + $(this).height()
    var currentId = $(this).closest('.variation').data('variation-id')
    var closeFunc = function () {
      $(document).off('.closer')
      $list.off('.closer')
      $('.variation-title').off('.closer')
      $('li', $list).off('.closer')
      $list.fadeOut()
    }

    $list
      .css({
        top: menuTopPos + 'px',
        left: offset.left + 'px'
      })
      .fadeIn({
        duration: 'fast',
        easing: 'swing',
        step: function (n) {
          $(this).css('top', menuTopPos + 10 * n)
        }
      })

    $('li', $list).removeClass('active')
    $('li[data-variation-id=' + currentId + ']', $list).addClass('active')

    $('.variation-title').on('click.closer', closeFunc)
    $(document).on('click.closer', closeFunc)
    $('li', $list).on('click.closer', function () {
      var targetId = $(this).data('variation-id')
      // show this variation data and recalculate toggle-ellipsis
      $('.variations .variation').removeClass('active')
      var $target = $('.variations .variation[data-variation-id=' + targetId + ']').addClass('active')
      $('.toggle-ellipsis', $target).trigger('recalculate')

      updateImageList(targetId);

      closeFunc()
    })

    e.stopPropagation()
  })

  function updateImageList(activeVariationId) {
    var activeVariationId = activeVariationId || $('.variations .variation').first().data('variation-id')
    // hide images other variations have
    $('.product-images .variation-image[data-variation-id!=' + activeVariationId + ']').hide()
    $('.product-images .variation-image[data-variation-id=' + activeVariationId + ']').show()

    // set first visible image 'active' if ex-active image is hidden
    if ($('.product-images .active').eq(0).is(':hidden')) {
      $('.product-images .active').removeClass('active')
      $('.product-images .image-select:visible').first().trigger('mouseover')
    }
  }
  updateImageList();
})