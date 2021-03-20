" vim: ts=2:sw=2

try
	" set gfn=Sarasa_Mono_Nerd:h16
	set gfn=等距更纱黑体_SC:h14:cGB2312:qDRAFT
	colorscheme desert
	colorscheme gruvbox
catch
endtry

if has('nvim')
	call GuiWindowMaximized(1)
	GuiFont! Consolas:h16
endif
