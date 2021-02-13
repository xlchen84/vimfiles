function! config#modules#python#init()
	 autocmd! filetype_python BufNew,BufRead *.py 
					 \ setlocal tabstop=4
					 \ setlocal softtabstop=4
					 \ setlocal shiftwidth=4
					 \ setlocal textwidth=79
					 \ setlocal colorcolumn=79
					 \ setlocal expandtab
					 \ setlocal autoindent
					 \ setlocal fileformat=unix
					 \ setlocal fenc=utf-8
	 autocmd! filetype_python BufRead,BufNewFile *.py,*.pyw,*.c,*.h
					 \ match BadWhitespace /\s\+$/
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
