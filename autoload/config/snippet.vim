" :NeoSnippetMakeCache [filetype]
" :NeoSnippetEdit [{options}] [filetype]
" :NeoSnippetSource [filename]
" :NeoSnippetClearMarkers

function! config#snippet#init()
	 call config#snippet#ultisnips()
endfunction

function! config#snippet#neosnippet()
	 let g:neosnippet#snippets_directory = expand("$VIM/vimfiles/snippets")
	 let g:which_key_map.s = { 'name': '+snippets'
					 \ ,				'c'   : { 'name': '+commands'
					 \ ,							 'c'   : ['NeoSnippetClearMarkers', 'clear marks']
					 \ ,							 'e'   : ['NeoSnippetEdit'			, 'edit']
					 \ ,							 'm'   : ['NeoSnippetMakeCache'	, 'make cache']
					 \ ,							 's'   : ['NeoSnippetSource'		, 'source']}
					 \ ,				'e'   : ['<Plug>(neosnippet_expand)'		, 'expand']
					 \ ,				'j'   : ['<Plug>(neosnippet_jump)'			, 'jump']
					 \ ,				'E'   : ['<Plug>(neosnippet_expand_or_jump)'		, 'expand or jump']
					 \ ,				'J'   : ['<Plug>(neosnippet_jump_or_expand)'		, 'jump or expand']
					 \ ,				'r'   : ['<Plug>(neosnippet_register_oneshot_snippet)'		, 'jump or expand']
					 \ ,				't'   : ['<Plug>(neosnippet_expand_target)'		, 'jump or expand']
					 \ ,				'u'   : ['<Plug>(neosnippet_start_unite_snippet)'		, 'jump or expand']
					 \ }
	 imap <expr><C-l> neosnippet#expandable_or_jumpable() ?
					 \ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>"
	 inoremap <silent> ((
					 \ <C-r>=neosnippet#anonymous('\left(${1}\right)${0}')<CR>
	 " OR
	 inoremap <expr><silent> ((
					 \ neosnippet#anonymous('\left(${1}\right)${0}')
	 inoremap <silent> test
					 \ i<C-r>=neosnippet#expand('date_english')<CR>
	 nnoremap <silent><expr> test
					 \ neosnippet#expand('date_english')
	 " return config#message("snippet module loaded.")
endfunction


function! config#snippet#ultisnips()
	 if exists('did_plugin_ultisnips')
		  let g:UltiSnipsEditSplit = 'normal'
		  let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit = expand($VIM . '/vimfiles/UltiSnips')
		  let g:UltiSnipsSnippetDirectories = ['UltiSnips']
		  let g:UltiSnipsEnableSnipMate = 1

		  let g:UltiSnipsExpandTrigger = '<tab>'
		  let g:UltiSnipsListSnippets = '<c-tab>'
		  let g:UltiSnipsJumpForwardTrigger = '<c-j>'
		  let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
		  inoremap <c-x><c-k> <c-x><c-k>
		  call config#debug('ultisnips enabled');
		  return v:true
	 endif
	 return v:false
endfunction
