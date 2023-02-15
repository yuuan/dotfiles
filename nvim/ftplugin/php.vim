setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" `<` と `>` を対応する括弧として認識させない
setlocal matchpairs-=<:>

" Baselib メソッドのハイライト
let g:php_baselib = 1

" `<?` をハイライトしない
let g:php_noShortTags = 1

" 文字列中の HTML をハイライト
"let g:php_htmlInStrings = 1

" 文字列中の SQL をハイライト
"let g:php_sql_query = 1

" SQL を MySQL とみなしてハイライト
let g:sql_type_default = 'mysql'
