
let s:matlab_engine_python_executable = 'd:/Programs/Python/3.6.8.amd64/python.exe'
let s:project_root = fnamemodify(expand('<sfile>'), ':p:h:h:h')


function! run_command#matlab#init() abort
	 let python_executable = get(g:, 'matlab_engine_python_executable', s:matlab_engine_python_executable)
	 if filereadable(python_executable)
		  let script_path = s:project_root . '/pythonx/ml_terminal.py'
		  if filereadable(script_path)
				let matlab_command = {
								\ 			'command': join([python_executable, script_path]), 
								\ 			'chdir': v:true
								\ }
				call run_command#register('matlab', matlab_command)
				return matlab_command
		  else
				echoerr "Python script " . script_path . "not found. "
		  endif
	 else
		  echoerr "Python not found. Please check g:matlab_engine_python_executable exists."
	 endif
endfunction
