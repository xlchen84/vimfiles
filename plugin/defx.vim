" vim:ft=vim:ts=2:sw=2:noet
if exists('g:defx_loaded')
	finish
endif

if exists(':Plug')
	if has('nvim')
		Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
	else
		Plug 'Shougo/defx.nvim'
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
	endif
	let g:defx_loaded = 1
endif
