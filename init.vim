" vim: ft=vim fdm=marker  ts=2 sw=2


" 外观 {{{
set go=egrLv
set rnu
set nu
set cmdheight=3
set laststatus=2
set colorcolumn=120
set cursorline
set cursorcolumn
" set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
set ruler
set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
"}}}

" 设置 {{{
set nocompatible
set nobackup
set nowritebackup
set noswapfile
set visualbell
set encoding=utf-8
set fencs=utf-8,ucs-bom,cp936
set helplang=cn
set ambiwidth=double
set backupdir=$VIM/vimfiles/temp,$TEMP
syntax on
language messages zh_CN.UTF-8

if has('win32')
	language messages zh_CN.utf-8
	set termencoding=utf-8
	"set guifont=Inziu_IosevkaCC_SC:h18
elseif has('mac')
	set guifont=Monaco:h18
endif
if !has('nvim')
	set guifont=Inziu_IosevkaCC_SC:h16
	set pyxversion=3
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

let g:vimfiles = expand('<sfile>:h')
if filereadable('d:/Programs/global/bin/ctags.exe')
	let $PATH = $PATH . ';' . 'd:/Programs/global/bin'
endif

let g:plugins = ['vim-plug' 
			\ , 'vim-which-key' 
			\ , 'vimproc.vim' 
			\ , 'vimfiler.vim' 
			\ , 'dein.vim' 
			\ , 'dein-command.vim' 
			\ , 'dein-ui.vim' 
			\ , 'unite.vim' 
			\ , 'unite-help' 
			\ , 'unite-outline' 
			\ , 'unite-quickfix' 
			\ , 'unite-git-log' 
			\ , 'unite-tag' 
			\ , 'vim-unite-history' 
			\ , 'unite-gtags' 
			\ , 'unite-bibtex' 
			\ , 'nvim-yarp' 
			\ , 'vim-hug-neovim-rpc' 
			\ , 'denite.nvim' 
			\ , 'denite-git' 
			\ , 'neomru.vim' 
			\ , 'neoyank.vim' 
			\ , 'neosnippet.vim' 
			\ , 'neosnippet-snippets' 
			\ , 'echodoc.vim' 
			\ , 'gvimfullscreen' 
			\ , 'bufexplorer' 
			\ , 'gruvbox' 
			\ , 'vim-textobj-function' 
			\ , 'vim-textobj-indent' 
			\ , 'vim-textobj-parameter' 
			\ , 'vim-textobj-syntax' 
			\ , 'vim-textobj-user' 
			\ , 'vim-airline' 
			\ , 'vim-airline-themes' 
			\ , 'vim-bufferline' 
			\ , 'neomake' 
			\ , 'vim-startify'
			\ , 'libcallex-vim' 
			\ , 'nerdcommenter' 
			\ , 'nerdcommenter'
			\ , 'nerdtree'
			\ , 'libcallex-vim'
			\ , 'limelight.vim'
			\ , 'vim-easymotion'
			\ , 'vim-terminal-help'
			\ , 'vim-textobj-function'
			\ , 'vim-textobj-indent'
			\ , 'vim-textobj-parameter'
			\ , 'vim-textobj-syntax'
			\ , 'vim-textobj-user'
			\ , 'vim-orgmode' 
			\ , 'vim-pandoc' 
			\ , 'vim-pandoc-syntax' 
			\ , 'vim-quickui' 
			\ , 'vim-sensible' 
			\ , 'vim-startify' 
			\ , 'vim-surround' 
			\ , 'vimcdoc' 
			\ , 'vim-commentary' 
			\ , 'vim-terminal-help' 
			\ , 'vim-unimpaired' 
			\ , 'vim-table-mode'
			\ , 'vimagit'
			\ , 'neosnippet.vim' 
			\ , 'neosnippet-snippets' 
			\ , 'vim-snippets'
			\ , 'ctrlp.vim'
			\ , 'vim-templates'
			\ , 'vim-cmake'
			\ , 'vim-fugitive'
			\ , 'vim-easymotion' 
			\ , 'vim-gitgutter' 
			\ , 'vim-gutentags' 
			\ , 'LeaderF'
			\ , 'plantuml-previewer.vim'
			\ ]
			" \	, 'coc.nvim'
			" \	, 'coc-snippets' 
			" \ , 'coc-git'
			" \ , 'coc-tabnine'

" https://github.com/iamcco/coc-vimlsp
" 				\ 'deoplete.nvim', 
" 				\ 'context_filetype.vim', 
" 				\ 'ale', 
" 				\ 'asyncomplete.vim', 
" 				\ 'asyncrun.vim', 
" 				\ 'asynctasks.vim', 
" 				\ 'AutoComplPop', 
" 				\ 'coc-snippets', 
" 				\ 'coc.nvim', 
" 				\ 'consolas-powerline-vim', 
" 				\ 'csv.vim', 
" 				\ 'deoplete-tabnine', 
" 				\ 'fern.vim', 
" 				\ 'fzf.vim', 
" 				\ 'gina.vim', 
" 				\ 'indentpython.vim', 
" 				\ 'limelight.vim', 
" 				\ 'nerdtree', 
" 				\ 'NrrwRgn', 
" 				\ 'poet-v', 
" 				\ 'promptline.vim', 
" 				\ 'python-mode', 
" 				\ 'syntastic', 
" 				\ 'taboo.vim', 
" 				\ 'tagbar', 
" 				\ 'ultisnips', 
" 				\ 'undotree', 
" 				\ 'unicode.vim', 
" 				\ 'vim-battery', 
" 				\ 'vim-bookmarks', 
" 				\ 'vim-capslock', 
" 				\ 'vim-clap', 
" 				\ 'vim-colors-solarized', 
" 				\ 'vim-cursormode', 
" 				\ 'vim-dirvish', 
" 				\ 'vim-easymotion', 
" 				\ 'vim-fugitive', 
" 				\ 'vim-gitgutter', 
" 				\ 'vim-gutentags', 
" 				\ 'vim-localsearch', 
" 				\ 'vim-lsp', 
" 				\ 'vim-markdown', 
" 				\ 'vim-markdown-preview', 
" 				\ 'vim-matlab', 
" 				\ 'vim-matlab-fold', 
" 				\ 'vim-obsession', 
" 				\ 'vim-tabws', 
" 				\ 'vim-translate', 
" 				\ 'vim-windowswap', 
" 				\ 'vimagit', 
" 				\ 'vimtex', 
" 				\ 'vista.vim', 
" 				\ 'YouCompleteMe', 
" 				\ 'zoomwintab.vim', 
" 				\ 'vim-slime', 
" 				\ 'vim-ipython', 
" 				\ 'vim-ipython-cell', 
" 				\ 'vim-leader-guide', 
" 				\ 'pynvim', 
" 				\ 'ctrlp.vim', 
" 				\ 'julia-vim', 
" 'tibabit/vim-templates'
" <https://github.com/lambdalisue/battery.vim>
" <https://github.com/MattesGroeger/vim-bookmarks>
" fugitive.vim <https://github.com/tpope/vim-fugitive>
" gina.vim     <https://github.com/lambdalisue/gina.vim>
" lawrencium   <https://bitbucket.org/ludovicchabant/vim-lawrencium>
" vcscommand   <http://www.vim.org/scripts/script.php?script_id=90>
" vim-capslock <https://github.com/tpope/vim-capslock>
" csv.vim <https://github.com/chrisbra/csv.vim>
" vim-ctrlspace <https://github.com/szw/vim-ctrlspace>
" cursormode <https://github.com/vheon/vim-cursormode>
" vim-dirvish <https://github.com/justinmk/vim-dirvish>
" fern.vim <https://github.com/lambdalisue/fern.vim>
" vim-gutentags <https://github.com/ludovicchabant/vim-gutentags>
" gen_tags.vim <https://github.com/jsfaint/gen_tags.vim>
" vim-gitgutter <https://github.com/airblade/vim-gitgutter>
" vim-signify <https://github.com/mhinz/vim-signify>
" changesPlugin <https://github.com/chrisbra/changesPlugin>
" quickfixsigns <https://github.com/tomtom/quickfixsigns_vim>
" coc-git <https://github.com/neoclide/coc-git>
" LanguageClient <https://github.com/autozimu/LanguageClient-neovim>
" localsearch <https://github.com/mox-mox/vim-localsearch>
" neomake <https://github.com/neomake/neomake>
" NrrwRgn <https://github.com/chrisbra/NrrwRgn>
" nvimlsp <https://github.com/neovim/nvim-lsp>
" vim-obsession <https://github.com/tpope/vim-obsession>
" OmniSharp <https://github.com/OmniSharp/omnisharp-vim>
" poetv <https://github.com/petobens/poet-v>
" syntastic <https://github.com/vim-syntastic/syntastic>
" taboo.vim <https://github.com/gcmt/taboo.vim>
" vim-tabws <https://github.com/s1341/vim-tabws>
" tagbar <https://github.com/majutsushi/tagbar>
" Undotree <https://github.com/mbbill/undotree>
" Unicode <https://github.com/chrisbra/unicode.vim>
" vimagit <https://github.com/jreybert/vimagit>
" Vim-CMake <https://github.com/cdelledonne/vim-cmake>
" virtualenv <https://github.com/jmcantrell/vim-virtualenv>
" vista.vim <https://github.com/liuchengxu/vista.vim>
" vim-windowswap <https://github.com/wesQ3/vim-windowswap>
" zoomwintab <https://github.com/troydm/zoomwintab.vim>
" DeXP/xkb-switch-win
"   
" let g:plugins = [ 'bling/vim-airline'
" 				\ 	, 'vim-airline/vim-airline-themes'
" 				\ 	, 'w0rp/ale'
" 				\   , 'lambdalisue/vim-battery'  
" 				\   , 'MattesGroeger/vim-bookmarks'
" 				\   , 'tpope/vim-fugitive'
" 				\   , 'lambdalisue/gina.vim'
" 				\   , 'jreybert/vimagit'
" 				\ 	, 'bling/vim-bufferline'
" 				\		, 'tpope/vim-capslock'
" 				\		, 'wincent/command-t'
" 				\		, 'chrisbra/csv.vim'
" 				\ 	, 'ctrlpvim/ctrlp.vim'
" 				\ 	, 'szw/vim-ctrlspace'
" 				\   , 'vheon/vim-cursormode'
" 				\ 	, 'justinmk/vim-dirvish'
" 				\ 	, 'lambdalisue/fern.vim'
" 				\ 	, 'junegunn/fzf'
" 				\		, 'mhinz/vim-grepper'
" 				\		, 'ludovicchabant/vim-gutentags'
" 				\		, 'airblade/vim-gitgutter'
" 				\		, 'neoclide/coc-git'
" 				\		, 'mox-mox/vim-localsearch'
" 				\ 	, 'morhetz/gruvbox'
" 				\ 	, 'eugeii/consolas-powerline-vim'
" 				\ 	, 'junegunn/vim-plug'
" 				\ 	, 'Shougo/dein.vim'
" 				\ 	, 'wsdjeg/dein-ui.vim'
" 				\ 	, 'haya14busa/dein-command.vim'
" 				\ 	, 'altercation/vim-colors-solarized'
" 				\ 	, 'liuchengxu/vim-which-key'
" 				\ 	, 'hecal3/vim-leader-guide'
" 				\ 	, 'skywind3000/vim-quickui'
" 				\ 	, 'Shougo/unite.vim'
" 				\ 	, 'thinca/vim-unite-history'
" 				\ 	, 'Shougo/unite-outline'
" 				\ 	, 'Shougo/unite-help'
" 				\ 	, 'tsukkee/unite-tag'
" 				\ 	, 'osyo-manga/unite-quickfix'
" 				\ 	, 'msprev/unite-bibtex'
" 				\ 	, 'chemzqm/unite-git-log'
" 				\ 	, 'hewes/unite-gtags'
" 				\ 	, 'Shougo/neoyank.vim'
" 				\ 	, 'Shougo/neomru.vim' 
" 				\ 	, 'Shougo/denite.nvim'
" 				\ 	, 'roxma/vim-hug-neovim-rpc'  	
" 				\ 	, 'roxma/nvim-yarp'
" 				\ 	, 'Yggdroot/LeaderF'
" 				\ 	, 'liuchengxu/vim-clap'
" 				\ 	, 'junegunn/fzf.vim'
" 				\ 	, 'prabirshrestha/vim-lsp'
" 				\		, 'neovim/nvim-lsp'
" 				\		, 'tpope/vim-obsession'
" 				\		, 'OmniSharp/omnisharp-vim'
" 				\ 	, 'Shougo/deoplete.nvim'
" 				\ 	, 'vim-scripts/indentpython.vim'
" 				\ 	, 'neomake/neomake'
" 				\ 	, 'Valloric/YouCompleteMe'
" 				\ 	, 'neoclide/coc-tabnine'
" 				\ 	, 'tbodt/deoplete-tabnine'
" 				\ 	, 'SirVer/ultisnips'
" 				\ 	, 'Shougo/neosnippet.vim'
" 				\ 	, 'Shougo/neosnippet-snippets'
" 				\ 	, 'neoclide/coc-snippets'
" 				\ 	, 'honza/vim-snippets'
" 				\ 	, 'jlanzarotta/bufexplorer'
" 				\ 	, 'archerc/gvimfullscreen'
" 				\ 	, 'skywind3000/asyncrun.vim'
" 				\ 	, 'skywind3000/vim-terminal-help' 
" 				\ 	, 'python-mode/python-mode'
" 				\ 	, 'tpope/vim-markdown'
" 				\ 	, 'JamshedVesuna/vim-markdown-preview'
" 				\ 	, 'daeyun/vim-matlab'
" 				\ 	, 'djoshea/vim-matlab-fold'
" 				\ 	, 'jceb/vim-orgmode'
" 				\ 	, 'vim-pandoc/vim-pandoc'
" 				\ 	, 'vim-pandoc/vim-pandoc-syntax'
" 				\ 	, 'tpope/vim-sensible'
" 				\ 	, 'tpope/vim-commentary'
" 				\ 	, 'tpope/vim-unimpaired'
" 				\ 	, 'tpope/vim-surround'
" 				\ 	, 'geratheon/vim-translate'
" 				\ 	, 'jreybert/vimagit'
" 				\ 	, 'yianwillis/vimcdoc'
" 				\ 	, 'lervag/vimtex'
" 				\ 	, 'Shougo/context_filetype.vim'
" 				\ 	, 'Shougo/echodoc.vim'
" 				\ 	, 'Shougo/vimproc.vim'           
" 				\ 	, 'Shougo/vimfiler.vim'
" 				\  	, 'JuliaEditorSupport/julia-vim'
" 				\  	, 'hanschen/vim-ipython-cell'
" 				\	  , 'chrisbra/NrrwRgn'
" 				\		, 'edkolev/promptline.vim'
" 				\		, 'vim-syntastic/syntastic'
" 				\		, 'gcmt/taboo.vim'
" 				\		, 'majutsushi/tagbar'
" 				\		, 'mbbill/undotree'
" 				\		, 'chrisbra/unicode.vim'
" 				\		, 'liuchengxu/vista.vim'
" 				\		, 'wesQ3/vim-windowswap'
" 				\		, 'troydm/zoomwintab.vim'
" 				\		, 'DeXP/xkb-switch-win'
" 				\ ]
"			\ 'nvim-lsp', 

let g:plugins_disabled = [ 
 				\		  'neovim/nvim-lsp'
 				\ 	, 'w0rp/ale'
				\ 	,	'Valloric/YouCompleteMe'
				\ 	, 'Shougo/deoplete.nvim'
				\		, 'jsfaint/gen_tags.vim'
				\		, 'autozimu/LanguageClient-neovim'
				\		, 'jmcantrell/vim-virtualenv'
				\		, 'tomtom/quickfixsigns_vim'
				\		, 'chrisbra/changesPlugin'
				\		, 'mhinz/vim-signify'
				\   , 'jpalardy/vim-slime'
				\ 	, 'prabirshrestha/asyncomplete.vim'
				\		, 's1341/vim-tabws'
				\		, 'petobens/poet-v'
				\ 	, 'vim-scripts/AutoComplPop'
 				\  	, 'junegunn/fzf.vim'
				\   , 'ultisnips'
 				\ 	, 'vim-ipython-cell' 
				\ ] 
 				" \ 	, 'Shougo/neoyank.vim'
 				" \ 	, 'neomake/neomake'
				" \		, 'cdelledonne/vim-cmake'

let g:modules = [ 'plug'
			\	, 'key'
			\	, 'gvimfullscreen'
 			\	, 'airline'
 			\	, 'table'
			\	, 'vimfiler'
			\	, 'quickmenu'
			\	, 'startify'
			\	, 'terminal'
			\	, 'denite'
			\ , 'pandoc'
			\ , 'tex'
			\ , 'git'
			\ , 'gutentags'
			\	]
			" \	, 'snippet'
			" \	, 'python'
			" \ , 'complete'

let g:modules_disabled = [
			\	  'context_filetype'
			\	, 'dein'
			\	, 'julia'
			\ , 'python-mode'
			\ ]

