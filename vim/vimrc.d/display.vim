" ----------------------------------------
" 表示
" ----------------------------------------

" カーソル行を強調表示しない
set nocursorline

" 挿入モードの時のみ、カーソル行を強調表示する
autocmd InsertEnter,InsertLeave * set cursorline!
