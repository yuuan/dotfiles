# ----------------------------------------
# `zplug` の設定
# ----------------------------------------

if [[ -f $HOME/.zplug/init.zsh ]]; then
	source $HOME/.zplug/init.zsh


	# plugins

	## zsh-completions
	zplug "zsh-users/zsh-completions"

	## zsh-syntax-highlighting
	zplug "zsh-users/zsh-syntax-highlighting", defer:2

	## zsh-autosuggestions
	zplug "zsh-users/zsh-autosuggestions", defer:2

	## fzf
	zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf

	## fzf-tmux
	zplug "junegunn/fzf", as:command, use:bin/fzf-tmux

	## peco
	zplug "peco/peco", as:command, from:gh-r

	## peco-tmux
	zplug "b4b4r07/peco-tmux.sh", as:command, use:'(*).sh', rename-to:'$1'

	## enhancd
	zplug "b4b4r07/enhancd", use:init.sh

	## history
	zplug "b4b4r07/history", use:misc/zsh/init.zsh, if:"[ -n \"${commands[history]}\" ]"


	# screen/tmux を使っていなければ
	if [[ -z "$STY$TMUX" ]]; then
		# インストールしてない項目があればインストールするか訊ねる
		if ! zplug check ${ZPLUG_VERBOSE:+--verbose}; then
			printf "Install zplug modules? [y/N]: "
			if read -q; then
				echo; zplug install
			else
				echo
			fi
		fi
	fi

	# プラグインを読み込み、コマンドにパスを通す
	zplug load ${ZPLUG_VERBOSE:+--verbose}
fi
