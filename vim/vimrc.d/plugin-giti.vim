" ----------------------------------------
" Giti
" ----------------------------------------

nnoremap [git] <Nop>
nmap <C-g> [git]

nnoremap <silent> [git]<C-g> :<C-u>Unite giti/status<CR>
nnoremap <silent> [git]b :<C-u>Unite giti/branch_all<CR>
"	nnoremap <silent> [git]c :<C-u>Unite giti/config<CR>
nnoremap <silent> [git]c :<C-u>Gcommit<CR>
nnoremap <silent> [git]l :<C-u>Unite giti/log<CR>
nnoremap <silent> [git]r :<C-u>Unite giti/remote<CR>
nnoremap <silent> [git]s :<C-u>Unite giti/status<CR>
nnoremap <silent> [git]<C-w> :<C-u>Gwrite<CR>
