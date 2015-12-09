#!/bin/zsh -eu

dotfiles="$(cd "$(dirname "$(dirname "${BASH_SOURCE:-${(%):-%N}}")")"; pwd)"

source "$dotfiles/bin/lib/functions.zsh"

run "ln -sni $dotfiles/git/config.d $HOME/.gitconfig.d"

if [[ -n `cat $HOME/.gitconfig | grep '.gitconfig.d'` ]]; then
	echo-info "Include setting is exists."
else
	echo-info "Add include setting to '~/.gitconfig'"
	echo '
[include]
	path = ~/.gitconfig.d/*.conf' >> ~/.gitconfig
fi

ls-d "$HOME/.gitconfig" "$HOME/.gitconfig.d"
ls-a "$HOME/.gitconfig.d/"
