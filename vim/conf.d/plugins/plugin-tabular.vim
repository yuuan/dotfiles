" ----------------------------------------
" tabular.vim
" ----------------------------------------

" `|` キーで位置を揃える
vnoremap <silent> \|, :<C-u>'<,'>Tabularize /,<cr>
vnoremap <silent> \|= :<C-u>'<,'>Tabularize /=>\?<cr>
vnoremap <silent> \|- :<C-u>'<,'>Tabularize /->\?/l0<cr>
vnoremap <silent> \|. :<C-u>'<,'>Tabularize /./l0<cr>
vnoremap <silent> \|: :<C-u>'<,'>Tabularize /::\?/l0l1<cr>
vnoremap <silent> \|; :<C-u>'<,'>Tabularize /;/l0l1<cr>
vnoremap <silent> \|\| :<C-u>'<,'>Tabularize /\|<cr>
