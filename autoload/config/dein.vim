" vim: ts=2:sw=2
" dein{{{
function! config#dein#init()
	set rtp+=~/vimfiles/bundle/dein.vim
	call dein#begin('~/vimfiles/bundle')
	call dein#add('Shougo/deoplete.nvim')
	call dein#add('wsdjeg/dein-ui.vim')
	call dein#end()
endfunction
"}}}

