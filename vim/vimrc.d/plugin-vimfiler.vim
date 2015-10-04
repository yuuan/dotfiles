" ----------------------------------------
" VimFiler
" ----------------------------------------

"vimデフォルトのエクスプローラをvimfilerで置き換える
"let g:vimfiler_as_default_explorer = 1

"セーフモードを無効にした状態で起動する
let g:vimfiler_safe_mode_by_default = 0

"新しいタブで編集する
let g:vimfiler_edit_action = 'tabopen'

"現在開いているバッファのディレクトリを開く
"nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>

"現在開いているバッファをIDE風に開く
"nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
"nnoremap <silent> <C-f> :<C-u>VimFilerBufferDir -split -simple -winwidth=35<CR>

"↓カーソルキーが効かなくなったのでコメントアウト
"デフォルトのキーマッピングを変更
" augroup vimrc
" 	autocmd FileType vimfiler call s:vimfiler_my_settings()
" augroup END
" function! s:vimfiler_my_settings()
" 	nmap <buffer> q <Plug>(vimfiler_exit)
" 	nmap <buffer> Q <Plug>(vimfiler_hide)
" 	nmap <buffer> <Tab> <Plug>(vimfiler_choose_action)
" 	nmap <buffer> <ESC> <Plug>(vimfiler_switch_to_other_window)
" endfunction
