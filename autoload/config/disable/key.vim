"vim:ft=vim:fdm=indent:ts=4:sw=4:noet
function! config#key#init() abort
	 try
		  call config#key#ascii_keys()
		  call config#key#meta_keys()
		  call config#key#control_keys()
		  call config#key#function_keys()
		  call config#key#shift_meta_keys()
		  call config#key#which_key()
	 catch
		  call config#debug('error: {}', v:exception)
	 endtry
endfunction

function! config#key#ascii_keys() abort
	 nnoremap 	]b 							:bnext<CR>
	 nnoremap 	[b 							:bprev<CR>
	 inoremap 	jk 							<Esc>
	 nnoremap 	<Esc> 						<Esc>:noh<CR>
endfunction

function! config#key#meta_keys()
	 if has('nvim')
		  nnoremap  	<M-b> 						:Denite buffer<CR>
	 else
		  nnoremap  	<M-b> 						:Unite -start-insert buffer<CR>
	 endif 
	 nnoremap  	<M-c> 						:Unite -start-insert command<CR>
	 nnoremap  	<M-d> 						:Unite -start-insert neomru/directory directory_rec<CR>
	 nnoremap  	<M-e> 						:VimFilerBufferDir<CR>
	 nnoremap  	<M-f> 						:Unite -start-insert file_rec -direction=botright<CR>
	 nnoremap  	<M-g> 						:Leaderf rg<CR>
	 nnoremap  	<M-h> 						:Unite -start-insert help<CR>
	 nnoremap  	<M-j> 						:Unite -start-insert jump<CR>
	 nnoremap  	<M-k> 						:Unite -start-insert mapping<CR>
	 nnoremap  	<M-l> 						:CocList<CR>
	 nnoremap  	<M-m> 						:Unite bookmark menu<CR>
	 nnoremap  	<M-n> 						:Unite -start-insert file/new<CR>
	 nnoremap  	<M-o> 						:Unite outline<CR>
	 nmap  		<M-s> 						<Plug>(easymotion-prefix)
	 nnoremap  	<M-q> 						:bd!<CR>
	 tnoremap 	<M-q> 						<C-\><C-n>
	 nnoremap  	<M-r> 						:Unite -start-insert neomru/file<CR>
	 nnoremap  	<M-t> 						:NERDTreeToggle<CR>
	 if has('nvim')
		  nnoremap  	<M-u> 						:Denite source<CR>
	 else
		  nnoremap  	<M-u> 						:Unite -start-insert source<CR>
	 endif 
	 nnoremap  	<M-v> 						:VimFilerExplorer -auto-cd -force-quit<CR>
	 nnoremap  	<M-w> 						:Unite window<CR>
	 nnoremap 	<M-=> 						:cd %:p:h<CR>:terminal <CR>
	 nnoremap  	<M-;> 						:Commentary<CR>
	 vnoremap  	<M-;> 						:Commentary<CR>
	 nnoremap  	<M-`> 						:call term_start(&shell, { 'cwd': expand('%:p:h')})<CR>
endfunction

function! config#key#control_keys() abort
	 nnoremap 	<C-h> 						<C-w>h
	 nnoremap 	<C-l> 						<C-w>l
	 inoremap 	<C-s> 						<Esc>:w<CR>
	 nnoremap 	<C-s> 						:w<CR>
endfunction

function! config#key#function_keys() abort
	 noremap 	<Plug>(init)  		:call config#init()<CR>
	 noremap 	<Plug>(reload-keymap) 	<Esc>:call config#keybindings()<CR>
	 noremap 	<Plug>(chdir) 				<Esc>:cd %:p:h<CR>
	 noremap 	<Plug>(open-log-file) 	<Esc>:call config#show_debug()<CR>
	 " nmap 					<F5> 				<Plug>(init)
	 nmap 		<silent> <F2> 				<Plug>(open-log-file)
	 nmap 					<F3> 				<Plug>(reload-keymap)
	 nmap 					<F4> 				<Plug>(chdir)
	 nmap 					<F11> 			<Plug>(toggle-fullscreen)
endfunction

function! config#key#shift_meta_keys() abort
	 nnoremap  	<M-S-b> 						:ToggleBufExplorer<CR>
	 nnoremap  	<M-S-c> 						<C-w>c
	 nnoremap  	<M-S-h> 						<C-w>h
	 nnoremap  	<M-S-l> 						<C-w>l
	 nnoremap  	<M-S-j> 						<C-w>j
	 nnoremap  	<M-S-k> 						<C-w>k
	 nnoremap  	<M-S-o> 						<C-w>o
	 nnoremap  	<M-S-s> 						<C-w>s
	 nnoremap  	<M-S-v> 						<C-w>v
	 nnoremap  	<M-S-w> 						<C-w>w
endfunction

function! config#key#which_key() abort
	 " default 1000
	 set timeoutlen=500
	 let g:mapleader = '\<Space>'
	 let g:maplocalleader = ','
	 map <Space> <leader>

	 " Define which_key_map
	 let g:which_key_map = {}
	 " define keymap
	 call config#key#which_key_buffer()
	 call config#key#which_key_config()
	 call config#key#which_key_file()
	 call config#key#which_key_open()
	 call config#key#which_key_plugin()
	 call config#key#which_key_run()
	 call config#key#which_key_search()
	 call config#key#which_key_toggle()
	 call config#key#which_key_window()
	 call config#key#which_key_leaderf()

	 " Register
	 call which_key#register('<Space>', "g:which_key_map")

	 nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
	 vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
	 nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
	 " Hide statusline
	 autocmd! FileType which_key
	 autocmd  FileType which_key set laststatus=0 noshowmode noruler
					 \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

endfunction

" Buffer:
function! config#key#which_key_buffer() abort
	 let g:which_key_map.b = {
					 \ 				'name' 	: '+buffer' ,
					 \ 				'1' 		: ['b1'        			, 'buffer 1']        ,
					 \ 				'2' 		: ['b2'        			, 'buffer 2']        ,
					 \ 				'c' 		: ['<Plug>(chdir)'      , 'chdir']   ,
					 \ 				'd' 		: ['bd'        			, 'delete-buffer']   ,
					 \ 				'e' 		: ['ToggleBufExplorer'  , 'explore-buffer']    ,
					 \ 				'f' 		: ['bfirst'    			, 'first-buffer']    ,
					 \ 				'h' 		: ['Startify'  			, 'home-buffer']     ,
					 \ 				'l' 		: ['blast'     			, 'last-buffer']     ,
					 \ 				'n' 		: ['bnext'     			, 'next-buffer']     ,
					 \ 				'p' 		: ['bprevious' 			, 'previous-buffer'] ,
					 \ 				'?' 		: ['Buffers'   			, 'fzf-buffer']      ,
					 \ }
endfunction

" Config:
function! config#key#which_key_config() abort
	 let g:which_key_map.c = { 'name' 	: '+config' 
					 \ , 				'a' 		: ['config#airline#init()' 	, 'airline' ]
					 \ , 				'i' 		: ['config#init()'						, 'init'    ] 
					 \ , 				'k' 		: ['config#key#init()' 		, 'key'     ]
					 \ , 				'p' 		: ['config#plug#init()' 		, 'plug'    ]
					 \ , 				'P' 		: ['config#python#init()' 	, 'Python'  ]
					 \ , 				's' 		: ['config#snippet#init()'  , 'snippet' ]
					 \ , 				't' 		: ['config#terminal#init()' , 'terminal']
					 \ }
	 nmap <silent> 	<Plug>(edit-init) :edit $VIM/vimfiles/init.vim<CR>
	 nmap <silent> 	<Plug>(edit-config) :edit $VIM/vimfiles/autoload/config.vim<CR>
	 nmap <silent> 	<Plug>(edit-config-key) :edit $VIM/vimfiles/autoload/config/modules/key.vim<CR>
	 let g:which_key_map.c.e = { 'name' 	: '+edit' 
					 \ , 				'i': ['<Plug>(edit-init)',  'init']
					 \ , 				'c': ['<Plug>(edit-config)',  'config']
					 \ , 				'k': ['<Plug>(edit-config-key)',  'key']
					 \ }
endfunction

" File:
function! config#key#which_key_file() abort
	 nmap <silent> <Plug>(recent-files) :Unite -start-insert neomru/file<CR>
	 nmap <silent> <Plug>(open-files)  	:Unite -start-insert file_rec<CR>
	 nmap <silent> <Plug>(edit-vimrc)  	:e $MYVIMRC<CR>
	 nmap <silent> <Plug>(source-vimrc) :source %<CR>
	 let g:which_key_map.f = { 'name' 	: '+file'
					 \ ,	    		'd'		: ['<Plug>(open-files)'			, 'edit-vimrc'] 
					 \ ,				'i'		: ['config#init()'				, 'init']	
					 \ ,				'r'		: ['<Plug>(recent-files)'		, 'recent']
					 \ ,				's'		: ['<Plug>(source-vimrc)'		, 'source']
					 \ ,				'v'		: ['VimFilerBufferDir'			, 'vimfiler']
					 \ ,				'w'		: ['update'							, 'save']
					 \ }
	 
	 " Jump:
	 let g:which_key_map.j = { 'name' : '+jump',
					 \ }
endfunction

" Leaderf:
function! config#key#which_key_leaderf() abort
	 let g:Lf_RgConfig = [
					 \ "--max-columns=150",
					 \ "--type-add web:*.{html,css,js}*",
					 \ "--glob=!git/*",
					 \ "--hidden"
					 \ ]
	 let g:which_key_map.l = { 'name': '+leader',
					 \ 				  't'   : [':Leaderf tag'				, 'tag'					]  ,
					 \ 				  'l'   : [':Leaderf line'				, 'line'					]  ,
					 \ 				  'c'   : [':Leaderf command'			, 'command'				]  ,
					 \ 				  'f'   : [':Leaderf file'				, 'file'					]  ,
					 \ 				  'j'   : [':Leaderf jumps'			, 'jump'					]  ,
					 \ 				  'm'   : [':Leaderf mru'				, 'mru'					]  ,
					 \ 				  'w'   : [':Leaderf window'			, 'window'				]  ,
					 \ 				  '&'   : [':Leaderf filetype'		, 'filetype'			]  ,
					 \ 				  'B'   : [':Leaderf bufTag'			, 'bufTag'				]  ,
					 \ 				  'r'   : [':Leaderf rg'	 			, 'rg'					]  ,
					 \ 				  'F'   : [':Leaderf function'		, 'function'			]  ,
					 \ 				  'q'   : [':Leaderf quickfix'		, 'quickfix'			]  ,
					 \ 				  's'   : [':Leaderf self'				, 'self'					]  ,
					 \ 				  'H'   : [':Leaderf cmdHistory'		, 'cmdHistory'			]  ,
					 \ 				  'S'   : [':Leaderf searchHistory'	, 'searchHistory'		]  ,
					 \ 				  'g'   : [':Leaderf gtags'			, 'gtags'				]  ,
					 \ 				  'h'   : [':Leaderf help'				, 'help'					]  ,
					 \ 				  'C'   : [':Leaderf colorscheme'	, 'colorscheme'		]  ,
					 \ 				  'L'   : [':Leaderf loclist'			, 'locationlist'		]  ,
					 \ 				  'b'   : [':Leaderf buffer'			, 'buffer'				]  ,
					 \ 				  '.'   : [':Leaderf --recall'		, 'repeat'				]  ,
					 \ 				  ']'   : [':Leaderf --next'			, 'next'					]  ,
					 \ 				  '['   : [':Leaderf --previous'		, 'previous'			]  ,
					 \ }
endfunction

" Open:
function! config#key#which_key_open() abort
	 let g:which_key_map.o = { 'name' : '+open',
					 \ 				'q' : ['copen', 'quickfix']    ,
					 \ 				'l' : ['lopen', 'locationlist'],
					 \ }
endfunction

" Slime:
function! config#key#which_key_run() abort
	 let g:which_key_map.r = { 'name' : '+run'
					 \,				'c' : ['<Plug>SlimeConfig'				, 'config']
					 \,				'l' : ['<Plug>SlimeLineSend'			, 'line']
					 \,				'm' : ['<Plug>SlimeMotionSend'		, 'move']
					 \,				'n' : ['<Plug>SlimeSendCell'			, 'move']
					 \,				'p' : ['<Plug>SlimeParagraphSend'	, 'paragraph']
					 \,				'r' : ['<Plug>SlimeRegionSend'		, 'region']
					 \,				's' : ['SlimeSend'  						, 'send']
					 \ }
endfunction


" Plugin:
function! config#key#which_key_plugin() abort
	 let g:which_key_map.p = { 'name': '+plugin',
					 \ 				'd':  ['config#dein()', 'dein'],
					 \ 			   'p':  ['config#plug()', 'plug'],
					 \ 			   'i':  ['dein#install()', 'install'],
					 \ 			   'u':  ['PlugUpdate', 'update'],
					 \ }
endfunction

" Search:
function! config#key#which_key_search() abort
	 let g:which_key_map.s = { 'name': '+search',
					 \					's' 	: ['<Plug>(easymotion-prefix)', 'easymotion'],
					 \					'f' 	: ['<Plug>(easymotion-f)'		, ''],
					 \					'F' 	: ['<Plug>(easymotion-F)'		, ''],
					 \					't' 	: ['<Plug>(easymotion-t)'		, ''],
					 \					'T' 	: ['<Plug>(easymotion-T)'		, ''],
					 \					'w' 	: ['<Plug>(easymotion-w)'		, ''],
					 \					'W' 	: ['<Plug>(easymotion-W)'		, ''],
					 \					'b' 	: ['<Plug>(easymotion-b)'		, ''],
					 \					'B' 	: ['<Plug>(easymotion-B)'		, ''],
					 \					'e' 	: ['<Plug>(easymotion-e)'		, ''],
					 \					'E' 	: ['<Plug>(easymotion-E)'		, ''],
					 \					'ge' 	: ['<Plug>(easymotion-ge'		, ''],
					 \					'gE' 	: ['<Plug>(easymotion-gE'		, ''],
					 \					'j' 	: ['<Plug>(easymotion-j)'		, ''],
					 \					'k' 	: ['<Plug>(easymotion-k)'		, ''],
					 \					'n' 	: ['<Plug>(easymotion-n)'		, ''],
					 \					'N' 	: ['<Plug>(easymotion-N)'		, ''],
					 \ }
endfunction

" Toggle:
function! config#key#which_key_toggle() abort
	 let g:which_key_map.t = { 'name': '+toggle'
					 \,				'a'   : ['AirlineToggle'    			, 'airline' ]
					 \,				'b'   : ['BookmarkToggle'    			, 'bookmark' ]
					 \,	 			'f'   : ['ToggleFullscreen', 'fullscreen']
					 \,	 			'n'   : ['NERDTree'  					, 'nerdtree']
					 \,	 			't'   : ['<Plug>(toogle-top-most)'  , 'topmost']
					 \,				'v'   : ['VimFilerExplorer'			, 'vimfiler']
					 \, 				'+'	: ['<Plug>(vim-increase-alpha)', 'increase-alpha']
					 \, 				'-'	: ['<Plug>(vim-decrease-alpha)', 'decrease-alpha']
					 \ }
endfunction

" Window:
function! config#key#which_key_window() abort
	 let g:which_key_map.w = {
					 \ 'name' : '+windows' ,
					 \ 'w' : ['<C-W>w'     , 'other-window']          ,
					 \ 'd' : ['<C-W>c'     , 'delete-window']         ,
					 \ '-' : ['<C-W>s'     , 'split-window-below']    ,
					 \ '|' : ['<C-W>v'     , 'split-window-right']    ,
					 \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
					 \ 'h' : ['<C-W>h'     , 'window-left']           ,
					 \ 'j' : ['<C-W>j'     , 'window-below']          ,
					 \ 'l' : ['<C-W>l'     , 'window-right']          ,
					 \ 'k' : ['<C-W>k'     , 'window-up']             ,
					 \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
					 \ 'J' : [':resize +5'  , 'expand-window-below']   ,
					 \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
					 \ 'K' : [':resize -5'  , 'expand-window-up']      ,
					 \ '=' : ['<C-W>='     , 'balance-window']        ,
					 \ 's' : ['<C-W>s'     , 'split-window-below']    ,
					 \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
					 \ '?' : ['Windows'    , 'fzf-window']            ,
					 \ }
	 " 1:
	 nnoremap <leader>1 :1wincmd w<CR>
	 let g:which_key_map.1 = 'which_key_ignore'
endfunction

"vim: set ft=vim fdm=indent
