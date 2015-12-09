#!/bin/zsh -u

function choices {
	if [[ $1 -eq 0 ]]; then echo "[Y/n]"; else echo "[y/N]"; fi
}

function white {
	echo -ne "\e[37m"
}

function endcolor {
	echo -ne "\e[m"
}

function confirm {
	local question=$1
	local default=$2

	white; read answer\?"$question $(choices "$default"): "; endcolor

	case "$answer" in
		[Yy]*)
			true
			;;
		[Nn]*)
			false
			;;
		*)
			if [[ $default -eq 0 ]]; then true; else false; fi
			;;
	esac
}

function echo-info {
	echo -e "\e[32m$*\e[m"
}

function echo-command {
	echo-info "> $*"
}

function run {
	local command=$*
	echo-command "$command"
	eval $command
}

function ls-l {
	case ${OSTYPE} in
		darwin*)
			ls -lhFG $*
			;;
		linux* | cygwin*)
			ls -lhF --time-style=+'%Y/%m/%d %H:%M:%S' --color=always $*
			;;
	esac
}

function ls-d {
	echo
	echo "$HOME/:"
	ls-l -d $*
}

function ls-dr {
	ls-d -r $*
}

function ls-a {
	echo
	echo "$*:"
	ls-l -a $* | tail -n +2
}
