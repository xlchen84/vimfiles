if has('nvim')
	call GuiWindowMaximized(1)
	GuiFont! Inziu IosevkaCC SC:h12
else
	try
		colorscheme gruvbox
	catch
		colorscheme desert
	endtry
endif
