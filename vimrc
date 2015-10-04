set encoding=utf-8
scriptencoding utf-8

filetype off
filetype plugin indent off

runtime! vimrc.init.d/*.vim
runtime! vimrc.d/*.vim

" 環境依存設定の読み込み
if filereadable(expand('~/.vimrc.local'))
	source ~/.vimrc.local
endif
