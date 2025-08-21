#!/bin/zsh

function __notify() {
	local message="${1:-OK}"

	if (( $+commands[osascript] )); then
		osascript -e "display notification \"${message}\" with title \"Claude Code\""
	elif (( $+commands[notify-send] )); then
		notify-send "Claude Code" "${message}"
	fi
}

__notify "$@" && tput bel
