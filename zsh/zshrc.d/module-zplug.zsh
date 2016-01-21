# ----------------------------------------
# `zplug` の設定
# ----------------------------------------

if [[ -f $HOME/.zplug/zplug ]]; then
	# zplug を読み込む
	source $HOME/.zplug/zplug


	# plugins

	## zsh-completions
	zplug "zsh-users/zsh-completions"


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
