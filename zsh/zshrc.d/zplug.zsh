# ----------------------------------------
# `zplug` の設定
# ----------------------------------------

if [[ -f $HOME/.zplug/init.zsh ]]; then
	local __zplug_ghr_os

	# zplug を読み込む
	source $HOME/.zplug/init.zsh

	case ${OSTYPE} in
		darwin*)
			__zplug_ghr_os="*darwin*amd64*"
			;;
		linux*)
			__zplug_ghr_os="*linux*amd64*"
			;;
		cygwin*)
			__zplug_ghr_os="*windows*amd64*"
			;;
	esac


	# plugins

	## zsh-completions
	zplug "zsh-users/zsh-completions"

	## fzf
	zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf, use:${__zplug_ghr_os:-os}

	## fzf-tmux
	zplug "junegunn/fzf", as:command, use:bin/fzf-tmux

	## peco
	zplug "peco/peco", as:command, from:gh-r, use:${__zplug_ghr_os:-os}

	## peco-tmux
	zplug "yuuan/c24d07d0708e37460e1ede30442251a3", as:command, from:gist, use:peco-tmux

	## enhancd
	zplug "b4b4r07/enhancd", use:init.sh

	## jid
	zplug "simeji/jid", as:command, from:gh-r, use:${__zplug_ghr_os:-os}

	## git-foresta
	zplug "takaaki-kasai/git-foresta", as:command, use:git-foresta


	local ZPLUG_VERBOSE

	# インストールしてない項目があればインストールするか訊ねる
	if ! zplug check ${ZPLUG_VERBOSE:-}; then
		printf "Install zplug modules? [y/N]: "
		if read -q; then
			echo; zplug install
		else
			echo
		fi
	fi

	# プラグインを読み込み、コマンドにパスを通す
	zplug load ${ZPLUG_VERBOSE:-}

	# `peco` があれば `peco` を使う
	export ZPLUG_FILTER="peco:${ZPLUG_FILTER:-}"
fi
