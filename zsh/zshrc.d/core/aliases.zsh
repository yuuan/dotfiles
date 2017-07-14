# ----------------------------------------
# エイリアスの設定
# ----------------------------------------

# グローバルエイリアスを記録する変数
typeset -g -a GLOBAL_ALIASES

# グローバルエイリアスをリスト表示
function @ {
	echo "Global Aliases: ${GLOBAL_ALIASES:-}"
}

# ファイルに変更を加える前に確認する

#alias rm="rm -i"
#alias cp="cp -i"
alias mv="mv -i"


## `ls` コマンドの設定

case ${OSTYPE} in
	darwin*)
		alias ls='ls -FG'
		;;
	linux* | cygwin*)
		alias ls='ls -F --time-style=+"%Y/%m/%d %H:%M:%S" --color=auto'
		;;
esac


alias la="ls -a"
alias ll="ls -lh"
alias lal="ls -lah"
alias lz="ls -lhZ"
alias laz="ls -laZ"
alias ssh-config="$EDITOR $HOME/.ssh/config"

alias ..='cd ..'
