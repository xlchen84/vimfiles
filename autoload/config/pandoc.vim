
let s:winword = 'C:\Program Files\Microsoft Office\Office16\WINWORD.EXE'
let s:winppt = 'C:\Program Files\Microsoft Office\Office16\POWERPNT.EXE'

function! s:error(message, ...) abort
	let msg = ''
	pyx print(vim.eval('a:message').format(*vim.eval('a:000')))
endfunction

function! config#pandoc#on_pandoc() abort
	nmap <buffer> <silent> <F5>  <Esc>:Pandoc! #default<CR>
endfunction

function! config#pandoc#init() abort
	autocmd FileType pandoc call config#pandoc#on_pandoc()
	if !executable(s:winword)
		call s:error('cannot find word at {}. ', s:winword)
	endif
	let g:pandoc#filetypes#pandoc_markdown=1
	let g:pandoc#filetypes#handled = ['pandoc'
				\ , 'rst'
				\ , 'textile'
				\ , 'markdown'
				\ , 'org'
				\ ]
	let g:pandoc#modules#enabled = ['yaml'
				\ , 'bibliographies'
				\ , 'completion'
				\ , 'command'
				\ , 'folding'
				\ , 'formatting'
				\ , 'indent'
				\ , 'menu'
				\ , 'metadata'
				\ , 'keyboard'
				\ , 'toc'
				\ , 'spell'
				\ , 'hypertext'
				\]
	let g:pandoc#formatting#mode = 's' 
	let g:pandoc#formatting#textwidth = 79
	let g:pandoc#folding#level = 0
	" relative
	let g:pandoc#folding#mode = "syntax" 
	let g:pandoc#keyboard#sections#header_style = 'a' 
	let g:pandoc#command#autoexec_command = "Pandoc! docx"

	let g:pandoc#command#custom_open = "MyPandocOpen"
	return v:true
endfunction

function! MyPandocOpen(file) abort
	let file = shellescape(fnamemodify(a:file, ':p'))
	let file_extension = fnamemodify(a:file, ':e')
	let cmd = 'start ' . file
	if file_extension is? 'pdf'
		if !empty($PDFVIEWER)
			let cmd = expand('$PDFVIEWER') . ' ' . file
		elseif executable('SumatraPDF')
			let cmd = 'SumatraPDF ' . file
		elseif executable('zathura')
			let cmd = 'zathura ' . file
		elseif executable('mupdf')
			let cmd = 'mupdf ' . file
		endif
	elseif file_extension is? 'html'
		if !empty($BROWSER)
			let cmd = expand('$BROWSER') . ' ' . file
		elseif executable('msedge')
			let cmd = 'msedge ' . file
		elseif executable('firefox')
			let cmd = 'firefox ' . file
		elseif executable('chromium')
			let cmd = 'chromium ' . file
		endif
	elseif file_extension is? 'doc'
		let cmd = shellescape(s:winword) . ' ' . file
	elseif file_extension is? 'docx'
		let cmd = shellescape(s:winword) . ' ' . file
	elseif file_extension is? 'ppt' || file_extension is? 'pptx' 
		let cmd = shellescape(s:winppt) . ' ' . file
	elseif file_extension is? 'odt' && executable('okular')
		let cmd = 'okular ' . file
	elseif file_extension is? 'epub' && executable('okular')
		let cmd = 'okular ' . file
	else
		let cmd = 'gvim --remote-tab-silent ' . file
	endif
	call config#debug('open pandoc output file {} with command {}', a:file, cmd)
	return cmd
endfunction

