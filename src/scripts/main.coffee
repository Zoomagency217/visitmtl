lastSize = window.$size
lastTop0 = true
lastTime = new Date().getTime()
showingVideo = true
firstTime = true
onSearch = false
onMenu = false

toggle = (item) ->
	switch item
		when 'hamburger'
			if $('#hamburger').length
				$('body').toggleClass 'pushed'
				onMenu = $('body').hasClass 'pushed'
				if onMenu then hideVideo()
		when 'search'
			if $('#search').length
				$('#search').toggleClass 'open'
				$('#search-input').focus()
				$('html').toggleClass 'fixed'
				onSearch = $('html').hasClass 'fixed'
				if onSearch then hideVideo()

calculateSize = ->
	if window.$xs or window.$sm
		if window.$size isnt lastSize
			hideVideo()
	else
		if $('body').hasClass('top-0') isnt lastTop0
			lastTop0 = $('body').hasClass('top-0')
			if lastTop0
				lastTime = new Date().getTime()
			else
				if firstTime then firstTime = false
				else
					if $('#bg-video video').get(0) then $('#bg-video video').get(0).pause()
					$('html').removeClass 'background-video'
					showingVideo = false
					$('#view-more').text 'VIEW MORE'
	if not $('#bg-video video').get(0)
		$('html').removeClass 'background-video'

showVideo = ->
	$('html').addClass 'background-video'
	if $('#bg-video video').get(0) then $('#bg-video video').get(0).play()
	showingVideo = true

hideVideo = ->
	$('html').removeClass 'background-video'
	$('#bg-video video').get(0).pause()
	lastSize = window.$size

$ ->
	# Carousel
	$('.carousel').carousel ->
		interval: 2000

	# Carousel mobile touch
	$('.carousel').swiperight ->
		$(this).carousel 'prev'

	$('.carousel').swipeleft ->
		$(this).carousel 'next'

	# Pushed menu
	$('.action-hamburger, #menu_cover').click ->
		toggle 'hamburger'

	# Search area
	$('.action-search, .search-close').click ->
		toggle 'search'

	# Select group
	$('.select_group').each ->
		_self = $(this)

		_self.click ->
			_self.find('.list').toggleClass 'active'

		_self.find('.list li').each ->
			$(this).click ->
				_self.find('.list li').removeClass 'active'
				_self.find('.selected').html $(this).html()
				$(this).addClass 'active'

	# Show/hide video
	sizeItv = setInterval ->
		calculateSize window.$size
	, 100

	$(window).on 'mousewheel', ->
		if !onSearch and !onMenu
			if lastTop0 and not showingVideo
				if new Date().getTime()-lastTime>500
					showVideo()