#!/bin/zsh -eu

function attach-pty {
	if which reptyr &> /dev/null; then
		local process=$(ps aux | grep "^$USER" | peco | awk '{print $2}')
		[[ -n "$process" ]] && reptyr "$process"
	else
		echo "reptyr is not installed."
	fi
}
