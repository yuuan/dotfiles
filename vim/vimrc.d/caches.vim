" ----------------------------------------
" Vim のキャッシュの設定
" ----------------------------------------

set backup
set backupdir=$HOME/.vim/backup

set swapfile
set directory=$HOME/.vim/swp

" Undo 履歴をファイルに保存
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.vim/undo
endif

augroup vimrc_caches
	augroup!

	" ファイルを開いたときカーソル位置を復元
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\""

augroup end
