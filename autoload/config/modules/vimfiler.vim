let g:vimfiler_as_default_explorer = 1
call vimfiler#set_execute_file('txt', 'gvim --remote-tab-silent')
call vimfiler#set_execute_file('c', ['gvim --remote-tab-silent', 'notepad'])
call vimfiler#set_execute_file('m', 'gvim --remote-tab-silent')

" Enable file operation commands.
" Edit file by tabedit.
call vimfiler#custom#profile('default', 'context', {
	       \ 'safe' : 0,
	       \ 'edit_action' : 'tabopen',
	       \ })

" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'

" Use trashbox.
" Windows only and require latest vimproc.
let g:unite_kind_file_use_trashbox = 1

" statusline
let g:vimfiler_force_overwrite_statusline = 0
