function! config#vimfiler#init() abort
	 call vimfiler#set_execute_file('txt', 'gvim --remote-tab-silent')
	 call vimfiler#set_execute_file('c', ['gvim --remote-tab-silent', 'notepad'])
	 call vimfiler#set_execute_file('m', 'gvim --remote-tab-silent')
	 call vimfiler#set_execute_file('doc,docx', 'C:\Program Files\Microsoft Office\Office16\WINWORD.EXE')

	 " Enable file operation commands.
	 " Edit file by tabedit.
	 call vimfiler#custom#profile('default', 'context', {
					 \ 'safe' : 0,
					 \ 'edit_action' : 'tabopen',
					 \ })
	 let g:unite_kind_file_delete_file_command = 'del'
	 let g:unite_kind_file_delete_directory_command = 'deltree'
	 let g:vimfiler_enable_auto_cd = 1
	 let g:vimfiler_as_default_explorer = 1
	 " let g:vimfiler_quick_look_command = 'qlmanage -p'
	 " let g:vimfiler_no_default_key_mappings = 1
	 let g:vimfiler_safe_mode_by_default = 0
	 let g:loaded_netrwPlugin = 1
	 let g:loaded_netrw       = 1

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
	 let g:vimfiler_force_overwrite_statusline = 1

	 " let g:vimfiler_execute_file_list = {
					 " \ 'txt': 'gvim --remote-tab-silent',
					 " \ 'c': ['gvim --remote-tab-silent', 'notepad'], 
					 " \ 'm': 'gvim --remote-tab-silent',
					 " \}

	 " g:vimfiler_execute_file_list			*g:vimfiler_execute_file_list*
		" This variable controls vimfiler execute.
		" The key is extension. The value is command name or
		" command name list.
		" If the key is "_", it will be default command name.

		" g:vimfiler_extensions				*g:vimfiler_extensions*
endfunction
