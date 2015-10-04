"タブの代わりにスペースを使う
setlocal expandtab
setlocal tabstop=4

"gf で相対パスなどでも開けるようにする
setlocal includeexpr=substitute(substitute(v:fname,'_','/','g'),'$','.php','')
setlocal path+=;vender/;src/;lib/
setlocal suffixesadd=.php,.inc

"`<` と `>` を対応する括弧として認識させない
autocmd FileType php set matchpairs-=<:>
