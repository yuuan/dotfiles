" ----------------------------------------
" echodoc
" ----------------------------------------

" NOTE:
" echodoc を表示するためには `cmdheight` を大きくするか `noshowmode` に設定する必要がある。
" `showmode` で表示される内容は Lightline で確認できるため必要ない。

" コマンドラインに使われる画面上の行数 (default: 1)
"set cmdheight=2

" 現在のモードを表示する (default: showmode)
set noshowmode

" 起動時に echodoc を有効化
let g:echodoc_enable_at_startup = 1
