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
      \ 'heading'  : '^function\s\+\S\+',
      \ }

function! s:outline_info.create_heading(which, heading_line, matched_line, context) abort
	try
		let heading = {
					\ 'word' : a:heading_line,
					\ 'level': 0,
					\ 'type' : 'generic',
					\ }
		return heading
	catch
		echo v:exception
	endtry

  "if a:which ==# 'heading'
  "  let heading.level = strlen(matchstr(a:heading_line, '^#\+'))
  "  let heading.word = substitute(heading.word, '^#\+\s*', '', '')
  "  let heading.word = substitute(heading.word, '\s*#\+\s*$', '', '')
  "elseif a:which ==# 'heading+1'
  "  if a:matched_line =~ '^='
  "    let heading.level = 1
  "  else
  "    let heading.level = 2
  "  endif
  "endif

	""call config#message('outline matlab heading: {}', heading)

  "if heading.level > 0
  "  let heading.word = substitute(heading.word, '\s*<a[^>]*>\s*\%(</a>\s*\)\=$', '', '')
  "  return heading
  "else
  "  return {}
  "endif
endfunction

" vim: ts=2 sw=2
