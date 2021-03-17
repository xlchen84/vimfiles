" vim:ts=2:sw=2 
" -------------------------------------                      *airline-tabline*
" Note: If you're using the ctrlspace tabline only the option marked with (c) are supported!
function! config#airline#tabline#init() abort
	call add(g:airline_extensions, 'tabline')
	call config#airline#tabline#variables()
endfunction

function! config#airline#tabline#variables() abort
	"* enable/disable enhanced tabline. (c) >
	let g:airline#extensions#tabline#enabled = 0
	"* enable/disable displaying open splits per tab (only when tabs are opened) >
	let g:airline#extensions#tabline#show_splits = 1
	"* switch position of buffers and tabs on splited tabline (c)
	"  (only supported for ctrlspace plugin). >
	let g:airline#extensions#tabline#switch_buffers_and_tabs = 0
	"<
	"* enable/disable displaying buffers with a single tab. (c) >
	let g:airline#extensions#tabline#show_buffers = 1
	"Note: If you are using neovim (has('tablineat') = 1), then you can click
	"on the tabline with the left mouse button to switch to that buffer, and
	"with the middle mouse button to delete that buffer.
	"* if you want to show the current active buffer like this:
	"  ----------------------
	"  buffer <buffer> buffer `
	">
	let g:airline#extensions#tabline#alt_sep = 1
	"< Only makes sense, if g:airline_right_sep is not empty.  default: 0
	"* enable/disable displaying tabs, regardless of number. (c) >
	let g:airline#extensions#tabline#show_tabs = 1
	"* enable/disable displaying number of tabs in the right side (c) >
	let g:airline#extensions#tabline#show_tab_count = 1
	"Note: Not displayed if the number of tabs is less than 1
	"* always displaying number of tabs in the right side (c) >
	let g:airline#extensions#tabline#show_tab_count = 2
	"<
	"* configure filename match rules to exclude from the tabline. >
	let g:airline#extensions#tabline#excludes = []
	"* enable/disable display preview window buffer in the tabline. >
	let g:airline#extensions#tabline#exclude_preview = 1
	"* configure how numbers are displayed in tab mode. >
	let g:airline#extensions#tabline#tab_nr_type = 0 " # of splits (default)
	let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
	let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
	let g:airline#extensions#tabline#tabnr_formatter = 'tabnr'
	"  Note: last option can be used to specify a different formatter for
	"  displaying the numbers. By default tabline/formatter/tabnr.vim is used
	"  The argument of that setting should either be a filename that exists
	"  autoload/airline/extensions/tabline/formatter/ (without .vim extension)
	"  and needs to provide a format() function. Alternatively you can use a
	"  custom function name, that is defined e.g. in your .vimrc file. In any
	"  case, the function needs to take 2 arguments, tab_nr_type and tabpage
	"  number.
	"  For an example, have a look at the default tabline/formatter/tabnr.vim
	"<
	"* enable/disable displaying tab number in tabs mode. >
	let g:airline#extensions#tabline#show_tab_nr = 0
	"* enable/disable displaying tab number in tabs mode for ctrlspace. (c) >
	let g:airline#extensions#tabline#ctrlspace_show_tab_nr = 1
	"* enable/disable displaying tab type (e.g. [buffers]/[tabs]) >
	let g:airline#extensions#tabline#show_tab_type = 1
	"* show buffer label at first position: >
	let g:airline#extensions#tabline#buf_label_first = 1
	"* rename label for buffers (default: 'buffers') (c) >
	let g:airline#extensions#tabline#buffers_label = 'b'
	"* rename label for tabs (default: 'tabs') (c) >
	let g:airline#extensions#tabline#tabs_label = 't'
	"* change the symbol for skipped tabs/buffers (default '...') >
	let g:airline#extensions#tabline#overflow_marker = '…'
	"* always show current tabpage/buffer first >
	let airline#extensions#tabline#current_first = 1
	"<  default: 0
	"* enable/disable displaying index of the buffer.
	"  `buffer_idx_mode` allows 3 different modes to access buffers from the
	"  tabline. When enabled, numbers will be displayed in the tabline and
	"  mappings will be exposed to allow you to select a buffer directly.
	"  In default mode, when the variable is 1 Up to 10 mappings will be
	"  exposed. Note: As 10 and 1 have same prefix, we use 0 to replace 10. So,
	"  <leader>0 will jump to tenth buffer. Those mappings are not automatically
	"  created, vim-airline just exposes those `<Plug>AirlineSeelctTab` keys
	"  for you to map to a convenient key >
	" let g:airline#extensions#tabline#buffer_idx_mode = 1
	" nmap <leader>1 <Plug>AirlineSelectTab1
	" nmap <leader>2 <Plug>AirlineSelectTab2
	" nmap <leader>3 <Plug>AirlineSelectTab3
	" nmap <leader>4 <Plug>AirlineSelectTab4
	" nmap <leader>5 <Plug>AirlineSelectTab5
	" nmap <leader>6 <Plug>AirlineSelectTab6
	" nmap <leader>7 <Plug>AirlineSelectTab7
	" nmap <leader>8 <Plug>AirlineSelectTab8
	" nmap <leader>9 <Plug>AirlineSelectTab9
	" nmap <leader>0 <Plug>AirlineSelectTab0
	" nmap <leader>- <Plug>AirlineSelectPrevTab
	" nmap <leader>+ <Plug>AirlineSelectNextTab
	"<
	"In mode 2, (when the variable is 2) 89 mappings will be exposed: >
	"
	" let g:airline#extensions#tabline#buffer_idx_mode = 2
	" nmap <Leader>10 <Plug>AirlineSelectTab10
	" nmap <Leader>11 <Plug>AirlineSelectTab11
	" nmap <Leader>12 <Plug>AirlineSelectTab12
	" nmap <Leader>13 <Plug>AirlineSelectTab13
	" ...
	" nmap <Leader>99 <Plug>AirlineSelectTab99
	" <
	" The <Plug>AirlineSelect<Prev/Next>Tab mapping handles counts as well,
	" so one can handle arbirtrarily number of buffers/tabs.
	" 
	"  Mode 3 is exactly the same as mode 2, except the indexing start at 01,
	"  exposing 99 mappings: >
	"
	let g:airline#extensions#tabline#buffer_idx_mode = 3
	" nmap <Leader>01 <Plug>AirlineSelectTab01
	" nmap <Leader>02 <Plug>AirlineSelectTab02
	" nmap <Leader>03 <Plug>AirlineSelectTab03
	" ...
	" nmap <Leader>99 <Plug>AirlineSelectTab99
	" <
	" This matches that of the numbering scheme of |:buffers|, letting
	" `<Plug>AirlineSelectTab67` to reference buffer 67.
	" 
	"   Note: To avoid ambiguity, there won't be <Plug>AirlineSelectTab1
	"   - <Plug>AirlineSelectTab9 maps in mode 2 and 3.
	" 
	"   Note: Mappings will be ignored for filetypes that match
	"  `g:airline#extensions#tabline#keymap_ignored_filetypes`.
	"   Note: In buffer_idx_mode these mappings won't change the
	"   current tab, but switch to the buffer `visible` in the current tab.
	"   If you want to switch to a buffer, that is not visible use the
	"   `AirlineSelectPrev/NextTab` mapping (it supports using a count).
	"   Use |gt| for switching tabs.
	"   In tabmode, those mappings will be exposed as well and will switch
	"   to the specified tab.
	" 
	" * define the set of filetypes which are ignored for the selectTab
	"   keymappings: >
	let g:airline#extensions#tabline#keymap_ignored_filetypes =
				\ ['vimfiler', 'nerdtree']
	" * change the display format of the buffer index >
	let g:airline#extensions#tabline#buffer_idx_format = {
				\ '0': '0 ',
				\ '1': '1 ',
				\ '2': '2 ',
				\ '3': '3 ',
				\ '4': '4 ',
				\ '5': '5 ',
				\ '6': '6 ',
				\ '7': '7 ',
				\ '8': '8 ',
				\ '9': '9 '
				\}
	" <
	" * defines the name of a formatter for how buffer names are displayed. (c) >
	let g:airline#extensions#tabline#formatter = 'default'
	"   " here is how you can define a 'foo' formatter:
	"   " create a file in the dir autoload/airline/extensions/tabline/formatters/
	"   " called foo.vim >
	"   function! airline#extensions#tabline#formatters#foo#format(bufnr, buffers)
	"     return fnamemodify(bufname(a:bufnr), ':t')
	"   endfunction
	"   let g:airline#extensions#tabline#formatter = 'foo'
	" <
	"   Note: the following variables are used by the 'default' formatter.
	"   When no disambiguation is needed, both 'unique_tail_improved' and
	"   'unique_tail' delegate formatting to 'default', so these variables also
	"   control rendering of unique filenames when using these formatters.
	" 
	"     * configure whether buffer numbers should be shown. >
	"       let g:airline#extensions#tabline#buffer_nr_show = 0
	" <
	"     * configure how buffer numbers should be formatted with |printf()|. >
	"       let g:airline#extensions#tabline#buffer_nr_format = '%s: '
	" <
	"     * configure the formatting of filenames (see |filename-modifiers|). >
	"       let g:airline#extensions#tabline#fnamemod = ':p:.'
	" <
	"     * configure collapsing parent directories in buffer name. >
	"       let g:airline#extensions#tabline#fnamecollapse = 1
	" <
	"     * configure truncating non-active buffer names to specified length. >
	"       let g:airline#extensions#tabline#fnametruncate = 0
	" 
	"   " The `unique_tail` algorithm will display the tail of the filename, unless
	"   " there is another file of the same name, in which it will display it along
	"   " with the containing parent directory.
	"   let g:airline#extensions#tabline#formatter = 'unique_tail'
	" 
	"       " The following variables are also used by `unique_tail` formatter.
	"       " the meanings are the same as the ones in default formatter.
	" 
	"       let g:airline#extensions#tabline#fnamemod = ':p:.'
	"       let g:airline#extensions#tabline#fnamecollapse = 1
	" 
	"   " The `unique_tail_improved` - another algorithm, that will smartly
	"   " uniquify buffers names with similar filename, suppressing common
	"   " parts of paths.
	"   let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
	" 
	"   " The `short_path` - is a simple formatter, that will show the
	"   filename, with its extension, and the first parent directory only.
	" 
	"   e.g.
	"      /home/user/project/subdir/file.ext -> subdir/file.ext
	" 
	"   let g:airline#extensions#tabline#formatter = 'short_path'
	" 
	" * defines the customized format() function to display tab title in tab mode. >
	"   let g:airline#extensions#tabline#tabtitle_formatter = 'MyTabTitleFormatter'
	" <
	"   Then define the MyTabTitleFormatter() function in your vimrc. >
	"     function MyTabTitleFormatter(n)
	"       let buflist = tabpagebuflist(a:n)
	"       let winnr = tabpagewinnr(a:n)
	"       let bufnr = buflist[winnr - 1]
	"       let winid = win_getid(winnr, a:n)
	"       let title = bufname(bufnr)
	" 
	"       if empty(title)
	"         if getqflist({'qfbufnr' : 0}).qfbufnr == bufnr
	"           let title = '[Quickfix List]'
	"         elseif winid && getloclist(winid, {'qfbufnr' : 0}).qfbufnr == bufnr
	"           let title = '[Location List]'
	"         else
	"           let title = '[No Name]'
	"         endif
	"       endif
	" 
	"       return title
	"     endfunction
	" 
	" * configure the minimum number of buffers needed to show the tabline. >
	"   let g:airline#extensions#tabline#buffer_min_count = 0
	" <
	"   Note: this setting only applies to a single tab and when `show_buffers` is
	"   true.
	" 
	" * configure the minimum number of tabs needed to show the tabline. >
	"   let g:airline#extensions#tabline#tab_min_count = 0
	" <
	"   Note: this setting only applies when `show_buffers` is false.
	" 
	" * configure separators for the tabline only. >
	"   let g:airline#extensions#tabline#left_sep = ''
	"   let g:airline#extensions#tabline#left_alt_sep = ''
	"   let g:airline#extensions#tabline#right_sep = ''
	"   let g:airline#extensions#tabline#right_alt_sep = ''
	" 
	" * configure whether close button should be shown: >
	"   let g:airline#extensions#tabline#show_close_button = 1
	" 
	" * configure symbol used to represent close button >
	"   let g:airline#extensions#tabline#close_symbol = 'X'
	" 
	" * configure pattern to be ignored on BufAdd autocommand >
	"   " fixes unnecessary redraw, when e.g. opening Gundo window
	"   let airline#extensions#tabline#ignore_bufadd_pat =
	"             \ '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'
	" 
	" Note: Enabling this extension will modify 'showtabline' and 'guioptions'.
	" 
	" * enable Refresh of tabline buffers on |BufAdd| autocommands
	"   (set this to one, if you note 'AirlineTablineRefresh', however, this
	"    won't update airline on |:badd| commands) >
	"   let airline#extensions#tabline#disable_refresh = 0
	" 
	" * preserve windows when closing a buffer from the bufferline
	"   (neovim specific, only works with buffers and not real tabs, default: 0) >
	"   let airline#extensions#tabline#middle_click_preserves_windows = 1
	" <
	" 						*airline-tabline-hlgroups*
	" When the tabline is enabled, vim-airline exposes the following highlighting
	" groups:
	" 
	"   airline_tab:		default highlighting group for the tabline
	"   airline_tab_right:	idem, but for the right side of the tabline
	" 
	"   airline_tabsel:	highlighting group of the selected item
	"   airline_tabsel_right: idem, but for the right side of the tabline
	"   airline_tabmod:       highlighting group for a 'modified' buffer
	"   airline_tabmod_right: idem, but on the right side
	"   airline_tabmod_unsel: unselected tab with modified buffer
	"   airline_tabmod_unsel_right: (unused)
	"   airline_tabtype:      label group used by ctrlspace and tabws
	"   airline_tabfill:	highlighting group for the filler space
	"   airline_tablabel:     highlighting group for the label
	"   airline_tablabel_right: highlighting group for the label on the right side
	"   airline_tabhid:	hidden buffer
	"   airline_tabhid_right: idem, but on the right
endfunction
