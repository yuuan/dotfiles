" ----------------------------------------
" vim-ref
" ----------------------------------------

if executable('lynx')
	let g:ref_alc_cmd='lynx -dump -nonumbers %s'
	let g:ref_phpmanual_cmd='lynx -dump -nonumbers %s'
endif
if isdirectory($HOME . '/.vim/docs/php-chunked-xhtml')
	let g:ref_phpmanual_path = $HOME . '/.vim/docs/php-chunked-xhtml'
endif
let g:ref_detect_filetype={
	\     'blade': 'phpmanual',
	\ }
