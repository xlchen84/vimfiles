" vim: ts=2 : sw=2
function! config#coc#init() abort
	call s:variables()
	if exists('g:did_coc_loaded')
		" call s:key_binding()
		call s:options()
		call s:autocmd()
		call s:command()
		call s:key()
	endif
endfunction

function! s:variables() abort
	let g:coc_disable_startup_warning = 0
	let g:coc_global_extensions = [
				\ "coc-clangd",
				\ "coc-cmake",
				\ "coc-css",
				\ "coc-emmet",
				\ "coc-explorer",
				\ 'coc-flutter',
				\ "coc-git",
				\ "coc-html",
				\ "coc-highlight",
				\ 'coc-java',
				\ "coc-jedi",
				\ "coc-json",
				\ "coc-lists",
				\ 'coc-markdownlint',
				\ "coc-pairs",
				\ "coc-python",
				\ "coc-sh",
				\ "coc-snippets",
				\ "coc-syntax",
				\ "coc-tasks",
				\ "coc-tsserver",
				\ "coc-vimlsp",
				\ "coc-vimtex",
				\ 'coc-xml',
				\ "coc-yaml",
				\ "coc-yank",
				\ ]
endfunction

" Use tab for trigger completion with characters ahead and navigate.
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! s:options() abort
	" if hidden is not set, TextEdit might fail.
	set hidden
	" Some servers have issues with backup files, see #649
	set nobackup
	set nowritebackup
	" You will have bad experience for diagnostic messages when it's default 4000.
	set updatetime=300
	" don't give |ins-completion-menu| messages.
	set shortmess+=c
	" always show signcolumns
	set signcolumn=yes
	" Better display for messages
	set cmdheight=2
endfunction

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction


function! s:autocmd() abort
	augroup coc
		autocmd!
		autocmd FileType cpp,hpp,h,c 		let b:coc_suggest_disable=1
		autocmd FileType cpp,hpp,h,c 		:call coc#config("suggest.autoTrigger", "none")
		autocmd FileType vim,python,tex 	:call coc#config("suggest.autoTrigger", "always")
		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
		" Update signature help on jump placeholder
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
		" Highlight symbol under cursor on CursorHold
		autocmd CursorHold * silent call CocActionAsync('highlight')
	augroup END
endfunction

function! s:command() abort
	" Use `:Format` to format current buffer
	command! -nargs=0 Format :call CocAction('format')
	" Use `:Fold` to fold current buffer
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)
	" use `:OR` for organize import of current buffer
	command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
 " Add status line support, for integration with other plugin, checkout `:h coc-status`
 set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
endfunction

function! s:key() abort
	" use <tab> for trigger completion and navigate to the next complete item
	inoremap <silent><expr> <TAB> 
				\ pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
	inoremap <silent><expr> <S-TAB> 
				\ pumvisible() ? "\<C-p>" : <SID>check_back_space() ? "\<S-TAB>" : coc#refresh()
	" To make <cr> select the first completion item and confirm the completion when no item has been selected:
	" Note: \<C-g>u is used to break undo level.
	" to make coc.nvim format your code on <cr>:
	inoremap <silent><expr> <cr> 
				\ pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
	" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
	" use <c-space>for trigger completion
	inoremap <silent><expr> <c-space> coc#refresh()
	" use <c-space>for trigger completion
	inoremap <silent><expr> <NUL> coc#refresh()

	nnoremap <M-e> 	:CocCommand explorer<CR>
	" Use tab for trigger completion with characters ahead and navigate.
	" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
	" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()

	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
	" Coc only does snippet and additional edit on confirm.
	" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	" Or use `complete_info` if your vim support it, like:
	" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

	" Use `[g` and `]g` to navigate diagnostics
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)
	" Remap keys for gotos
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use K to show documentation in preview window
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	if !exists('g:mapleader')
		let g:mapleader = ' '
	endif
	" Remap for rename current word
	nmap <leader>rn <Plug>(coc-rename)

	" Remap for format selected region
	xmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)

	" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	" Remap for do codeAction of current line
	nmap <leader>ac  <Plug>(coc-codeaction)
	" Fix autofix problem of current line
	nmap <leader>qf  <Plug>(coc-fix-current)

	" Create mappings for function text object, requires document symbols feature of languageserver.
	xmap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap if <Plug>(coc-funcobj-i)
	omap af <Plug>(coc-funcobj-a)
endfunction


" " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" 
" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()
" 
" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" " Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" " Or use `complete_info` if your vim support it, like:
" " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" 
" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
" 
" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" 
" " Use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" 
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction
" 
" " Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')
" 
" " Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)
" 
" " Remap for format selected region
" xmap <leader>fm  <Plug>(coc-format-selected)
" nmap <leader>fm  <Plug>(coc-format-selected)
" 
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
" 
" " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
" 
" " Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)
" 
" " Create mappings for function text object, requires document symbols feature of languageserver.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)
" 
" " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)
" " Using CocList
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
