# ----------------------------------------
# `zplug` の設定
# ----------------------------------------

if [[ -f $HOME/.zplug/zplug ]]; then
	local zplug_peco_os

	# zplug を読み込む
	source $HOME/.zplug/zplug

	case ${OSTYPE} in
		darwin*)
			__zplug_peco_os="*darwin*amd64*"
			;;
		linux*)
			__zplug_peco_os="*linux*amd64*"
			;;
		cygwin*)
			__zplug_peco_os="*windows*amd64*"
			;;
	esac


	# plugins

	## zsh-completions
	zplug "zsh-users/zsh-completions"

	## fzf
	zplug "junegunn/fzf-bin", as:command, from:gh-r

	## fzf-tmux
	zplug "junegunn/fzf", as:command, of:bin/fzf-tmux

	## peco
	zplug "peco/peco", as:command, from:gh-r, of:${__zplug_peco_os:-os}

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

	# `peco` があれば `peco` を使う
	export ZPLUG_FILTER="peco:${ZPLUG_FILTER:-}"
fi
