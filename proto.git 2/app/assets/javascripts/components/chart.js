// using canvasChart: http://oreweb.toypark.in/jquery.canvasChart/

$(function () {
  $('.evaluation-chart').each(function () {
    $(this).canvasChart({
      polygon : 5,
      valuation : 5,
      valuationName : getLabels(this),
      valuationCntPrint : false,
      printZero : false,
      radius : 80,
      bgFillColor : 'rgb(250, 250, 250)',//背景の塗り
      chartStrokeColor : ['#5add5a'],
      chartFillColor : ['rgba(173, 255, 173, 0.5)','none'],
      chartPoint : true,
      chartPointType: 'arc',
      chartPointSize: [3],
      scale : false
    });
  })

  function getLabels(chartElement) {
    var labels = []
    $('.chartInput input', chartElement).each(function () {
      labels.push($(this).data('label'))
    })
    return labels
  }

  // chart styles
  $('.evaluation-chart').css({
    'font-size': '11px'
  })
  $('.evaluation-chart .no-value').css({
    'color': '#ccc'
  })
})