" ----------------------------------------
" キーバインド - 編集
" ----------------------------------------

" HomeとEnd
noremap <C-A> <Home>
inoremap <C-A> <Home>
noremap <C-E> <End>
inoremap <C-E> <End>

" Ctrl + h, j, k, l でカーソル移動
inoremap <C-H> <Left>
inoremap <C-J> <Down>
"inoremap <C-K> <Up>
inoremap <C-L> <Right>

" Ctrl + k で行末まで削除
inoremap <expr> <C-k> "\<C-g>u".(col('.') == col('$') ? '<C-o>gJ' : '<C-o>D')
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

" 検索後に ESC キーでハイライトを消す
"nnoremap <ESC> :nohlsearch<CR>

" コマンドラインモードで Ctrl + p で貼り付け
cnoremap <C-P> <C-R>"

" インサートモードで Ctrl + p で貼り付け
inoremap <buffer> <C-p> <C-r>0

" 単語を選択
nnoremap + viw

" 括弧内を選択
nnoremap ; vib
vnoremap ; <ESC>vab

" インデントした後も範囲選択を残す
vnoremap < <gv
vnoremap > >gv

" ペーストモード切り替え {{{
	function! SwitchPaste()
		if &paste
			setlocal nopaste
		else
			setlocal paste
		endif
	endfunction

	nnoremap <silent> "" :<C-u>call SwitchPaste()<CR>
" }}}

noremap <kPlus> <C-a>
noremap <kMinus> <C-x>
