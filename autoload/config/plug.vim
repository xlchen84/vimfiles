
let s:file = expand('<sfile>')

function! config#plug#home() abort
	 let vimfiles = fnamemodify(s:file, ':p:h:h:h')
	 let plug_home = fnamemodify(vimfiles . '\bundle', ':p:h')
	 return get(g:, 'plug_home', plug_home)
endfunction

function! s:get_url(directory)
	 let file = glob(a:directory . '\config')
	 let lines = readfile(file)
	 let origin_section = match(lines, '\[remote "origin"\]')
	 let url = lines[origin_section + 1][7:]
	 let short = substitute(url, '.*github.com/\(\S\+/\S\+\)\(.git\)\?', '\1', '')
	 return {'url': url, 'short': short}
endfunction

let s:plugins_disabled = uniq(get(g:, 'plugins_disabled', []))

function! s:load_plugin() dict
	 call plug#(self.short)
	 let self.loaded = v:true
endfunction

function! s:new_plugin(repo) abort
	 let path = fnamemodify(a:repo, ':p:h')
	 let config = path . '/config'
	 if filereadable(config)
		  let gitdir = fnamemodify(path, ':t')
		  if gitdir ==? '.git'
				let plugin = s:get_url(path)
				let plugin.name = fnamemodify(path, ':h:t')
				if index(s:plugins_disabled, plugin.name) >= 0 || index(s:plugins_disabled, plugin.short) >= 0
					 let plugin.disabled = v:true
				endif
				let plugin.load = function('s:load_plugin')
				return plugin
		  else
				call config#error('should be git but is {}', gitdir)
		  endif
	 else
		  call config#error('config file {} is not readable', config)
	 endif
endfunction

function! config#plug#list_plugins() abort
	 let plug_home = config#plug#home()
	 let repos = glob(plug_home . '\*\.git', v:true, v:true)
	 let s:plugin_list = repos->map({_, val -> s:new_plugin(val)})
	 let s:plugin_dict = {}
	 for p in s:plugin_list
		  let s:plugin_dict[p.name] = p
		  " call config#debug('add plugin {} to s:plugin_dict[{}]', p.short, p.name)
	 endfor
	 return s:plugin_list
endfunction

function config#plug#get_plugin(name) abort
	 return s:plugin_dict[a:name]
endfunction

function! config#plug#load_plugins(plugins) abort
	 try
		  let bundle = config#plug#home()
		  call config#debug('begin at bundle {}', bundle)
		  call plug#begin(bundle)
		  for p in a:plugins
				if !has_key(p, 'disabled') || !p.disabled
					 try
						  call config#debug('load plugin {} with {}', p.name, p.short)
						  call plug#(p.short)
					 catch
						  call config#debug('load plugin {} error: {}', p.name, v:exception)
						  throw v:exception
					 endtry
				else
					 call config#debug('disable plugin {} ', p.name)
				endif
		  endfor
		  call config#debug('end ')
		  call plug#end()
		  call config#debug('load_plugins sucess.')
	 catch
		  call config#debug('load plugin {} error: {}', a:plugins[0].name, v:exception)
		  throw v:exception
	 endtry
endfunction

function! config#plug#init()
	 if exists('s:plugins_loaded') && s:plugins_loaded
		  return v:true
	 endif
	 let s:plugins_loaded = v:false
	 try
		  let plugin_list = config#plug#list_plugins()
		  let plugin_names = get(g:, 'plugins', plugin_list->map({_, val -> val.name}))
		  call config#plug#load_plugins(plugin_names->map({_, val -> s:plugin_dict[val]}))
		  let s:plugins_loaded = v:true
	 catch
		  call config#debug('load module plug failed: {}.', v:exception)
		  call config#show_debug()
	 endtry
endfunction

let g:coc_disable_startup_warning = 1
