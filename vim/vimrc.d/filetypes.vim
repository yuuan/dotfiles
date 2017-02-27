" ----------------------------------------
" ファイルの種類ごとの設定
" ----------------------------------------

augroup vimrc_file_types
	" 二重に登録されるのを防止する
	autocmd!

	" php-template
	autocmd BufNewFile,BufRead *.phtml set filetype=php
	autocmd BufNewFile,BufRead *.ctp set filetype=php

	" Twig
	autocmd BufNewFile,BufRead *.tpl set filetype=twig
	autocmd BufNewFile,BufRead *.volt set filetype=twig

	" CoffeeScript
	autocmd BufNewFile,BufRead,BufReadPre *.coffee set filetype=coffee

	" TT2 syntax
	autocmd BufNewFile,BufRead *.tmpl set filetype=tt2html

	" Markdown
	autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=mkd

	" `*.t` ファイルをPerlファイルとして認識
	autocmd BufNewFile,BufRead *.t set filetype=perl

	" `nyagos` ファイルをLuaファイルとして認識
	autocmd BufNewFile,BufRead *nyagos set filetype=lua

augroup end
