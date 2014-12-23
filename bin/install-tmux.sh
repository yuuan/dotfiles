#!/bin/sh -eu

[[ ! -d $HOME/.tmux ]] && mkdir -p $HOME/.tmux/
[[ ! -d $HOME/.tmux/plugins ]] && mkdir -p $HOME/.tmux/plugins/

if [ ! -d $HOME/.tmux/plugins/tmux-powerline ]; then
	git clone git://github.com/erikw/tmux-powerline.git $HOME/.tmux/plugins/tmux-powerline
	cd $HOME/.tmux/plugins/tmux-powerline/
	/bin/sh ./generate_rc.sh
fi

