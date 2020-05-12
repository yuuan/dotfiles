" ----------------------------------------
" deoplete
" ----------------------------------------

" 起動時に有効化 (default: 0)
let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
\	'smart_case': v:true,
\	'ignore_case': v:false,
\ })

" Tab キーで候補を選択
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"
