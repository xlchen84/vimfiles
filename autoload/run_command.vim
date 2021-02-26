" vim: ft=vim ts=2 sw=2 fdm=indent

if !exists("*term_start")
	call config#debug("run_command requires vim built with :terminal support")
	finish
endif

function! run_command#init() abort
	call run_command#define_commands() 
	call run_command#define_mappings()
	call run_command#matlab#init()
endfunction

function! run_command#define_commands() abort
	command! -bar -nargs=0 				RunCommandConfig 					call run_command#config()
	command! -range -bar -nargs=0 RunCommandSend 						call run_command#send_range(<line1>, <line2>)
	command! -nargs=+ 						RunCommandSend1 					call run_command#send(<q-args> . "\r")
	command! -nargs=+ 						RunCommandSend0 					call run_command#send(<args>)
	command! 											RunCommandSendCurrentLine call run_command#send(getline(".") . "\r")
endfunction


function! run_command#define_mappings() abort
	noremap <SID>Operator :<c-u>call run_command#store_curpos()<cr>:set opfunc=run_command#send_op<cr>g@
	noremap <script> <silent> <Plug>RunCommandRegionSend 			
				\ :<c-u>call run_command#send_op(visualmode(), 1)<cr>
	noremap <script> <silent> <Plug>RunCommandLineSend 				
				\ :<c-u>call run_command#send_lines(v:count1)<cr>j
	noremap <script> <silent> <Plug>RunCommandMotionSend 			<SID>Operator
	noremap <script> <silent> <Plug>RunCommandParagraphSend 		<SID>Operatorip
	noremap <script> <silent> <Plug>RunCommandConfig 					:<c-u>RunCommandConfig<cr>
	noremap <script> <silent> <Plug>RunCommandSendCell 				:<c-u>call run_command#send_cell()<cr>
  if !hasmapto('<Plug>RunCommandRegionSend', 'x')
    xmap <c-c><c-c> <Plug>RunCommandRegionSend
  endif

  if !hasmapto('<Plug>RunCommandParagraphSend', 'n')
    nmap <c-c><c-c> <Plug>RunCommandParagraphSend
  endif

  if !hasmapto('<Plug>RunCommandConfig', 'n')
    nmap <c-c>v <Plug>RunCommandConfig
  endif

  if !hasmapto('<Plug>RunCommandLineSend', 'n')
    nmap <F10> <Plug>RunCommandLineSend
  endif
endfunction

function! run_command#config() abort
	if !exists("b:run_command_config")
		let b:run_command_config = s:RunCommandGetConfig()
	endif
	return b:run_command_config
	" let b:run_command_config = s:VimterminalConfig(b:run_command_config)
endfunction

function! run_command#send(text)
  let b:run_command_config = s:VimterminalConfig(s:RunCommandGetConfig())
  " this used to return a string, but some receivers (coffee-script)
  " will flush the rest of the buffer given a special sequence (ctrl-v)
  " so we, possibly, send many strings -- but probably just one
  let pieces = s:_EscapeText(a:text)
  for piece in pieces
    if type(piece) == 0  " a number
      if piece > 0  " sleep accepts only positive count
        execute 'sleep' piece . 'm'
      endif
    else
      call s:VimterminalSend(b:run_command_config, piece)
    end
  endfor
endfunction

function! run_command#send_op(type, ...) abort
  let b:run_command_config = s:VimterminalConfig(s:RunCommandGetConfig())

  let sel_save = &selection
  let &selection = "inclusive"
  let rv = getreg('"')
  let rt = getregtype('"')

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    silent exe "normal! `<" . a:type . '`>y'
  elseif a:type == 'line'
    silent exe "normal! '[V']y"
  elseif a:type == 'block'
    silent exe "normal! `[\<C-V>`]\y"
  else
    silent exe "normal! `[v`]y"
  endif

  call setreg('"', @", 'V')
  call run_command#send(@")

  let &selection = sel_save
  call setreg('"', rv, rt)

  call s:RunCommandRestoreCurPos()
endfunction

function! run_command#send_range(startline, endline) abort
  let b:run_command_config = s:VimterminalConfig(s:RunCommandGetConfig())
  let rv = getreg('"')
  let rt = getregtype('"')
  silent exe a:startline . ',' . a:endline . 'yank'
  call run_command#send(@")
  call setreg('"', rv, rt)
endfunction

function! run_command#send_lines(count) abort
  let b:run_command_config = s:VimterminalConfig(s:RunCommandGetConfig())
  let rv = getreg('"')
  let rt = getregtype('"')
  silent exe 'normal! ' . a:count . 'yy'
  call run_command#send(@")
  call setreg('"', rv, rt)
endfunction

let s:run_command_filetype_configs = {
			\ 	'python': { 'command': 'ipython' ,  "chdir": v:true }
			\ }

function! run_command#register(filetype, config) abort
	if !empty(a:filetype)
		let s:run_command_filetype_configs[a:filetype] = a:config
	endif
	return s:run_command_filetype_configs
endfunction

function! s:RunCommandGetConfig()
  " b:run_command_config already configured...
  if exists("b:run_command_config")
    return b:run_command_config
  end
	" filetype 
	if has_key(s:run_command_filetype_configs, &ft)
		let b:run_command_config = s:run_command_filetype_configs[&ft]
    return b:run_command_config
	endif
  " assume defaults, if they exist
  if exists("g:run_command_default_config")
    let b:run_command_config = g:run_command_default_config
    return b:run_command_config
  end
	" custom by user
	let cmd = input("Enter a command to run [".&shell."]:")
	if len(cmd)==0
		let cmd = &shell
	endif
	let b:run_command_config = { "command": cmd , "chdir": v:true }
	return b:run_command_config
endfunction

function! s:VimterminalDescription(idx, info)
	let title = term_gettitle(a:info.bufnr)
	if len(title)==0
		let title = term_getstatus(a:info.bufnr)
	endif
	return printf("%2d.%4d %s [%s]", a:idx, a:info.bufnr, a:info.name, title)
endfunction

function! s:VimterminalSend(config, text)
  let bufnr = str2nr(get(a:config,"bufnr",""))
  if len(term_getstatus(bufnr))==0
    echoerr "Invalid terminal. Use :RunCommandConfig to select a terminal"
    return
  endif
  " Ideally we ought to be able to use a single term_sendkeys call however as
  " of vim 8.0.1203 doing so can cause terminal display issues for longer
  " selections of text.
  for l in split(a:text,'\n\zs')
    call term_sendkeys(bufnr,substitute(l,'\n',"\r",''))
    call term_wait(bufnr)
  endfor
endfunction

function! s:VimterminalConfig(config) abort
	if !has_key(a:config, "bufnr")
		let bufs = filter(term_list(), "term_getstatus(v:val)=~'running'")
		let terms = map(bufs,"getbufinfo(v:val)[0]")
		let choices = map(copy(terms),"s:VimterminalDescription(v:key+1,v:val)")
		call add(choices, printf("%2d. <New instance>", len(terms) + 1))
		let choice = len(choices)>1 ? inputlist(choices) : 1
		if choice > 0
			if choice>len(terms)
				let winid = win_getid()
				let cmd = a:config["command"]
				if has_key(a:config, "options")
					let options = a:config["options"]
				else
					let options = {}
				end
				if has_key(a:config, "chdir") && a:config["chdir"]
					let options["cwd"] = expand('%:p:h')
				endif
				let new_bufnr = term_start(cmd, options)
				call win_gotoid(winid)
				let a:config["bufnr"] = new_bufnr
			else
				let a:config["bufnr"] = terms[choice-1].bufnr
			endif
		endif
	endif
	return a:config
endfunction

if !exists("g:run_command_preserve_curpos")
  let g:run_command_preserve_curpos = 1
end

function! run_command#store_curpos()
  if g:run_command_preserve_curpos == 1
    let s:cur = winsaveview()
  endif
endfunction

function! s:RunCommandRestoreCurPos()
  if g:run_command_preserve_curpos == 1 && exists("s:cur")
    call winrestview(s:cur)
    unlet s:cur
  endif
endfunction

function! s:_EscapeText(text)
  if exists("&filetype")
    let custom_escape = "_EscapeText_" . substitute(&filetype, "[.]", "_", "g")
    if exists("*RunCommandOverride" . custom_escape)
      let result = call("RunCommandOverride" . custom_escape, [a:text])
    elseif exists("*" . custom_escape)
      let result = call(custom_escape, [a:text])
    end
  end
  " use a:text if the ftplugin didn't kick in
  if !exists("result")
    let result = a:text
  end
  " return an array, regardless
  if type(result) == type("")
    return [result]
  else
    return result
  end
endfunction

