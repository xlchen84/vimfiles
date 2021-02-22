" vim: ft=vim fdm=marker sw=2 ts=2

let s:file = expand('<sfile>')
let s:logging_conf = expand(fnamemodify(s:file, ':p:h') . '/logging.conf')
let s:modules = {}

function! config#logging() abort
	let logging_conf = get(g:, 'logging_conf', s:logging_conf)
	py3 <<EOF
import vim
import logging.config
logging.config.fileConfig(vim.eval('logging_conf'))
EOF
	return logging_conf
endfunction

function! config#edit_logging_config() abort
	let logging_conf = get(g:, 'logging_conf', s:logging_conf)
	exe 'edit ' . logging_conf 
endfunction

function! config#init() abort
	let modules = config#list_modules() 
	for module in modules
		let s:modules[module.name] = module
		call module.load()
	endfor
endfunction

function! config#home() abort
	 return fnamemodify(s:file, ':p:h:h')
endfunction


function! config#list_modules() abort
	let modules = glob(config#home() . '/autoload/config/*.vim', v:true, v:true)
	return modules->map({_, val -> {
					\ 'name': fnamemodify(val, ':p:t:r'),
					\ 'path': val,
					\ 'load': function('config#load_module')
					\}})
endfunction

function! config#load_module() dict
	 if has_key(self, 'is_loaded') && self.is_loaded
		  return v:true
	 endif
	 if has_key(self, 'disabled') && self.disabled
		  return v:false
	 endif
	 try
		  " call config#message('loading module: {}', self.name)
		  return config#{self.name}#init()
	 catch /^Vim\%((\a\+)\)\=:E/	 " catch all Vim errors
		  let self.error = v:exception
	 endtry
endfunction


function! config#os()
	 if has('win32')
		  return 'windows'
	 endif
	 if has('mac')
		  return 'mac'
	 endif
endfunction


" info{{{
function! config#info(template, ...)
	 if has('python3')
		  py3 logging.info(vim.eval('a:template').format(*vim.eval('a:000')))
	 endif
endfunction
"}}}

function! config#debug(template, ...)
	 if has('python3') 
		  py3 logging.debug(vim.eval('a:template').format(*vim.eval('a:000')))
	 endif
endfunction

" error {{{
function! config#error(template, ...)
	 echohl ErrorMsg
	 py3 import vim; vim.command("let msg='%s'" % vim.eval('a:template').format(*vim.eval('a:000')))
	 echom msg
	 echohl None
endfunction
"}}}
" download{{{
function! config#download(location, url)
	 call config#message('downloading to {} from {}', a:location, a:url)
endfunction
"}}}



" vim: ft=vim fdm=indent ts=2 sw=2
