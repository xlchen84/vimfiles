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
let s:pattern['class'] = '^\s*classdef\s\+'
let s:pattern['function'] = '^\s*function\s\+'
let s:pattern['properties'] = '^\s*properties\s*'
let s:pattern['methods'] = '^\s*methods\s*'
let s:pattern['section'] = '^\s*%%\s\S\+'
let s:pattern['comment'] = '^\s*%[^%]\=\s\+\S\+'

"-----------------------------------------------------------------------------
" Outline Info
let s:outline_info = {
			\ 'heading'  : s:pattern['section']
			\								. '\|' . s:pattern['class']
			\ 							. '\|' . s:pattern['function']
			\ 							. '\|' . s:pattern['properties']
			\ 							. '\|' . s:pattern['methods'] 			
			\ }
" . '\|' . s:pattern['comment'],

" let s:outline_info['heading-1'] = s:pattern['class']
" let s:outline_info['heading+1'] = s:pattern['class'] . '\|' . s:pattern['function'] . '\|'
" 			\      				. s:pattern['properties'] . '\|' . s:pattern['methods']

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
		let heading_line = a:heading_line
		let matched_line = a:matched_line
		let context = a:context
		if a:which ==# 'heading'

			let heading = unite#sources#outline#matlab#parse_classdef(heading, heading_line, matched_line, context) 
			let heading = unite#sources#outline#matlab#parse_properties(heading, heading_line, matched_line, context) 
			let heading = unite#sources#outline#matlab#parse_methods(heading, heading_line, matched_line, context) 
			let heading = unite#sources#outline#matlab#parse_function(heading, heading_line, matched_line, context) 
			let heading = unite#sources#outline#matlab#parse_section(heading, heading_line, matched_line, context) 
			let heading = unite#sources#outline#matlab#parse_comment(heading, heading_line, matched_line, context) 
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

" class
function! unite#sources#outline#matlab#parse_classdef(heading, heading_line, matched_line, context) abort
	let heading = a:heading
	if match(a:heading_line, s:pattern['class']) >= 0          
		let heading.word = matchstr(a:heading_line, s:pattern['class'] . '\S\+\s*\%(<\s*\%(\S\+\s\+\%(\s*&\s*\S\+\s*\)*\)\+\)\=') 
		let heading.level = 1
		let heading.type = 'class'
	endif
	return heading
endfunction

" properties
function! unite#sources#outline#matlab#parse_properties(heading, heading_line, matched_line, context) abort
	let heading = a:heading
	if match(a:heading_line, s:pattern['properties']) >= 0
		let extra = '\s*\%((\S\+\s*\%(,\s*\S\+\)*)\)\='
		let heading.word = matchstr(a:heading_line, s:pattern['properties'] . extra)
		let heading.level = 2
		let heading.type = 'properties'
	endif
	return heading
endfunction

" methods
function! unite#sources#outline#matlab#parse_methods(heading, heading_line, matched_line, context) abort
	let heading = a:heading
			if match(a:heading_line, s:pattern['methods']) >= 0
				let extra = '\s*\%((\S\+\s*\%(,\s*\S\+\)*)\)\='
				let heading.word = matchstr(a:heading_line, s:pattern['methods'] . extra)
				let heading.level = 2
				let heading.type = 'methods'
			endif
	return heading
endfunction

" function
function! unite#sources#outline#matlab#parse_function(heading, heading_line, matched_line, context) abort
	let heading = a:heading
	if match(a:heading_line, s:pattern['function']) >= 0
		let retval = '\%(\%(\S\+\s*\|\[\s*\S\+\s*\%(,\s*\S\+\s*\)*\]\)\s*=\s*\)\='
		let args = '\s*\S\+\s*\%(,\s*\S\+\s*\)*'
		let funcall = '\S\+\s*(' . args . ')\s*'
		let pattern = s:pattern['function'] . retval . funcall
		let heading.word = matchstr(a:heading_line,  pattern )
		let heading.level = 3
		let heading.type = 'function'
	endif
	return heading
endfunction

" section
function! unite#sources#outline#matlab#parse_section(heading, heading_line, matched_line, context) abort
	let heading = a:heading
	if match(a:heading_line, s:pattern['section']) >= 0
		let heading.word = a:heading_line
		let heading.level = 1
		let heading.type = 'section'
	endif
	return heading
endfunction

" comment
function! unite#sources#outline#matlab#parse_comment(heading, heading_line, matched_line, context) abort
	let heading = a:heading
			if match(a:heading_line, s:pattern['comment']) >= 0
				let heading.word = a:heading_line
				let heading.type = 'comment'
				let heading.level = 3
			endif
	return heading
endfunction

" vim: ts=2 sw=2
