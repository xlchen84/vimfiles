
let g:coc_disable_startup_warning = 1
let g:vimfiles_windows = expand('$VIM/vimfiles')
let g:vimfiles_mac = fnamemodify(expand('<sfile>'), ':p:h:h:h:h')

function! config#modules#plug#list_plugins() abort
	 let plug_home = config#modules#plug#home()
	 let repos = glob(plug_home . '\*\.git', v:true, v:true)
	 return repos->map({_, val -> config#modules#plug#get_url(val)})
endfunction

function! config#modules#plug#get_url(directory)
	 let file = glob(a:directory . '\config')
	 let lines = readfile(file)
	 let origin_section = match(lines, '\[remote "origin"\]')
	 let url = lines[origin_section + 1][7:]
	 let name = substitute(url, 'https\?://.*github.com/\(\S\+/\S\+\).git', '\1', '')
	 return name
endfunction

function! config#modules#plug#init()
	 if !exists('s:plugins')
		  let s:plugins = config#modules#plug#list_plugins()
	 endif
	 if exists('g:plugins')
		  call extend(s:plugins, g:plugins)
	 endif
	 let plugins = uniq(s:plugins)
	 let plugins_disabled = uniq(get(g:, 'plugins_disabled', []))
	 call filter(plugins, {_, val -> index(plugins_disabled, val) < 0})
	 call plug#begin(config#modules#plug#home())
	 " call config#message('initialize plugins.')
	 for p in plugins
		  try
				call plug#(p)
		  catch
				call config#message('error: {}', v:exception)
		  endtry
	 endfor
	 call plug#end()
	 " call config#message('plugins initialize sucessfullly.')
endfunction

function! config#modules#plug#home() abort
	 let vimfiles = g:vimfiles_{config#os()}
	 let plug_home = fnamemodify(vimfiles . '\bundle', ':p')
	 return get(g:, 'plug_home', plug_home)
endfunction

