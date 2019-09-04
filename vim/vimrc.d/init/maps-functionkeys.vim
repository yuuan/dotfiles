" ----------------------------------------
" キーバインド - ファンクションキー
" ----------------------------------------

"F2 F3でバッファ切り替え F4でバッファを閉じる
noremap <F2> <ESC>:bp<CR>
noremap <F3> <ESC>:bn<CR>
noremap <F4> <ESC>:bw<CR>:tabp<CR>

"F5 F6で位置を記録 F7 F8で記録した位置に戻る
"noremap <F5> <ESC>ma
"noremap <F6> <ESC>mb
"noremap <F7> <ESC>`a
"noremap <F8> <ESC>`b

"F9 F10でタブを切り替え
noremap <F9> <ESC>:tabp<CR>
noremap <F10> <ESC>:tabn<CR>
