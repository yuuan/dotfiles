#!/bin/zsh -eu

dotfiles="$(cd "$(dirname "$(dirname "${BASH_SOURCE:-${(%):-%N}}")")"; pwd)"

pushd $dotfiles
git submodule foreach git pull origin master
popd

rm -f ~/.zcompdump
autoload -U compinit; compinit
