" ----------------------------------------
" NeoSnippet
" ----------------------------------------

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

" デフォルトで用意されているスニペットを使わない
let g:neosnippet#disable_runtime_snippets = {
\     'php': 1,
\ }

let g:neosnippet#snippets_directory='~/.vim/snippets/'
