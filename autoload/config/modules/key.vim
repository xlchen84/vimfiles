
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

	 " Buffer:
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

	 " Config:
	 let g:which_key_map.c = { 'name' 	: '+config' 
					 \ , 				'i' 		: ['config#init()'	, 'init'] 
					 \ , 				'k' 		: ['config#modules#key#init()' 	, 'key' ]
					 \ , 				'p' 		: ['config#modules#plug#init()' 	, 'plug' ]
					 \ }

	 " File:
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

	 " Open:
	 let g:which_key_map.o = { 'name' : '+open',
					 \ 				'q' : ['copen', 'quickfix']    ,
					 \ 				'l' : ['lopen', 'locationlist'],
					 \ }

	 " Plugin:
	 let g:which_key_map.p = { 'name': '+plugin',
					 \ 				'd':  ['config#dein()', 'dein'],
					 \ 			   'p':  ['config#plug()', 'plug'],
					 \ 			   'i':  ['dein#install()', 'install'],
					 \ 			   'u':  ['PlugUpdate', 'update'],
					 \ }
	 " Toggle:
	 let g:which_key_map.t = { 'name': '+toggle'
					 \,				'a'   : ['AirlineToggle'    			, 'airline' ]
					 \,	 			'f'   : ['<Plug>(toggle-fullscreen)', 'fullscreen']
					 \,	 			'n'   : ['NERDTree'  					, 'nerdtree']
					 \,	 			't'   : ['<Plug>(toogle-top-most)'  , 'topmost']
					 \,				'v'   : ['VimFilerExplorer'			, 'vimfiler']
					 \, 				'+'	: ['<Plug>(vim-increase-alpha)', 'increase-alpha']
					 \, 				'-'	: ['<Plug>(vim-decrease-alpha)', 'decrease-alpha']
					 \ }

	 " Window:
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


function! config#modules#key#init()
	 nnoremap 	<C-h> 						<C-w>h
	 nnoremap 	<C-l> 						<C-w>l
	 inoremap 	<C-s> 						<Esc>:w<CR>
	 nnoremap 	<C-s> 						:w<CR>
	 nnoremap 	]b 							:bnext<CR>
	 nnoremap 	[b 							:bprev<CR>
	 nnoremap  	<M-b> 						:ToggleBufExplorer<CR>
	 nnoremap  	<M-c> 						:Unite -start-insert command<CR>
	 nnoremap  	<M-d> 						:Unite -start-insert neomru/directory directory_rec<CR>
	 nnoremap  	<M-e> 						:VimFilerBufferDir<CR>
	 nnoremap  	<M-f> 						:Unite -start-insert file_rec file/new<CR>
	 nnoremap  	<M-h> 						:Unite -start-insert help<CR>
	 nnoremap  	<M-j> 						:Unite -start-insert jump<CR>
	 nnoremap  	<M-l> 						:Unite -start-insert line<CR>
	 nnoremap  	<M-m> 						:Unite bookmark menu<CR>
	 nnoremap  	<M-n> 						:Unite -start-insert file/new<CR>
	 nnoremap  	<M-o> 						:Unite outline<CR>
	 nnoremap  	<M-q> 						:bd<CR>
	 tnoremap 	<M-q> 						<C-\><C-n>
	 nnoremap  	<M-r> 						:Unite -start-insert neomru/file<CR>
	 nnoremap  	<M-t> 						:NERDTreeToggle<CR>
	 nnoremap  	<M-u> 						:Unite -start-insert<CR>
	 nnoremap  	<M-w> 						:Unite window<CR>
	 nnoremap 	<M-=> 						:terminal<CR>
	 nnoremap  	<M-;> 						:Commentary<CR>
	 vnoremap  	<M-;> 						:Commentary<CR>
	 noremap 	<Plug>(init)  		:call config#init()<CR>
	 nmap 		<F5> 							<Plug>(init)
	 noremap 	<Plug>(edit-vimrc) 		<Esc>:edit $VIM/vimrc<CR>
	 nmap 		<F2> 							<Plug>(edit-vimrc)
	 noremap 	<Plug>(reload-keymap) 	<Esc>:call config#keybindings()<CR>
	 nmap 		<F3> 							<Plug>(reload-keymap)
	 noremap 	<Plug>(chdir) 				<Esc>:cd %:p:h<CR>
	 nmap 		<F4> 							<Plug>(chdir)
	 nmap 		<F11> 						<Plug>(toggle-fullscreen)
	 try
		  call s:which_key()
		  call gvimfullscreen#init()
	 catch
		  call config#message('error: {}', v:exception)
	 endtry
endfunction

"vim: fdm=indent
