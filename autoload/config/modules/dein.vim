
" dein{{{
function! config#modules#dein#init()
	 if dein#load_state($VIM)
		  call dein#begin($VIM)
		  call dein#add('Shougo/deoplete.nvim')
		  call dein#add('wsdjeg/dein-ui.vim')
		  " My plugins here:
		  " ...
		  call dein#end()
		  call dein#save_state()
	 endif
endfunction
"}}}

