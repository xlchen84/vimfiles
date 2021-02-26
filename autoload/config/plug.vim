" vim: ft=vim ts=2 sw=2 et

let g:coc_disable_startup_warning = 1
let s:file = expand('<sfile>')
let s:plugins_disabled = uniq(get(g:, 'plugins_disabled', []))
let s:plugins_loaded = []

function! config#plug#home() abort
	 let vimfiles = fnamemodify(s:file, ':p:h:h:h')
	 let plug_home = fnamemodify(vimfiles . '\bundle', ':p:h')
	 return get(g:, 'plug_home', plug_home)
endfunction

function! config#plug#new_plugin(repo)
	 let path = fnamemodify(a:repo, ':p:h')
	 let config = expand(path . '/config')
	 if filereadable(config)
		  let gitdir = fnamemodify(path, ':t')
		  if gitdir ==? '.git'
				let lines = readfile(config)
				let origin_section = match(lines, '\[remote "origin"\]')
				let plugin = {}
				let plugin.name = fnamemodify(path, ':h:t')
				let plugin.url = lines[origin_section + 1][7:]
				let plugin.short = substitute(plugin.url, '.*github.com/\(\S\+/[^.]\+\)\(\.git\)\?', '\1', '')
				return plugin
		  endif
	 endif
endfunction

function! config#plug#list_plugins() abort
	 call config#debug('list_plugins')
	 let plug_home = config#plug#home()
	 let repos = glob(plug_home . '\*\.git', v:true, v:true)
	 let s:plugin_list = map(repos, {_, val -> config#plug#new_plugin(val)})
	 call config#debug('list_plugins sucess.')
	 return s:plugin_list
endfunction

function! config#plug#init() abort
	let plugins = config#plug#list_plugins() 
	call plug#begin(config#plug#home())
	for p in plugins
		 if index(g:plugins_disabled, p.short) < 0
       call plug#(p.short)
     else
       echom 'plugin ' . p.short . ' is disabled'
     endif
	endfor
	call plug#end()
endfunction

