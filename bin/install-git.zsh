#!/bin/zsh -eu

function cyan-echo {
	echo -e "\e[32m$*\e[m"
}

dotfiles="$(cd "$(dirname "$(dirname "${BASH_SOURCE:-${(%):-%N}}")")"; pwd)"

cyan-echo "dotfiles directory is \"$dotfiles/\""

cyan-echo "> ln -si $dotfiles/gitconfig $HOME/.gitconfig"
ln -si $dotfiles/gitconfig $HOME/.gitconfig

cyan-echo "> touch $HOME/.gitconfig.local"
touch $HOME/.gitconfig.local
