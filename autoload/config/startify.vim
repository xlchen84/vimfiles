
function! config#startify#init()
	if exists('g:loaded_startify') && g:loaded_startify
		if v:vim_did_enter
			Startify
		else
			autocmd! vim_init VimEnter * Startify
		endif
	endif
endfunction

" vim: ts=2 sw=2 fdm=indent
