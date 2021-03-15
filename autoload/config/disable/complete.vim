function! config#complete#init() abort
	 return config#complete#coc() 
endfunction

function! config#complete#coc() abort
	 let g:coc_global_extensions = [
					 \ "coc-clangd",
					 \ "coc-cmake",
					 \ "coc-css",
					 \ "coc-emmet",
					 \ "coc-explorer",
					 \ "coc-git",
					 \ "coc-html",
					 \ "coc-highlight",
					 \ "coc-jedi",
					 \ "coc-json",
					 \ "coc-lists",
					 \ "coc-pairs",
					 \ "coc-python",
					 \ "coc-sh",
					 \ "coc-snippets",
					 \ "coc-syntax",
					 \ "coc-tasks",
					 \ "coc-tsserver",
					 \ "coc-vimlsp",
					 \ "coc-vimtex",
					 \ "coc-yaml",
					 \ "coc-yank",
					 \ ]
	 autocmd FileType cpp,hpp,h,c 		let b:coc_suggest_disable=1
	 autocmd FileType cpp,hpp,h,c 		:call coc#config("suggest.autoTrigger", "none")
	 autocmd FileType vim,python,tex 	:call coc#config("suggest.autoTrigger", "always")
	 " call s:key_binding()
	 call config#complete#options()
	 call config#complete#key()
	 call config#complete#autocmd()
	 call config#complete#command()
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! config#complete#options() abort
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

" function s:key_binding() abort
" 	 " Note: \<C-g>u is used to break undo level.
" 	 " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" 	 " To make <cr> select the first completion item and confirm the completion when no item has been selected:
" 	 " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" 	 " to make coc.nvim format your code on <cr>:
" 	 inoremap <silent><expr> <cr> 
" 					 \ pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 	 " use <tab> for trigger completion and navigate to the next complete item
" 	 inoremap <silent><expr> <Tab>
" 					 \ pumvisible() ? "\<C-n>" :
" 					 \ <SID>check_back_space() ? "\<Tab>" :
" 					 \ coc#refresh()

" 	 " use <c-space>for trigger completion
" 	 inoremap <silent><expr> <c-space> coc#refresh()
" 	 " use <c-space>for trigger completion
" 	 inoremap <silent><expr> <NUL> coc#refresh()

" 	 inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" 	 inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" endfunction
function! config#complete#key() abort
	 " Use tab for trigger completion with characters ahead and navigate.
	 " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
	 inoremap <silent><expr> <TAB>
					 \ pumvisible() ? "\<C-n>" :
					 \ <SID>check_back_space() ? "\<TAB>" :
					 \ coc#refresh()
	 inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	 " Use <c-space> to trigger completion.
	 inoremap <silent><expr> <c-space> coc#refresh()

	 " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
	 " Coc only does snippet and additional edit on confirm.
	 inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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

	 " Highlight symbol under cursor on CursorHold
	 autocmd CursorHold * silent call CocActionAsync('highlight')

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



function! config#complete#autocmd() abort
	 augroup mygroup
		  autocmd!
		  " Setup formatexpr specified filetype(s).
		  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
		  " Update signature help on jump placeholder
		  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	 augroup end
endfunction

function! config#complete#command() abort
	 " Use `:Format` to format current buffer
	 command! -nargs=0 Format :call CocAction('format')

	 " Use `:Fold` to fold current buffer
	 command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	 " use `:OR` for organize import of current buffer
	 command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
endfunction

