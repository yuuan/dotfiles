# ----------------------------------------
# コマンド履歴に `peco` を使う
# ----------------------------------------

# `peco` でコマンド履歴を表示する関数
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
#	zle clear-screen
}

# コマンド履歴の表示に `peco` を使う
if which peco &> /dev/null || which $HOME/.zplug/bin/peco &> /dev/null; then
	zle -N peco-select-history
	bindkey '^R' peco-select-history
else
	bindkey '^R' history-incremental-search-backward
fi
