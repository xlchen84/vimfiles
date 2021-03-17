if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal ts=2 sw=2
augroup END
