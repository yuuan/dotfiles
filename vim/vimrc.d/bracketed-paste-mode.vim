" ----------------------------------------
" Bracketed Paste mode の設定
" ----------------------------------------

" クリップボードからの貼り付け時に `:set paste` する
if &term =~ "xterm|screen"

	if &term =~ "screen"
		let &t_SI = &t_SI . "\eP\e[?2004h\e\\"
		let &t_EI = "\eP\e[?2004l\e\\" . &t_EI
		let &pastetoggle = "\e[201~"
	elseif &term =~ "xterm"
		let &t_SI .= &t_SI . "\e[?2004h"
		let &t_EI .= "\e[?2004l" . &t_EI
		let &pastetoggle = "\e[201~"
	endif

	function XTermPasteBegin2(ret)
		set paste
		return a:ret
	endfunction

	inoremap <special> <expr> <Esc>[200~ XTermPasteBegin2("")
endif
