#!/bin/zsh -eu

dotfiles="$(cd "$(dirname "$(dirname "${BASH_SOURCE:-${(%):-%N}}")")"; pwd)"

source "$dotfiles/bin/lib/functions.zsh"

[[ ! -d $HOME/.vim/backup ]] && run "mkdir -p $HOME/.vim/backup/"
[[ ! -d $HOME/.vim/swp ]] && run "mkdir -p $HOME/.vim/swp/"
[[ ! -d $HOME/.vim/undo ]] && run "mkdir -p $HOME/.vim/undo/"

run "ln -si $dotfiles/vimrc $HOME/.vimrc"
run "ln -sni $dotfiles/vim/vimrc.init.d $HOME/.vim/vimrc.init.d"
run "ln -sni $dotfiles/vim/vimrc.d $HOME/.vim/vimrc.d"
run "ln -sni $dotfiles/vim/ftplugin $HOME/.vim/ftplugin"

if [ ! -d $HOME/.vim/bundle/ ]; then
	run "mkdir -p $HOME/.vim/bundle/"
	run "git clone https://github.com/Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim"
fi

ls-dr "$HOME/.vimrc" "$HOME/.vim"
ls-a "$HOME/.vim/"
