#!/bin/zsh -eu

function cyan-echo {
	echo -e "\e[32m$*\e[m"
}

dotfiles="$(cd "$(dirname "$(dirname "${BASH_SOURCE:-${(%):-%N}}")")"; pwd)"

cyan-echo "dotfiles directory is \"$dotfiles/\""

cyan-echo "> ln -sni $dotfiles/git/config.d $HOME/.gitconfig.d"
ln -sni $dotfiles/git/config.d $HOME/.gitconfig.d

if [[ -n `cat $HOME/.gitconfig | grep '.gitconfig.d'` ]]; then
	cyan-echo "Include setting is exists."
else
	cyan-echo "Add include setting to '~/.gitconfig'"
	echo '
[include]
	path = ~/.gitconfig.d/*.conf' >> ~/.gitconfig
fi
