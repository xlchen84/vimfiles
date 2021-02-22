" vim: ft=vim fdm=marker

function! config#os()
	 if has('win32')
		  return 'windows'
	 endif
	 if has('mac')
		  return 'mac'
	 endif
endfunction


function! config#init() abort
	 let modules = uniq(get(g:, 'modules', []))
	 for module in modules
		  call config#modules#load(module)
	 endfor
endfunction

" message{{{
let g:config#verbose = v:true

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

