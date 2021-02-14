
" - 'g:terminal_key': which key will be used to toggle terminal window, default
"   to '<m-=>'.
" - 'g:terminal_cwd': initialize working dir: '0' for unchanged, '1' for file
"   path and '2' for project root.
" - 'g:terminal_height': new terminal height, default to 10.
" - 'g:terminal_pos': where to open the terminal, default to 'rightbelow'.
" - 'g:terminal_shell': specify shell rather than default one.
" - 'g:terminal_edit': command to open the file in vim, default to 'tab drop'.
" - 'g:terminal_kill': set to 'term' to kill term session when exiting vim.
" - 'g:terminal_list': set to 0 to hide terminal buffer in the buffer list.
" - 'g:terminal_fixheight': set to 1 to set 'winfixheight' for the terminal
"   window.
" - 'g:terminal_close': set to 1 to close window if process finished.

function! config#modules#terminal#init()
	 let g:terminal_key = '<m-=>'
	 let g:terminal_cwd = 1
	 let g:terminal_height = 10
	 let g:terminal_pos = 'rightbelow'
	 let g:terminal_shell = 'powershell'
	 let g:terminal_edit = 'tab drop'
	 let g:terminal_kill = 'term'
	 let g:terminal_list = 1
	 let g:terminal_fixheight = 1
	 let g:terminal_close = 1
	 let g:slime_target = "vimterminal"
	 let g:slime_vimterminal_cmd = "powershell.exe"
	 let g:slime_vimterminal_config = {"term_finish": "close"}
endfunction

