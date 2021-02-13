
function! config#modules#startify#init()
	 if v:vim_did_enter
		  Startify
	 else
		  autocmd! vim_init VimEnter * Startify
	 endif
endfunction

" vim: ts=2 sw=2 fdm=indent
