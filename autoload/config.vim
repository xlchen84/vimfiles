" vim: ft=vim fdm=marker

function! config#os()
	 if has('win32')
		  return 'windows'
	 endif
	 if has('mac')
		  return 'mac'
	 endif
endfunction

let s:modules = []

function! config#init() abort
	 if has('python')
		  echom 'python enabled'
	 endif

	 if has('python3')
		  echom 'python3 enabled'
	 endif

	 let modules = get(g:, 'modules', [])
	 call extend(modules, s:modules)
	 let modules = uniq(modules)
	 " call config#message('modules to be loaded: {}', modules)
	 for module in modules
		  "call config#message('loading module {}', module)
		  call config#modules#load(module)
	 endfor
endfunction

" message{{{
let g:config#verbose = v:false

function! config#message(template, ...)
	 let verbose = get(g:, 'config#verbose', v:true)
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

