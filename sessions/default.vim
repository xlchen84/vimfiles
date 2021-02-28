let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd D:\Projects\MATLAB\SDRV3\BIT
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
edit \Programs\Vim\vimfiles\bundle\unite-outline\autoload\unite\sources\outline.vim
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
balt \Programs\Vim\vimfiles\bundle\unite.vim\autoload\unite\init.vim
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 15) / 31)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
lcd D:\Programs\Vim\vimfiles\bundle\unite-outline\autoload\unite\sources\outline\modules
tabnext 1
badd +93 D:\Projects\MATLAB\SDRV3\BIT\runSimulationData.m
badd +2 D:\Projects\MATLAB\SDRV3\回波数据2021年2月27日\RealParamters.m
badd +12 D:\Programs\Vim\vimfiles\autoload\config\plug.vim
badd +53 D:\Programs\Vim\mine\autoload\config\complete.vim
badd +54 d:\Projects\MATLAB\SDRV3\BIT\Spectrum.m
badd +7 D:\Projects\MATLAB\SDRV3\BIT\[BufExplorer]
badd +32 D:\Projects\MATLAB\SDRV3\BIT\PulseCompression.m
badd +26 D:\Projects\MATLAB\SDRV3\BIT\runData.m
badd +1 D:\Projects\MATLAB\SDRV3\BIT\Correlation.m
badd +137 D:\Programs\Vim\vimfiles\autoload\config.vim
badd +12 D:\Programs\Vim\vimfiles\pythonx\config.py
badd +167 D:\Programs\Vim\vimfiles\pythonx\debug.log
badd +2 D:\Programs\Vim\vimfiles\bundle\unite-outline\autoload\unite\sources\outline.vim
badd +1 D:\Programs\Vim\vimfiles\bundle\unite.vim\autoload\unite\sources\line.vim
badd +4 D:\Programs\Vim\vimfiles\pythonx\vimfiler:default@11
badd +35 D:\Programs\Vim\vimfiles\bundle\unite.vim\autoload\unite\sources\source.vim
badd +136 D:\Programs\Vim\vimfiles\bundle\unite.vim\autoload\unite.vim
badd +54 D:\Programs\Vim\vimfiles\bundle\unite.vim\autoload\unite\variables.vim
badd +2 D:\Programs\Vim\vimfiles\bundle\unite.vim\autoload\unite\init.vim
badd +60 D:\Programs\Vim\vimfiles\bundle\unite-outline\autoload\unite\sources\outline\modules\file_cache.vim
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
