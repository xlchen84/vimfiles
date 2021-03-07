" vim:ft=vim:ts=2:sw=2:et


function! config#tex#init() abort
  let g:tex_flavor = 'latex'
  set conceallevel=1
  let g:tex_conceal='abdmg'
  " let g:vimtex_compiler_latexmk_engines = { }
  let g:vimtex_compiler_latexmk = {
        \ 'build_dir': 'pdf',
        \ 'callback': 1,
        \ 'continous': 1,
        \ 'executable': 'latexmk',
        \ 'hooks' : [],
        \	'options' : [
        \   '-xelatex',
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \   '-aux-directory=pdf',
        \   '-outdir=pdf',
        \ ] ,
        \}

  let s:SumatraPDF = 'd:/Programs/SumatraPDF/SumatraPDF.exe'
  if !executable('SumatraPDF.exe')
    let $PATH = fnamemodify(s:SumatraPDF, ':p:h') . ';' . $PATH
  endif 
  if executable('SumatraPDF.exe')
    let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
  else
    let g:vimtex_view_general_viewer = 'd:\Programs\SumatraPDF\SumatraPDF.exe'
  endif
  let g:vimtex_view_general_options_latexmk = '-reuse-instance'
  let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
        \ . ' -inverse-search "' . exepath(v:progpath)
        \ . ' --servername ' . v:servername
        \ . ' --remote-send \"^<C-\^>^<C-n^>'
        \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
        \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
        \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
   " let g:vimtex_quickfix_open_on_warning=0
endfunction
