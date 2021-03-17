" vim: ts=2:sw=2
if has('nvim')
	call GuiWindowMaximized(1)
	GuiFont! Consolas:h16
else
	try
		colorscheme desert
		colorscheme gruvbox
	catch
	endtry
endif
