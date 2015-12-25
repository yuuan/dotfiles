" ----------------------------------------
" Unite
" ----------------------------------------

let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
let g:unite_force_overwrite_statusline = 0

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
	imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
	imap <buffer> <C-h> <ESC><Plug>(unite_quick_help)
	imap <buffer> <C-p> <C-r>0
	nmap <buffer> <F4> <Plug>(unite_exit)
	nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction

"ファイルを開くとき新しいタブで開く
call unite#custom#default_action('file', 'tabopen')

"キーの割り当て
nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file file/new directory/new<CR>
nnoremap <silent> <C-h> :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> <C-b> :<C-u>Unite buffer<CR>
nnoremap <silent> <C-Space> :<C-u>Unite tab<CR>
"inoremap <silent> <C-Space> <ESC>:<C-u>Unite tab<CR>
nnoremap <silent> <C-p> :<C-u>Unite history/yank<CR>
"inoremap <silent> <C-p> <ESC>:<C-u>Unite history/yank<CR>
