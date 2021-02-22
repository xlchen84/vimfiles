let s:file = expand('<sfile>')

function! config#modules#list_modules() abort
	let modules = glob(fnamemodify(s:file, ':p:h') . '/modules/*.vim', v:true, v:true)
	return modules->map({_, val -> fnamemodify(val, ':p:t:r')})
endfunction

let s:modules = {}

function! config#modules#is_loaded(...) abort
	if a:0 > 0
		if has_key(s:modules, a:1)
			return s:modules[a:1]
		else 
			return v:false
		endif
	else
		return s:modules
	endif
endfunction

function! config#modules#load(module) abort
	try
		if config#modules#is_loaded(a:module)
			return v:true
		endif
		let disabled_modules = get(g:, 'modules_disabled', [])
		if index(disabled_modules, a:module) >= 0
			call config#message('module {} is disabled.', a:module)
			return v:false
		endif
		" call config#message('loading module: {}', a:module)
		let result = config#modules#{a:module}#init()
		" call config#message('module {} loaded.', a:module)
		let s:modules[a:module] = v:true
		return result
	catch /^Vim\%((\a\+)\)\=:E/	 " catch all Vim errors
		let s:modules[a:module] = v:exception
		" if v:exception !~? "E117"
		" 	call config#message('error catched: {}', v:exception)
		" else
		" 	call config#message('exception {} thrown.', v:exception)
		" endif
		" try
		" 	let result = config#modules#{a:module}()
		" 	" call config#message('module {} loaded.', a:module)
		" 	let s:modules[a:module] = v:true
		" 	return result
		" catch /^Vim\%((\a\+)\)\=:E/	 " catch all Vim errors
		" 	call config#message('module {} not found.', a:module)
		" 	let s:modules[a:module] = v:false
		" endtry
	endtry
endfunction

" vim: ft=vim fdm=indent ts=2 sw=2
