" vim: ft=vim fdm=marker

function! config#os()
	 if has('win32')
		  return 'windows'
	 endif
endfunction

let s:modules = []

function! config#init()
	 let modules = get(g:, 'modules', [])
	 call extend(modules, s:modules)
	 let modules = uniq(modules)
	 " call config#message('modules to be loaded: {}', modules)
	 for module in modules
		  " call config#message('loading module {}', module)
		  call config#modules#load(module)
	 endfor
endfunction

" message{{{
function! config#message(template, ...)
	 let verbose = get(g:, 'verbose', v:true)
	 if has('python3') && verbose
		  py3 <<EOF
import vim
print(vim.eval('a:template').format(*vim.eval('a:000')))
EOF
	 endif
endfunction
"}}}

" download{{{
function! config#download(location, url)
	 call config#message('downloading to {} from {}', a:location, a:url)
endfunction
"}}}

