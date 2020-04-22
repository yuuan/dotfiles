" ----------------------------------------
" ファイルの種類ごとの設定
" ----------------------------------------

augroup vimrc_file_types
	" 二重に登録されるのを防止する
	autocmd!

	" php-template
	autocmd BufNewFile,BufRead *.phtml set filetype=php
	autocmd BufNewFile,BufRead *.ctp set filetype=php

	" .neon は YAML
	autocmd BufNewFile,BufRead *.neon{,.dist} set filetype=yaml

	" Twig
	autocmd BufNewFile,BufRead *.tpl set filetype=twig
	autocmd BufNewFile,BufRead *.volt set filetype=twig

	" CoffeeScript
	autocmd BufNewFile,BufRead,BufReadPre *.coffee set filetype=coffee

	" TT2 syntax
	autocmd BufNewFile,BufRead *.tmpl set filetype=tt2html

	" Markdown
	autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=mkd

	" `*.t` は Perl
	autocmd BufNewFile,BufRead *.t set filetype=perl

	" `nyagos` は Lua
	autocmd BufNewFile,BufRead *nyagos set filetype=lua

	" `composer.lock` は JSON
	autocmd BufNewFile,BufRead *composer.lock set filetype=json

	" `.php_cs` は PHP
	autocmd BufNewFile,BufRead .php_cs{,.dist} set filetype=php

	" `.env` は SH
	autocmd BufNewFile,BufRead .env.* set filetype=sh

	" `/etc/td-agent/` 以下にあるのは fluentd
	autocmd BufNewFile,BufRead /etc/td-agent/*.conf{,.example} set filetype=fluentd

augroup end
