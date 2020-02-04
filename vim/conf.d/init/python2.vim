" ----------------------------------------
" Python 2 のパスを設定
" ----------------------------------------

if ! exists('g:python_host_prog')
	if executable('/usr/local/bin/python2')
		let g:python_host_prog = '/usr/local/bin/python2'
	elseif executable('/usr/bin/python2')
		let g:python_host_prog = '/usr/bin/python2'
	elseif executable('/usr/bin/python2.7')
		let g:python_host_prog = '/usr/bin/python2.7'
	endif
endif
