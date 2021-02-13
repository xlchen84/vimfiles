function! config#modules#load(module)
	try
		let result = config#modules#{a:module}#init()
	catch /^Vim\%((\a\+)\)\=:E/	 " catch all Vim errors
		try
			let result = config#modules#{a:module}()
		catch /^Vim\%((\a\+)\)\=:E/	 " catch all Vim errors
			call config#message('module {} not found.', a:module)
			call config#message('error catched: {}', v:exception)
		endtry
	endtry
endfunction

function! config#modules#gvimfullscreen()
	call gvimfullscreen#init()
endfunction

" vim: ft=vim fdm=indent ts=2 sw=2
