" ----------------------------------------
" vim-lsp
" ----------------------------------------

" sign の表示を無効化 (ALE で行うため)
let g:lsp_diagnostics_enabled = 0

nmap <C-W>gf :<C-U>tab LspDefinition<CR>
nmap gf :<C-U>tab LspDefinition<CR>
