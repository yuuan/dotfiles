# ----------------------------------------
# `zplug` の設定
# ----------------------------------------

# `peco` があれば `peco` を使う
export ZPLUG_FILTER="peco:$ZPLUG_FILTER"

if [[ -f $HOME/.zplug/zplug ]]; then
	# zplug を読み込む
	source $HOME/.zplug/zplug


	# plugins

	## zsh-completions
	zplug "zsh-users/zsh-completions"

	## fzf
#	zplug "junegunn/fzf-bin", as:command, from:gh-r, file:fzf

	## fzf-tmux
#	zplug "junegunn/fzf", as:command, of:bin/fzf-tmux

	## peco
	zplug "peco/peco", as:command, from:gh-r, file:peco

	## enhancd
	zplug "b4b4r07/enhancd", as:plugin, of:enhancd.sh


	# インストールしてない項目があればインストールするか訊ねる
	if ! zplug check --verbose; then
		printf "Install? [y/N]: "
		if read -q; then
			echo; zplug install
		else
			echo
		fi
	fi

	# プラグインを読み込み、コマンドにパスを通す
	zplug load --verbose
fi
