" ----------------------------------------
" Python 3 のパスを設定
" ----------------------------------------

if ! exists('g:python3_host_prog')
	if executable('/usr/local/bin/python3')
		let g:python3_host_prog = '/usr/local/bin/python3'
	elseif executable('/usr/bin/python3')
		let g:python3_host_prog = '/usr/bin/python3'
	endif
endif
