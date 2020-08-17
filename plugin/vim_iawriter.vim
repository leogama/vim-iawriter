if exists('g:loaded_iawriter_plugin')
	finish
endif
let g:loaded_iawriter_plugin = 1

fun! vim_iawriter#check_configs()
	let s:saved_colorscheme = "default"
	if exists('g:colors_name')
		let s:saved_colorscheme = g:colors_name
	endif
	if !exists('g:goyo_width')
		let g:goyo_width = '65%'
	endif
	if !exists('g:limelight_paragraph_span')
		let g:limelight_paragraph_span = 1
	endif
	if !exists('g:limelight_default_coefficient')
		let g:limelight_default_coefficient = 0.7
	endif

	if !exists('g:iawriter_change_underline')
		let g:iawriter_change_underline = 1
	endif
	if !exists('g:iawriter_change_cursorline')
		let g:iawriter_change_cursorline = 1
	endif
endfun!

fun! vim_iawriter#pre_enter()
	call vim_iawriter#check_configs()
	au User GoyoEnter nested ++once call vim_iawriter#post_enter()
	AirlineToggle
endfun!

fun! vim_iawriter#post_enter()
	colo pencil
	let g:limelight_paragraph_span = 1
	Limelight
	au User GoyoLeave nested ++once call vim_iawriter#leave()
	if g:iawriter_change_cursorline
		set nocursorline
	endif
	if g:iawriter_change_underline
		hi CursorLine gui=NONE
	endif
endfun!

fun! vim_iawriter#leave()
	execute('colo ' . s:saved_colorscheme)
	Limelight!
	AirlineToggle
	AirlineRefresh
endfun!

fun! vim_iawriter#toggle()
	call vim_iawriter#pre_enter()
	Goyo
endfun!
