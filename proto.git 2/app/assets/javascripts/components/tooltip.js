$(function(){
	$('.show-tooltip').each(initTooltip)

	function initTooltip() {
		var index = $('.show-tooltip').index(this)
		var content = $(this).data('tooltip-text')
		if ( ! content ) content = $('#' + $(this).data('tooltip-target')).html()
		if ( ! content) return;
		var tooltip = $('<div></div>')
		tooltip.attr('id', 'tooltip' + index)
		tooltip.addClass('tooltip')
		if ($(this).hasClass('tooltip-top')) tooltip.addClass('tooltip-top')
		else tooltip.addClass('tooltip-bottom')
		tooltip.html(content)

		if ($(this).data('append-local')) tooltip.appendTo(this)
		else tooltip.appendTo('body')

		if ($(this).hasClass('open-by-click')) {
			$(this).on('click', openTooltip)
			$(tooltip).on('mouseleave', function () { closeTooltip(tooltip) })
			$('.close', tooltip).on('click', function () { closeTooltip(tooltip) })
		}
		else {
			$(this).on('mouseover', openTooltip)
			$(this).on('mouseout', closeTooltip)
		}

		if ($(this).data('autohide')) {
			$(tooltip).on('mouseover', function () {
				$(this).removeClass('autohide-countdown')
			})
			$(this).on('mouseover', function () {
				$(this).removeClass('autohide-countdown')
			})
		}

		// Open the link even if stopPropagation is set
		$('.force-link').on('click', function () {
			location.href = $(this).attr('href')
		})
	}

	function openTooltip(e) {
		var target_offset = $(this).offset()
		var target_height = $(this).height()
		var index = $('.show-tooltip').index(this)
		var tooltip = $('#tooltip' + index)
		var offsetLeft = $(this).data('offset-left')
		if ( ! offsetLeft ) offsetLeft = 0
		var width = $(this).data('width')
		if ( ! width ) width = 100
		var classname = $(this).data('classname')
		if ( ! classname ) classname = 100
		var parentOffset = $(this).offset()

		$(this).stop().removeClass('autohide-countdown')

		tooltip.width(width)
		tooltip.addClass(classname)

		tooltip.fadeIn()
		if ($(this).hasClass('tooltip-top'))
			tooltip.css({
				top: target_offset.top - tooltip.height() - 10 - parentOffset.top,
				left: target_offset.left + $(this).width()/2 - tooltip.width()/2 + offsetLeft - parentOffset.left
			})
		else
			tooltip.css({
				top: target_offset.top + $(this).height() + 10 - parentOffset.top,
				left: target_offset.left + $(this).width()/2 - tooltip.width()/2 + offsetLeft - parentOffset.left
			})

		if ($(this).data('autohide')) {
			$(this).on('mouseleave', function () {
				$(tooltip).addClass('autohide-countdown')
				setTimeout(function () {
					if ( ! $(tooltip).hasClass('autohide-countdown')) return
					closeTooltip(tooltip)
				}, $(this).data('autohide'));
			})
		}

		e.preventDefault()
		e.stopPropagation()
	}

	function closeTooltip(target) {
		if (typeof target == 'undefined') {
			var index = $('.show-tooltip').index(target)
			var target = $('#tooltip' + index)
		}
		target.fadeOut()
	}
})
