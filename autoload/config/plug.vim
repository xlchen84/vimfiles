" vim: ft=vim ts=2 sw=2 et

function! config#plug#init() abort
  let g:plug_root = glob(g:vimfiles . '/bundle/vim-plug')
  if !empty(g:plug_root)
    call config#debug('vim-plug is at {}', g:plug_root)
    exe 'set rtp+=' . g:plug_root
    let plugins = config#list_plugins() 
    let bundle = get(g:, 'bundle', fnamemodify(g:plug_root, ':h'))
    call config#debug('bundle for plug is {}', bundle)
    call plug#begin(bundle)
    for p in plugins
      call plug#(p.short)
      call config#debug('add plug {} =  {}', p.name, p.short)
    endfor
    call plug#end()
  endif
endfunction

