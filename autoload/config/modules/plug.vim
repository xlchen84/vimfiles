
let g:coc_disable_startup_warning = 1
let g:vimfiles_windows = expand('$VIM/vimfiles')
let g:vimfiles_mac = fnamemodify(expand('<sfile>'), ':p:h:h:h:h')

" \ 		'prabirshrestha/asyncomplete.vim',
" \ 		'vim-scripts/AutoComplPop',
" \ 		'Valloric/YouCompleteMe',
let s:plugins = [
				\ 		'bling/vim-airline',
				\ 		'vim-airline/vim-airline-themes',
				\ 		'bling/vim-bufferline',
				\ 		'morhetz/gruvbox',
				\ 		'eugeii/consolas-powerline-vim',
				\ 		'junegunn/vim-plug',
				\ 		'Shougo/dein.vim',
				\ 		'wsdjeg/dein-ui.vim',
				\ 		'haya14busa/dein-command.vim',
				\ 		'altercation/vim-colors-solarized',
				\ 		'liuchengxu/vim-which-key',
				\ 		'hecal3/vim-leader-guide',
				\ 		'skywind3000/vim-quickui',
				\ 		'skywind3000/asyncrun.vim',
				\ 		'skywind3000/asynctasks.vim',
				\ 		'skywind3000/vim-terminal-help', 
				\ 		'Shougo/unite.vim',
				\ 		'thinca/vim-unite-history',
				\ 		'Shougo/unite-outline',
				\ 		'Shougo/unite-help',
				\ 		'tsukkee/unite-tag',
				\ 		'osyo-manga/unite-quickfix',
				\ 		'msprev/unite-bibtex',
				\ 		'chemzqm/unite-git-log',
				\ 		'hewes/unite-gtags',
				\ 		'Shougo/neoyank.vim',
				\ 		'Shougo/neomru.vim', 
				\ 		'Shougo/denite.nvim',
				\ 		'roxma/vim-hug-neovim-rpc',  	
				\ 		'roxma/nvim-yarp',  				
				\ 		'Yggdroot/LeaderF',
				\ 		'liuchengxu/vim-clap',
				\ 		'junegunn/fzf.vim',
				\ 		'neoclide/coc.nvim',
				\ 		'prabirshrestha/vim-lsp',
				\ 		'w0rp/ale',
				\ 		'Shougo/deoplete.nvim',
				\ 		'neoclide/coc-tabnine',
				\ 		'tbodt/deoplete-tabnine',
				\ 		'SirVer/ultisnips',
				\ 		'Shougo/neosnippet.vim',
				\ 		'Shougo/neosnippet-snippets',
				\ 		'neoclide/coc-snippets',
				\ 		'honza/vim-snippets',
				\ 		'jlanzarotta/bufexplorer',
				\ 		'archerc/gvimfullscreen',
				\ 		'kien/ctrlp.vim',
				\ 		'python-mode/python-mode',
				\ 		'tpope/vim-markdown',
				\ 		'JamshedVesuna/vim-markdown-preview',
				\ 		'daeyun/vim-matlab',
				\ 		'djoshea/vim-matlab-fold',
				\ 		'jceb/vim-orgmode',
				\ 		'vim-pandoc/vim-pandoc',
				\ 		'vim-pandoc/vim-pandoc-syntax',
				\ 		'tpope/vim-sensible',
				\ 		'tpope/vim-commentary',
				\ 		'tpope/vim-unimpaired',
				\ 		'tpope/vim-surround',
				\ 		'preservim/nerdcommenter',
				\ 		'preservim/nerdtree',
				\ 		'mattn/libcallex-vim',
				\ 		'junegunn/limelight.vim',
				\ 		'easymotion/vim-easymotion',
				\ 		'mhinz/vim-startify',
				\ 		'kana/vim-textobj-function',
				\ 		'kana/vim-textobj-indent',
				\ 		'sgur/vim-textobj-parameter',
				\ 		'kana/vim-textobj-syntax',
				\ 		'kana/vim-textobj-user',
				\ 		'geratheon/vim-translate',
				\ 		'jreybert/vimagit',
				\ 		'yianwillis/vimcdoc',
				\ 		'lervag/vimtex',
				\ 		'Shougo/context_filetype.vim',
				\ 		'Shougo/echodoc.vim',
				\ 		'Shougo/vimproc.vim',           
				\ 		'Shougo/vimfiler.vim',
				\ ]

function! config#modules#plug#init()
	 let vimfiles = g:vimfiles_{config#os()}
	 let plug_home = fnamemodify(vimfiles . '\bundle', ':p')
	 let plug_home = get(g:, 'plug_home', plug_home)
	 let plugins = get(g:, 'plugins', [])
	 call extend(plugins, s:plugins)
	 let plugins = uniq(plugins)
	 let disabled = uniq(g:plugins_disabled)
	 call filter(plugins, 'index(disabled, v:val) < 0')
	 try
		  let verbose = get(g:, 'verbose', v:false)
		  call plug#begin(plug_home)
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

