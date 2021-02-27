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
endfunction

