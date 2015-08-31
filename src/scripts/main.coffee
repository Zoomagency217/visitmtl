toggle = (item) ->
	switch item
		when 'hamburger'
			if $('#hamburger').length then $('#hamburger').toggleClass 'active'

$ ->
	$('.carousel').carousel ->
		interval: 2000

	$('.action-hamburger').click ->
		toggle 'hamburger'