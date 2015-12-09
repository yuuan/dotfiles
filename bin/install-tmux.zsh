#!/bin/zsh -eu

dotfiles="$(cd "$(dirname "$(dirname "${BASH_SOURCE:-${(%):-%N}}")")"; pwd)"

source "$dotfiles/bin/lib/functions.zsh"

run "ln -si $dotfiles/tmux.conf $HOME/.tmux.conf"


TMUX_PLUGINS="$HOME/.tmux/plugins"
TMUX_PLUGINS_POWERLINE_DIR="$TMUX_PLUGINS/tmux-powerline"

[[ ! -d $TMUX_PLUGINS ]] && run "mkdir -p $HOME/.tmux/plugins/"

if [ ! -d $TMUX_PLUGINS_POWERLINE_DIR ]; then
	run "git clone git://github.com/erikw/tmux-powerline.git $TMUX_PLUGINS_POWERLINE_DIR"
	cd $TMUX_PLUGINS_POWERLINE_DIR
	run "/bin/sh $TMUX_PLUGINS_POWERLINE_DIR/generate_rc.sh"
fi

ls-dr "$HOME/.tmux.conf" "$HOME/.tmux"
ls-a "$HOME/.tmux/"
ls-a "$HOME/.tmux/plugins/"
