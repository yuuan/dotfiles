" ----------------------------------------
" vim-cursorword の設定
" ----------------------------------------

augroup vim_cursorword_init
	" 二重に登録されるのを防止する
	autocmd!

	" 変数宣言
	autocmd BufNewFile,BufRead * let b:cursorword = 0
augroup end

" `_` キーでオン/オフ設定
nnoremap <silent> __ :<C-u>let b:cursorword = ! b:cursorword<CR>
