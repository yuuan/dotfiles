" ----------------------------------------
" キーバインド - ファンクションキー
" ----------------------------------------

"F2 F3でバッファ切り替え F4でバッファを閉じる
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bw<CR>

"F5 F6で位置を記録 F7 F8で記録した位置に戻る
map <F5> <ESC>ma
map <F6> <ESC>mb
map <F7> <ESC>`a
map <F8> <ESC>`b

"F9 F10でタブを切り替え
map <F9> <ESC>:tabp<CR>
map <F10> <ESC>:tabn<CR>
