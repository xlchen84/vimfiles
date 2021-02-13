
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
let g:pymode_doc_bind = 'K'
let g:pymode_virtualenv = 1
let g:pymode_virtualenv_path = $VIRTUAL_ENV
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>r'
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
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

function! config#modules#python#init()
	 augroup filetype_python 
		  autocmd!
		  " autocmd BufNew,BufRead *.py 
						  " \ setlocal tabstop=4
						  " \ setlocal softtabstop=4
						  " \ setlocal shiftwidth=4
						  " \ setlocal textwidth=79
						  " \ setlocal colorcolumn=79
						  " \ setlocal expandtab
						  " \ setlocal autoindent
						  " \ setlocal fileformat=unix
						  " \ setlocal fenc=utf-8
		  " autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h
						  " \ match BadWhitespace /\s\+$/
	 augroup END
	 " command! -nargs=1 PymodePython python3 <args>
	 call config#modules#python#virthenv()
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
