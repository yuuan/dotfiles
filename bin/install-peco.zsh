#!/bin/zsh -eu

dotfiles="$(cd "$(dirname "$(dirname "${BASH_SOURCE:-${(%):-%N}}")")"; pwd)"

source "$dotfiles/bin/lib/functions.zsh"

run "ln -sni $dotfiles/peco $HOME/.peco"

ls-d "$HOME/.peco"
ls-a "$HOME/.peco/"
