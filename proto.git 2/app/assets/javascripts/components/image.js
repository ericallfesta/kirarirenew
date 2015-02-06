$(document).ready(function() {
  $(".image-popup").fancybox({
    showNavArrows : true,
  });

  $('.image-select').on('mouseover', function (){
    var viewer = $(this).data('viewer');
    var src = $(this).data('src');
    $(viewer).attr('src', src);
    $('.image-select[data-viewer='+viewer+']').removeClass('active');
    $(this).addClass('active');
  });
});