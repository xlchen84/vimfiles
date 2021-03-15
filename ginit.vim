" vim: ts=2:sw=2
if has('nvim')
	call GuiWindowMaximized(1)
	GuiFont! Consolas:h16
else
	try
		colorscheme gruvbox
	catch
		colorscheme desert
	endtry
endif
