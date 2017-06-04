" gf で相対パスなどでも開けるようにする
setlocal includeexpr=substitute(v:fname,'^\\/','','')
setlocal path+=;/
