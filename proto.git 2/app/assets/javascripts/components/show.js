$(function (){
	$('.trigger-show').on('click', function(){
		var target = $(this).data('target')
		if ($(this).hasClass('self-destruct')) $(this).fadeOut('fast', function (){
			$(target).fadeIn('fast', linefix)
		})
		else $(target).fadeIn('fast', linefix)
	}).css('cursor', 'pointer')
})