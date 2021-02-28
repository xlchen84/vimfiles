function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function s:key_binding() abort
	 " Note: \<C-g>u is used to break undo level.
	 " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

	 " To make <cr> select the first completion item and confirm the completion when no item has been selected:
	 " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

	 " to make coc.nvim format your code on <cr>:
	 inoremap <silent><expr> <cr> 
					 \ pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

	 " use <tab> for trigger completion and navigate to the next complete item
	 inoremap <silent><expr> <Tab>
					 \ pumvisible() ? "\<C-n>" :
					 \ <SID>check_back_space() ? "\<Tab>" :
					 \ coc#refresh()

	 " use <c-space>for trigger completion
	 inoremap <silent><expr> <c-space> coc#refresh()
	 " use <c-space>for trigger completion
	 inoremap <silent><expr> <NUL> coc#refresh()

	 inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
	 inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endfunction

function! config#complete#coc() abort
	 let g:coc_global_extensions = [
					 \ "coc-explorer",
					 \ "coc-lists",
					 \ "coc-vimlsp",
					 \ "coc-python",
					 \ "coc-tasks",
					 \ "coc-yank",
					 \ "coc-json",
					 \ "coc-vimtex",
					 \ "coc-html",
					 \ "coc-css",
					 \ "coc-snippets",
					 \ "coc-tsserver"]
	 autocmd FileType cpp,hpp,h,c 		let b:coc_suggest_disable=1
	 autocmd FileType cpp,hpp,h,c 		:call coc#config("suggest.autoTrigger", "none")
	 autocmd FileType vim,python,tex 	:call coc#config("suggest.autoTrigger", "always")
	 call s:key_binding()
endfunction

function! config#complete#init() abort
	 return config#complete#coc() 
endfunction

