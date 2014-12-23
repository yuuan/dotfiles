#!/bin/zsh -eu

function cyan-echo {
	echo -e "\e[32m$*\e[m"
}

dotfiles="$(cd "$(dirname "$(dirname "${BASH_SOURCE:-${(%):-%N}}")")"; pwd)"

cyan-echo "dotfiles directory is \"$dotfiles/\""

cyan-echo "> ln -sni $dotfiles/zsh $HOME/.zsh"
ln -sni $dotfiles/zsh $HOME/.zsh

cyan-echo "> ln -si $dotfiles/zshrc $HOME/.zshrc"
ln -si $dotfiles/zshrc $HOME/.zshrc

