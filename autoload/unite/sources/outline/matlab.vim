"=============================================================================
" File    : autoload/unite/sources/outline/matlab.vim
" Author  : archerC <brightcxl@gmail.com>
" Updated : 2021-02-09
"
" Licensed under the MIT license:
" http://www.opensource.org/licenses/mit-license.php
"
"=============================================================================

" Default outline info for Markdown
" Version: 0.0.5

function! unite#sources#outline#matlab#outline_info() abort
	" call config#message('matlab outline: outline_info {}', s:outline_info)
  return s:outline_info
endfunction

"-----------------------------------------------------------------------------
" Outline Info

let s:outline_info = {
      \ 'heading'  : '^function\s\+\S\+\|^%%\s\S\+',
      \ 'highlight_rules': [
      \   { 'name'     : 'comment',
      \     'pattern'  : '/%.*/' },
      \   { 'name'     : 'function',
      \     'pattern'  : '/\S\+\ze\s*(/' },
      \   { 'name'     : 'parameter_list',
      \     'pattern'  : '/(.*)/' },
      \ ],
      \ }
      " \   { 'name'     : 'augroup',
      " \     'pattern'  : '/\S\+\ze : augroup/',
      " \     'highlight': unite#sources#outline#get_highlight('type') },

function! s:outline_info.create_heading(which, heading_line, matched_line, context) abort
	call config#debug('call outline_info.create_heading')
	try
		let heading = {
					\ 'word' : a:heading_line,
					\ 'level': 0,
					\ 'type' : 'generic',
					\ }
		if a:which ==# 'heading'
			call config#debug('which is "heading"')
			if match(a:heading_line, '^function\s\+\S\+') >= 0
				let function_expression = '^function\s\+\(\(\[\s*\i\+\(,\s*\i\+\s*\)*\]\|\s*\i\+\s*\)=\)\=\s*\i\+(.*)'
				let heading.word = matchstr(a:heading_line, function_expression)
				call config#debug('matching {} with expression {} gives {}', a:heading_line, function_expression, heading.word)
				let heading.level = 2
			else
				let heading.word = matchstr(a:heading_line, '^%%\s\S\+')
				let heading.level = 1
			endif
		elseif a:which ==# 'heading+1'
			call config#debug('which is "heading+1"')
		endif
		call config#debug('return heading = {}', heading)
		return heading
	catch
		call config#debug('exception {}', v:exception)
		echo v:exception
	endtry
endfunction

" vim: ts=2 sw=2
