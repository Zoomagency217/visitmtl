toggle = (item) ->
	switch item
		when 'hamburger'
			if $('#hamburger').length then $('body').toggleClass 'pushed'

resizeVideo = (ele)->
	itv = setInterval ->
		if !scale and $(ele).height()
			scale = $(ele).width()/$(ele).height()

		if scale
			if $(ele).height() < $(window).innerHeight()
				$(ele).height $(window).innerHeight()
				$(ele).width $(ele).height()*scale
				$(ele).css 'margin-left', ($(window).innerWidth()-$(ele).width())/2+'px'
			else
				$(ele).width '100%'
				$(ele).height $(ele).width()/scale
			clearInterval itv
	, 100

$ ->
	$('.carousel').carousel ->
		interval: 2000

	$('.action-hamburger').click ->
		toggle 'hamburger'