#!/bin/zsh -eu

function cyan-echo {
	echo -e "\e[32m$*\e[m"
}

dotfiles="$(cd "$(dirname "$(dirname "${BASH_SOURCE:-${(%):-%N}}")")"; pwd)"

cyan-echo "dotfiles directory is \"$dotfiles/\""

cyan-echo "> ln -si $dotfiles/gitconfig $HOME/.gitconfig.common"
ln -si $dotfiles/gitconfig $HOME/.gitconfig.common

if [[ -n `cat $HOME/.gitconfig | grep .gitconfig.common` ]]; then
	cyan-echo "Include setting is exists."
else
	cyan-echo "Add include setting to ~/.gitconfig."
	echo '
[include]
	path = ~/.gitconfig.common' >> ~/.gitconfig
fi
