
function! config#modules#gvimfullscreen#init() abort
	 try
		  call gvimfullscreen#init()
	 catch
		  call config#message('initialize gvimfullscreen failed because {}', v:exception)
	 endtry
endfunction

