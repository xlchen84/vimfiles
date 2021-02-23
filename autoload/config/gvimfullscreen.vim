
function! config#gvimfullscreen#init() abort
	 try
		  call gvimfullscreen#init()
	 catch
		  call config#debug('initialize gvimfullscreen failed because {}', v:exception)
	 endtry
endfunction

