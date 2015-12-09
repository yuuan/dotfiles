#!/bin/zsh -eu

dotfiles="$(cd "$(dirname "$(dirname "${BASH_SOURCE:-${(%):-%N}}")")"; pwd)"

source "$dotfiles/bin/lib/functions.zsh"

run "ln -si $dotfiles/screenrc $HOME/.screenrc"

ls-dr "$HOME/.screenrc"
