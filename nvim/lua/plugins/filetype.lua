-- ファイルタイプの振り分けを定義
vim.cmd([[
  augroup vimrc_file_type
    " 二重に登録されるのを防止する
    autocmd!

    " `.env` は SH
    autocmd BufNewFile,BufRead .env.* set filetype=sh

    " 環境ごとの YAML
    autocmd BufNewFile,BufRead *.yml.{production,staging,development,test} set filetype=yaml

    " `composer.lock` は JSON
    autocmd BufNewFile,BufRead *composer.lock set filetype=json

    " `.php_cs` は PHP
    autocmd BufNewFile,BufRead .php_cs{,.dist} set filetype=php

    " .neon は YAML
    autocmd BufNewFile,BufRead *.neon{,.dist} set filetype=yaml

    " Twig
    autocmd BufNewFile,BufRead *.tpl set filetype=twig
    autocmd BufNewFile,BufRead *.volt set filetype=twig

    " `*.t` は Perl
    autocmd BufNewFile,BufRead *.t set filetype=perl

    " Markdown
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=mkd

    " `nyagos` は Lua
    autocmd BufNewFile,BufRead *nyagos set filetype=lua

    " `/etc/td-agent/` 以下にあるのは fluentd
    autocmd BufNewFile,BufRead /etc/td-agent/*.conf{,.example} set filetype=fluentd

  augroup end
]])
