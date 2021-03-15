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

function! config#list_plugins(...) abort
	if a:0 > 0
		let bundle = a:1
	else
		if exists('g:bundle') && !empty(g:bundle)
			let bundle = g:bundle
		else
			let bundle = g:vimfiles . '/bundle'
		endif
	endif
	let repo_list = glob(bundle . '/*', v:true, v:true)
	call config#debug('repo_list = {}', repo_list)
	if empty(repo_list)
		call config#debug('no plugin was found in {}', bundle)
		return []
	endif
	let plugins_available = []
	for repo in repo_list 
		call config#debug('create plugin from {}', repo)
		let plugin = config#new_plugin(repo)
		if empty(plugin)
			call config#debug('create plugin failed for {}', repo)
		else
			call config#debug('add plugin {} to available', plugin)
			call add(plugins_available, plugin)
		endif
	endfor
	return plugins_available
endfunction

function! config#get_repo_url(repo) 
	let root = fnamemodify(a:repo, ':p:h:h:h')
	" call config#debug('root = "{}" for gitmodules', root)
	let module_file = glob(root . '/.gitmodules')
	let url = ''
	if filereadable(module_file)
		let lines = readfile(module_file)
		let name = fnamemodify(a:repo, ':p:h:t')
		let pattern = '\[submodule "bundle/' . name .'"\]'
		" call config#debug('search {} for {} in gitmodules', pattern, name)
		let section = match(lines, pattern)
		if section >= 0 
			call config#debug('extract url from "{}" in gitmodules', lines[section + 2])
			let url = substitute(lines[section + 2], '\s*url\s\+=\s\+\(\S\+\)', '\1', '')
			call config#debug('url = "{}" from gitmodules', url)
		else
			call config#debug('module {} not found in gitmodules', name)
		endif
	else
		call config#debug('gitmodule file {} not found', module_file)
	endif
	if !empty(url)
		return url
	endif
	let config_file = glob(a:repo . '/config')
	if filereadable(config_file)
		let lines = readfile(config_file)
		let section = match(lines, '\[remote "origin"\]')
		let url = substitute(lines[section + 1], 'url = \(\S\+\)', '\1', '')
		call config#debug('url = "{}" from config', url)
	else
		call config#debug('config file {} is not readable', config_file)
	endif 
	return url
endfunction

function! config#get_author(url) 
	return substitute(a:url, '.*github.com/\([^/]\+\)/[^/]\+\%(\.git\)\?', '\1', '')
endfunction

function! config#get_basename(path) 
	let name = fnamemodify(a:path, ':t')
	call config#debug('get basename {} from {}', name, a:path)
	return name
endfunction

function! config#new_plugin(repo) abort
	let plugin = {}
	let path = glob(fnamemodify(a:repo, ':p:h'))
	if empty(path)
		call config#debug('repo {} path {} is not found ', a:repo, path)
		return {}
	endif 
	let plugin.path = path
	let plugin.name = config#get_basename(path)
	let url = config#get_repo_url(a:repo)
	if empty(url)
		return {}
	endif 
	let plugin.url = url
	let plugin.author = config#get_author(url)
	let plugin.short = plugin.author . '/' . plugin.name 
	return plugin
endfunction

function! config#list_modules() abort
	let module_files = glob(g:vimfiles . '/autoload/config/*.vim', v:true, v:true)
	let modules = map(module_files, {_, val -> fnamemodify(val, ':t:r')})
	call config#debug('found modules {} ', modules)
	return modules
endfunction

function! config#init() abort
	for module in config#list_modules()
		call config#{module}#init()
	endfor
endfunction

