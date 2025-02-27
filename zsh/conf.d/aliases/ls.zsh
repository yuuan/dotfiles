# ----------------------------------------
# `ls` コマンドに関するエイリアス
# ----------------------------------------

## 必ず付けたいオプション
case ${OSTYPE} in
	darwin*)
		alias ls='ls -FG'
		;;
	linux*|cygwin*)
		alias ls='ls -F --time-style=+"%Y/%m/%d %H:%M:%S" --color=auto'
		;;
esac

alias la='ls -a'
alias ll='ls -lh'
alias lal='ls -lah'
alias lz='ls -lhZ'
alias laz='ls -laZ'
