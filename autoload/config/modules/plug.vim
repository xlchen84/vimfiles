
let g:coc_disable_startup_warning = 1
let g:vimfiles_windows = expand('$VIM/vimfiles')
let g:vimfiles_mac = fnamemodify(expand('<sfile>'), ':p:h:h:h:h')

let s:plugins = config#modules#plug#list_plugins()

function! config#modules#plug#init()
	 let plugins = get(g:, 'plugins', [])
	 call extend(plugins, s:plugins)
	 let plugins = uniq(plugins)
	 let disabled = uniq(g:plugins_disabled)
	 call filter(plugins, 'index(disabled, v:val) < 0')
	 try
		  let verbose = get(g:, 'verbose', v:false)
		  call plug#begin(config#modules#plug#home())
		  if verbose
				call config#message('initialize plugins.')
		  endif
		  for p in plugins
				call plug#(p)
		  endfor
		  if verbose
				call config#message('plugins initialized.')
		  endif
		  call plug#end()
		  if verbose
				call config#message('plugins initialize sucessfullly.')
		  endif
	 catch
		  call config#message('error: {}', v:exception)
	 endtry
endfunction

function! config#modules#plug#home()
	 let vimfiles = g:vimfiles_{config#os()}
	 let plug_home = fnamemodify(vimfiles . '\bundle', ':p')
	 return get(g:, 'plug_home', plug_home)
endfunction

function! config#modules#plug#list_plugins()
	 let plug_home = config#modules#plug#home()
	 let repos = glob(plug_home . '\*\.git', v:false, v:true)
	 return repos->map({_, val -> fnamemodify(val, ':p:h:h:t')})
endfunction
