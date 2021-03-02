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


let s:pattern = {}
let s:pattern['class'] = '^\s*classdef\s*\%(\S\+\)\(\s*<\s*\%(\S\+\)\)\='
let s:pattern['function'] = '^\s*function\s\+\S\+(.*)'
let s:pattern['property'] = '^\s*properties\s\*\%((\%(\S\+\s*\)\+)\)\='
let s:pattern['method'] = '^\s*methods\s\*\%((\%(\S\+\s*\)\+)\)\='
let s:pattern['section'] = '^\s*%%\s\S\+.*'
let s:pattern['comment'] = '^\s*%\s*\S\+.*'

"-----------------------------------------------------------------------------
" Outline Info
let s:outline_info = {
			\ 'heading'  : s:pattern['section']
			\								. '\|' . s:pattern['class']
			\ 							. '\|' . s:pattern['function']
			\ 							. '\|' . s:pattern['property']
			\ 							. '\|' . s:pattern['method']
			\  							. '\|' . s:pattern['comment'],
			\ }

let s:outline_info['heading-1'] = s:pattern['class']
let s:outline_info['heading+1'] = s:pattern['class'] . '\|' . s:pattern['function'] . '\|'
			\      				. s:pattern['property'] . '\|' . s:pattern['method']

let s:outline_info.highlight_rules = [
				\   			{ 'name'     : 'comment',
				\   			  'pattern'  : '/%.*/' },
				\   			{ 'name'     : 'function',
				\   			  'pattern'  : '/\S\+\ze\s*(/' },
				\   			{ 'name'     : 'parameter_list',
				\   			  'pattern'  : '/(.*)/' },
				\ 				]
" \   { 'name'     : 'augroup',
" \     'pattern'  : '/\S\+\ze : augroup/',
" \     'highlight': unite#sources#outline#get_highlight('type') },

function! s:outline_info.create_heading(which, heading_line, matched_line, context) 
	call config#debug('call outline_info.create_heading')
	call config#debug('which = {}', a:which)
	call config#debug('heading_line = {}', a:heading_line)
	call config#debug('matched_line = {}', a:matched_line)
	try
		let heading = {
					\ 'word' : a:heading_line,
					\ 'level': 0,
					\ 'type' : 'generic',
					\ }
		if a:which ==# 'heading'
			" section
			if match(a:heading_line, s:pattern['section']) >= 0        "'^\s*%%\s\S\+.*'
				let heading.word = matchstr(a:heading_line, s:pattern['section'])
				let heading.level = 1
				let heading.type = 'section'
			endif
			" class
			if match(a:heading_line, s:pattern['class']) >= 0          " '^\s*classdef\s\+\S\+'
				let heading.word = matchstr(a:heading_line, s:pattern['class']) 
				let heading.level = 1
				let heading.type = 'class'
			endif
			" function
			if match(a:heading_line, s:pattern['function']) >= 0
				let heading.word = matchstr(a:heading_line, s:pattern['function'])
				let heading.level = 1
				let heading.type = 'function'
			endif
			" properties
			if match(a:heading_line, s:pattern['property']) >= 0
				let heading.word = matchstr(a:heading_line, '^\s*properties\s\+\S\+')
				let heading.level = 2
				let heading.type = 'property'
			endif
			" methods
			if match(a:heading_line, s:pattern['method']) >= 0
				let heading.word = matchstr(a:heading_line, s:pattern['method'])
				let heading.level = 2
				let heading.type = 'method'
			endif
			" comment
			if match(a:heading_line, s:pattern['comment']) >= 0
				let heading.word = matchstr(a:heading_line, s:pattern['comment'])
				let heading.type = 'comment'
				let heading.level = 3
			endif
		elseif a:which ==# 'heading+1'
			call config#debug('which is "heading+1"')
		endif
		call config#debug('heading = {}', heading)
		if heading.level > 0 
			return heading
		else
			return {}
		endif
	catch
		call config#debug('exception {}', v:exception)
		echo v:exception
	endtry
endfunction

" vim: ts=2 sw=2
