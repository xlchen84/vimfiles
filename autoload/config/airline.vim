" vim: ft=vim fdm=marker

"load airline extension {{{
let s:ext = {}
let s:ext._theme_funcrefs = []

function! s:ext.add_statusline_func(name) dict
  call airline#add_statusline_func(a:name)
endfunction

function! s:ext.add_statusline_funcref(function) dict
  call airline#add_statusline_funcref(a:function)
endfunction

function! s:ext.add_inactive_statusline_func(name) dict
  call airline#add_inactive_statusline_func(a:name)
endfunction

function! s:ext.add_theme_func(name) dict
  call add(self._theme_funcrefs, function(a:name))
endfunction

function! s:load_airline_extension(ext) abort
	 return airline#extensions#{a:ext}#init(s:ext)
endfunction
"}}}

" init airline {{{
function! config#airline#init()
	 " call config#message('initalizing airline')
	 call s:init_variables()
	 call config#airline#extensions()
	 autocmd User AirlineAfterTheme call s:update_highlights()
endfunction
"}}}

"airline variables{{{
function! s:init_variables()
	 let g:airline_left_sep='>'
	 let g:airline_right_sep='<'
	 let g:airline_detect_modified=1
	 let g:airline_detect_paste=1
	 let g:airline_detect_crypt=1
	 let g:airline_detect_spell=1
	 let g:airline_detect_spelllang=1
	 let g:airline_detect_iminsert=1
	 let g:airline_inactive_collapse=1
	 let g:airline_inactive_alt_sep=1
	 let g:airline_theme='dark'
	 let g:airline_powerline_fonts = 1
	 let g:airline_symbols_ascii = 1
	 let g:airline_mode_map = {
					 \ '__'     : '-',
					 \ 'c'      : 'C',
					 \ 'i'      : 'I',
					 \ 'ic'     : 'I',
					 \ 'ix'     : 'I',
					 \ 'n'      : 'N',
					 \ 'multi'  : 'M',
					 \ 'ni'     : 'N',
					 \ 'no'     : 'N',
					 \ 'R'      : 'R',
					 \ 'Rv'     : 'R',
					 \ 's'      : 'S',
					 \ 'S'      : 'S',
					 \ ''     : 'S',
					 \ 't'      : 'T',
					 \ 'v'      : 'V',
					 \ 'V'      : 'V',
					 \ ''     : 'V',
					 \ } 
	 let g:airline_filetype_overrides = {
					 \ 'coc-explorer':  [ 'CoC Explorer', '' ],
					 \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
					 \ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
					 \ 'gundo': [ 'Gundo', '' ],
					 \ 'help':  [ 'Help', '%f' ],
					 \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
					 \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
					 \ 'startify': [ 'startify', '' ],
					 \ 'vim-plug': [ 'Plugins', '' ],
					 \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
					 \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
					 \ 'vaffle' : [ 'Vaffle', '%{b:vaffle.dir}' ],
					 \ }
	 let g:airline_exclude_preview = 0
	 let g:airline_highlighting_cache = 0
	 let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
	 let g:airline_statusline_ontop = 0
	 let g:airline_stl_path_style = 'short'
	 " let g:airline_theme="solarized" 
	 let g:airline_powerline_fonts = 1  
	 if !exists('g:airline_symbols')
		  let g:airline_symbols = {}
	 endif
endfunction
"}}}

function! s:update_highlights()
	 hi CursorLine ctermbg=none guibg=none
	 hi VertSplit ctermbg=none guibg=none
endfunction

" unicode symbols{{{
function! config#airline#unicode_symbols()
  let g:airline_left_sep = '»'
  let g:airline_right_sep = '«'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = 'Ɇ'
  let g:airline_symbols.whitespace = 'Ξ'
endfunction
"}}}

" unicode_symbols_alternative{{{
function! config#airline#unicode_symbols_alternative()
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.maxlinenr = '㏑'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
endfunction
"}}}

" powerline symbols{{{
function! config#airline#powerline_symbols()
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.dirty='⚡'
endfunction
"}}}

" old vim-powerline symbols{{{
function! config#airline#old_powerline_symbols()
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'
  let g:airline_symbols.branch = '⭠'
  let g:airline_symbols.readonly = '⭤'
  let g:airline_symbols.linenr = '⭡'
endfunction
"}}}

function! config#airline#extensions()
	 let g:airline_extensions = ['branch', 'tabline'] 
	 call airline#extensions#load()
	 call config#airline#ale()
	 call config#airline#bufferline()
	 call config#airline#default()
	 call config#airline#tabline()
	 call config#airline#timer()
	 for ext in g:airline_extensions
		  call s:load_airline_extension(ext)
	 endfor
endfunction

" ale{{{
function! config#airline#ale()
	 let g:airline#extensions#ale#enabled = 1
	 let g:airline#extensions#ale#error_symbol = 'E:'
	 let g:airline#extensions#ale#warning_symbol = 'W:'
	 let g:airline#extensions#ale#show_line_numbers = 1
	 let g:airline#extensions#ale#open_lnum_symbol = '(L'
	 let g:airline#extensions#ale#close_lnum_symbol = ')'
endfunction
"}}}

" bufferline{{{
function! config#airline#bufferline()
	 let g:airline#extensions#bufferline#enabled = 1
	 let g:bufferline_echo = 1
	 let g:bufferline_active_highlight = 'StatusLine'
	 let g:bufferline_inactive_highlight = 'StatusLineNC'
	 let g:bufferline_show_bufnr = 1
	 autocmd VimEnter * let &statusline='%{bufferline#refresh_status()}'.bufferline#get_status_string()
endfunction
"}}}

" tabline{{{
function! config#airline#tabline()
	 let g:airline#extensions#tabline#enabled = 1
	 let g:airline#extensions#tabline#show_tabs = 1
	 let g:airline#extensions#tabline#show_buffers = 1
	 let g:airline#extensions#tabline#buffer_nr_show = 1
endfunction
"}}}

" default{{{
function! config#airline#default() abort
  " Note: set to an empty dictionary to disable truncation.
  " let g:airline#extensions#default#section_truncate_width = {}
  let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 79,
      \ 'x': 60,
      \ 'y': 88,
      \ 'z': 45,
      \ 'warning': 80,
      \ 'error': 80,
      \ }
  let g:airline#extensions#default#layout = [
				  \ [ 'a', 'b', 'c' ],
				  \ [ 'x', 'y', 'z', 'error', 'warning' ]
				  \ ]
endfunction
"}}}

" timer{{{
function! config#airline#update_status_bar(timer)
	execute 'let &ro = &ro'
endfunction

function! config#airline#timer() abort
	 let timer = timer_start(4000, function('config#airline#update_status_bar'), {'repeat':-1})
	 return timer
endfunction
"}}}
