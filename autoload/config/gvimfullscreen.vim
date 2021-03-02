
function! config#gvimfullscreen#init() abort
	 try
		  let loaded = gvimfullscreen#init()
		  let msg = config#message('gvimfullscreen loaded: {} ', loaded)
		  echom msg
	 catch
		  call config#debug('initialize gvimfullscreen failed because {}', v:exception)
	 endtry
endfunction

