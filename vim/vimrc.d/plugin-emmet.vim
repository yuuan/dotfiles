" ----------------------------------------
" Emmet
" ----------------------------------------

let g:user_emmet_settings = {
\     'variables': {
\         'lang' : 'ja'
\     }
\ }

" デフォルトで無効
let g:user_emmet_install_global = 0

augroup vimrc_plugin_emmet
	autocmd!

	" 次の FileType でのみ有効化
	autocmd FileType html,css,blade EmmetInstall

augroup end
