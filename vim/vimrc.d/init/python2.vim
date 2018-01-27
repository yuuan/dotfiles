" ----------------------------------------
" Python 2 のパスを設定
" ----------------------------------------

if ! exists('g:python_host_prog') && executable('/usr/bin/python2')
	let g:python_host_prog = '/usr/bin/python2'
endif
