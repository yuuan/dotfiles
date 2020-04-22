" ----------------------------------------
" キーバインド - 画面操作
" ----------------------------------------

" Ctrl + 左右キーでタブを切り替え
nnoremap <C-Right> :<C-u>tabn<CR>
nnoremap <C-Left> :<C-u>tabp<CR>
inoremap <C-Right> <ESC>:tabn<CR>
inoremap <C-Left> <ESC>:tabp<CR>
cnoremap <C-Right> <C-u>tabn
cnoremap <C-Left> <C-u>tabp
inoremap <expr><C-Right> "\<ESC>:tabn\<CR>"
inoremap <expr><C-Left> "\<ESC>:tabp\<CR>"

" Ctrl + 上下キーでスクロール
noremap <C-Up> <C-Y>
noremap <C-Down> <C-E>
inoremap <C-Up> <C-O><C-Y>
inoremap <C-Down> <C-O><C-E>

" Alt + 上下キーでスクロール
noremap <M-Up> <C-Y>
noremap <M-Down> <C-E>

" PageUp/Down の幅を半分に
noremap <PageUp> <C-U>
noremap <PageDown> <C-D>

" 行番号表示切り替え {{{
	function! SwitchNumber()
		if &number
			setlocal nonumber
			setlocal nolist
			setlocal signcolumn=no
			execute ":IndentLinesDisable"
			execute ":GitGutterDisable"
		else
			setlocal number
			setlocal list
			setlocal signcolumn=auto
			execute ":IndentLinesEnable"
			execute ":GitGutterEnable"
		endif
	endfunction

	nnoremap <silent> !! :<C-u>call SwitchNumber()<CR>
" }}}
