" ----------------------------------------
" Unite
" ----------------------------------------

" インサートモードで始める
let g:unite_enable_start_insert = 1

" ステータスラインを上書きする
let g:unite_force_overwrite_statusline = 0

" セッションを自動で保存
let g:unite_source_session_enable_auto_save = 1

"ファイルを開くとき新しいタブで開く
call unite#custom#default_action('file', 'tabopen')

" Unite 内のキー割り当て
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
	highlight CursorLine ctermbg=31 ctermfg=231
	imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
"	imap <buffer> <C-h> <ESC><Plug>(unite_quick_help)
	imap <buffer> <F1> <ESC><Plug>(unite_quick_help)
	nmap <buffer> <F4> <Plug>(unite_exit)
	nmap <buffer> <ESC> <Plug>(unite_exit)
	inoremap <buffer> <C-p> <C-r>0
endfunction

" Unite を呼び出すキー割り当て
nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file file/new directory/new<CR>
nnoremap <silent> <C-h> :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> <C-b> :<C-u>Unite buffer<CR>
nnoremap <silent> <C-Space> :<C-u>Unite tab<CR>
"inoremap <silent> <C-Space> <ESC>:<C-u>Unite tab<CR>
nnoremap <silent> <C-p> :<C-u>Unite history/yank<CR>
"inoremap <silent> <C-p> <ESC>:<C-u>Unite history/yank<CR>
