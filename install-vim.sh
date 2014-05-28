#!/bin/sh

if [ ! -d $HOME/.vim/bundle/ ]; then
	mkdir -p $HOME/.vim/backup/
	mkdir -p $HOME/.vim/swp/
	mkdir -p $HOME/.vim/bundle/
	git clone https://github.com/Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
fi

