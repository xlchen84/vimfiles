let s:file = expand('<sfile>')

function! config#modules#list_modules() abort
	let module
endfunction

function! config#modules#load(module) abort
	try
		let verbose = get(g:, 'verbose', v:false)
		if verbose
			call config#message('loading module: {}', a:module)
		endif
		let result = config#modules#{a:module}#init()
		if verbose
			call config#message('module {} loaded.', a:module)
		endif
	catch /^Vim\%((\a\+)\)\=:E/	 " catch all Vim errors
		if verbose
			call config#message('exception {} thrown.', v:exception)
		endif
		if v:exception !~? "E117"
			call config#message('error catched: {}', v:exception)
		endif
		try
			let result = config#modules#{a:module}()
		catch /^Vim\%((\a\+)\)\=:E/	 " catch all Vim errors
			call config#message('module {} not found.', a:module)
		endtry
	endtry
endfunction

" vim: ft=vim fdm=indent ts=2 sw=2
