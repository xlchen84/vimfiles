" vim: ft=vim fdm=marker sw=2 ts=2

let s:file = expand('<sfile>')
let s:directory = fnamemodify(s:file, ':p:h:h')
let s:logging_logfile = get(g:, 'logging_logfile', expand(s:directory . '/debug.log'))
let s:logging_conf = get(g:, 'logging_conf', expand(s:directory . '/logging.conf'))

function! config#python() abort
	return has('pythonx')
endfunction

function! config#logging() abort
	return v:false
	if !(exists('g:logging_conf') && filereadable(g:logging_conf))
		let g:logging_conf = s:logging_conf
	endif
	if !(exists('g:logging_logfile') && filereadable(g:logging_logfile))
		let g:logging_logfile = s:logging_logfile
	endif
	if config#python()
		try
			pyx import config
			return filereadable(g:logging_logfile)
		catch
			echoerr v:exception
		endtry
	endif
endfunction

function! config#show_debug() abort
	if config#logging()
		exe 'edit ' . g:logging_logfile 
	endif
endfunction

function! config#edit_logging_config() abort
	let logging_conf = get(g:, 'logging_conf', s:logging_conf)
	exe 'edit ' . logging_conf 
endfunction

function! config#init() abort
	let modules = config#list_modules()
	if !exists('s:modules')
		let s:modules = {}
		for module in modules
			let s:modules[module.name] = module
		endfor
	endif
	let orderd_module_names = get(g:, 'modules', [])
	for name in orderd_module_names 
		if has_key(s:modules, name)
			let module = s:modules[name]
			call module.load()
			call config#debug('module {} loaded.', name)
		endif
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

function! config#find_module(name) abort
	let path = glob(config#home() . '/autoload/config/' . a:name . '.vim', v:true, v:true)
	return path->map({_, val -> config#new_module(val)})
endfunction

function! config#new_module(path) abort
	return {
				\ 'name': fnamemodify(a:path, ':p:t:r'),
				\ 'path': a:path,
				\ 'load': function('config#load_module')
				\}
endfunction

function! config#load_module() dict
	 if has_key(self, 'is_loaded') && self.is_loaded
		  return v:true
	 endif
	 if has_key(self, 'disabled') && self.disabled
		  return v:false
	 endif
	 try
		  call config#debug('loading module: {}', self.name)
		  return config#{self.name}#init()
	 catch /^Vim\%((\a\+)\)\=:E/	 " catch all Vim errors
		  let self.error = v:exception
			call config#debug('loading module {} failed: {}', self.name, self.error)
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

function! config#message(template, args) abort
	if config#python()
		try
			let g:_msg = ''
			pyx import vim
			pyx vim.vars['_msg'] = vim.eval('a:template').format(*vim.eval('a:args'))
			return g:_msg
		catch
			echom 'config#message: ' . v:exception
		endtry
	else
		echoerr 'python3 not enabled'
	endif
endfunction

" info{{{
function! config#info(template, ...)
	let msg = config#message(a:template, a:000)
	if config#logging()
		pyx config.rootLogger.info(vim.eval('msg'))
	else
		echom msg
	endif
endfunction
"}}}

function! config#debug(template, ...)
	let msg = config#message(a:template, a:000)
	if config#logging()
		pyx config.debug(vim.eval('msg'))
	else
		echom msg
	endif
endfunction


" error {{{
function! config#error(template, ...)
	let msg = config#message(a:template, a:000)
	if config#logging()
		pyx import logging
		pyx logging.debug(vim.eval('msg'))
	else
		echohl ErrorMsg
		echoerr msg
		echohl None
	endif
endfunction
"}}}

" download{{{
function! config#download(location, url)
	call config#message('downloading to {} from {}', a:location, a:url)
endfunction
"}}}



" vim: ft=vim fdm=indent ts=2 sw=2
