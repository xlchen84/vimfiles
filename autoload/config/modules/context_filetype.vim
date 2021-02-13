
" context_filetype{{{
function! config#modules#context_filetype#init()
	 call config#message('initalizing context_filetype')
	 if !exists('g:context_filetype#filetypes')
		  let g:context_filetype#filetypes = {}
	 endif
	 let g:context_filetype#filetypes.perl6 =
					 \ [{'filetype' : 'pir', 'start' : 'Q:PIR\s*{', 'end' : '}'}]
	 let g:context_filetype#filetypes.vim =
					 \ [{'filetype' : 'python',
					 \   'start' : '^\s*execute py_exe "<<\s*\(\h\w*\)"', 'end' : '^\1'}]
endfunction
"}}}
