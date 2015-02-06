$(function () {
	$('.toggle-ellipsis').each(function (target) {
		if (typeof target != 'object') var target = this

		var height = $(target).data('height')
		if ($(target).height() == 0) {
			var thisFunc = arguments.callee
			$(target).on('recalculate.ellipsis-not-applied', function () {
				thisFunc(target)
				$(target).off('.ellipsis-not-applied')
			})
			return
		}
		if ($(target).height() < height) return

		var fullHeight = $(target).css('height')

		$(target)
			.css({
				'overflow': 'hidden',
				'cursor': 'pointer',
				'position': 'relative'
			})
			.height(height)

		$('<div class="gradient-more"><div class="inner">もっと見る ▼</div></div>').appendTo(target).css({
			'width': '100%',
			'height': height
		})
		if ($(target).data('closable')) {
			$('<div class="close"><div class="inner">閉じる ▲</div></div>')
				.appendTo(target)
				.css({
					'display': 'none'
				})
				.on('click', function (e) {
					$(target).animate({
						height: height
					})
					e.stopPropagation()
					$(this).hide()
					$('.gradient-more', target).show()
					$(target).on('mouseenter', mouseenter)
					$(target).on('mouseleave', mouseleave)
					$(target).css('cursor', 'pointer')
				})
		}

		$(target).on('mouseenter', mouseenter)
		$(target).on('mouseleave', mouseleave)
		$(target).on('click', function (){
			$(this).off('mouseenter', mouseenter)
			$(this).off('mouseleave', mouseleave)

			var beforeHeight = $(this).height()
			$(this).css('height', 'auto');
			var afterHeight = $(this).height() + ($(target).data('closable') ? 15 : 0);

			$(this).css({
				'opacity': 1,
				'cursor': 'default',
				'height': beforeHeight
			}).animate({
				'height': afterHeight,
			}, {
				complete: function () {
					// show close button
					if ($(this).data('closable')) {
						$('.close', this).show()
					}
				}
			})
			$('.gradient-more', this).hide()
		})

	})

	function mouseenter() {
		$(this).css({
			'opacity': 0.5
		})
	}
	function mouseleave() {
		$(this).css({
			'opacity': 1
		})
	}
})
