" vim: ft=vim fdm=marker  ts=2 sw=2


" 外观 {{{
set go=egrLv
set rnu
set nu
set cmdheight=3
set laststatus=2
set cursorline
set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
colorscheme desert
"}}}

" 设置 {{{
set nocompatible
set encoding=utf-8
set fencs=utf-8,ucs-bom,cp936
set helplang=cn
set noswapfile
set ambiwidth=double
set visualbell
set pyxversion=3
syntax on
language messages zh_CN.UTF-8

if has('win32')
	language messages zh_CN.utf-8
	set termencoding=cp936
" set guifont=Inziu_IosevkaCC_SC:h14
	set guifont=Inziu_IosevkaCC_SC:h18
elseif has('mac')
	set guifont=Monaco:h18
endif
"}}}

" 规则{{{
augroup vim_init
	 autocmd!
	 autocmd VimEnter * call config#init()
augroup END

filetype plugin on
augroup filetype_vim
	 autocmd!
	 autocmd FileType vim  setl ts=3 sw=4
	 autocmd FileType vim  autocmd BufWritePost <buffer=abuf> :source %
augroup END

augroup filetype_matlab
	 autocmd!
	 autocmd FileType matlab  setlocal ts=4 sw=4 
	 autocmd FileType matlab  setlocal fenc=cp936
	 autocmd FileType matlab  setlocal cms=%%s
augroup END
"}}}

let g:pymode_python = 'python3'

" plugins{{{
let g:plugins = [ 'bling/vim-airline'
				\ 	, 'vim-airline/vim-airline-themes'
				\ 	, 'bling/vim-bufferline'
				\ 	, 'morhetz/gruvbox'
				\ 	, 'eugeii/consolas-powerline-vim'
				\ 	, 'junegunn/vim-plug'
				\ 	, 'Shougo/dein.vim'
				\ 	, 'wsdjeg/dein-ui.vim'
				\ 	, 'haya14busa/dein-command.vim'
				\ 	, 'altercation/vim-colors-solarized'
				\ 	, 'liuchengxu/vim-which-key'
				\ 	, 'hecal3/vim-leader-guide'
				\ 	, 'skywind3000/vim-quickui'
				\ 	, 'Shougo/unite.vim'
				\ 	, 'thinca/vim-unite-history'
				\ 	, 'Shougo/unite-outline'
				\ 	, 'Shougo/unite-help'
				\ 	, 'tsukkee/unite-tag'
				\ 	, 'osyo-manga/unite-quickfix'
				\ 	, 'msprev/unite-bibtex'
				\ 	, 'chemzqm/unite-git-log'
				\ 	, 'hewes/unite-gtags'
				\ 	, 'Shougo/neoyank.vim'
				\ 	, 'Shougo/neomru.vim' 
				\ 	, 'Shougo/denite.nvim'
				\ 	, 'roxma/vim-hug-neovim-rpc'  	
				\ 	, 'roxma/nvim-yarp'
				\ 	, 'Yggdroot/LeaderF'
				\ 	, 'liuchengxu/vim-clap'
				\ 	, 'junegunn/fzf.vim'
				\ 	, 'neoclide/coc.nvim'
				\ 	, 'prabirshrestha/vim-lsp'
				\ 	, 'w0rp/ale'
				\ 	, 'Shougo/deoplete.nvim'
				\ 	, 'vim-scripts/indentpython.vim'
				\ 	, 'neomake/neomake'
				\ 	, 'Valloric/YouCompleteMe'
				\ 	, 'neoclide/coc-tabnine'
				\ 	, 'tbodt/deoplete-tabnine'
				\ 	, 'SirVer/ultisnips'
				\ 	, 'Shougo/neosnippet.vim'
				\ 	, 'Shougo/neosnippet-snippets'
				\ 	, 'neoclide/coc-snippets'
				\ 	, 'honza/vim-snippets'
				\ 	, 'jlanzarotta/bufexplorer'
				\ 	, 'archerc/gvimfullscreen'
				\ 	, 'kien/ctrlp.vim'
				\ 	, 'skywind3000/asyncrun.vim'
				\ 	, 'skywind3000/vim-terminal-help' 
				\ 	, 'python-mode/python-mode'
				\ 	, 'tpope/vim-markdown'
				\ 	, 'JamshedVesuna/vim-markdown-preview'
				\ 	, 'daeyun/vim-matlab'
				\ 	, 'djoshea/vim-matlab-fold'
				\ 	, 'jceb/vim-orgmode'
				\ 	, 'vim-pandoc/vim-pandoc'
				\ 	, 'vim-pandoc/vim-pandoc-syntax'
				\ 	, 'tpope/vim-sensible'
				\ 	, 'tpope/vim-commentary'
				\ 	, 'tpope/vim-unimpaired'
				\ 	, 'tpope/vim-surround'
				\ 	, 'preservim/nerdcommenter'
				\ 	, 'preservim/nerdtree'
				\ 	, 'mattn/libcallex-vim'
				\ 	, 'junegunn/limelight.vim'
				\ 	, 'easymotion/vim-easymotion'
				\ 	, 'mhinz/vim-startify'
				\ 	, 'skywind3000/vim-terminal-help'
				\ 	, 'kana/vim-textobj-function'
				\ 	, 'kana/vim-textobj-indent'
				\ 	, 'sgur/vim-textobj-parameter'
				\ 	, 'kana/vim-textobj-syntax'
				\ 	, 'kana/vim-textobj-user'
				\ 	, 'geratheon/vim-translate'
				\ 	, 'jreybert/vimagit'
				\ 	, 'yianwillis/vimcdoc'
				\ 	, 'lervag/vimtex'
				\ 	, 'Shougo/context_filetype.vim'
				\ 	, 'Shougo/echodoc.vim'
				\ 	, 'Shougo/vimproc.vim'           
				\ 	, 'Shougo/vimfiler.vim'
				\  , 'JuliaEditorSupport/julia-vim'
				\  , 'hanschen/vim-ipython-cell'
				\ ]
" \  , 'jpalardy/vim-slime'
" \ 	, 'prabirshrestha/asyncomplete.vim'
" \ 	, 'vim-scripts/AutoComplPop'
"}}}

let g:modules = [ 'plug'
				\   , 'key'
 				\ 	, 'airline'
 				\ 	, 'quickmenu'
 				\ 	, 'gvimfullscreen'
				\   , 'snippet'
 				\ 	, 'terminal'
				\ ]
"				\ 	, 'python'
"				\   , 'startify'

let g:plugins_disabled = [ 'SirVer/ultisnips'
				\ 	,	'Valloric/YouCompleteMe'
				\ 	, 'Shougo/deoplete.nvim'
				\ ]

