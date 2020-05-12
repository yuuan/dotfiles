" Fixer の設定
let g:ale_fixers = {
\	'javascript': ['eslint', 'prettier'],
\	'typescript': ['eslint', 'prettier'],
\	'typescriptreact': ['eslint', 'prettier'],
\ }

" ファイル保存時に整形
let g:ale_fix_on_save = 1
