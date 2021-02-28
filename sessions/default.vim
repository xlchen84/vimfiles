let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd D:\Programs\Vim\vimfiles\pythonx
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
edit \Projects\MATLAB\SDRV3\BIT\runSimulationData.m
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
balt \Programs\Rime\User\user.yaml
setlocal fdm=expr
setlocal fde=MatlabFoldExpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=20
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 19 - ((9 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 19
normal! 04|
lcd D:\Programs\Rime\User
tabnext 1
badd +2 D:\Programs\Rime\User\weasel.custom.yaml
badd +5 D:\Programs\Vim\vimfiles\pythonx\ml_terminal.py
badd +47 D:\Programs\Vim\mine\autoload\config\complete.vim
badd +1 D:\Programs\Vim\mine\bundle\coc.nvim\autoload\[BufExplorer]
badd +396 D:\Programs\Vim\mine\init.vim
badd +4 D:\Projects\MATLAB\SDRV3\BIT\[BufExplorer]
badd +14 D:\Projects\MATLAB\SDRV3\BIT\runSimulationData.m
badd +1 D:\Programs\Vim\mine\autoload\run_command\matlab.vim
badd +42 D:\Programs\Vim\mine\autoload\run_command.vim
badd +36 D:\Programs\Rime\User\clover.schema.yaml
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOSA
set winminheight=1 winminwidth=1
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
