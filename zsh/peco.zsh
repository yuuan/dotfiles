function peco-select-history() {
	local tac
	if which tac &> /dev/null; then
		tac="tac"
	elif which gtac &> /dev/null; then
		tac="gtac"
	else
		tac="tail -r"
	fi

	BUFFER=$(\history -n 1 | eval $tac | LANG=ja_JP.UTF-8 peco --query "$LBUFFER")
	CURSOR=$#BUFFER
	zle clear-screen
}

if which peco &> /dev/null; then
	zle -N peco-select-history
	bindkey '^r' peco-select-history
fi

