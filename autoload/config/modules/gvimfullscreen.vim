
function! config#modules#gvimfullscreen#init() abort
	if has("win32") && exists("g:did_gvimfullscreen") && g:did_gvimfullscreen
		call gvimfullscreen#init()
	endif
endfunction

