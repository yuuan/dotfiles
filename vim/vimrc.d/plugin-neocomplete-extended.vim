" ----------------------------------------
" NeoComplete-Extended
" ----------------------------------------

if executable('composer.phar')
	let g:phpcomplete_index_composer_command = 'composer.phar'
elseif executable('composer')
	let g:phpcomplete_index_composer_command = 'composer'
endif
