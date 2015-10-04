" ----------------------------------------
" キーバインド - 画面操作
" ----------------------------------------

"Ctrl + 左右キーでタブを切り替え
nnoremap <C-Right> :<C-u>tabn<CR>
nnoremap <C-Left> :<C-u>tabp<CR>
inoremap <C-Right> <ESC>:tabn<CR>
inoremap <C-Left> <ESC>:tabp<CR>
cnoremap <C-Right> <C-u>tabn
cnoremap <C-Left> <C-u>tabp

if neobundle#is_installed('neocomplete')
	inoremap <expr><C-Right> pumvisible() ? neocomplete#smart_close_popup() : "\<ESC>:tabn\<CR>"
	inoremap <expr><C-Left> pumvisible() ? neocomplete#smart_close_popup() : "\<ESC>:tabp\<CR>"
else
	inoremap <expr><C-Right> "\<ESC>:tabn\<CR>"
	inoremap <expr><C-Left> "\<ESC>:tabp\<CR>"
endif

"Shift + 上下キーでスクロール
noremap <S-Up> <C-Y>
noremap <S-Down> <C-E>

"Alt + 上下キーでスクロール
map <M-Up> <C-Y>
map <M-Down> <C-E>

"PageUp/Downの幅を半分に
map <PageUp> <C-U>
map <PageDown> <C-D>

" 行番号表示切り替え {{{
	function! SwitchNumber()
		if &number
			setlocal nonumber
			setlocal nolist
			execute ":IndentLinesDisable"
		else
			setlocal number
			setlocal list
			execute ":IndentLinesEnable"
		endif
	endfunction

	nnoremap <silent> !! :<C-u>call SwitchNumber()<CR>
" }}}
