#!/bin/zsh

mkdir -p $HOME/.vim/backup/
mkdir -p $HOME/.vim/swp/
mkdir -p $HOME/.vim/undo/


dotfiles="$(cd "$(dirname "$(dirname "${BASH_SOURCE:-${(%):-%N}}")")"; pwd)"

ln -sni $dotfiles/vim/ftplugin $HOME/.vim/ftplugin


if [ ! -d $HOME/.vim/bundle/ ]; then
	mkdir -p $HOME/.vim/bundle/
	git clone https://github.com/Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
fi

