" ----------------------------------------
" Python 3 のパスを設定
" ----------------------------------------

if ! exists('g:python3_host_prog') && executable('/usr/bin/python3')
	let g:python3_host_prog = '/usr/bin/python3'
endif
