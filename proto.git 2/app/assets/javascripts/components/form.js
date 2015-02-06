// rating
// 基本的にレポート投稿フォームはページ内にひとつしかないはずなので
// parent を使わないでシンプルに作り直しても良さそう
$(function (){
	var description = $('.rating-group .give-stars .description').html()
	var fixValue = null
	var disabled = false

	$('.rating-group .give-stars .star').on('mouseover', function (){
		if (disabled) return

		var parent = $(this).closest('.rating-group .give-stars')
		var value = $(this).data('value')
		$('.description', parent).html($(this).attr('title'))
		setStars(value, parent)
	})

	$('.rating-group .give-stars .star').on('mouseout', function (){
		if (disabled) return

		var parent = $(this).closest('.rating-group .give-stars')
		var value = $('input[type=hidden].star-value', parent).val()
		var newDescription = value ? $('.rating-group .give-stars .star').eq(value).attr('title') : description
		$('.description', parent).html(newDescription)
		setStars(value, parent)
	})

	$('.rating-group .give-stars .star').on('click', function (){
		if (disabled) return

		var parent = $(this).closest('.rating-group .give-stars')
		var value = $(this).data('value')
		$('input[type=hidden].star-value', parent).val(value)
		description = $(this).attr('title')
		fixValue = value
		setStars(value, parent)
	})

	$('.rating-group .give-stars .star').on('click', function (){
		if (disabled) return

		var parent = $(this).closest('.rating-group .give-stars')
		var value = $(this).data('value')
		$('input[type=hidden].star-value', parent).val(value)
		description = $(this).attr('title')
		fixValue = value
		setStars(value, parent)
	})

	$('.rating-group #no-star').on('click', noStar)

	// validation for ratings
	$('#new-report-form').on('submit', function (e){
		if (!disabled && !$('#report_star', this).val()) {
			alert('満足度を選択するか「評価をしない」にチェックを入れてください')
			e.preventDefault()
			return false;
		}
	})

	// set default stars on error page
	if ($('body').hasClass('page-create')) {
		$('input[type="hidden"].star-value').each(function() {
			var stars = $(this).val();
			if (stars) {
				$(this).siblings('.stars').children('.star').eq(stars).trigger('click')
			}
			else {
				$('.rating-group #no-star').prop('checked', true);
				noStar.apply($('.rating-group #no-star'))
			}
		});
	}

	function setStars(value, parent) {
		for (var i = 0; i < $('.star', parent).length; i++) {
			var target = $('.star', parent).eq(i)
			if (i <= value*1) target.removeClass('icon-star-empty').addClass('icon-star-full')
			else target.removeClass('icon-star-full').addClass('icon-star-empty')
		}

		$(parent).css('opacity', (value == fixValue ? 1 : 0.5))
	}

	function resetStars(parent, disabled) {
		if (disabled) setStars(0, parent)
		$('.description', parent).html('')
		$(parent).css('opacity', (disabled ? 0.2 : 0.5))
		$('input[type=hidden].star-value', parent).val('')
	}

	function noStar() {
		var noStar = $(this).prop('checked')
		var parent = $('.give-stars', $(this).closest('.rating-group'))

		if (noStar) {
			resetStars(parent, true)
			disabled = true
			$(parent).addClass('disabled')
		}
		else {
			resetStars(parent, false)
			disabled = false
			$(parent).removeClass('disabled')
		}
	}
})
