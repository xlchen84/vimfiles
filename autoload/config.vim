" vim: ft=vim fdm=indent ts=2 sw=2

function! config#debug(msg, ...) abort
	let pwd = getcwd()
	if exists('g:vimfiles')
		call chdir(g:vimfiles)
	endif
	pyx import config
	pyx import vim
	pyx config.debug(vim.eval('a:msg'), *vim.eval('a:000'))
	call chdir(pwd)
endfunction

function! config#reload_config() abort
	pyx from importlib import reload
	pyx reload(config)
	call config#debug('reloading config')
endfunction

function! config#open_log() abort
	if filereadable(g:logfile)
		exe 'edit ' . g:logfile
	endif
endfunction

function! config#list_plugins(bundle) abort
  return glob(a:bundle . '/*/.git', v:true, v:true)
endfunction

function! config#get_repo_url(config_file) abort
	try
		let lines = readfile(a:config_file)
		let origin_section = match(lines, '\[remote "origin"\]')
		let url = lines[origin_section + 1][7:]
		return url
	catch
		echoerr 'file ' . a:config_file . ' not found.'
	endtry
endfunction

function! config#get_author(url) 
	return substitute(a:url, '.*github.com/\([^/]\+\)/[^/]\+\%(\.git\)\?', '\1', '')
endfunction

function! config#get_basename(path) 
	let name = fnamemodify(a:path, ':p:h:h:t')
	return name
endfunction

function! config#new_plugin(repo) abort
	let plugin = {}
	try
		let config_file = glob(a:repo . '/config')
		if filereadable(config_file)
			let plugin.path = fnamemodify(a:repo, ':p:h')
			let plugin.url = config#get_repo_url(config_file)
			let plugin.author = config#get_author(plugin.url)
			let plugin.name = config#get_basename(plugin.path)
			let plugin.short = plugin.author . '/' . plugin.name 
			return plugin
		else
			call config#debug('config file {} for {} is not readable ', config_file, a:repo)
			return {}
		endif 
	catch
		return {}
	endtry
endfunction

function! config#init() abort
	let plugins_available = []
	if !exists('g:bundle') || empty(g:bundle)
		let g:bundle = g:vimfiles . '/bundle'
	endif
	let plugins_list = config#list_plugins(g:bundle)
	if empty(plugins_list)
		call config#debug('no plugin was found in ' . g:bundle)
	endif
	for repo in plugins_list 
		let plugin = config#new_plugin(repo)
		call add(plugins_available, plugin)
	endfor
	let g:plugins_available = plugins_available
endfunction

