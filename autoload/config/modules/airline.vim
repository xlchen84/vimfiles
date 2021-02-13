
" airline {{{
function! config#modules#airline#init()
	 " call config#message('initalizing airline')
	 let g:airline_extensions = ['branch', 'tabline', 'ale'] ", 'bufferline'
	 let g:airline_theme="dark" 
	 " let g:airline_theme="solarized" 
	 let g:airline_powerline_fonts = 1  
	 let g:airline#extensions#ale#enabled = 1
	 let g:airline#extensions#tabline#enabled = 1
	 let g:airline#extensions#tabline#buffer_nr_show = 1
	 call config#modules#airline#bufferline()
endfunction
"}}}

" bufferline{{{
function! config#modules#airline#bufferline()
	 let g:airline#extensions#bufferline#enabled = 1
	 let g:bufferline_echo = 0
	 let g:bufferline_active_highlight = 'StatusLine'
	 let g:bufferline_inactive_highlight = 'StatusLineNC'
	 let g:bufferline_show_bufnr = 1
	 autocmd VimEnter * let &statusline='%{bufferline#refresh_status()}'.bufferline#get_status_string()
endfunction
"}}}

