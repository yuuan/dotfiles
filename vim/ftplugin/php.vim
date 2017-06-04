" タブの代わりにスペースを使う
setlocal expandtab
setlocal tabstop=4

" gf で相対パスなどでも開けるようにする
setlocal includeexpr=substitute(substitute(v:fname,'_','/','g'),'$','.php','')
setlocal path+=;vendor/;src/;lib/
setlocal suffixesadd=.php,.inc

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
