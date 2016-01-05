autoload -Uz add-zsh-hook

if [ ${STY} ]; then

	# ディレクトリ名を表示
	precmd-for-screen () {
		[ ${STY} ] && echo -ne "\ek$(basename $(pwd))\e\\"
	}

	add-zsh-hook precmd precmd-for-screen

	# コマンド名を表示
	preexec-for-screen () {
		if [ ${STY} ]; then
			case "$1" in
				mysql*|tail*)
					echo -ne "\ek${1%% *}\e\\"
					;;
				*)
					echo -ne "\ek$(basename $(pwd))\e\\"
					;;
			esac
		fi
	}

	add-zsh-hook preexec preexec-for-screen
fi

