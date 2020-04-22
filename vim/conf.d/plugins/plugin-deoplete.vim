" ----------------------------------------
" deoplete
" ----------------------------------------

" 起動時に有効化 (default: 0)
let g:deoplete#enable_at_startup = 1

" オートコンプリートを無効にする (default: 0)
"let g:deoplete#disable_auto_complete = 1

" オートコンプリートを開始する文字数 (default: 2)
let g:deoplete#auto_complete_start_length = 1

" スマートケースを有効にする (default: `smartcase` と同じ値)
let g:deoplete#enable_smart_case = 1

" メニューの幅 (default: 40)
let g:deoplete#max_menu_width = 100

" 入力してから候補を出すまでのミリ秒数 (default: 50)
let g:deoplete#auto_complete_delay = 0

" Tab キーで候補を選択
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"
