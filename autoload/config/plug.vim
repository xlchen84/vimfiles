
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
	 let short = substitute(url, 'https\?://.*github.com/\(\S\+/\S\+\).git', '\1', '')
	 return {'url': url, 'short': short}
endfunction

let s:plugins_disabled = uniq(get(g:, 'plugins_disabled', []))

function! s:load_plugin() dict
	 call plug#(self.short)
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
	 let s:plugins = repos->map({_, val -> s:new_plugin(val)})
	 return s:plugins
endfunction


function! config#plug#init()
	 let plugins = config#plug#list_plugins()
	 if exists('g:plugins')
		  call extend(plugins, g:plugins)
	 endif
	 " call filter(plugins, {_, val -> !val.disabled})
	 call plug#begin(config#plug#home())
	 for p in plugins
		  if !has_key(p, 'disabled') || !p.disabled
				try
					 call plug#(p.short)
					 " call config#message('load plugin {} ', p.name)
				catch
					 call config#message('load plugin {} error: {}', p.name, v:exception)
				endtry
		  else
				call config#message('disable plugin {} ', p.name)
		  endif
	 endfor
	 call plug#end()
endfunction

let g:coc_disable_startup_warning = 1
