" vim:ft=vim:ts=2:sw=2:et

let s:SumatraPDF = 'd:/Programs/SumatraPDF/SumatraPDF.exe'

function! config#tex#init() abort
  let g:vimtex_compiler_latexmk = {
        \	'options' : [
          \ '-xelatex',
          \ '-verbose',
          \ '-file-line-error',
          \ '-synctex=1',
          \ '-interaction=nonstopmode',
          \ ] ,
          \}
  let g:vimtex_view_general_viewer = s:SumatraPDF
  " let g:vimtex_view_general_options
  "       \ = '-reuse-instance -forward-search @tex @line @pdf'
  let g:vimtex_view_general_options_latexmk = '-reuse-instance'

  let g:vimtex_view_general_options
        \ = '-reuse-instance -forward-search @tex @line @pdf'
        \ . ' -inverse-search "' . exepath(v:progpath)
        \ . ' --servername ' . v:servername
        \ . ' --remote-send \"^<C-\^>^<C-n^>'
        \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
        \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
        \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
endfunction
