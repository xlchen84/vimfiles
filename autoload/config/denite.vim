" Denite{{{
function! config#modules#denite#init()
	 " let g:python3_host_prog = 'D:/Programs/Python/3.6.8.amd64/python.exe'
	 let g:python3_host_prog = expand($VIM . '/vim81/python.exe')
	 try
		  pyx import nyvim
	 catch
	 endtry
endfunction
"}}}

