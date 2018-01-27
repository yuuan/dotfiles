" ----------------------------------------
" php.vim
" ----------------------------------------

function! PhpSyntaxOverride()
	highlight! def link phpDocTags  phpDefine
	highlight! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
	autocmd!
	autocmd FileType php call PhpSyntaxOverride()
augroup end
