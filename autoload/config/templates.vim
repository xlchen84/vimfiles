function! config#templates#init() abort
	 let g:tmpl_auto_initialize = 1
	 let g:tmpl_search_paths = [expand(g:vimfiles . '/templates'), '~/templates']
	 let g:tmpl_author_email = 'chenxinliang@bit.edu.cn'
endfunction	
