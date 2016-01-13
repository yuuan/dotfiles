" ----------------------------------------
" Syntastic
" ----------------------------------------

" Perl で `lib/` からモジュールを探す
"let g:syntastic_perl_lib_path = 'lib'

" Perl で FindBin::libs を使う
let g:syntastic_perl_perl_args = '-MFindBin::libs'
