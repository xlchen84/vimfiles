" vim: ft=vim fdm=marker 
let g:vimrc_loaded = 0

if (g:vimrc_loaded == 0)

	 " 外观 {{{
	 set go=egrLv
	 set guifont=Inziu_IosevkaCC_SC:h14
	 set rnu
	 set cmdheight=1
	 set laststatus=2
	 set cursorline
	 colorscheme desert
	 "}}}

	 " 设置 {{{
	 set encoding=utf-8
	 set termencoding=cp936
	 set fencs=utf-8,ucs-bom,cp936
	 set helplang=cn
	 set noswapfile
	 set ambiwidth=double
	 set visualbell
	 syntax on
	 language messages zh_CN.utf-8
	 "}}}

	 " 规则{{{
	 augroup vim_init
		  autocmd!
		  autocmd VimEnter * call config#init()
	 augroup END

	 filetype plugin on
	 augroup filetype_vim
		  autocmd!
		  autocmd FileType vim  setl ts=3 sw=4
		  autocmd FileType vim  autocmd BufWritePost <buffer=abuf> :source %
	 augroup END

	 augroup filetype_matlab
		  autocmd!
		  autocmd FileType matlab  setlocal ts=4 sw=4 
		  autocmd FileType matlab  setlocal fenc=cp936
		  autocmd FileType matlab  setlocal cms=%%s
	 augroup END
	 "}}}


	 let g:vimrc_loaded = 1
endif
