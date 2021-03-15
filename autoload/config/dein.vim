" vim: ts=2:sw=2
" dein{{{
function! config#dein#init()
	set rtp+=~/vimfiles/bundle/dein.vim
	call dein#begin('~/vimfiles/bundle')
	call config#debug('g:dein#_base_path = {}', g:dein#_base_path)
	if exists('g:dein#cache_directory')
		call config#debug('g:dein#cache_directory = {}', g:dein#cache_directory)
	endif
	call dein#add('Shougo/deoplete.nvim')
	call dein#add('wsdjeg/dein-ui.vim')
	call dein#end()
endfunction
"}}}

