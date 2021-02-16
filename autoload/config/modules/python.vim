" vim: fdm=indent
let g:python3_host_prog = 'd:/Programs/Python/3.9.1/python.exe'

function! s:ipython()
	 " fix paste issues in ipython
	 let g:slime_python_ipython = 1

	 " always send text to the top-right pane in the current tmux tab without asking
	 let g:slime_dont_ask_default = 1

	 " ipython-cell configuration
	 " Keyboard mappings. <Leader> is \ (backslash) by default

	 " map <Leader>s to start IPython
	 nnoremap <LocalLeader>s :SlimeSend1 ipython --matplotlib<CR>

	 " map <Leader>r to run script
	 nnoremap <LocalLeader>r :IPythonCellRun<CR>

	 " map <Leader>R to run script and time the execution
	 nnoremap <LocalLeader>R :IPythonCellRunTime<CR>

	 " map <Leader>c to execute the current cell
	 nnoremap <LocalLeader>c :IPythonCellExecuteCell<CR>

	 " map <Leader>C to execute the current cell and jump to the next cell
	 nnoremap <LocalLeader>C :IPythonCellExecuteCellJump<CR>

	 " map <Leader>l to clear IPython screen
	 nnoremap <LocalLeader>l :IPythonCellClear<CR>

	 " map <Leader>x to close all Matplotlib figure windows
	 nnoremap <LocalLeader>x :IPythonCellClose<CR>

	 " map [c and ]c to jump to the previous and next cell header
	 nnoremap [c :IPythonCellPrevCell<CR>
	 nnoremap ]c :IPythonCellNextCell<CR>

	 " map <Leader>h to send the current line or current selection to IPython
	 nmap <LocalLeader>h <Plug>SlimeLineSend
	 xmap <LocalLeader>h <Plug>SlimeRegionSend

	 " map <Leader>p to run the previous command
	 nnoremap <LocalLeader>p :IPythonCellPrevCommand<CR>

	 " map <Leader>Q to restart ipython
	 nnoremap <LocalLeader>Q :IPythonCellRestart<CR>

	 " map <Leader>d to start debug mode
	 nnoremap <LocalLeader>d :SlimeSend1 %debug<CR>

	 " map <Leader>q to exit debug mode or IPython
	 nnoremap <LocalLeader>q :SlimeSend1 exit<CR>

	 nnoremap <F5> :w<CR>:IPythonCellRun<CR>
	 inoremap <F5> <C-o>:w<CR><C-o>:IPythonCellRun<CR>
	 nnoremap <F6> :IPythonCellExecuteCell<CR>
	 inoremap <F6> <C-o>:IPythonCellExecuteCell<CR>
	 nnoremap <F7> :IPythonCellExecuteCellJump<CR>
	 inoremap <F7> <C-o>:IPythonCellExecuteCellJump<CR>

	 if hasmapto('<Plug>SlimeRegionSend')
		  xmap <C-c><C-c> <Plug>SlimeRegionSend
	 endif
	 if hasmapto('<Plug>SlimeParagraphSend')
		  nmap <c-c><c-c> <Plug>SlimeParagraphSend
	 endif
	 if hasmapto('<Plug>SlimeConfig')
		  nmap <c-c>c     <Plug>SlimeConfig
	 endif
endfunction

function! config#modules#python#init()
	 let g:pymode = 1
	 let g:pymode_warnings = 1
	 let g:pymode_paths = []
	 let g:pymode_trim_whitespaces = 1
	 let g:pymode_options = 1
	 " setlocal complete+=t
	 " setlocal formatoptions-=t
	 " if v:version > 702 && !&relativenumber
	 "     setlocal number
	 " endif
	 " setlocal nowrap
	 " setlocal textwidth=79
	 " setlocal commentstring=#%s
	 " setlocal define=^\s*\\(def\\\\|class\\)
	 let g:pymode_options_max_line_length = 79
	 let g:pymode_options_colorcolumn = 1
	 let g:pymode_quickfix_minheight = 3
	 let g:pymode_quickfix_maxheight = 6
	 let g:pymode_preview_height = &previewheight
	 let g:pymode_preview_position = 'botright'
	 let g:pymode_python = 'python3'
	 let g:pymode_indent = 1
	 let g:pymode_folding = 0
	 let g:pymode_motion = 1
	 let g:pymode_doc = 1
	 let g:pymode_doc_bind = '<F1>'
	 let g:pymode_virtualenv = 1
	 let g:pymode_virtualenv_path = $VIRTUAL_ENV
	 let g:pymode_run = 1
	 let g:pymode_run_bind = '<F5>'
	 let g:pymode_breakpoint = 1
	 let g:pymode_breakpoint_bind = '<F12>'
	 let g:pymode_breakpoint_cmd = ''
	 let g:pymode_lint = 1
	 let g:pymode_lint_on_write = 1
	 let g:pymode_lint_unmodified = 0
	 let g:pymode_lint_on_fly = 0
	 let g:pymode_lint_message = 1
	 let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
	 let g:pymode_lint_ignore = ["E501", "W",]
	 let g:pymode_lint_select = ["E501", "W0011", "W430"]
	 let g:pymode_lint_sort = []
	 let g:pymode_lint_cwindow = 1
	 let g:pymode_lint_signs = 1
	 let g:pymode_lint_todo_symbol = 'WW'
	 let g:pymode_lint_comment_symbol = 'CC'
	 let g:pymode_lint_visual_symbol = 'RR'
	 let g:pymode_lint_error_symbol = 'EE'
	 let g:pymode_lint_info_symbol = 'II'
	 let g:pymode_lint_pyflakes_symbol = 'FF'
	 let g:pymode_lint_options_pep8 =
					 \ {'max_line_length': g:pymode_options_max_line_length}
	 let g:pymode_lint_options_pyflakes = { 'builtins': '_' }
	 let g:pymode_lint_options_mccabe = { 'complexity': 12 }
	 let g:pymode_lint_options_pep257 = {}
	 let g:pymode_lint_options_pylint =
					 \ {'max-line-length': g:pymode_options_max_line_length}
	 let g:pymode_rope = 0
	 let g:pymode_rope_lookup_project = 0
	 let g:pymode_rope_project_root = ""
	 let g:pymode_rope_ropefolder='.ropeproject'
	 let g:pymode_rope_show_doc_bind = '<C-c>d'
	 let g:pymode_rope_regenerate_on_write = 1
	 let g:pymode_rope_completion = 1
	 let g:pymode_rope_complete_on_dot = 1
	 let g:pymode_rope_goto_definition_bind = '<C-c>g'

	 augroup filetype_python 
		  autocmd!
		  autocmd BufNew,BufRead *.py setlocal
						  \ tabstop=4
						  \ softtabstop=4
						  \ shiftwidth=4
						  \ textwidth=79
						  \ colorcolumn=79
						  \ expandtab
						  \ autoindent
		  " autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
	 augroup END
	 " command! -nargs=1 PymodePython python3 <args>
	 call config#modules#python#virthenv()

	 call run_command#init()
	 " call s:ipython()
endfunction

function! config#modules#python#virthenv()
	 pyx << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
	 project_base_dir = os.environ['VIRTUAL_ENV']
	 activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	 execfile(activate_this, dict(__file__=activate_this))
EOF
endfunction

