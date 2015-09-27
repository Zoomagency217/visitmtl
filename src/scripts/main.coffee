toggle = (item) ->
	switch item
		when 'hamburger'
			if $('#hamburger').length then $('body').toggleClass 'pushed'
		when 'search'
			if $('#search').length
				$('#search').toggleClass 'open'
				$('#search-input').focus()
				$('body').toggleClass 'fixed'

lastSize = window.$size
lastTop0 = true
lastTime = new Date().getTime()
showingVideo = true
firstTime = true

calculateSize = ->
	if window.$xs or window.$sm
		if window.$size isnt lastSize
			$('html').removeClass 'background-video'
			$('#bg-video video').get(0).pause()
			lastSize = window.$size
	else
		if $('body').hasClass('top-0') isnt lastTop0
			lastTop0 = $('body').hasClass('top-0')
			if lastTop0
				lastTime = new Date().getTime()
			else
				if firstTime then firstTime = false
				else
					$('#bg-video video').get(0).pause()
					$('html').removeClass 'background-video'
					showingVideo = false
					$('#view-more').text('VIEW MORE')

showVideo = ->
	$('html').addClass 'background-video'
	$('#bg-video video').get(0).play()
	showingVideo = true

$ ->
	$('.carousel').carousel ->
		interval: 2000

	$('.action-hamburger').click ->
		toggle 'hamburger'

	$('.action-search, .search-close').click ->
		toggle 'search'

	sizeItv = setInterval ->
		calculateSize window.$size
	, 100

	$(window).on 'mousewheel', ->
		if lastTop0 and not showingVideo
			if new Date().getTime()-lastTime>500
				showVideo()