" ----------------------------------------
" deoplete
" ----------------------------------------

" 起動時に有効化 (default: 0)
let g:deoplete#enable_at_startup = 1

if has('python3') && v:version >= 800
	call deoplete#custom#option({
	\	'smart_case': v:true,
	\	'ignore_case': v:false,
	\ })
endif

" Tab キーで候補を選択
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"
