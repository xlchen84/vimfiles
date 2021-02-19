function! config#modules#load(module)
	try
		let result = config#modules#{a:module}#init()
	catch /^Vim\%((\a\+)\)\=:E/	 " catch all Vim errors
		" if v:exception !~? "E117"
			call config#message('error catched: {}', v:exception)
		" endif
		try
			let result = config#modules#{a:module}()
		catch /^Vim\%((\a\+)\)\=:E/	 " catch all Vim errors
			call config#message('module {} not found.', a:module)
		endtry
	endtry
endfunction

" vim: ft=vim fdm=indent ts=2 sw=2
