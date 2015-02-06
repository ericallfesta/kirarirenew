$(linefix)

function linefix() {
  var maxHeights = [];
  $('.linefix').each(function () {
    var group = $(this).data('linefix')
    if (typeof maxHeights[group] == 'undefined') maxHeights[group] = 0
    if (maxHeights[group] < $(this).height()) maxHeights[group] = $(this).height()
  })

  for (var group in maxHeights) {
    $('[data-linefix=' + group + ']').height(maxHeights[group])
  }

  var maxWidths = []
  $('.widthfix:visible').each(function () {
    var group = $(this).data('widthfix')
    if (typeof maxWidths[group] == 'undefined') maxWidths[group] = 0
    if (maxWidths[group] < $(this).width()) maxWidths[group] = $(this).width()
      console.log(maxWidths[group], $(this).width())
  })

  for (var group in maxWidths) {
    $('[data-widthfix=' + group + ']').width(maxWidths[group] - - 1) // なぜかそのままのwidthだと崩れることがあるので +1 しておく
  }
}