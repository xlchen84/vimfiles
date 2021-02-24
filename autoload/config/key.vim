
" Buffer:
function! s:which_key_buffer()
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
function! s:which_key_config()
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
function! s:which_key_file()
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

" Open:
function! s:which_key_open()
	 let g:which_key_map.o = { 'name' : '+open',
					 \ 				'q' : ['copen', 'quickfix']    ,
					 \ 				'l' : ['lopen', 'locationlist'],
					 \ }
endfunction

" Slime:
function! s:which_key_run()
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
function! s:which_key_plugin()
	 let g:which_key_map.p = { 'name': '+plugin',
					 \ 				'd':  ['config#dein()', 'dein'],
					 \ 			   'p':  ['config#plug()', 'plug'],
					 \ 			   'i':  ['dein#install()', 'install'],
					 \ 			   'u':  ['PlugUpdate', 'update'],
					 \ }
endfunction

" Toggle:
function! s:which_key_toggle()
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
function! s:which_key_window()
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

function! s:which_key()
	 " default 1000
	 set timeoutlen=500
	 let g:mapleader = "\<Space>"
	 let g:maplocalleader = ','
	 let g:which_key_map = {}
	 call which_key#register('<Space>', "g:which_key_map")
	 nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
	 vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
	 nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
	 " Hide statusline
	 autocmd! FileType which_key
	 autocmd  FileType which_key set laststatus=0 noshowmode noruler
					 \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

	 " define keymap
	 call s:which_key_buffer()
	 call s:which_key_config()
	 call s:which_key_file()
	 call s:which_key_open()
	 call s:which_key_plugin()
	 call s:which_key_run()
	 call s:which_key_toggle()
	 call s:which_key_window()
endfunction

function! s:meta_keys()
	 nnoremap  	<M-b> 						:ToggleBufExplorer<CR>
	 nnoremap  	<M-c> 						:Unite -start-insert command<CR>
	 nnoremap  	<M-d> 						:Unite -start-insert neomru/directory directory_rec<CR>
	 nnoremap  	<M-e> 						:VimFilerBufferDir<CR>
	 nnoremap  	<M-f> 						:Unite -start-insert file_rec file/new<CR>
	 nnoremap  	<M-g> 						:MagitOnly<CR>
	 nnoremap  	<M-h> 						:Unite -start-insert help<CR>
	 nnoremap  	<M-j> 						:Unite -start-insert jump<CR>
	 nnoremap  	<M-k> 						:Unite -start-insert mapping<CR>
	 nnoremap  	<M-l> 						:Unite -start-insert line<CR>
	 nnoremap  	<M-m> 						:Unite bookmark menu<CR>
	 nnoremap  	<M-n> 						:Unite -start-insert file/new<CR>
	 nnoremap  	<M-o> 						:Unite outline<CR>
	 nnoremap  	<M-q> 						:bd<CR>
	 tnoremap 	<M-q> 						<C-\><C-n>
	 nnoremap  	<M-r> 						:Unite -start-insert neomru/file<CR>
	 nnoremap  	<M-t> 						:NERDTreeToggle<CR>
	 nnoremap  	<M-u> 						:Unite -start-insert<CR>
	 nnoremap  	<M-v> 						:VimFilerExplorer -auto-cd -force-quit<CR>
	 nnoremap  	<M-w> 						:Unite window<CR>
	 nnoremap 	<M-=> 						:cd %:p:h<CR>:terminal powershell<CR>
	 nnoremap  	<M-;> 						:Commentary<CR>
	 vnoremap  	<M-;> 						:Commentary<CR>
	 nnoremap  	<M-`> 						:call term_start(&shell, { 'cwd': expand('%:p:h')})<CR>
endfunction

function! s:shift_meta_keys()
	 nnoremap  	<M-S-h> 						<C-w>h
	 nnoremap  	<M-S-l> 						<C-w>l
	 nnoremap  	<M-S-j> 						<C-w>j
	 nnoremap  	<M-S-k> 						<C-w>k
	 nnoremap  	<M-S-o> 						<C-w>o
endfunction

function! s:control_keys()
	 nnoremap 	<C-h> 						<C-w>h
	 nnoremap 	<C-l> 						<C-w>l
	 inoremap 	<C-s> 						<Esc>:w<CR>
	 nnoremap 	<C-s> 						:w<CR>
endfunction

function! s:function_keys()
	 noremap 	<Plug>(init)  		:call config#init()<CR>
	 noremap 	<Plug>(reload-keymap) 	<Esc>:call config#keybindings()<CR>
	 noremap 	<Plug>(chdir) 				<Esc>:cd %:p:h<CR>
	 nmap 					<F5> 				<Plug>(init)
	 nmap 		<silent> <F2> 				<Esc>:call config#show_debug()<CR>
	 nmap 					<F3> 				<Plug>(reload-keymap)
	 nmap 					<F4> 				<Plug>(chdir)
	 nmap 					<F11> 			<Plug>(toggle-fullscreen)
endfunction

function! s:ascii_keys()
	 nnoremap 	]b 							:bnext<CR>
	 nnoremap 	[b 							:bprev<CR>
endfunction

function! config#key#init()
	 try
		  call s:ascii_keys()
		  call s:meta_keys()
		  call s:control_keys()
		  call s:function_keys()
		  call s:shift_meta_keys()
		  call s:which_key()
	 catch
		  call config#debug('error: {}', v:exception)
	 endtry
endfunction

"vim: set ft=vim fdm=indent
