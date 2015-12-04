#!/bin/zsh -eu

dotfiles="$(cd "$(dirname "$(dirname "${BASH_SOURCE:-${(%):-%N}}")")"; pwd)"

pushd $dotfiles
git submodule update --init
popd

rm -f $HOME/.zcompdump
autoload -U compinit; compinit
