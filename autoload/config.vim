" vim: ft=vim fdm=marker
"平台无关 {{{
function config#os()
	 if has('win32')
		  return 'windows'
	 endif
endfunction
"}}} 

" 初始化{{{
let g:vimfiles_windows = expand('$VIM/vimfiles')
let $MYVIMRC = expand('$VIM/vimrc')
function config#init()
	 call config#message('initalizing')
	 let vimfiles = g:vimfiles_{config#os()}
	 let manager = expand(vimfiles . '/autoload/plug.vim')
	 let manager_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	 if empty(glob(manager))
		  call config#download(manager, manager_url)
		  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	 endif
	 let bundle = vimfiles . '/bundle'
	 call plug#begin(bundle)
	 Plug 'w0rp/ale'
	 Plug 'vim-scripts/AutoComplPop'
	 Plug 'bling/vim-airline'
	 Plug 'jlanzarotta/bufexplorer'
	 Plug 'eugeii/consolas-powerline-vim'
	 Plug 'morhetz/gruvbox'
	 Plug 'archerc/gvimfullscreen'
	 Plug 'hecal3/vim-leader-guide'
	 Plug 'kien/ctrlp.vim'
	 Plug 'skywind3000/asyncrun.vim'
	 Plug 'skywind3000/vim-terminal-help' " https://github.com/skywind3000/vim-terminal-help
	 Plug 'wsdjeg/dein-ui.vim'
	 Plug 'haya14busa/dein-command.vim'
	 Plug 'Shougo/context_filetype.vim'
	 Plug 'Shougo/denite.nvim'
	 Plug 'Shougo/echodoc.vim'
	 Plug 'Shougo/vimproc.vim', { 'do': 'make' }
	 Plug 'Shougo/unite.vim'
	 Plug 'Shougo/vimfiler.vim'
	 Plug 'Shougo/unite-outline'
	 Plug 'Shougo/neomru.vim' " https://github.com/Shougo/neomru.vim
	 Plug 'tpope/vim-sensible' 
	 Plug 'tpope/vim-commentary' 
	 Plug 'vim-airline/vim-airline-themes'
	 call plug#end()
	 call config#keybindings()
endfunction
"}}}

" 按键{{{
function! config#keybindings()
	 inoremap 	<C-s> 						<Esc>:w<CR>
	 nnoremap 	<C-s> 						:w<CR>jk
	 nnoremap 	]b 							:bnext<CR>
	 nnoremap 	[b 							:bprev<CR>
	 nnoremap  	<M-b> 						:Unite buffer<CR>
	 nnoremap  	<M-c> 						:Unite -start-insert command<CR>
	 nnoremap  	<M-d> 						:Unite -start-insert neomru/directory directory_rec<CR>
	 nnoremap  	<M-f> 						:Unite -start-insert neomru/file file_rec file/new<CR>
	 nnoremap  	<M-j> 						:Unite -start-insert jump<CR>
	 nnoremap  	<M-l> 						:Unite -start-insert line<CR>
	 nnoremap  	<M-m> 						:Unite bookmark menu<CR>
	 nnoremap  	<M-n> 						:Unite -start-insert file/new<CR>
	 nnoremap  	<M-o> 						:Unite outline<CR>
	 nnoremap  	<M-q> 						:bd<CR>
	 tnoremap 	<M-q> 						<C-\><C-n>
	 nnoremap  	<M-u> 						:Unite -start-insert<CR>
	 nnoremap  	<M-w> 						:Unite window<CR>
	 nnoremap 	<M-=> 						:terminal<CR>
	 nnoremap  	<M-;> 						:Commentary<CR>
	 vnoremap  	<M-;> 						:Commentary<CR>
	 noremap 	<Plug>(init)  				:call config#init()<CR>
	 nmap 		<F5> 							<Plug>(init)
	 noremap 	<Plug>(edit-vimrc) 		<Esc>:edit $VIM/vimrc<CR>
	 nmap 		<F2> 							<Plug>(edit-vimrc)
	 noremap 	<Plug>(reload-keymap) 	<Esc>:call config#keybindings()<CR>
	 nmap 		<F3> 							<Plug>(reload-keymap)
	 noremap 	<Plug>(chdir) 				<Esc>:cd %:p:h<CR>
	 nmap 		<F4> 							<Plug>(chdir)
	 nmap 		<F11> 						:simalt ~X<CR>
	 " let 			mapleader='\<Space>'
	 " map 			<leader>. <Plug>leaderguide-global
	 " map 			<localleader>. <Plug>leaderguide-buffer
endfunction

"}}}

" LeaderGuide {{{2
function config#leader_guide()
	 " Define prefix dictionary
	 let g:lmap =  {}

	 " Second level dictionaries:
	 let g:lmap.f = { 'name' : 'File Menu' }
	 let g:lmap.o = { 'name' : 'Open Stuff' }
	 " 'name' is a special field. It will define the name of the group.
	 " leader-f is the "File Menu" group.
	 " Unnamed groups will show an empty string

	 " Provide commands and descriptions for existing mappings
	 nmap <silent> <leader>fd :e $MYVIMRC<CR>
	 let g:lmap.f.d = ['e $MYVIMRC', 'Open vimrc']

	 nmap <silent> <leader>fs :so %<CR>
	 " let g:lmap.f.s = ['so %', 'Source file']

	 nmap <silent> <leader>oo  :copen<CR>
	 " let g:lmap.o.o = ['copen', 'Open quickfix']

	 nmap <silent> <leader>ol  :lopen<CR>
	 " let g:lmap.o.l = ['lopen', 'Open locationlist']

	 nmap <silent> <leader>fw :w<CR>
	 " let g:lmap.f.w = ['w', 'Write file']

	 " Menu Function~
	 " Create new menus not based on existing mappings:
	 let g:lmap.g = { 'name' : 'Git Menu',
					 \ 		's' : ['Gstatus', 'Git Status'],
					 \		'p' : ['Gpull',   'Git Pull'],
					 \		'u' : ['Gpush',   'Git Push'],
					 \		'c' : ['Gcommit', 'Git Commit'],
					 \		'w' : ['Gwrite',  'Git Write'],
					 \	}

	 " NerdCommenter~
	 " If you use NERDCommenter:
	 let g:lmap.c = { 'name' : 'Comments' }
	 " Define some descriptions
	 let g:lmap.c.c = ['call feedkeys("\<Plug>NERDCommenterComment")','Comment']
	 let g:lmap.c[' '] = ['call feedkeys("\<Plug>NERDCommenterToggle")','Toggle']
	 " The Descriptions for other mappings defined by NerdCommenter, will default
	 " to their respective commands.

	 " Plugin Specific Menus~
	 " set up dictionary for <localleader>
	 let g:llmap = {}
	 autocmd FileType tex let g:llmap.l = { 'name' : 'vimtex' }
	 call leaderGuide#register_prefix_descriptions(",", "g:llmap")
	 " to name the <localleader>-n group vimtex in tex files.

	 " Paging Function
	 let g:leaderGuide_max_size = 5
	 let g:leaderGuide_submode_mappings = { '<C-F>': 'page_down', '<C-B>': 'page_up'}


	 " Final Setup
	 " combine the two dictionaries into a single top-level dictionary:
	 let g:topdict = {}
	 let g:topdict[' '] = g:lmap
	 let g:topdict[' ']['name'] = '<leader>'
	 let g:topdict[','] = g:llmap
	 let g:topdict[',']['name'] = '<localleader>'

	 " register it with the guide:
	 call leaderGuide#register_prefix_descriptions("", "g:topdict")

	 let g:mapleader='\<Space>'
	 " define mappings:
	 nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
	 vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>
	 map <leader>. <Plug>leaderguide-global
	 nnoremap <localleader> :<c-u>LeaderGuide  ','<CR>
	 vnoremap <localleader> :<c-u>LeaderGuideVisual  ','<CR>
	 map <localleader>. <Plug>leaderguide-buffer
endfunction
"2}}}

" 插件配置{{{1

" airline {{{2
let g:airline_extensions = ['branch', 'tabline', 'ale']
let g:airline_theme="dark" 
" let g:airline_theme="solarized" 
let g:airline_powerline_fonts = 1  
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
"2}}}

"1}}}

function config#message(template, ...)
	 python3 <<EOF
import vim
print(vim.eval('a:template').format(*vim.eval('a:000')))
EOF
endfunction

function config#download(location, url)
	 call config#message('downloading to {} from {}', a:location, a:url)
endfunction


