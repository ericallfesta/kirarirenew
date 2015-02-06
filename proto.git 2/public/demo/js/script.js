$(document).ready(function (){
  // ---common---
  // fav
  $('.mark_fav').each(function (){
    if ($(this).hasClass('marked')){
      $(this).html('★');
    }
    else {
      $(this).html('☆');
    }
  });
  $('.mark_fav').on('click', function (){
    alert('test');
    // ajax 通信処理
  })

  // ---on product pages---
  // comments
  $('.view_comments').on('click', function (e){
    $('.comments', $(this).closest('article')).slideToggle();
    e.preventDefault();
  });
  // new posts
  $('.auto_resize').on('focus', function (e){
    $(this).animate({
      height: '150px'
    }, 'fast');
    $('.upload_images', $(this).closest('form')).slideDown('fast');
  });

  // body map
  $('#bodymap .parts a').on('click', function (e){
    $('#bodymap .parts a').removeClass('active');
    $(this).addClass('active');

    var classname = $(this).parent().attr('class');

    $('#bodymap .submenu .active').fadeOut('fast', function (){
      $('#bodymap .submenu .'+classname).fadeIn('fast').addClass('active');
    }).removeClass('active');

    e.preventDefault();
  });

  // slider
  $('#feature_selector a').on('click', function (e){
    $('#feature_selector li a').removeClass('active');
    $(this).addClass('active');

    var target = $(this).attr('href');
    $('#features section').fadeOut();
    $('#features '+target).fadeIn();

    e.preventDefault();
  });
});