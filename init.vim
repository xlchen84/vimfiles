" vim: ft=vim fdm=marker  ts=2 sw=2


" 外观 
set go=egrLv
set rnu
set nu
set cmdheight=3
set laststatus=2
set colorcolumn=120
set cursorline
set cursorcolumn
set ruler
set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
" set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)

" 设置 
set nocompatible
set nobackup
set nowritebackup
set noswapfile
set visualbell
set encoding=utf-8
set fencs=utf-8,ucs-bom,cp936
set helplang=cn
set ambiwidth=double
set backupdir=$VIM/vimfiles/temp,$TEMP
set autoread
syntax on
filetype plugin indent on
language messages zh_CN.UTF-8
colorscheme desert

if has('win32')
	language messages zh_CN.utf-8
	set termencoding=utf-8
	"set guifont=Inziu_IosevkaCC_SC:h18
elseif has('mac')
	set guifont=Monaco:h18
endif
if has('nvim')
	if executable('python.exe')
		let g:python3_host_prog = exepath('python.exe')
	else
		"fallback
		let g:python3_host_prog='D:/Programs/Python/3.9.1/python.exe'
	endif
else
	set guifont=更纱黑体_Mono_SC_Nerd:h16:cGB2312:qDRAFT
	"set guifont=Inziu_IosevkaCC_SC:h16
	set pyxversion=3
endif


" 按键(不依赖于任何插件)
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
inoremap jk 	<Esc>

nnoremap ]b 	:bnext<CR>
nnoremap [b 	:bprev<CR>
nnoremap <M-q> 	:bd<CR>

nnoremap <M-S-h> 	<C-W>h
nnoremap <M-S-l> 	<C-W>l
nnoremap <M-S-j> 	<C-W>j
nnoremap <M-S-k> 	<C-W>k
nnoremap <M-S-c> 	<C-W>c
nnoremap <M-S-v> 	<C-W>v
nnoremap <M-S-o> 	<C-W>o
