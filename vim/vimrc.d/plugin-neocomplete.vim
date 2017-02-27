" ----------------------------------------
" NeoComplete
" ----------------------------------------
"
" 起動時に有効化"
let g:neocomplete#enable_at_startup = 1

" 補完を表示する最小文字数 (default: 2)
let g:neocomplete#min_syntax_length = 3

" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1

" `_` 区切りの補完を有効化
let g:neocomplete#enable_underbar_completion = 1

" (default: 0)
let g:neocomplete#disable_auto_complete = 0

" (default: 0)
let g:neocomplete#enable_auto_select = 0

" (default: 1)
"let g:neocomplete#enable_smart_case = 0

" (default: 1)
"let g:neocomplete#enable_fuzzy_completion = 0

" (default: 0)
"let g:neocomplete#enable_camel_case = 0

augroup vimrc_plugin_neocomplete
	autocmd!

	"Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	autocmd FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP
	autocmd FileType gitcommit setlocal omnifunc=emoji#complete

augroup end

if !exists('g:neocomplete#sources')
	let g:neocomplete#sources = {}
endif

let g:neocomplete#sources.gitcommit = [ 'buffer', 'dictionary', 'omni' ]

if neobundle#is_installed('neocomplete')
	"上下キーで開かないように
	inoremap <expr><Up> neocomplete#smart_close_popup() . "\<Up>"
	inoremap <expr><Down> neocomplete#smart_close_popup() . "\<Down>"

	"改行しようとして候補を入力されないように
	inoremap <expr><CR> pumvisible() ? neocomplete#smart_close_popup() : "\<CR>"

	"Ctrl + Space で表示
	inoremap <expr><C-Space> pumvisible() ? "\<C-Y>" : "\<C-Space>"

	"Ctrl + 上下キーで候補を移動
	inoremap <expr><S-Up> pumvisible() ? "\<C-P>" : "\<Up>"
	inoremap <expr><S-Down> pumvisible() ? "\<C-N>" : "\<Down>"
endif
