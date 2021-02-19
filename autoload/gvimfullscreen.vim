" vim: ft=vim ts=2 sw=2 et
function! gvimfullscreen#init() abort
  if exists('g:did_gvimfullscreen') && g:did_gvimfullscreen
    if exists("g:gvimfillscreen_dll")
      command! -nargs=0 ToggleFullscreen :call libcallnr(g:gvimfullscreen_dll, "ToggleFullScreen", 0)
      map <M-CR> :ToggleFullscreen<CR>
    endif
  endif
endfunction
